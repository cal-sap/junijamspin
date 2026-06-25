if PAUSED return;

switch (state) {

    case GUY_STATE.WALK:
		UpdateFloatyMove(direction)
		SpriteFlipCheck()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;
		}
	break;
		

    case GUY_STATE.HURT:
		UpdateFloatyMove(direction,move_maxSpeed*0.5)
		if hurt_timeLeft > 0{
		if (--hurt_timeLeft == 0){
			BehaveStopHurt()
		}}
	break;

		
		
		
//GUY_STATE.IDLE 
    default:	
		
		UpdateFloatyMove()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;	//edge case for when starting out
			case GUY_STATE.WALK:	BehaveStartWalk()	break;
		}

        break
}