

///MANAGE BEHAVIORS

///PLAYER CONTROL

var _inputX = (keyboard_check(ord("D")) || keyboard_check(vk_right)) -	(keyboard_check(ord("A")) || keyboard_check(vk_left)) 
var _inputY = (keyboard_check(ord("S")) || keyboard_check(vk_down)) -	(keyboard_check(ord("W")) || keyboard_check(vk_up)) 

//Move or stand still
if _inputX != 0 || _inputY != 0 {
	player.aiState = GUY_STATE.WALK
	player.direction = point_direction(0,0,_inputX,_inputY)
}else{
	player.aiState = GUY_STATE.IDLE
}


if keyboard_check(vk_space){
	player.aiState = GUY_STATE.SPIN
}
//AI CONTROLLER
for (var i = 0; i < enemyCt; ++i) {
	var _enemy = enemies[i]
    _enemy.aiState = GUY_STATE.WALK
	_enemy.direction = point_direction(_enemy.x,_enemy.y,player.x,player.y)
}


