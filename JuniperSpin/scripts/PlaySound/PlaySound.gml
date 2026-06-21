function PlaySound(_sndIndex,_pitch = 1){
	if objGame.mute return;
	var _snd = audio_play_sound(_sndIndex, 10, false);
	audio_sound_pitch(_snd,_pitch)
}