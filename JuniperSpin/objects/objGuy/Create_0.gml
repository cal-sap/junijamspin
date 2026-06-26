

enum GUY_STATE{
	IDLE,
	WALK,
	SPIN,
	HURT,
	PREP,
	ATTACK,
	CLASH
}


mask_index = sprGuyWalk
image_scale = 0.75
image_xscale = image_scale
image_yscale = image_scale
shadow_yscale_mult = 0.3;
shadow_xscale_mult = 1.2;
spriteData_idle = sprGuyIdle
spriteData_walk = sprGuyWalk
spriteData_hurt = sprGuyHurt
spriteData_dead = sprGuyDead
debugColor = c_lime
debugColor2 = c_green
animSpeed = image_speed;
drawDirectionArrow = false;
drawHP = false;
isBoss = false;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Gameplay Parameters Etc.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

move_speed = {x:0,y:0}	//[NOT PARAMETER]
move_direction = 0		//[NOT PARAMETER] Where the guy is physically moving, 
move_accel = 0.5		//these are additive to the speed
move_decel = 0.4		//THIS IS A POSITIVE NUMBER
move_maxSpeed = 9

targetPos = {x:x,y:y}		//[NOT PARAMETER]
facing = 1					//[NOT PARAMETER] The Xscale of the sprite
faceGraceDegrees = 10	//you need to be facing the other direction by this amount to turn the sprite around (10 = 80-100 degrees & 260-280)

hp_max =	20			//****PLAYER HEALTH IS HANDLED IN objGame.invHealth
hp =	hp_max			//[NOT PARAMETER]
hurt_timeMax = 50
hurt_timeLeft = 0		//[NOT PARAMETER]
damage = 1;				//damage dealt by player spinnning, or enemy touch

spin_accel = move_accel	//
spin_decel = 0.1		//alternate movement tech when spinning, low friction THIS IS A POSITIVE NUMBER	
spin_timeMax = 40
spin_timeLeft = 0	//[NOT PARAMETER]
spin_cooldownMax = 60
spin_cooldownLeft = 0	//[NOT PARAMETER]
spin_level = 0			//[NOT PARAMETER]
spin_levelMaxMax = 7	//The maximum level of spins there are
spin_levelMax = 7		//the maximum level of spin you have access to
spin_lvl_sprite =	[sprGuySpin0,sprGuySpin1,sprGuySpin2,sprGuySpin3,sprGuySpin4,sprGuySpin5,sprGuySpin6]
spin_lvl_maxSpeed = [	16,	18,	20,	22,	24,	26,	28]
spin_ready = true	//[NOT PARAMETER] if you are not affected by cooldown
spin_dustCloudStepMax = 6
spin_dustCloudStepLeft = 0	//[NOT PARAMETER]
spin_knockbackMult = 1.0
spin_soundStart = sfxFireSpinStart
spin_soundEnd = sfxSpinStart


stamina_max = 400		//steps (60fps) for a full bar
stamina_startCost = 50	//minimum downtime to take inbetween spins (prevents spamming)
stamina_spinCost = 10	//additional cost of stamina when "shifting up" in power.
stamina_recoverMult = 1.5	//How much faster/slower stamina recovers than depletes
stamina = stamina_max

state = GUY_STATE.IDLE		//[NOT PARAMETER]
aiState = GUY_STATE.IDLE	//[NOT PARAMETER]
stateChanReady = true;		//[NOT PARAMETER]

debug = false;

DrawGuy = draw_self

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region State Behavior stuff
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

BehaveStopIdle = function(){
	targetPos = PositionRandomInRoom()
	state = GUY_STATE.WALK
}
BehaveStartIdle = function(){
	sprite_index = spriteData_idle
	state = GUY_STATE.IDLE
}
BehaveStartWalk = function(){
	sprite_index = spriteData_walk
	state = GUY_STATE.WALK
}

BehaveStartHurt = function(_direction,_knockback){
	hurt_timeLeft = hurt_timeMax
	state = GUY_STATE.HURT
	sprite_index = spriteData_hurt
	direction = _direction
	move_speed = Vec2Add(move_speed,Vec2FromMagDir(_knockback,_direction))
	//move_speed = Vec2FromMagDir(_knockback,_direction)
}
BehaveStopHurt = function(){
	hurt_timeLeft = 0
	BehaveStartIdle()	
}

