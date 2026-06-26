
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
	if _other.state == GUY_STATE.HURT || objGame.invuln return;
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
function PlayerCollideCoin(_other){
	if (_other.invuln){
		return;
	}

	with _other instance_destroy()
	objGame.invMoney++
	
	PlaySound(SFX.PICKUP_COIN)
}
function PlayerCollideMedpack(_other){
	if (_other.invuln){
		return;
	}
	
	stamina = stamina_max	//Set the thing
	spin_ready = true;	
	with _other instance_destroy()
	
	PlaySound(SFX.PICKUP_RECOVERY)
}
function PlayerTouchWall(){
	if state == GUY_STATE.SPIN{
		PlaySound(SFX.SPIN_WALLBOUNCE)
	}
}

function PlayerDraw(){
	if !objGame.invuln || InvulnFlashBool(){
		draw_self()
	}
}

player.DrawGuy = method(player,PlayerDraw)
player.CollideWithGuy = method(player,PlayerCollideEnemy)
player.CollideWithCoin = method(player,PlayerCollideCoin)
player.CollideWithMedpack = method(player,PlayerCollideMedpack)
player.BehaveOnWallBounce = method(player,PlayerTouchWall)

player.drawDirectionArrow = true



#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Powerup Configs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

//POWERUP CONFIG

powerUp =	array_create(POWERUP.COUNT)	//(order is decided through enum)
powerUp[POWERUP.ATTACK]=	new PowerUp(POWERUP.ATTACK,		"Increase Spinning Damage",	sprUpgradesAttack,				5,	10,	4)
powerUp[POWERUP.CONTROL]=	new PowerUp(POWERUP.CONTROL,	"Spinning Control",			sprUpgradesControl,				5,	10,	4)
powerUp[POWERUP.HPDROP]=	new PowerUp(POWERUP.HPDROP,		"Medpack Drop Chance",		sprUpgradesHealthDropChance,	15,	20,	1)
powerUp[POWERUP.HPMAX]=		new PowerUp(POWERUP.HPMAX,		"Increase Max Health",		sprUpgradesHealthUp,			5,	10,	4)
powerUp[POWERUP.MONEYDROP]=	new PowerUp(POWERUP.MONEYDROP,	"Money Drop Chance",		sprUpgradesMoneyDropChance,		5,	10,	4)
powerUp[POWERUP.MONEYUP]=	new PowerUp(POWERUP.MONEYUP,	"Stamina Recovery Up",		sprUpgradesSpeedUp,				20,	5,	5)
powerUp[POWERUP.STAMINA]=	new PowerUp(POWERUP.STAMINA,	"Increase maximum Stamina",	sprUpgradesSpeedUp,				15,	10,	1)
powerUp[POWERUP.SPEEDMAX]=	new PowerUp(POWERUP.SPEEDMAX,	"Max Velocity",				sprUpgradesStrengthUp,			7,	20,	10)

guyNudgeSpeed = 0.5	//the magnitude applied to enemies when touching. A constant weak force, prevents overlapping

healthStart = 3		//
healthMaxMax =	healthStart+powerUp[POWERUP.HPMAX].lvlMax		//The highest that Health can go
medkitSpawnRate = 5;

