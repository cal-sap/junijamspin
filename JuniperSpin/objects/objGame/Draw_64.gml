
var _debugText = ""
_debugText += $"x:{player.x}\n"
_debugText += $"y:{player.y}\n"
_debugText += $"speed:{player.move_speed}\n"


draw_set_colour(c_black)
draw_text(10,10,_debugText)


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the "Stamina bar"
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

var _hbuff = 66
var _width = 8
var _vbuff = 22
var _canSpin = player.stamina >= player.stamina_spinCost

//Stamina bar with backing, showing cost
draw_healthbar(_hbuff,room_height-_width-_vbuff,room_width-_hbuff,room_height-_vbuff,
	(_canSpin?player.stamina/player.stamina_max:0)*100,	//only show back bar when can spin
	_canSpin?c_black:#391d27,c_lime,c_lime,0,1,1)		//offcolor back when not able to spin
	
draw_healthbar(_hbuff,room_height-_width-_vbuff+1,room_width-_hbuff,room_height-_vbuff-2,
	(player.stamina-(_canSpin*player.stamina_spinCost))/player.stamina_max*100,
	c_black,c_olive,c_green,0,0,0)

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

