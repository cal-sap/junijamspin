global.useTestWaves = false	//w
global.money = 0	//w
global.enemyList = [objEnemy,objEnemyBeaver];	//this isn't going to be used, but needs to be defined for some reason

#macro WINDOWW 1280
#macro WINDOWH 720
#macro GUYDEPTHBOTTOM 300


///LOAD ALL OF THE DATAS
if (file_exists("waveData.json")){
    var _file = file_text_open_read("waveData.json");
	var _jsonStr = ""
	while (!file_text_eof(_file)){
	    _jsonStr += file_text_readln(_file);
	}
	file_text_close(_file);

	global.waveData = json_parse(_jsonStr);
}else{
	show_error("ERROR: Cannot find waveData.json",1)
}

if (file_exists("testWaveData.json")){
    var _file = file_text_open_read("testWaveData.json");
	var _jsonStr = ""
	while (!file_text_eof(_file)){
	    _jsonStr += file_text_readln(_file);
	}
	file_text_close(_file);

	global.testWaveData = json_parse(_jsonStr);
}else{
	show_error("ERROR: Cannot find testWaveData.json)",0)
}

//
//if (file_exists("testWaves.json")){
//    var _file = file_text_open_read("testWaves.json");
//	var _jsonStr = ""
//	while (!file_text_eof(_file))
//	{
//	    _jsonStr += file_text_readln(_file);
//	}
//	file_text_close(_file);
//
//	var _data = json_parse(_jsonStr)

