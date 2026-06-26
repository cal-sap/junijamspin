function ScatterCoins(_coinCount){
	
	var _dir = irandom(360)
	var _inc = 360/_coinCount
	
	repeat(_coinCount){
		instance_create_depth(x,y,depth,objCoin,{direction: _dir+irandom(5)})
		_dir += _inc
	}
}