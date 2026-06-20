draw_self()
if debug{
	draw_set_colour(c_lime)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
	
	var _stateString = "state: "
	
	switch (state) {
	    case GUY_STATE.IDLE:	_stateString += "IDLE";	break;
	    case GUY_STATE.WALK:	_stateString += "WALK";	break;
	    case GUY_STATE.SPIN:	_stateString += "SPIN";	break;
	    default:				_stateString += "?UNKNOWN?";	break;
	}
	
	draw_text(x,y-100,_stateString)
	var _arrowSize = 100
	draw_arrow(x,y,
		x+lengthdir_x(_arrowSize,move_direction),
		y+lengthdir_y(_arrowSize,move_direction),
		20)
}