BehaveStartSpin = function(){
	if !spin_ready || objGame.invuln return;

	stamina -= stamina_startCost
	state = GUY_STATE.SPIN
	spin_level = 0
	sprite_index = spin_lvl_sprite[spin_level]
	spin_timeLeft = spin_timeMax	//start counting spin time to level up
	spin_dustCloudStepLeft = spin_dustCloudStepMax
	PlaySound(SFX.SPIN_START)
}
BehaveContinueSpin = function(){
	if !spin_ready return;
	stamina--	
	state = GUY_STATE.SPIN
	if stamina <= 0 BehaveStopSpin()
}
BehaveStopSpin = function(){
	//enforce a clean spinning reset
	spin_timeLeft = 0
	spin_dustCloudStepLeft = 0
	spin_cooldownLeft = spin_cooldownMax
	spin_ready = false	//if you are not affected by cooldown
	BehaveStartIdle()
	PlaySound(SFX.SPIN_END)
}
BehaveLevelUpSpin = function(){
	if stamina < stamina_spinCost return;
	if spin_level >= spin_levelMax-1 return;
	spin_level++
	stamina -= stamina_spinCost	//"Shifting up" cost

	sprite_index = spin_lvl_sprite[spin_level]
	spin_timeLeft = spin_timeMax	//refresh spin time
	
	PlaySound(SFX.SPIN_SPEED_UP,1+(0.12*spin_level))
}
BehaveOnWallBounce = function(){


}

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
	

CollideWithGuy =	function(_other){
	if PAUSED return;
	///nudge out
	var _awayDir = point_direction(_other.x,_other.y,x,y)
	move_speed = Vec2Add(move_speed,	new Vec2(
		lengthdir_x(objGame.guyNudgeSpeed,_awayDir),
		lengthdir_y(objGame.guyNudgeSpeed,_awayDir)))
	UpdateMoveDirection()
}
CollideWithCoin =	function(_other){}	//Only Player picks up coin
CollideWithMedpack =function(_other){}	//Only Player picks up coin


UpdateAnimSpeed = function(){
	if PAUSED image_speed = 0;	else image_speed = animSpeed;
}
UpdateAnimSpeed()	//Do whatever the pause functionality is when this is created.

function SpriteFlipCheck(){
	if facing == 1{
		if (direction >= 90+faceGraceDegrees && direction <= 270-faceGraceDegrees){
			facing = -1
		}
	}else{	//can only be -1
		if (direction <= 90-faceGraceDegrees || direction >= 270+faceGraceDegrees){
			facing = 1
		}
	}
	image_xscale = facing * image_scale
}
function UpdateMoveDirection(_updatePointingDirection = false){
	move_direction = point_direction(0,0,move_speed.x,	move_speed.y)
	if _updatePointingDirection direction = move_direction
}
function UpdateFloatyMove(_acceldir = undefined,_maxSp = move_maxSpeed){
	var _accel = move_accel
	var _decel = move_decel
	
	switch(state){
		case GUY_STATE.SPIN: _accel = spin_accel;	_decel = spin_decel; break;
		case GUY_STATE.HURT: _accel *= 2;			 break;
	}
	

	var _mag = Vec2Magnitude(move_speed)		//how fast its currently moving
	
	if is_undefined(_acceldir) || _mag > _maxSp{	//Not acceling in any direction OR going too fast, slow down
		if _mag <= _decel{						//slowed to a stop
			move_speed = {x:0,y:0}
		}else{
			var _decelVec2 = Vec2FromMagDir(-_decel,move_direction)	//how much this slows down
			move_speed = Vec2Add(move_speed,_decelVec2)				//apply deceleration
			UpdateMoveDirection()
		}
		
	}else{				//accelerating in a given direction
	//find acceleration vector
		var _accelVec2 = Vec2FromMagDir(_accel,_acceldir)	
	//apply acceleration
		move_speed = Vec2Add(move_speed,_accelVec2)		

	//update direction you are moving.
		UpdateMoveDirection()
	}


	//CHECK FOR COLLISIONS
	var _collideX = place_meeting(x+move_speed.x,y,objGame.collideTilemap)
	var _collideY = place_meeting(x,y+move_speed.y,objGame.collideTilemap)
	if !(_collideX || _collideY) && place_meeting(x+move_speed.x,y+move_speed.y,objGame.collideTilemap){	//Diagonal check
		_collideX = true;	_collideY = true;
	}
	
	if _collideX {
		move_speed.x = -move_speed.x
	}
	
	if _collideY {
		move_speed.y = -move_speed.y
	}
	
	if (_collideX || _collideY) UpdateMoveDirection(true)
	direction = move_direction
	
	//MOVE
	x += move_speed.x
	y += move_speed.y

}

function DrawUISpinBar(_amount,_color = c_aqua){
	var _minCol = merge_colour(_color,c_black,0.5)
	draw_healthbar(x-40,y-60,x+40,y-55,_amount *100,c_black,_minCol,_color,0,1,1)
}
	
Damage = function(_amount){
	hp -= _amount
	if _amount <= 3{		PlaySound(SFX.ENEMY_HIT_S)}
	else if _amount <= 6{	PlaySound(SFX.ENEMY_HIT_M)}
	else {					PlaySound(SFX.ENEMY_HIT_L)}
	
	
	if hp <= 0
	OnDeath()
}
OnDeath = function(){}