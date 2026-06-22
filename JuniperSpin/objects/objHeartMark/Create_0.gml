

popping = false;
function Pop(){
	sprite_index = sprUIHeartExplode
	popping = true;
	image_index = 0;
}

function Recover(){
	image_index = floor(0.01*x)*0.6;
}


Recover()