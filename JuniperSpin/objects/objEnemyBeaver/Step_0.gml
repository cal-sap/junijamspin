if PAUSED return;

switch (state) {

    case GUY_STATE.WALK:
		UpdateFloatyMove(direction)
		SpriteFlipCheck()
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;
		}
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