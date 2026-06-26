var _touchingPlayer = place_meeting(x, y, objGame.player)

//Animate if any Guy touches this, not just player
if (place_meeting(x, y, objGuy)) {
	if !touched	{//TOUCHED FOR FIRST TIME
		if _touchingPlayer PlaySound(SFX.PLAYER_FOLIAGE)
		else PlaySound(SFX.ENEMY_FOLIAGE)
	}
	touched = true;
    image_speed = defaultSpeed;
} else if (touched) {
    image_speed = 0;
    image_index -= defaultSpeed; // Reverse animation speed.
    if (image_index <= 0) {
        image_index = 0;
        touched = false;
    }
}