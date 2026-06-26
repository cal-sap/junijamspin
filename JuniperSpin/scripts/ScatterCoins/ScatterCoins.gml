function ScatterCoins(_coinCount){
	
	var _dir = irandom(360)
	var _inc = 360/_coinCount
	
	//One of the pickups has a chance to be a medpack
	var _pickupAsset = objCoin
	//if objGame.powerUp[POWERUP.HPDROP].level >= irandom(99){
	if objGame.medkitSpawnRate > irandom(99){
		_pickupAsset = objMedpack
	}
	instance_create_depth(x,y,depth,_pickupAsset,{direction: _dir+irandom(5)})
	_dir += _inc
	
	//The rest are all coins
	repeat(_coinCount-1){
		instance_create_depth(x,y,depth,objCoin,{direction: _dir+irandom(5)})
		_pickupAsset = objCoin	//go back to coins
		_dir += _inc
	}
}