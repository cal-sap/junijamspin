
var _clickCollide = point_in_rectangle(device_mouse_raw_x(0),device_mouse_raw_y(0),bbox_left,bbox_top,bbox_right,bbox_bottom)


if _clickCollide && objGame.shopOpen {
	//global.money = objGame.invMoney
	objGame.CloseShop();

	PlaySound(SFX.SHOP_COMPLETE)
}