
PAUSED = false;
enum POWERUP{
ATTACK,
CONTROL,
HPDROP,
HPMAX,
MONEYDROP,
MONEYUP,
SPINLEVEL,
SPEEDMAX,
COUNT
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Configs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

powerUp =	array_create(POWERUP.COUNT)	//(order is decided through enum)
powerUp[POWERUP.ATTACK]=	new PowerUp("Attack",				sprUpgradesAttack,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.ATTACK		}))
powerUp[POWERUP.CONTROL]=	new PowerUp("Control",				sprUpgradesControl,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.CONTROL		})) 
powerUp[POWERUP.HPDROP]=	new PowerUp("Hp Drop\nChance",		sprUpgradesHealthDropChance,	5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.HPDROP		})) 
powerUp[POWERUP.HPMAX]=		new PowerUp("Max Health",			sprUpgradesHealthUp,			5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.HPMAX		})) 
powerUp[POWERUP.MONEYDROP]=	new PowerUp("Money Drop\nChance",	sprUpgradesMoneyDropChance,		5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.MONEYDROP	})) 
powerUp[POWERUP.MONEYUP]=	new PowerUp("Money Value",			sprUpgradesMoneyUp,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.MONEYUP		})) 
powerUp[POWERUP.SPINLEVEL]=	new PowerUp("Spin Level",			sprUpgradesStrengthUp,			5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.SPINLEVEL	})) 
powerUp[POWERUP.SPEEDMAX]=	new PowerUp("Max Speed",			sprUpgradesSpeedUp,				5,	10,	4,	instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	POWERUP.SPEEDMAX	})) 

guyNudgeSpeed = 0.5	//the magnitude applied to enemies when touching. A constant weak force, prevents overlapping
invMoney = 120		//
healthStart = 3		//
healthMaxMax =	healthStart+powerUp[POWERUP.HPMAX].lvlMax		//The highest that Health can go
invHealth =		healthStart		//
invHealthMax =	healthStart		//

for(var i = 0; i < healthMaxMax; i++){
	instance_create_layer(40+70*i,room_height-100,"GUI",objHeartMark)
}

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


collideTilemap = layer_tilemap_get_id("Walls");

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
	}else if state != GUY_STATE.HURT{
		BehaveStartHurt(_dir, -15)
	}
}
player.CollideWithGuy = method(player,PlayerCollideEnemy)

enemies = []
enemyCt = 5
for (var i = 0; i < enemyCt; ++i) {
    enemies[i] = instance_create_layer(222+222*i,400,"Guys",objEnemy)
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