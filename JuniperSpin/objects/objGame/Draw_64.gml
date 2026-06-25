


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw Debugs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
	var _debugText = ""
	_debugText += $"R: Reset\n"
	_debugText += $"M: Mute\n"
	_debugText += $"O: Switch to Test waves\n"
	_debugText += $"P: Big Money\n"


	draw_set_colour(c_aqua)
	draw_set_font(fontSmall)
	draw_text(10,10,_debugText)

	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the Shop window / Game over data
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
if shopOpen{
	//Powerupwindow
	var _wb	=	16	//window buffer
	var _rh	=	60	//row height
	var _ww =	300	//window width
	var _spriteOffset = new Vec2(-32,-32)
	var _windowOrigin = new Vec2(40,60)	//The top Left of the window
	var _windowEnd =	new Vec2(		//The bottom right of the window
			_windowOrigin.x+_ww,	
			//_windowOrigin.y+(_rh*POWERUP.COUNT))
			_windowOrigin.y+(_wb*1)+(_rh*POWERUP.COUNT))

	DrawShopWindow(_windowOrigin.x,_windowOrigin.y)

}else{

#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Draw the WAVE Counter
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
draw_set_colour(c_white)
draw_set_font(fontMenu)
var _waveString = $"[Wave {currentWave+1}]: {enemyCt} Enemies remain"
draw_text(400,30,_waveString)
}
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
draw_healthbar(_hbuff,WINDOWH-_width-_vbuff,WINDOWW-_hbuff,WINDOWH-_vbuff,
	(_canSpin?player.stamina/player.stamina_max:0)*100,	//only show back bar when can spin
	_canSpin?c_black:#391d27,c_lime,c_lime,0,1,1)		//offcolor back when not able to spin
	
draw_healthbar(_hbuff,WINDOWH-_width-_vbuff+1,WINDOWW-_hbuff,WINDOWH-_vbuff-2,
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
var _moneyY = WINDOWH*0.8+(WINDOWH*0.1*shopOpen)
draw_sprite_ext(sprUIMoneyCenter,0,
			60,_moneyY,_scale,_scale,0,c_white,1)
draw_text(	80,_moneyY,	$"x{invMoney}")

	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~


if global.useTestWaves{
	draw_set_colour(c_lime)
	draw_text(	55*(current_second mod 4 < 2),
				44*(current_second mod 2 == 0),
				"[RUNNING testWaveData.json]")
}
//draw_text_transformed(WINDOWW-40,WINDOWH*0.9,$"x{invMoney}",_scale,_scale,0)
	
