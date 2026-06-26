global.gainLevel	= 1
global.sfxMuted		= false
global.musicMuted	= false
global.paused		= false
global.soundEffectsList =	array_create(SFX.MAXIMUM,[])
global.pitchShiftList =		array_create(SFX.MAXIMUM,0)
#macro VOLUME	global.gainLevel
#macro SFXMUTED		global.sfxMuted		
#macro MUSICMUTED	global.musicMuted	
#macro PAUSED		global.paused

#macro SFX_LIST global.soundEffectsList
#macro PITCHSHIFT_LIST global.pitchShiftList

enum SFX{
	MENU_HOVER,
	MENU_CLICK,
	
	SPIN_START,
	SPIN_LOOP,
	SPIN_SPEED_UP,
	SPIN_END,
	SPIN_READY,
	SPIN_WALLBOUNCE,
	
	PICKUP_COIN,
	PICKUP_RECOVERY,
	
	ENEMY_HIT_S,
	ENEMY_HIT_M,
	ENEMY_HIT_L,
	ENEMY_KO,
	ENEMY_BOSS_KO,
	ENEMY_FOLIAGE,
	
	E_BKING_TAUNT,
	E_BKING_HIT,
	E_SANDY_TAUNT,
	E_SANDY_HIT,
	E_BICKY_TAUNT,
	E_BICKY_HIT,
	E_LONAL_TAUNT,
	E_LONAL_HIT,
	
	PLAYER_HIT,
	PLAYER_KO,
	PLAYER_FOLIAGE,
	
	SHOP_PURCHASE,
	SHOP_CANTAFFORD,
	SHOP_COMPLETE,
	
	WAVE_COMPLETE,
	
	MAXIMUM
	
}


SFX_LIST[SFX.MENU_HOVER	]	=	[]
SFX_LIST[SFX.MENU_CLICK	]	=	[]
								
SFX_LIST[SFX.SPIN_START	]	=	[]
SFX_LIST[SFX.SPIN_LOOP	]	=	[]		//?? haven't tested this out
SFX_LIST[SFX.SPIN_SPEED_UP]	=	[]		//This is pitched up for each speed beyond the first
SFX_LIST[SFX.SPIN_END	]	=	[]
SFX_LIST[SFX.SPIN_READY	]	=	[]
SFX_LIST[SFX.SPIN_WALLBOUNCE] =	[]
							
SFX_LIST[SFX.PICKUP_COIN]	=	[sfxBeep1,sfxBeep2,sfxBeep3]
SFX_LIST[SFX.PICKUP_RECOVERY] =	[]
							
SFX_LIST[SFX.ENEMY_HIT_S]	=	[]
SFX_LIST[SFX.ENEMY_HIT_M]	=	[]
SFX_LIST[SFX.ENEMY_HIT_L]	=	[]
SFX_LIST[SFX.ENEMY_KO]		=	[]
SFX_LIST[SFX.ENEMY_BOSS_KO]	=	[]
SFX_LIST[SFX.ENEMY_FOLIAGE]	=	[]
							
SFX_LIST[SFX.E_BKING_TAUNT]	=	[]
SFX_LIST[SFX.E_BKING_HIT]	=	[]
SFX_LIST[SFX.E_SANDY_TAUNT]	=	[]
SFX_LIST[SFX.E_SANDY_HIT]	=	[]
SFX_LIST[SFX.E_BICKY_TAUNT]	=	[]
SFX_LIST[SFX.E_BICKY_HIT]	=	[]
SFX_LIST[SFX.E_LONAL_TAUNT]	=	[]
SFX_LIST[SFX.E_LONAL_HIT]	=	[]
							
SFX_LIST[SFX.PLAYER_HIT]	=	[	sfxHurt1_SamK,	sfxHurt2_SamK,	sfxHurt3_SamK,
									sfxHurt4_SamK,	sfxHurt5_SamK,	sfxHurt6_SamK,
									sfxHurt7_SamK,	sfxHurt8_SamK,	sfxHurt9_SamK,	sfxHurt10_SamK]
SFX_LIST[SFX.PLAYER_KO]		=	[]
SFX_LIST[SFX.PLAYER_FOLIAGE] =	[]
								
SFX_LIST[SFX.SHOP_PURCHASE]	=	[]
SFX_LIST[SFX.SHOP_CANTAFFORD] =	[]
SFX_LIST[SFX.SHOP_COMPLETE]	=	[]
							
SFX_LIST[SFX.WAVE_COMPLETE]	=	[]

PITCHSHIFT_LIST[SFX.PICKUP_COIN]	=	[0.25]	//Will pitch shift randomly between 1	& 1.25
PITCHSHIFT_LIST[SFX.PLAYER_HIT]	=		[-0.2]	//Will pitch shift randomly between 0.8 & 1
