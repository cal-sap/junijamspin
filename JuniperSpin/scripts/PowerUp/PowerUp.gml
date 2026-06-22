function PowerUp(_name,_sprite,_lvlMax,_costStart,_costInc,_button) constructor{
	name = _name
	sprite = _sprite
	lvlMax = _lvlMax
	costStart = _costStart
	costInc = _costInc
	level = 0
	button = _button
	
	function GetCost(){
		return level*costInc+ costStart
	}
}