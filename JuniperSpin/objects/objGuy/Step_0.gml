
if PAUSED return;

switch (state) {

    case GUY_STATE.WALK:
		UpdateFloatyMove(direction)
		SpriteFlipCheck()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;
		    case GUY_STATE.SPIN:	BehaveStartSpin()	break;
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
			if spin_level < spin_levelMax-1{
				BehaveLevelUpSpin()	//Level up automatically
			}
		}}
		
		switch (aiState) {
			case GUY_STATE.SPIN:	BehaveContinueSpin()	break;	//check for ramping up
			default: BehaveStopSpin()
		}
		//}
	break;
		
    case GUY_STATE.HURT:
		//direction = move_direction	//can only fly in one direction
		//UpdateFloatyMove()
		UpdateFloatyMove(direction,move_maxSpeed*0.5)
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
		    case GUY_STATE.SPIN:	BehaveStartSpin()	break;
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




//RECOVER STAMINA
if state != GUY_STATE.SPIN{
	if stamina < stamina_max{
		stamina = min(stamina+stamina_recoverMult,stamina_max)	
		if stamina == stamina_max{
			stamina = stamina_max
			spin_ready = true;	
			PlaySound(SFX.SPIN_READY)
		}
	}	
}