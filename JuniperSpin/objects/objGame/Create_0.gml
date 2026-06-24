
PAUSED = false;
enum POWERUP{
ATTACK,
CONTROL,
HPDROP,
HPMAX,
MONEYDROP,
MONEYUP,
STAMINA,
SPEEDMAX,
COUNT
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Manage Guys
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
player = instance_create_layer(200,200,"Guys",objGuy)

function PlayerCollideEnemy(_other){
	if PAUSED return;
	//DEAL DAMAGE TO OTHER
	if _other.state == GUY_STATE.HURT return;
	var _dir = point_direction(x,y,_other.x,_other.y)	//direction to hurt enemy
	if state == GUY_STATE.SPIN{
		var _spd = Vec2Magnitude(move_speed)				//force to hurt enemy
		_other.BehaveStartHurt(_dir, max(10,spin_knockbackMult*_spd))
		_other.Damage(damage)	
//BE DAMAGED BY OTHER
	}else if state != GUY_STATE.HURT{
		BehaveStartHurt(_dir, -15)
		objGame.Damage()
	}
}
player.CollideWithGuy = method(player,PlayerCollideEnemy)

player.drawDirectionArrow = true



#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~



//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Powerup Configs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

//POWERUP CONFIG

powerUp =	array_create(POWERUP.COUNT)	//(order is decided through enum)
powerUp[POWERUP.ATTACK]=	new PowerUp("Attack",				sprUpgradesAttack,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.ATTACK		}))
powerUp[POWERUP.CONTROL]=	new PowerUp("Control",				sprUpgradesControl,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.CONTROL		})) 
powerUp[POWERUP.HPDROP]=	new PowerUp("Hp Drop\nChance",		sprUpgradesHealthDropChance,	5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.HPDROP		})) 
powerUp[POWERUP.HPMAX]=		new PowerUp("Max Health",			sprUpgradesHealthUp,			5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.HPMAX		})) 
powerUp[POWERUP.MONEYDROP]=	new PowerUp("Money Drop\nChance",	sprUpgradesMoneyDropChance,		5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.MONEYDROP	})) 
powerUp[POWERUP.MONEYUP]=	new PowerUp("Recovery",				sprUpgradesSpeedUp,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.MONEYUP		})) 
powerUp[POWERUP.STAMINA]=	new PowerUp("Stamina",				sprUpgradesSpeedUp,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.STAMINA		})) 
powerUp[POWERUP.SPEEDMAX]=	new PowerUp("Max Velocity",			sprUpgradesStrengthUp,			5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.SPEEDMAX	})) 

guyNudgeSpeed = 0.5	//the magnitude applied to enemies when touching. A constant weak force, prevents overlapping

healthStart = 3		//
healthMaxMax =	healthStart+powerUp[POWERUP.HPMAX].lvlMax		//The highest that Health can go


//POWERUP EFFECTS
function UpdatePowerUp(_powerupIndex){
	var _powRatio = powerUp[_powerupIndex].level / powerUp[_powerupIndex].lvlMax 
	switch(_powerupIndex) {
		case POWERUP.ATTACK:
			player.damage =	lerp(	2,		10,	_powRatio)		
		break;
		case POWERUP.CONTROL:
			player.move_accel =	lerp(	0.5,	1,	_powRatio)		//these are additive to the speed
			player.move_decel =	lerp(	0.4,	1,	_powRatio)		//THIS IS A POSITIVE NUMBER
			player.spin_accel =	lerp(	0.5,	2,	_powRatio)	
			player.spin_decel =	lerp(	0.1,	0.5,_powRatio)	
		break;
		case POWERUP.HPDROP:
			//CODE HERE
		break;
		case POWERUP.HPMAX:
			invHealthMax = healthStart+powerUp[POWERUP.HPMAX].level
			invHealth = invHealthMax
			UpdateHealth()
		break;
		case POWERUP.MONEYDROP:
			//CODE HERE
		break;
		case POWERUP.MONEYUP:	//SUBSITUTE FOR RECOVERY REPLACE THE ENUM FOR THIS EVENTUALLY
			player.stamina_recoverMult =	lerp(	1,		4,	_powRatio)		
		break;
		case POWERUP.STAMINA:
			player.stamina_max =			lerp(	200,	600,_powRatio)	
			player.stamina = player.stamina_max
		break;
		case POWERUP.SPEEDMAX:
			player.spin_levelMax = powerUp[_powerupIndex].level
		break;
	}
}




