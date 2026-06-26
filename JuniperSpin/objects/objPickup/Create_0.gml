
image_speed = random_range(0.75,1)
move_speed = Vec2FromMagDir(irandom_range(3,8),direction)	//speed

lifeTimeMax =	irandom_range(500,700)
lifeTime =		lifeTimeMax

arcHeight = 150;

invuln = true;	//if this can be picked up
invulnMax = 60;	//if this can be picked up
invulnTime = invulnMax;	//if this can be picked up

shadow_yscale_mult = 0.3;
shadow_xscale_mult = 1.2;

flashing = false;	//the blinking before it fades out
