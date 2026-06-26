
//
//puEntry = objGame.powerUp[powerupID]
//show_debug_message($"POWER UP {puEntry}")

active = false;
//Can only be clicked when active
OnClick = function(){
	//Check if active after clicking, so 
	if active{
		PlaySound(SFX.SHOP_PURCHASE)
		//Spend money
		objGame.invMoney -=	objGame.powerUp[powerupID].GetCost()
		objGame.powerUp[powerupID].level++
		objGame.UpdatePowerUpEffect(powerupID)
	
		sprite_index = sprUIBoxClicked
	}else{
		//Unable to buy
		PlaySound(SFX.SHOP_CANTAFFORD)
	}
}
