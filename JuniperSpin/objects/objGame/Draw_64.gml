
var _debugText = ""
_debugText += $"x:{player.x}\n"
_debugText += $"y:{player.y}\n"
_debugText += $"speed:{player.move_speed}\n"


draw_set_colour(c_black)
draw_text(10,10,_debugText)