function PlaySound(_sndIndex,_pitchMod = 1){
	if SFXMUTED return;
	var _sndAsset = SFX_LIST[_sndIndex]	//either an array or single. 
	var _pitchRange = PITCHSHIFT_LIST[_sndIndex]
	//var _pitch = random_range(min(_pitchRange,1),max(_pitchRange,1)) * _pitchMod
	var _pitch = 1
	
	//Format _sndAsset if an array
	if is_array(_sndAsset){
		if array_length(_sndAsset) == 0 return;	//Nothing assigned here, leave.
		_sndAsset = _sndAsset[irandom(array_length(_sndAsset)-1)]
	}


	var _snd = audio_play_sound(_sndAsset, 10, false);
	audio_sound_pitch(_snd,_pitch)
	
	return _snd;
}