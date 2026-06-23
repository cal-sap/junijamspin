

popping = false;
function Pop(){
	sprite_index = sprUIHeartExplode
	popping = true;
	image_index = 0;
}

function Recover(){
	visible = true
	popping = false;
	sprite_index = sprUIHeart
	image_index = floor(0.01*x)*0.6;
}


Recover()