#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region HEARTS & MONEY
//~~~~~~~~~~~~~~~~~~~~~~~~~~~



invMoney = 120					//
invHealth =		healthStart		//
invHealthMax =	healthStart		//
							//healthMaxMax is in powerup section
heartGraphic = []

//MAKE HEART GRAPHICS
for(var i = 0; i < healthMaxMax; i++){
	heartGraphic[i] = instance_create_layer(40+70*i,room_height-100,"GUI",objHeartMark)
	heartGraphic[i].visible = false;
}

//Trim to just used hearts
for(var i = 0; i < healthStart; i++){
	heartGraphic[i].visible = true;
}



	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region UX / UI
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

instance_create_layer(64,576,"Control",objDebugButton,{
	OnDraw: function(){draw_text(x-20,590,$"Toggle Mute:{MUTED}")},
	OnClickFunc: function(){MUTED = !MUTED}
	
	})

shopOpen = false;

function TogglePause(_pause = !PAUSED){
	PAUSED = _pause
	with objGuy UpdateAnimSpeed()
	
}
function ToggleShop(_open = !shopOpen){
	shopOpen = _open;
	TogglePause(shopOpen)
	
}



#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~



//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region ENEMY SPAWNS
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
enemies =	[]
enemyCt =	0
waves =		[]

array_push(waves,[[objEnemy, 1],[objEnemy, 2]])


EnemyOnDeath = function(){	//what enemy does on death
	//Spawn a Coin maybe
	
	
	
	//reduce the counter
	objGame.enemyCt--
	
	
	
	instance_destroy()
}

function AddEnemy(_enemyType, _count = 1){	//add enemy to the field (NEEDS WORK)
	var _newEnemy;
	repeat(_count){
		array_push(enemies,instance_create_layer(irandom_range(222,1000),400,"Guys",_enemyType))
		_newEnemy = array_last(enemies)
		_newEnemy.OnDeath = method(_newEnemy,EnemyOnDeath)
	}
	enemyCt	+=_count
}


function SpawnWave(_waveNumber){
	var _wave = global.waveData[_waveNumber]
	if global.useTestWaves _wave = global.testWaveData[_waveNumber]
	
	var _eGroup;
	for(var i = 0; i < array_length(_wave); i++){
		_eGroup = _wave[i]	//a number of the same enemies
		AddEnemy(asset_get_index(_eGroup[0]),_eGroup[1])	//Add the given number of the given enemy
	}
}

fundData = ""
if (file_exists("testWaves.json")){
    var _file = file_text_open_read("testWaves.json");
	var _jsonStr = ""
	while (!file_text_eof(_file))
	{
	    _jsonStr += file_text_readln(_file);
	}
	file_text_close(_file);

	var _data = json_parse(_jsonStr)

	
	show_debug_message($"PLAIN DATA: {_data}")
	show_debug_message($"WAVE	_data[0]: {_data[0]}")
	show_debug_message($"ENEMY	_data[0][0]: {_data[0][0]}")
	show_debug_message($"NAME	_data[0][0]: {_data[0][0][0]}")
fundData = _data

	//show_debug_message(_jsonStr)
	//show_debug_message($"stringify {json_stringify(_jsonStr)}")
	//show_debug_message($"Parse {json_parse(_jsonStr)}")
	//show_debug_message($"S&P {json_parse(json_stringify(_jsonStr))}")

}


#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

function Damage(){
	invHealth--
	UpdateHealth()
	if invHealth <= 0{
		room_restart()
	}
}
function UpdateHealth(){
	//Trim to just used hearts (update hearts)
	for(var i = 0; i < healthMaxMax; i++){
		if i < invHealth{
			heartGraphic[i].Recover()
		}else{
			heartGraphic[i].Pop()
		}
	}	
}


//APPLY POWERUP VALUES (may be different than objGuy defualt)
for(var i = 0; i < POWERUP.COUNT; i++){
	UpdatePowerUp(i)
}

collideTilemap = layer_tilemap_get_id("Walls");
alarm[0] = 100