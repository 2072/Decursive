--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2007 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------


-- Acelocal register for koKR // {{{
local L = Dcr.L;
L:RegisterTranslations("koKR", function() return {

	[Dcr.LOC.CLASS_DRUID]	=	"드루이드",
	[Dcr.LOC.CLASS_HUNTER]	=	"사냥꾼",
	[Dcr.LOC.CLASS_MAGE]	=	"마법사",
	[Dcr.LOC.CLASS_PALADIN]	=	"성기사",
	[Dcr.LOC.CLASS_PRIEST]	=	"사제",
	[Dcr.LOC.CLASS_ROGUE]	=	"도적",
	[Dcr.LOC.CLASS_SHAMAN]	=	"주술사",
	[Dcr.LOC.CLASS_WARLOCK]	=	"흑마법사",
	[Dcr.LOC.CLASS_WARRIOR]	=	"전사",

	[Dcr.LOC.DISEASE]	=	"질병",
	[Dcr.LOC.MAGIC]		=	"마법",
	[Dcr.LOC.POISON]	=	"독",
	[Dcr.LOC.CURSE]		=	"저주",
	[Dcr.LOC.CHARMED]	=	"정신 지배",

	-------------------------------------------------------------------------------
	-- English localization (Default)
	-------------------------------------------------------------------------------

	--start added in Rc4
	[Dcr.LOC.ALLIANCE_NAME]	=	"얼라이언스",

	[Dcr.LOC.CLASS_DRUID]	=	"드루이드",
	[Dcr.LOC.CLASS_HUNTER]	=	"사냥꾼",
	[Dcr.LOC.CLASS_MAGE]	=	"마법사",
	[Dcr.LOC.CLASS_PALADIN]	=	"성기사",
	[Dcr.LOC.CLASS_PRIEST]	=	"사제",
	[Dcr.LOC.CLASS_ROGUE]	=	"도적",
	[Dcr.LOC.CLASS_SHAMAN]	=	"주술사",
	[Dcr.LOC.CLASS_WARLOCK]	=	"흑마법사",
	[Dcr.LOC.CLASS_WARRIOR]	=	"전사",

	[Dcr.LOC.STR_OTHER]	= 	"기타",
	[Dcr.LOC.STR_OPTIONS]	= 	"Decursive 설정",
	[Dcr.LOC.STR_CLOSE]	= 	"닫기",
	[Dcr.LOC.STR_DCR_PRIO]  = 	"Decursive 우선순위",
	[Dcr.LOC.STR_DCR_SKIP]  = 	"Decursive 제외",
	[Dcr.LOC.STR_QUICK_POP] = 	"빠른 추가",
	[Dcr.LOC.STR_POP]	= 	"추가 목록",
	[Dcr.LOC.STR_GROUP]	= 	"파티 ",




	[Dcr.LOC.PRIORITY_SHOW] = "P",
	[Dcr.LOC.POPULATE]	    = "p",
	[Dcr.LOC.SKIP_SHOW]	    = "S",
	[Dcr.LOC.CLEAR_PRIO]	= "C",
	[Dcr.LOC.CLEAR_SKIP]	= "C",

	[Dcr.LOC.PET_FEL_CAST]	=	"마법 삼키기",
	[Dcr.LOC.PET_DOOM_CAST]	=	"마법 무효화",

	[Dcr.LOC.SPELL_POLYMORPH]	=	"변이",
	[Dcr.LOC.SPELL_CURE_DISEASE]	=	"질병 치료",
	[Dcr.LOC.SPELL_ABOLISH_DISEASE]	=	"질병 해제",
	[Dcr.LOC.SPELL_PURIFY]		=	"순화",
	[Dcr.LOC.SPELL_CLEANSE]		=	"정화", -- 성기사
	[Dcr.LOC.SPELL_DISPELL_MAGIC]	=	"마법 무효화",
	[Dcr.LOC.SPELL_CURE_POISON]	=	"해독",
	[Dcr.LOC.SPELL_ABOLISH_POISON]	=	"독 해제",
	[Dcr.LOC.SPELL_REMOVE_LESSER_CURSE] =	"하급 저주 해제",
	[Dcr.LOC.SPELL_REMOVE_CURSE]	=	"저주 해제",
	[Dcr.LOC.SPELL_PURGE]		=	"정화", -- 주술사

	[BINDING_NAME_DCRSHOW]    	= "Decursive 메인바 표시/숨김",

	[BINDING_NAME_DCRPRADD]     = "대상을 우선순위 목록에 추가",
	[BINDING_NAME_DCRPRCLEAR]   = "우선순위 목록 초기화",
	[BINDING_NAME_DCRPRLIST]    = "우선순위 목록 출력",
	[BINDING_NAME_DCRPRSHOW]    = "우선순위 목록 표시/숨김",

	[BINDING_NAME_DCRSKADD]   	= "대상을 제외 목록에 추가",
	[BINDING_NAME_DCRSKCLEAR] 	= "제외 목록 초기화",
	[BINDING_NAME_DCRSKLIST]  	= "제외 목록 출력",
	[BINDING_NAME_DCRSKSHOW]  	= "제외 목록 표시/숨김",



	[Dcr.LOC.PRIORITY_LIST]  	= "Decursive 우선순위 목록",
	[Dcr.LOC.SKIP_LIST_STR]  	= "Decursive 제외 목록",
	[Dcr.LOC.OPTION_MENU]   	= "Decursive 설정 메뉴",
	[Dcr.LOC.POPULATE_LIST]  	= "Decursive 목록에 빠른 추가",
	[Dcr.LOC.LIST_ENTRY_ACTIONS]	= "|cFF33AA33[CTRL]|r 클릭: 해당 플레이어 제거\n|cFF33AA33좌|r-클릭: 해당 플레이어를 위로\n|cFF33AA33우|r-클릭: 해당 플레이어를 아래로\n|cFF33AA33[SHIFT] 좌|r-클릭: 해당 플레이어를 최상위로\n|cFF33AA33[SHIFT] 우|r-클릭: 해당 플레이어를 최하위로",
	[Dcr.LOC.HIDE_MAIN]      	= "Decursive 창 닫기",
	[Dcr.LOC.SHOW_MSG]	   	= "Decursive 창 표시, /dcrshow 명령어를 입력하세요.",
	[Dcr.LOC.IS_HERE_MSG]	   	= "Decursive가 초기화 되었습니다. 옵션을 설정하세요.",

	[Dcr.LOC.PRINT_CHATFRAME] 	= "기본 대화창에 메세지 표시",
	[Dcr.LOC.PRINT_CUSTOM]    	= "Decursive 창에 메세지 표시",
	[Dcr.LOC.PRINT_ERRORS]    	= "오류 메세지 출력",

	[Dcr.LOC.SHOW_TOOLTIP]    	= "툴팁 표시",
	[Dcr.LOC.REVERSE_LIVELIST]	= "실시간 목록 표시 반전",
	[Dcr.LOC.TIE_LIVELIST]    	= "실시간 목록 표시를 DCR 창과 함께 표시",
	[Dcr.LOC.HIDE_LIVELIST]   	= "실시간 목록 숨김",

	[Dcr.LOC.AMOUNT_AFFLIC]   	= "표시할 대상의 수 : ",
	[Dcr.LOC.BLACK_LENGTH]    	= "블랙리스트 추가 시간(초) : ",
	[Dcr.LOC.SCAN_LENGTH]     	= "실시간 탐색 시간(초) : ",
	[Dcr.LOC.ABOLISH_CHECK]   	= "해제전 \"해제 주문\" 검사",
	[Dcr.LOC.RANDOM_ORDER]    	= "무작위 해제",
	[Dcr.LOC.CURE_PETS]       	= "소환수 탐색과 해제",
	[Dcr.LOC.IGNORE_STEALTH]  	= "은신 대상 무시",
	[Dcr.LOC.PLAY_SOUND]	    	= "효과음 재생",
	[Dcr.LOC.ANCHOR]          	= "Decursive 글자 위치",
	[Dcr.LOC.DONOT_BL_PRIO]   	= "우선순위 블랙리스트 제외",

	-- $s is spell name
	-- $a is affliction name/type
	-- $t is target name
	[Dcr.LOC.SPELL_FOUND]      	= "%s 주문 발견!",

	-- spells and potions
	[Dcr.LOC.DREAMLESSSLEEP]	= "숙면",
	[Dcr.LOC.GDREAMLESSSLEEP]	= "상급 숙면",
	[Dcr.LOC.ANCIENTHYSTERIA]	= "고대의 격분",
	[Dcr.LOC.IGNITE]		= "마나 점화",
	[Dcr.LOC.TAINTEDMIND]		= "부패한 정신",
	[Dcr.LOC.MAGMASHAKLES]		= "용암 족쇄",
	[Dcr.LOC.CRIPLES]		= "신경 마비",
	[Dcr.LOC.DUSTCLOUD]		= "먼지 구름",
	[Dcr.LOC.WIDOWSEMBRACE]		= "귀부인의 은총",
	[Dcr.LOC.CURSEOFTONGUES]	= "언어의 저주",
	[Dcr.LOC.SONICBURST]		= "음파 폭발",
	[Dcr.LOC.THUNDERCLAP]		= "천둥벼락",
	[Dcr.LOC.DELUSIONOFJINDO]	= "진도의 망상",

	[Dcr.LOC.MUTATINGINJECTION] = Dcr.LOC.MUTATINGINJECTION,
	[Dcr.LOC.DEFAULT_MACROKEY] = Dcr.LOC.DEFAULT_MACROKEY, -- Ideally the key just beneath the "escape" key
	[Dcr.LOC.OPT_LIVELIST] = "실시간 목록",
	[Dcr.LOC.OPT_LIVELIST_DESC] = "실시간 목록에 대한 설정입니다.",
	[Dcr.LOC.OPT_HIDELIVELIST_DESC] = "숨긴다면 해제된 대상의 정보를 표시합니다.",
	[Dcr.LOC.OPT_SHOWTOOLTIP_DESC] = "실시간 목록과 작은 유닛 프레임에 디버프에 대한 자세한 툴팁을 표시합니다.",
	[Dcr.LOC.OPT_PLAYSOUND_DESC]  = "해제 가능한 디버프 발견시 효과음을 재생합니다.",
	[Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC] = "실시간 목록에 표시할 유닛의 최대 수를 지정합니다.",
	[Dcr.LOC.OPT_BLACKLENTGH_DESC] =  "블랙리스트에 등록할 시간을 지정합니다.",
	[Dcr.LOC.OPT_SCANLENGTH_DESC] = "각 탐색의 시간 간격을 지정합니다.",
	[Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = "실시간 목록을 아래에서 위로 생성합니다.",
	[Dcr.LOC.OPT_TIE_LIVELIST_DESC] = "실시간 목록을 아래에서 위로 생성합니다.",
	[Dcr.LOC.OPT_MESSAGES]	= "메세지",
	[Dcr.LOC.OPT_MESSAGES_DESC] = "메세지 표시에 대한 설정입니다.",
	[Dcr.LOC.OPT_CHATFRAME_DESC] = "Decursive의 메세지가 기본 대화창에 표시됩니다.",
	[Dcr.LOC.OPT_PRINT_CUSTOM_DESC] = "Decursive의 메세지가 사용자 정의 대화창에 표시됩니다.",
	[Dcr.LOC.OPT_PRINT_ERRORS_DESC] = "오류를 표시합니다.",
	[Dcr.LOC.OPT_ANCHOR_DESC]	= "사용자 정의 메세지창의 고정위치를 표시합니다.",
	[Dcr.LOC.OPT_MFSETTINGS] = "작은 유닛 프레임 설정",
	[Dcr.LOC.OPT_MFSETTINGS_DESC] = "작은 유닛 프레임에 대한 설정입니다.",
	[Dcr.LOC.OPT_DISPLAYOPTIONS] = "디스플레이 옵션",
	[Dcr.LOC.OPT_SHOWMFS] = "작은 유닛 프레임 표시",
	[Dcr.LOC.OPT_SHOWMFS_DESC] = "클릭으로 해제하려면 반드시 활성화 되어야 합니다.",
	[Dcr.LOC.OPT_MAXMFS]  = "표시할 최대 유닛",
	[Dcr.LOC.OPT_MAXMFS_DESC] = "표시할 작은 유닛 프레임의 최대 개수를 지정합니다.",
	[Dcr.LOC.OPT_UNITPERLINES] = "한줄에 표시할 유닛의 수",
	[Dcr.LOC.OPT_UNITPERLINES_DESC] = "한줄에 표시할 작은 유닛 프레임의 최대 개수를 지정합니다.",
	[Dcr.LOC.OPT_MFSCALE] = "작은 유닛 프레임의 크기",
	[Dcr.LOC.OPT_MFSCALE_DESC] = "작은 유닛 프레임의 크기를 설정합니다.",
	[Dcr.LOC.OPT_SHOWHELP] = "도움말 표시",
	[Dcr.LOC.OPT_SHOWHELP_DESC] = "작은 유닛 프레임에 마우스를 올리면 정보 툴팁을 표시합니다.",
	[Dcr.LOC.OPT_MFPERFOPT] = "성능 설정",
	[Dcr.LOC.OPT_MFREFRESHRATE] = "갱신 주기",
	[Dcr.LOC.OPT_MFREFRESHRATE_DESC] = "갱신할 시간 간격(한번에 1 혹은 그 이상 작은 유닛 프레임을 갱신할 수 있습니다.)",
	[Dcr.LOC.OPT_MFREFRESHSPEED] = "갱신 속도",
	[Dcr.LOC.OPT_MFREFRESHSPEED_DESC] = "한번에 갱신할 작은 유닛 프레임의 개수",
	[Dcr.LOC.OPT_CURINGOPTIONS] = "해제 옵션",
	[Dcr.LOC.OPT_CURINGOPTIONS_DESC] = "해제의 다양한 형태를 설정합니다.",
	[Dcr.LOC.OPT_ABOLISHCHECK_DESC] = "'해제' 주문을 가진 대상을 표시하고 치유 할 지를 선택합니다.",
	[Dcr.LOC.OPT_DONOTBLPRIO_DESC] = "우선순위에 등록된 유닛은 블랙리스트에 추가하지 않습니다.",
	[Dcr.LOC.OPT_RANDOMORDER_DESC] = "대상을 무작위로 표시하고 치료합니다.(비추천)",
	[Dcr.LOC.OPT_CUREPETS_DESC] = "소환수를 관리하고 해제합니다.",
	[Dcr.LOC.OPT_IGNORESTEALTHED_DESC] = "은신한 대상을 무시합니다.",
	[Dcr.LOC.OPT_CURINGORDEROPTIONS] = "해제 순서 설정",
	[Dcr.LOC.OPT_MAGICCHECK_DESC]	= "체크 시 마법에 걸린 대상을 표시하고 치료합니다.",
	[Dcr.LOC.OPT_CHARMEDCHECK_DESC] = "체크 시 지배에 걸린 대상을 표시하고 치료합니다.",
	[Dcr.LOC.OPT_POISONCHECK_DESC] = "체크 시 독에 걸린 대상을 표시하고 치료합니다.",
	[Dcr.LOC.OPT_DISEASECHECK_DESC] = "체크 시 질병에 걸린 대상을 표시하고 치료합니다.",
	[Dcr.LOC.OPT_CURSECHECK_DESC] = "체크 시 저주에 걸린 대상을 표시하고 치료합니다.",
	[Dcr.LOC.OPT_DEBUFFFILTER] = "디버프 필터링",
	[Dcr.LOC.OPT_DEBUFFFILTER_DESC] = "이름과 직업에 의해 필터링 할 디버프를 선택합니다.",
	[Dcr.LOC.OPT_MACROOPTIONS] = "매크로 설정",
	[Dcr.LOC.OPT_MACROOPTIONS_DESC] = "Decursive에 의해 생성된 매크로의 동작을 설정합니다.",
	[Dcr.LOC.OPT_MACROBIND] = "매크로 단축키 설정",
	[Dcr.LOC.OPT_MACROBIND_DESC] = "'Decursive' 매크로를 호출 할 키을 지정합니다.\n\nPress the key and hit your 'Enter' keyboard key to save the new assignement (with your mouse cursor over the edit field)",
	[Dcr.LOC.OPT_RESETOPTIONS] = "기본값으로 설정 초기화",
	[Dcr.LOC.OPT_RESETOPTIONS_DESC] =  "현재 프로파일을 기본값으로 초기화합니다.",
	[Dcr.LOC.OPT_REMOVESKDEBCONF] = "정말로 Decursive의 디버프 제외 목록에서\n %s|1을;를; 를 제거 하시겠습니까?",
	[Dcr.LOC.OPT_RESTPROFILECONF] = "정말로 '(%s) %s'\n 프로파일을 기본 설정으로\n 초기화 하시겠습니까?",
	[Dcr.LOC.OPT_PROFILERESET] = "프로파일 초기화...",
	[Dcr.LOC.OPT_AFFLICTEDBYSKIPPED] = "%s - %s에 걸리면 무시합니다.",
	[Dcr.LOC.OPT_DEBCHECKEDBYDEF] = "\n\n기본값으로 설정됨",
	[Dcr.LOC.OPT_REMOVETHISDEBUFF] = "해당 디버프 제거",
	[Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = "Skip 목록에서 '%s' 제거",
	[Dcr.LOC.OPT_RESETDEBUFF] = "해당 디버프 초기화",
	[Dcr.LOC.OPT_RESETDTDCRDEFAULT] = "'%s' Decursive 기본으로 초기화",
	[Dcr.LOC.OPT_USERDEBUFF] = "해당 디버프는 Decursive의 기본 디버프가 아닙니다.",
	[Dcr.LOC.OPT_DEBUFFENTRY_DESC] = "해당 디버프에 걸렸을 때 전투 중 무시할 직업을 선택하세요.",
	[Dcr.LOC.OPT_ADDDEBUFF] = "목록에 디버프 추가",
	[Dcr.LOC.OPT_ADDDEBUFF_DESC] = "이 목록에 새로운 디버프 추가",
	[Dcr.LOC.OPT_ADDDEBUFF_USAGE] = "<디버프명>",
	[Dcr.LOC.OPT_READDDEFAULTSD] = "기본 디버프 재추가",
	[Dcr.LOC.OPT_READDDEFAULTSD_DESC1] = "해당 목록에 누락된 Decursive의 기본 디버프를 추가합니다.\n설정은 변하지 않습니다.",
	[Dcr.LOC.OPT_READDDEFAULTSD_DESC2] = "Decursive의 모든 기본 디버프는 해당 목록에 있습니다.",

	[Dcr.LOC.OPT_LVONLYINRANGE] = "범위내 대상",
	[Dcr.LOC.OPT_LVONLYINRANGE_DESC] = "해제 범위내 대상만 실시간 목록에 표시합니다.",

	[Dcr.LOC.HLP_LEFTCLICK] 	= "좌-클릭",
	[Dcr.LOC.HLP_RIGHTCLICK] 	= "우-클릭",
	[Dcr.LOC.HLP_MIDDLECLICK] 	= "가운데-클릭",

	[Dcr.LOC.CTRL] 	= "CTRL",
	[Dcr.LOC.ALT] 	= "ALT",
	[Dcr.LOC.SHIFT] = "SHIFT",

	[Dcr.LOC.TARGETUNIT] 	= "대상",
	[Dcr.LOC.FOCUSUNIT] 	= "주시 대상",

	[Dcr.LOC.ABSENT] 	= "(%s) 자리비움",
	[Dcr.LOC.TOOFAR] 	= "거리 벗어남",
	[Dcr.LOC.NORMAL] 	= "정상",
	[Dcr.LOC.STEALTHED] 	= "은신상태",
	[Dcr.LOC.BLACKLISTED] 	= "블랙리스트됨",
	[Dcr.LOC.UNITSTATUS] 	= "상태: ",
	[Dcr.LOC.AFFLICTEDBY] 	= "%s에 걸림",

	[Dcr.LOC.SUCCESSCAST] 	= "%s|1으로;로 %s|1을;를; |cFF00AA00치료 성공!|r",

	[Dcr.LOC.HANDLEHELP] 	= "작은 유닛 프레임(MUFs) 모두 이동",

	[Dcr.LOC.MACROKEYALREADYMAPPED] = "경고: The key mapped to Decursive macro [%s] was mapped to action '%s'.\nDecursive will restore the previous mapping if you set another key for its macro.",
	[Dcr.LOC.MACROKEYMAPPINGSUCCESS] = "[%s] 키가 Decursive 매크로로 성공적으로 지정되었습니다.",
	[Dcr.LOC.MACROKEYMAPPINGFAILED] = "[%s] 키는 Decursive 매크로로 지정할 수 없습니다!",
	[Dcr.LOC.MACROKEYNOTMAPPED] = "Decursive 매크로가 지정되지 않앗습니다. 설정 메뉴를 통해 키를 지정할 수 있습니다.",

} end);

-- // }}}

