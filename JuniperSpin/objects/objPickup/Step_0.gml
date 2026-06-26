if PAUSED return

//check if can be picked up


if invulnTime > 0{
	invulnTime--
	if invulnTime <= 0{
		invulnTime = 0
		invuln = false;
	}
	
}


if lifeTime > 0{
	lifeTime--
	if lifeTime <= 0{
		instance_destroy()
	}else if (lifeTime/ lifeTimeMax) < 0.2{
		flashing = true
	}
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
	
if (_collideX || _collideY) direction = point_direction(0,0,move_speed.x,move_speed.y)
	
//MOVE
x += move_speed.x
y += move_speed.y