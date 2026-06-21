
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Configs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
guyNudgeSpeed = 0.5
	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~

player = instance_create_layer(200,200,"Guys",objGuy)
collideTilemap = layer_tilemap_get_id("Walls");

function PlayerCollideEnemy(_other){
	//DEAL DAMAGE TO OTHER
	if _other.state == GUY_STATE.HURT return;
	var _dir = point_direction(x,y,_other.x,_other.y)	//direction to hurt enemy
	if state == GUY_STATE.SPIN{
		var _spd = Vec2Magnitude(move_speed)				//force to hurt enemy
		_other.BehaveStartHurt(_dir, max(10,spin_knockbackMult*_spd))
	}else if state != GUY_STATE.HURT{
		BehaveStartHurt(_dir, -15)
	}
}

player.CollideWithGuy = method(player,PlayerCollideEnemy)


enemies = []
enemyCt = 5
for (var i = 0; i < enemyCt; ++i) {
    enemies[i] = instance_create_layer(222+222*i,400,"Guys",objEnemy)
}

instance_create_layer(64,576,"Control",objDebugButton,{
	OnDraw: function(){draw_text(x-20,590,$"Toggle Mute:{MUTED}")},
	OnClickFunc: function(){MUTED = !MUTED}
	
	})
