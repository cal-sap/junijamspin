
active = false;
OnClick = function(){
	if !active return;
	objGame.invMoney -=	objGame.powerUp[powerupID].GetCost()
	objGame.powerUp[powerupID].level++
	sprite_index = sprUIBoxClicked
}
