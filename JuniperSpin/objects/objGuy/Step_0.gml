

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
	
		switch (aiState) {
		    case GUY_STATE.IDLE:	BehaveStartIdle()	break;
		    case GUY_STATE.WALK:	BehaveStartWalk()	break;
		}
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

