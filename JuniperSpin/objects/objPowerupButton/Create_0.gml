
//
//puEntry = objGame.powerUp[powerupID]
//show_debug_message($"POWER UP {puEntry}")

active = false;
//Can only be clicked when active
OnClick = function(){
	show_debug_message("CLICK!")	
	//Spend money
	objGame.invMoney -=	objGame.powerUp[powerupID].GetCost()
	objGame.powerUp[powerupID].level++
	objGame.UpdatePowerUpEffect(powerupID)
	sprite_index = sprUIBoxClicked
}
