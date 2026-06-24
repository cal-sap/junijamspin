ready = false;

//Check if this is in the player's vision
function CheckReady(){
	var _play = objGame.player
	ready =  !point_in_rectangle(x,y,
		min(_play.x-WINDOWW/2,room_width-WINDOWW),
		min(_play.y-WINDOWH/2,room_height-WINDOWH),
		max(_play.x+WINDOWW/2,room_width-WINDOWW),
		max(_play.y+WINDOWH/2,room_height-WINDOWH))
	if ready{
		array_push(objGame.validSpawns,id)
	}
}