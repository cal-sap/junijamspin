

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region DEBUG
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
if debug{
	draw_set_colour(debugColor)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)

//FIND THE TEXT
	var _stateString = "state: "
	switch (state) {
	    case GUY_STATE.IDLE:	_stateString += "IDLE";	break;
	    case GUY_STATE.WALK:	_stateString += "WALK";	break;
	    case GUY_STATE.SPIN:	_stateString += "SPIN";	break;
	    case GUY_STATE.HURT:	_stateString += "HURT";	break;
	    default:				_stateString += "?UNKNOWN?";	break;
	}
	_stateString += $" -----\nSpd:{Vec2Magnitude(move_speed)}"
	if state == GUY_STATE.SPIN _stateString += $"\nSpin Level: {spin_level}"

//MOVE DIRECTION ARROW
	var _arrowSize = 100
	draw_arrow(x,y,
		x+lengthdir_x(_arrowSize,move_direction),
		y+lengthdir_y(_arrowSize,move_direction),
		20)
//DIRECTION ARROW
	draw_set_colour(debugColor2)
	draw_arrow(x,y,
		x+lengthdir_x(_arrowSize,direction),
		y+lengthdir_y(_arrowSize,direction),
		20)
		
//PRINTING THE ACTUAL TEXT
	draw_text(x-111,y-100,_stateString)
	
}

if drawDirectionArrow{
	draw_sprite_ext(sprUIDirectionArrow,0,x,y,1,1,move_direction,c_white,1)
}

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~



DrawShadow()
//DrawGuy()
draw_sprite_ext(sprite_index, image_index, x + spin_shakeX, y + spin_shakeY, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region SPINNING LINE
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
var _points = 120
var _angleInc = 10
draw_set_colour(c_red)
draw_primitive_begin(pr_linestrip)
var _mouseDist = point_distance(x,y,mouse_x,mouse_y)
var _mouseDir = point_direction(x,y,mouse_x,mouse_y)

for(var i = 0; i < _points; i++){
	//draw_vertex(x+, _yy);
}

draw_primitive_end()


#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the "spin bar" (no longer used?)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
if drawHP{
	DrawUISpinBar(hp/hp_max,c_maroon)
}


#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

