

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
		
		if spin_timeLeft > 0{	//Ending spin check
		if (--spin_timeLeft == 0){
			BehaveStopSpin()	//end spinning
		}}
		
		switch (aiState) {
			case GUY_STATE.SPIN:	BehaveLevelUpSpin()	break;	//check for ramping up
		}
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


if spin_cooldownLeft > 0{
if (--spin_cooldownLeft == 0){
	spin_ready = true;
}}

//GET STAMINA STUFF
if state != GUY_STATE.SPIN{
	if stamina < stamina_max stamina++
}