function Vec2( _x = 0,_y = 0) constructor{
	x = _x;
	y = _y;
}

function Vec2Add( _vec2A, _vec2B){
	return new Vec2(
		_vec2A.x+	_vec2B.x,
		_vec2A.y+	_vec2B.y)
}

function Vec2Sub( _vec2A, _vec2B){
	return new Vec2(
		_vec2A.x-_vec2B.x,
		_vec2A.y-_vec2B.y)
}

function Vec2FromMagDir(_mag, _dir){
	return new Vec2(lengthdir_x(_mag, _dir),
					lengthdir_y(_mag, _dir))
}

function Vec2Mult( _vec2, _multiplier){
	return new Vec2(
		_vec2.x*_multiplier,
		_vec2.y*_multiplier)
}

function Vec2MultVec2( _vec2A, _vec2B){
	return new Vec2(
		_vec2A.x*	_vec2B.x,
		_vec2A.y*	_vec2B.y)
}

function Vec2Div( _vec2, _divisor){
	return new Vec2(
		_vec2.x/_divisor,
		_vec2.y/_divisor)
}

function Vec2Magnitude(_vec2){
	return point_distance(0,0,_vec2.x,_vec2.y)
}

function Vec2Direction(_vec2){
	return point_direction(0,0,_vec2.x,_vec2.y)
}


function Vec2Normalize(_vec2, _magnitude = 1){
	var _origMag =		Vec2Magnitude(_vec2)
	var _normalVec =	Vec2Div( _vec2, _origMag)	//normalized
	return				Vec2Mult(_normalVec, _magnitude)	//applying provided magnitude
}
