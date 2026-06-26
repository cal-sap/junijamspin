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
	SPIN_DENIED,
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
	E_Whend_TAUNT,
	E_Whend_HIT,
	
	PLAYER_HIT,
	PLAYER_HIT2,
	PLAYER_KO,
	PLAYER_FOLIAGE,
	
	SHOP_PURCHASE,
	SHOP_CANTAFFORD,
	SHOP_COMPLETE,
	
	WAVE_COMPLETE,
	
	MAXIMUM
	
}


SFX_LIST[SFX.MENU_HOVER	]	=	[ sfxButton2 ]
SFX_LIST[SFX.MENU_CLICK	]	=	[ sfxButton1 ]
								
SFX_LIST[SFX.SPIN_START	]	=	[ sfxSpinStart]
SFX_LIST[SFX.SPIN_LOOP	]	=	[ sfxSpinStart]		//?? haven't tested this out
SFX_LIST[SFX.SPIN_SPEED_UP]	=	[]		//This is pitched up for each speed beyond the first
SFX_LIST[SFX.SPIN_END	]	=	[ sfxSpinEnd ]
SFX_LIST[SFX.SPIN_READY	]	=	[ sfxPistolLoad1 ]
SFX_LIST[SFX.SPIN_WALLBOUNCE] =	[ sfxKick1, sfxKick2 ]
SFX_LIST[SFX.SPIN_DENIED	]	=	[ sfxBoop5 ]
							
SFX_LIST[SFX.PICKUP_COIN]	=	[ sfxBeep1,sfxBeep2,sfxBeep3 ]
SFX_LIST[SFX.PICKUP_RECOVERY] =	[ sfxConfirm53]
							
SFX_LIST[SFX.ENEMY_HIT_S]	=	[ sfxPierce ]
SFX_LIST[SFX.ENEMY_HIT_M]	=	[ sfxPierce ]
SFX_LIST[SFX.ENEMY_HIT_L]	=	[ sfxPierce ]
SFX_LIST[SFX.ENEMY_KO]		=	[]
SFX_LIST[SFX.ENEMY_BOSS_KO]	=	[]
SFX_LIST[SFX.ENEMY_FOLIAGE]	=	[  sfx01_grass, sfx02_grass, sfx03_grass, sfx04_grass ]
							
SFX_LIST[SFX.E_BKING_TAUNT]	=	[ sfxBiggerBetter1_LavenderVA, sfxBiggerbetter2_LavenderVA, sfxEatlikeaking1_LavenderVA,  sfxEatlikeaking2_LavenderVA, sfxOhyeah1_LavenderVA, sfxOhyeah2_LavenderVA, sfxWherevalueisking1_LavenderVA, sfxWherevalueisking2_LavenderVA ]
SFX_LIST[SFX.E_BKING_HIT]	=	[ sfxHurt1_LavenderVA, sfxHurt2_LavenderVA, sfxHurt3_LavenderVA, sfxHurt4_LavenderVA, sfxHurt5_LavenderVA, sfxHurt5_LavenderVA, sfxHurt6_LavenderVA ]
SFX_LIST[SFX.E_SANDY_TAUNT]	=	[ sfxSandy_Damage_02, sfxSandy_Damage_03, sfxSandy_Damage_04, sfxSandy_Damage_05, sfxSandy_Damage_06 ]
SFX_LIST[SFX.E_SANDY_HIT]	=	[ sfxSandy_Taunt_01, sfxSandy_Taunt_02, sfxSandy_Taunt_03, sfxSandy_Taunt_04, sfxSandy_Taunt_05, sfxSandy_Taunt_06 ]
SFX_LIST[SFX.E_BICKY_TAUNT]	=	[ sfxBickey_Sound1, sfxBickey_Sound2, sfxBickey_Sound3, sfxTaunt_01_VTS141, sfxTaunt_02_VTS141, sfxTaunt_03_VTS141, sfxTaunt_04_VTS141 ]
SFX_LIST[SFX.E_BICKY_HIT]	=	[ sfxHurt_01_VTS141, sfxHurt_02_VTS141, sfxHurt_03_VTS141, sfxHurt_04_VTS141 ]
SFX_LIST[SFX.E_LONAL_TAUNT]	=	[ sfxTaunt_01_av03x, sfxTaunt_02_av03x, sfxTaunt_03_av03x, sfxTaunt_04_av03x ]
SFX_LIST[SFX.E_LONAL_HIT]	=	[ sfxHurt_01_av03x, sfxHurt_02_av03x, sfxHurt_03_av03x, sfxHurt_04_av03x ]
SFX_LIST[SFX.E_Whend_TAUNT] =   [ sfxWhendyTaunt_01_Kasabake, sfxWhendyTaunt_02_Kasabake, sfxWhendyTaunt_03_Kasabake, sfxWhendyTaunt_04_Kasabake ]
SFX_LIST[SFX.E_Whend_HIT]	=	[ sfxWhendyHurt_01_Kasabake, sfxWhendyHurt_02_Kasabake, sfxWhendyHurt_03_Kasabake, sfxWhendyHurt_04_Kasabake ]

SFX_LIST[SFX.PLAYER_HIT2]	=  	[ sfxWhip ]				
SFX_LIST[SFX.PLAYER_HIT]	=	[	sfxHurt1_SamK,	sfxHurt2_SamK,	sfxHurt3_SamK,
									sfxHurt4_SamK,	sfxHurt5_SamK,	sfxHurt6_SamK,
									sfxHurt7_SamK,	sfxHurt8_SamK,	sfxHurt9_SamK,	sfxHurt10_SamK]
SFX_LIST[SFX.PLAYER_KO]		=	[ sfxDeath1_SamK, sfxDeath2_SamK, sfxDeath3_SamK, sfxDeath4_SamK, sfxDeath5_SamK, sfxDeath6_SamK, sfxDeath7_SamK ]
SFX_LIST[SFX.PLAYER_FOLIAGE] =	[ sfx01_grass, sfx02_grass, sfx03_grass, sfx04_grass ]
								
SFX_LIST[SFX.SHOP_PURCHASE]	=	[ sfxChing ]
SFX_LIST[SFX.SHOP_CANTAFFORD] =	[ sfxBoop5 ]
SFX_LIST[SFX.SHOP_COMPLETE]	=	[ sfxButton1 ]
							
SFX_LIST[SFX.WAVE_COMPLETE]	=	[ sfxConfirm51 ]

PITCHSHIFT_LIST[SFX.PICKUP_COIN]	=	[0.25]	//Will pitch shift randomly between 1	& 1.25
PITCHSHIFT_LIST[SFX.PLAYER_HIT]	=		[-0.2]	//Will pitch shift randomly between 0.8 & 1
