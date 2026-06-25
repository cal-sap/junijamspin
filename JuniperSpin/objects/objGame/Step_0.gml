

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
//MAYBE YOU SHOULD REMOVE THE enemies[] ARRAY SINCE I DONT WANT TO FIND THE INDEX AGAIN
//NEW VERSION
with objEnemy {
	
    aiState = GUY_STATE.WALK	//REPLACE A BEHAVIOR FUNCTION HERE
	direction = point_direction(x,y,objGame.player.x,objGame.player.y)
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region TIMERs ETC updates
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

if invulnTimeLeft > 0{
	invulnTimeLeft--
	if invulnTimeLeft <= 0{
		invulnTimeLeft = 0
		EndInvuln()
	}
}

//UPDATE ALL Powerups
for(var i = 0; i < POWERUP.COUNT; i++){
	powerUp[i].Update()
}


	
	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~