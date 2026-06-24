
var _debugText = ""
_debugText += $"x:{player.x}\n"
_debugText += $"y:{player.y}\n"
_debugText += $"speed:{player.move_speed}\n"


draw_set_colour(c_black)
draw_text(10,10,_debugText)


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the Shop window
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
if shopOpen{
//Powerupwindow
var _wb	=	16	//window buffer
var _rh	=	60	//row height
var _ww =	600	//window width
var _spriteOffset = new Vec2(-32,-32)
var _windowOrigin = new Vec2(40,60)	//The top Left of the window
var _windowEnd =	new Vec2(		//The bottom right of the window
		_windowOrigin.x+_ww,	
		//_windowOrigin.y+(_rh*POWERUP.COUNT))
		_windowOrigin.y+(_wb*1)+(_rh*POWERUP.COUNT))

draw_set_colour(c_dkgray)
draw_rectangle(_windowOrigin.x,_windowOrigin.y,_windowEnd.x,_windowEnd.y,0)
draw_set_colour(c_ltgrey)
draw_rectangle(_windowOrigin.x,_windowOrigin.y,_windowEnd.x,_windowEnd.y,1)

draw_set_colour(c_white)
var _ln = new Vec2(_windowOrigin.x+_wb,_windowOrigin.y+_wb)	//Line item
var _windowMargin = _ln.x	//position of the left margin
draw_set_valign(fa_middle)
for(var i = 0; i < POWERUP.COUNT; i++){
	_ln.x = _windowMargin;
	_ln.y = _windowOrigin.y+(_wb*2)+(_rh*i)
	//ICON
	draw_sprite(powerUp[i].sprite,0,_ln.x+_spriteOffset.x+20,_ln.y+_spriteOffset.y)
	_ln.x += 50	//width of this element
	//NAME
	draw_set_font(fontMenu)
	draw_text(_ln.x,_ln.y,powerUp[i].name)
	_ln.x += 120	//width of this element
	//LEVEL
	draw_text(_ln.x,_ln.y,$"Level: [{powerUp[i].level}/{powerUp[i].lvlMax}]")
	_ln.x += 160	//width of this element
	//COST
	draw_sprite(sprUIMoney,0,_ln.x+_spriteOffset.x,	_ln.y+_spriteOffset.y)
	_ln.x += 30	//width of this element
	draw_text(	_ln.x,	_ln.y,$"COST: {powerUp[i].GetCost()}")
	_ln.x += 120	//width of this element
	//PURCHASE BOX
	powerUp[i].button.x = _ln.x
	powerUp[i].button.y = _ln.y+_spriteOffset.y
	
}}
draw_set_valign(fa_top)

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the "Stamina bar"
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

var _hbuff = 66
var _width = 8
var _vbuff = 22
var _canSpin = player.spin_ready

//Stamina bar with backing, showing cost
draw_healthbar(_hbuff,room_height-_width-_vbuff,room_width-_hbuff,room_height-_vbuff,
	(_canSpin?player.stamina/player.stamina_max:0)*100,	//only show back bar when can spin
	_canSpin?c_black:#391d27,c_lime,c_lime,0,1,1)		//offcolor back when not able to spin
	
draw_healthbar(_hbuff,room_height-_width-_vbuff+1,room_width-_hbuff,room_height-_vbuff-2,
	(player.stamina-(_canSpin*player.stamina_spinCost))/player.stamina_max*100,
	c_black,c_olive,c_green,0,0,0)

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the Money Counter
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

var _ratio = min(invMoney/200,1)	//Min to maximum money val
var _scale = lerp(1,	2,	_ratio)	//Min to maximum scale
draw_set_colour(c_white)
draw_set_font(fontMenu)
draw_sprite_ext(sprUIMoneyCenter,0,
			room_width-110,room_height*0.8,_scale,_scale,0,c_white,1)
draw_text(	room_width-80,room_height*0.8,$"x{invMoney}")

	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


if global.useTestWaves{
	draw_set_colour(c_lime)
	draw_text(	55*(current_second mod 4 < 2),
				44*(current_second mod 2 == 0),
				"[RUNNING testWaveData.json]")
}
//draw_text_transformed(room_width-40,room_height*0.9,$"x{invMoney}",_scale,_scale,0)
	
