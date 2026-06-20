

enum GUY_STATE{
	IDLE,
	WALK,
	SPIN,
	CLASH
}

mask_index = sprGuyWalk
image_scale = 0.75
image_xscale = image_scale
image_yscale = image_scale


move_accel = 0.5	//these are additive to the speed
move_decel = 0.4	//THIS IS A POSITIVE NUMBER
move_speed = {x:0,y:0}
move_maxSpeed = 16
move_direction = 0 //Where the guy is physically moving, 

facing = 1
faceGraceDegrees = 10	//you need to be facing the other direction by this amount to turn the sprite around
targetPos = {x:x,y:y}

spin_time = 4
spin_speed = 6
spin_cooldown = 20

stamina_max = 100
stamina = stamina_max

state = GUY_STATE.IDLE
aiState = GUY_STATE.IDLE



debug_bounceWall = true;
debug = true;


BehaveStopIdle = function(){
	targetPos = PositionRandomInRoom()
	state = GUY_STATE.WALK
}

BehaveStartIdle = function(){
        image_speed = 0
		sprite_index = sprGuyWalk
		state = GUY_STATE.IDLE
}

BehaveStartWalk = function(){
        image_speed = 1
		sprite_index = sprGuyWalk
		state = GUY_STATE.WALK
}

BehaveStartSpin = function(){
        image_speed = 1
		sprite_index = sprGuySpin0
		state = GUY_STATE.SPIN
}


//only used if move speed ins't a vector
//function MoveInDirection(_direction){
//	move_and_collide(
//		lengthdir_x(move_speed,_direction),
//		lengthdir_y(move_speed,_direction),
//		[objGame.collideTilemap,objGuy])
//}


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
function UpdateMoveDirection(){
	move_direction = point_direction(0,0,move_speed.x,	move_speed.y)
}
function UpdateFloatyMove(_acceldir = undefined){
	if is_undefined(_acceldir){	//Not acceling in any direction, slow down
		var _mag = Vec2Magnitude(move_speed)
		if _mag <= move_decel{
			move_speed = {x:0,y:0}
		}else{
			var _decelVec2 = Vec2FromMagDir(-move_decel,move_direction)	//how much this slows down
			move_speed = Vec2Add(move_speed,_decelVec2)	//apply deceleration
			UpdateMoveDirection()
		}
		
	}else{	//accelerating in a given direction
	//find acceleration vector
		var _accelVec2 = Vec2FromMagDir(move_accel,_acceldir)	
	//apply acceleration
		move_speed = Vec2Add(move_speed,_accelVec2)		
	//limit the max speed
		if Vec2Magnitude(move_speed) > move_maxSpeed{	
			move_speed = Vec2Normalize(move_speed,move_maxSpeed)
		}
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
	
	if (_collideX || _collideY) UpdateMoveDirection()

	
	//MOVE
	x += move_speed.x
	y += move_speed.y
	
	//move_and_collide(	move_speed.x,	move_speed.y,	[objGame.collideTilemap,objGuy])

}