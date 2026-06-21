
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
#region Configs
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
guyNudgeSpeed = 0.5
	
#endregion
//~~~~~~~~~~~~~~~~~~~~~~~~~~~
debug_continuousSpin = false
mute = false;
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

//player.CollideWithGuy = function(_other){
//	//take damage or deal damage
//}

instance_create_layer(64,576,"Control",objDebugButton,{
	OnDraw: function(){draw_text(x-20,590,$"Toggle Mute:{objGame.mute}")},
	OnClickFunc: function(){objGame.mute = !objGame.mute}
	
	})
instance_create_layer(100,630,"Control",objDebugButton,{
	OnDraw: function(){draw_text(x-20,660,objGame.debug_continuousSpin?"Cont. Spin":"Active Spin")},
	OnClickFunc: function(){objGame.debug_continuousSpin = !objGame.debug_continuousSpin}
	})

// DEBUG CONSOLE
//instance_create_layer(64,576,"Control",objDebugButton,{
//	OnDraw: function(){draw_text(x-20,590,$"Top Speed:\n{objGuy.move_maxSpeed}")},
//	OnClickFunc: function(){objGuy.move_maxSpeed += 0.5}
//	
//	})
//instance_create_layer(64,644,"Control",objDebugButton,{image_yscale: -1, 
//	OnClickFunc: function(){objGuy.move_maxSpeed = max(1,objGuy.move_maxSpeed - 0.5)}
//	})
//	
//	
//instance_create_layer(164,576,"Control",objDebugButton,{
//	OnDraw: function(){draw_text(x-20,590,$"Accel:\n{objGuy.move_accel}")},
//	OnClickFunc: function(){objGuy.move_accel += 0.05}
//	
//	})
//instance_create_layer(164,644,"Control",objDebugButton,{image_yscale: -1, 
//	OnClickFunc: function(){objGuy.move_accel = max(0.05,objGuy.move_accel - 0.05)}
//	})
//	
//instance_create_layer(264,576,"Control",objDebugButton,{
//	OnDraw: function(){draw_text(x-20,590,$"Brake:\n{objGuy.move_decel}")},
//	OnClickFunc: function(){objGuy.move_decel += 0.05}
//	
//	})
//instance_create_layer(264,644,"Control",objDebugButton,{image_yscale: -1, 
//	OnClickFunc: function(){objGuy.move_decel = max(0,objGuy.move_decel - 0.05)}
//	})