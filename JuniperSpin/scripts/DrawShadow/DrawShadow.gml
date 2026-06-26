function DrawShadow(_xoffset = 0,_yoffset = 0){
	draw_sprite_ext(
	    sprite_index, 
	    image_index, 
	    x + 8 + _xoffset,          // Shift shadow 4 pixels right
	    y + 2 + _yoffset,          // Shift shadow 4 pixels down
	    image_xscale * shadow_xscale_mult, 
	    image_yscale * shadow_yscale_mult, 
	    image_angle, 
	    c_black,        // Tint the sprite pure black
	    0.2             // Set transparency (0 = invisible, 1 = solid)
	);
}