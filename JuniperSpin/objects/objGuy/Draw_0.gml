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