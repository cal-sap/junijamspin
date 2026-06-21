

switch (state) {

    case GUY_STATE.WALK:
		UpdateFloatyMove(direction)
		SpriteFlipCheck()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;
		    case GUY_STATE.SPIN:	if objGame.debug_continuousSpin{BehaveContinueSpinStart()}else{BehaveStartSpin()}	break;
		}
	break;
		

		
    case GUY_STATE.SPIN:
		if move_speed.x == 0 && move_speed.y == 0{
		//if aiState != GUY_STATE.WALK{
			direction = move_direction	//if not moving, go where last moving
		}
		UpdateFloatyMove(direction,spin_lvl_maxSpeed[spin_level])
		
		//DUST CLOUD
		//if current_time mod spin_dustCloudCooldown == 0{
			
		//}
		
		if spin_timeLeft > 0{		//Ending spin check
		if (--spin_timeLeft == 0){
			if objGame.debug_continuousSpin{
				if spin_level < spin_levelMax-1{
					BehaveLevelUpSpin()	//Level up automatically
				}
			}else{
				BehaveStopSpin()	//end spinning
			}
		}}
		
		switch (aiState) {
			case GUY_STATE.SPIN:	if objGame.debug_continuousSpin{BehaveContinueSpin()}else{BehaveLevelUpSpin()}	break;	//check for ramping up
			default: if objGame.debug_continuousSpin{BehaveStopSpin()}
		}
		//}
	break;
		
    case GUY_STATE.HURT:
		direction = move_direction	//can only fly in one direction
		UpdateFloatyMove()
		if hurt_timeLeft > 0{
		if (--hurt_timeLeft == 0){
			BehaveStopHurt()
		}}
		//}
	break;
		
		
//GUY_STATE.IDLE 
    default:	
		
		UpdateFloatyMove()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;	//edge case for when starting out
		    case GUY_STATE.SPIN:	if objGame.debug_continuousSpin{BehaveContinueSpinStart()}else{BehaveStartSpin()}	break;
			case GUY_STATE.WALK:	BehaveStartWalk()	break;
		}

        break
}

//TIMERS

if spin_dustCloudStepLeft > 0{
if (--spin_dustCloudStepLeft == 0){
	instance_create_layer(x,y,"GroundFX",objFX,{image_angle: irandom(360)})
	spin_dustCloudStepLeft = spin_dustCloudStepMax
}}

if !objGame.debug_continuousSpin{
	if spin_cooldownLeft > 0{
	if (--spin_cooldownLeft == 0){
		spin_ready = true;
	}}

}else if stamina == stamina_max{
	spin_ready = true;
}


//GET STAMINA STUFF
if state != GUY_STATE.SPIN{
	if stamina < stamina_max stamina = min(stamina+1,stamina_max)
}