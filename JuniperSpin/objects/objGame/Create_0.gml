



player = instance_create_layer(200,200,"Guys",objGuy)
collideTilemap = layer_tilemap_get_id("Walls");

//enemies = []
//for (var i = 0; i < 5; ++i) {
//    enemies[i] = instance_create_layer(222+222*i,400,"Guys",objGuy)
//}


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