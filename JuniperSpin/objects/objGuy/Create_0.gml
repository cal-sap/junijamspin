

enum GUY_STATE{
	IDLE,
	WALK,
	SPIN,
	HURT,
	CLASH
}


mask_index = sprGuyWalk
image_scale = 0.75
image_xscale = image_scale
image_yscale = image_scale
spriteData_idle = sprGuyIdle
spriteData_walk = sprGuyWalk
spriteData_hurt = sprGuyHurt
spriteData_dead = sprGuyDead
debugColor = c_lime
debugColor2 = c_green

move_accel = 0.5	//these are additive to the speed
move_decel = 0.4	//THIS IS A POSITIVE NUMBER
move_speed = {x:0,y:0}
move_maxSpeed = 9
move_direction = 0 //Where the guy is physically moving, 

facing = 1
faceGraceDegrees = 10	//you need to be facing the other direction by this amount to turn the sprite around
targetPos = {x:x,y:y}

hp_max =	20
hp =	hp_max
hurt_timeMax = 50
hurt_timeLeft = 0

spin_decel = 0.1	//alternate movement tech when spinning, low frictionTHIS IS A POSITIVE NUMBER	
spin_timeMax = 40
spin_timeLeft = 0
spin_cooldownMax = 60
spin_cooldownLeft = 0
spin_level = 0
spin_levelMax = 7
spin_lvl_sprite = [sprGuySpin0,sprGuySpin1,sprGuySpin2,sprGuySpin3,sprGuySpin4,sprGuySpin5,sprGuySpin6]
spin_lvl_maxSpeed = [	16,	18,	20,	22,	24,	26,	28]
spin_ready = true	//if you are not affected by cooldown
spin_dustCloudStepMax = 7
spin_dustCloudStepLeft = 0
spin_knockbackMult = 1.0
spin_soundStart = sfxFireSpinStart
spin_soundEnd = sfxSpinStart

stamina_max = 200	//steps for a full bar
stamina_spinCost = floor(stamina_max/(spin_levelMax+3))
stamina = stamina_max

state = GUY_STATE.IDLE
aiState = GUY_STATE.IDLE
stateChanReady = true;

debug_bounceWall = true;
debug = true;

BehaveStopIdle = function(){
	targetPos = PositionRandomInRoom()
	state = GUY_STATE.WALK
}
BehaveStartIdle = function(){
    image_speed = 0
	sprite_index = spriteData_idle
	state = GUY_STATE.IDLE
}
BehaveStartWalk = function(){
	image_speed = 1
	sprite_index = spriteData_walk
	state = GUY_STATE.WALK
}
BehaveStartSpin = function(){
	if !spin_ready return;
	if stamina < stamina_spinCost return;
	spin_ready = false
	stamina -= stamina_spinCost 
	
	state = GUY_STATE.SPIN
	image_speed = 1
	spin_level = 0
	sprite_index = spin_lvl_sprite[spin_level]
	spin_cooldownLeft = 0
	spin_timeLeft = spin_timeMax	//refresh spin time
	spin_dustCloudStepLeft = spin_dustCloudStepMax
	
	PlaySound(spin_soundStart)
}
BehaveContinueSpinStart = function(){
	if !spin_ready return;
	stamina -= stamina_spinCost*2
	state = GUY_STATE.SPIN
	spin_level = 0
	image_speed = 1
	sprite_index = spin_lvl_sprite[spin_level]
	spin_timeLeft = spin_timeMax	//start counting spin time to level up
	spin_dustCloudStepLeft = spin_dustCloudStepMax
	PlaySound(spin_soundStart)
}
BehaveContinueSpin = function(){
	if !spin_ready return;
	stamina-= 0.5;
	state = GUY_STATE.SPIN
	if stamina <= 0 BehaveStopSpin()
}
BehaveStartHurt = function(_direction,_knockback){
	hurt_timeLeft = hurt_timeMax
	state = GUY_STATE.HURT
	image_speed = 1
	sprite_index = spriteData_hurt
	direction = _direction
	move_speed = Vec2Add(move_speed,Vec2FromMagDir(_knockback,_direction))
	//move_speed = Vec2FromMagDir(_knockback,_direction)
	show_debug_message($"OW! {_direction}")
}
BehaveStopHurt = function(){
	hurt_timeLeft = 0
	BehaveStartIdle()	
}
	
BehaveStopSpin = function(){
	//enforce a clean spinning reset
	spin_timeLeft = 0
	spin_dustCloudStepLeft = 0
	spin_cooldownLeft = spin_cooldownMax
	spin_ready = false	//if you are not affected by cooldown
	BehaveStartIdle()
	PlaySound(spin_soundEnd,0.8)
}
BehaveLevelUpSpin = function(){
	if stamina < stamina_spinCost return;
	if spin_level >= spin_levelMax-1 return;
	spin_level++
	if !objGame.debug_continuousSpin{
		stamina -= stamina_spinCost
	}
	sprite_index = spin_lvl_sprite[spin_level]
	spin_timeLeft = spin_timeMax	//refresh spin time
	
	PlaySound(spin_soundStart,1+(0.12*spin_level))
}
BehaveOnWallBounce = function(){
	
}

//only used if move speed ins't a vector
//function MoveInDirection(_direction){
//	move_and_collide(
//		lengthdir_x(move_speed,_direction),
//		lengthdir_y(move_speed,_direction),
//		[objGame.collideTilemap,objGuy])
//}

CollideWithGuy = function(_other){
	///nudge out
	var _awayDir = point_direction(_other.x,_other.y,x,y)
	move_speed = Vec2Add(move_speed,	new Vec2(
		lengthdir_x(objGame.guyNudgeSpeed,_awayDir),
		lengthdir_y(objGame.guyNudgeSpeed,_awayDir)))
}


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
	var _decel = move_decel
	if state == GUY_STATE.SPIN _decel = spin_decel
	var _mag = Vec2Magnitude(move_speed)		//how fast its currently moving
	
	if is_undefined(_acceldir) || _mag > _maxSp{	//Not acceling in any direction OR going too fast, slow down
		if _mag <= _decel{						//slowed to a stop
			move_speed = {x:0,y:0}
		}else{
			var _decelVec2 = Vec2FromMagDir(-_decel,move_direction)	//how much this slows down
			move_speed = Vec2Add(move_speed,_decelVec2)					//apply deceleration
			UpdateMoveDirection()
		}
		
	}else{				//accelerating in a given direction
	//find acceleration vector
		var _accelVec2 = Vec2FromMagDir(move_accel,_acceldir)	
	//apply acceleration
		move_speed = Vec2Add(move_speed,_accelVec2)		
	//limit the max speed
		//if Vec2Magnitude(move_speed) > _maxSp{	
		//	move_speed = Vec2Normalize(move_speed,_maxSp)
		//}
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

	
	//MOVE
	x += move_speed.x
	y += move_speed.y
	
	//move_and_collide(	move_speed.x,	move_speed.y,	[objGame.collideTilemap,objGuy])

}

function DrawUISpinBar(_amount,_color = c_aqua){
	var _minCol = merge_colour(_color,c_black,0.5)
	draw_healthbar(x-40,y-60,x+40,y-55,_amount *100,c_black,_minCol,_color,0,1,1)
}