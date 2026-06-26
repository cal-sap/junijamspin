

DrawShadow(0,20)
var _invulnRatio = invulnTime / invulnMax
var _h = sin(_invulnRatio*pi)*arcHeight

if !flashing || InvulnFlashBool(){
	draw_sprite_ext(sprite_index,image_index,x,y-_h,image_yscale,image_xscale,0,image_blend,image_alpha)
}