function PowerUp(_index,_name,_sprite,_lvlMax,_costStart,_costInc) constructor{
	index = _index
	name = _name
	sprite = _sprite
	lvlMax = _lvlMax	//inclusive. Start at 0
	costStart = _costStart
	costInc = _costInc
	level = 0
	button = instance_create_layer(0,0,"GUI",objPowerupButton,{ powerupID:	index})
	
	selected = false	//if the GUI has this selected
	fullyLeveled = false;	//if this is max level
	buyable = false
	boxAnimTime = 0
	boxAnimTimeMax = 40

	
	//Functional step event. Manages timers and various traits of a powerup in context of the shop
	function Update(){
	
		//Find if fully leveled
		if level >= lvlMax{
			level = lvlMax
			fullyLeveled = true;
		}
	
		//find cost and buyability
		var _cost =  level*costInc + costStart
		buyable = (objGame.invMoney >= _cost) && !fullyLeveled
	
		//find if Selected
		selected = objGame.shopHighlight == index
	
		//animate
		if boxAnimTime > 0{
			boxAnimTime--
		}	
	}
	
	
	function GetCost(){
		return level*costInc+ costStart
	}
	
}