//POWERUP EFFECTS
function UpdatePowerUpEffect(_powerupIndex){
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
		break;
		case POWERUP.MONEYDROP:
			medkitSpawnRate++
		break;
		case POWERUP.MONEYUP:	//SUBSITUTE FOR RECOVERY REPLACE THE ENUM FOR THIS EVENTUALLY
			player.stamina_recoverMult =	lerp(	1,		4,	_powRatio)		
		break;
		case POWERUP.STAMINA:
			player.stamina_max =			floor(lerp(	200,	600,_powRatio))
			player.stamina = player.stamina_max
			player.spin_ready = true;
			
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

invMoney = global.money			//saved globally when restarting
invHealth =		healthStart		//
invHealthMax =	healthStart		//
							//healthMaxMax is in powerup section
heartGraphic = []
invuln = false;
invulnTimeMax = 80;
invulnTimeLeft = 0;

//MAKE HEART GRAPHICS
for(var i = 0; i < healthMaxMax; i++){
	heartGraphic[i] = instance_create_layer(40+70*i,WINDOWH-100,"GUI",objHeartMark)
	heartGraphic[i].visible = false;
}

//Trim to just used hearts
for(var i = 0; i < healthStart; i++){
	heartGraphic[i].visible = true;
}

function StartInvuln(){
	invulnTimeLeft = invulnTimeMax
	invuln = true;
}
function EndInvuln(){
	invuln = false;
}

function Damage(){

	if invuln return;
	invHealth--
	UpdateHealth()
	StartInvuln()
	if invHealth <= 0{
		//DEATH GOES HEREE
		GameOver()
	}
	var _bloop = SFX.PLAYER_HIT
	PlaySound(SFX.PLAYER_HIT)
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

function GameOver(){
	ToggleShop(1)
	PlaySound(SFX.PLAYER_KO)
	StartInvuln()
}
	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region UX / UI
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

shopOpen = false;
shopHighlight = 0	//whatever the first powerup is

function TogglePause(_pause = !PAUSED){
	PAUSED = _pause
	with objGuy UpdateAnimSpeed()
	
}
function ToggleShop(_open = !shopOpen){
	shopOpen = _open;
	TogglePause(shopOpen)
	
}

function DrawShopWindow(_x,_y){
	var _ww =	300	//window width
	var _wb	=	16	//window buffer
	var _rh	=	60	//row height
	draw_set_colour(c_dkgrey)
	draw_set_alpha(0.75)
	draw_rectangle(_x,_y,_x+_ww,_y+(_wb*2)+(_rh*POWERUP.COUNT),0)
	draw_set_colour(c_ltgrey)
	draw_set_alpha(1)
	draw_rectangle(_x,_y,_x+_ww,_y+(_wb*2)+(_rh*POWERUP.COUNT),1)
	draw_set_colour(c_white)
	for(var i = 0; i < POWERUP.COUNT; i++){
		DrawShopEntry(_x,_y+_rh*i,i)
		//DrawShopEntry(_x,_y+_wb*2+_rh*i,i)
	}
	
}

function DrawShopEntry(_x,_y,_powerupIndex,_selected = false){
	var _powerUp = powerUp[_powerupIndex]
	var _valid = true;
	//ICON
	draw_sprite(_powerUp.sprite,0,_x+12,_y+10)
	//PURCHASE BOX (move this since its an object)
	_powerUp.button.x = _x+12
	_powerUp.button.y = _y+10
	//NAME
	draw_set_font(fontMenu)
	draw_text(_x+83,_y+20,_powerUp.name)
	//COST
	draw_set_font(fontSubMenu)
	draw_text(_x+208,_y+50,$"COST: {_powerUp.GetCost()}")
	//Level
	var _level_string = $"LVL {_powerUp.level}"
	var _max_string =	$"/{_powerUp.lvlMax} max"
	if _powerUp.fullyLeveled{
		//Draw that it is maxed out
		_level_string = $"MAXIMUM LEVEL"
		_max_string =	$" Wow!!"
	}
	var _lm = string_width(_level_string)
	draw_text(_x+83,_y+50,_level_string)
	draw_set_font(fontSmall)
	draw_text(_x+85+_lm,_y+62,_max_string)
	
	
}



#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region MUSIC
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
if !audio_is_playing(soundTheme){
	audio_play_sound(soundTheme,10,1)
}
function ToggleSFXMute(_muted = !SFXMUTED){
	SFXMUTED = _muted	//stops things from still playing
}

function ToggleMusicMute(_muted = !MUSICMUTED){
	MUSICMUTED = _muted
	audio_sound_gain(soundTheme,!MUSICMUTED,0)
}

	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region ENEMY SPAWNS
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
enemies =	[]
currentWave = 0;
enemyCt =	0
validSpawns = []

waves =		global.waveData
if global.useTestWaves{
	waves = global.testWaveData
}
maxWaves =	array_length(waves)


//array_push(waves,[[objEnemy, 1],[objEnemy, 2]])

EnemyOnDeath = function(){	//what enemy does on death
	//Spawn a Coin maybe

	//reduce the counter
	objGame.enemyCt--

	instance_destroy()
	objGame.EndOfWaveCheck()
	
	PlaySound(isBoss ? SFX.ENEMY_BOSS_KO : SFX.ENEMY_KO)
	ScatterCoins(5)
}

function EndOfWaveCheck(){
	if enemyCt == 0{	
		PlaySound(SFX.WAVE_COMPLETE)
		with objEnemy instance_destroy()
		enemies = [];
		enemyCt =	0
		currentWave++
	
		//TEST CASE TO LOOP WAVES
		currentWave = currentWave mod maxWaves
		SpawnWave(currentWave)
	}
}

function AddEnemy(_enemyType, _count = 1){	//add enemy to the field (NEEDS WORK)
	var _newEnemy;
	repeat(_count){
		var _spawner = validSpawns[irandom(array_length(validSpawns)-1)]
		
		array_push(enemies,instance_create_layer(_spawner.x+random_range(-4,4),_spawner.y+random_range(-4,4),"Guys",_enemyType))
		_newEnemy = array_last(enemies)
		_newEnemy.OnDeath = method(_newEnemy,EnemyOnDeath)
	}
	enemyCt	+=_count
}

//RESET THJE GAME 
function CloseShop(){
	with objEnemy instance_destroy()
	player.BehaveStartIdle()
	enemies =	[]
	enemyCt =	0
	validSpawns = []
	currentWave = 0;
	SpawnWave(0)	//Start the wave over again
	
	invHealth = invHealthMax
	UpdateHealth()

	shopOpen = false
	TogglePause(false)
}
	

function SpawnWave(_waveNumber){
	var _wave = global.waveData[_waveNumber]
	if global.useTestWaves _wave = global.testWaveData[_waveNumber]
	
	validSpawns = []
	with objSpawner CheckReady()
	show_debug_message($"VALID SPAWNS: {validSpawns}")
	show_debug_message($"enemies: {enemies}")
	
	var _eGroup;
	
	for(var i = 0; i < array_length(_wave); i++){
		_eGroup = _wave[i]	//a number of the same enemies
		AddEnemy(asset_get_index(_eGroup[0]),_eGroup[1])	//Add the given number of the given enemy
	}
}


#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//APPLY POWERUP VALUES (may be different than objGuy defualt)
for(var i = 0; i < POWERUP.COUNT; i++){
	UpdatePowerUpEffect(i)
}

collideTilemap = layer_tilemap_get_id("Walls");

//ToggleMute()
alarm[0] = 1	//Spawns the first wave... needs to wait until spawners are present
//ToggleMusicMute(1)
//ToggleSFXMute(1)
audio_master_gain(0.5)