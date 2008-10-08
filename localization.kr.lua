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

if not DcrLoadedFiles or not DcrLoadedFiles["localization.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (localization.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

--Dcr:SetDateAndRevision("$Date: 2008-07-22 06:35:49 +0200 (mar., 22 juil. 2008) $", "$Revision: 78889 $");


-- Acelocal register for koKR // {{{
local L = Dcr.L;
local LOC = Dcr.LOC;
L:RegisterTranslations("koKR", function() return {


	[LOC.CLASS_DRUID]	=	"드루이드",
	[LOC.CLASS_HUNTER]	=	"사냥꾼",
	[LOC.CLASS_MAGE]	=	"마법사",
	[LOC.CLASS_PALADIN]	=	"성기사",
	[LOC.CLASS_PRIEST]	=	"사제",
	[LOC.CLASS_ROGUE]	=	"도적",
	[LOC.CLASS_SHAMAN]	=	"주술사",
	[LOC.CLASS_WARLOCK]	=	"흑마법사",
	[LOC.CLASS_WARRIOR]	=	"전사",

	[LOC.DISEASE]	=	"질병",
	[LOC.MAGIC]		=	"마법",
	[LOC.POISON]	=	"독",
	[LOC.CURSE]		=	"저주",
	[LOC.MAGICCHARMED]	=	"주술", -- check
	[LOC.CHARMED]	=	"지배", -- check

	-------------------------------------------------------------------------------
	-- Korean localization
	-------------------------------------------------------------------------------

	--start added in Rc4

	[LOC.CLASS_DRUID]	=	"드루이드",
	[LOC.CLASS_HUNTER]	=	"사냥꾼",
	[LOC.CLASS_MAGE]	=	"마법사",
	[LOC.CLASS_PALADIN]	=	"성기사",
	[LOC.CLASS_PRIEST]	=	"사제",
	[LOC.CLASS_ROGUE]	=	"도적",
	[LOC.CLASS_SHAMAN]	=	"주술사",
	[LOC.CLASS_WARLOCK]	=	"흑마법사",
	[LOC.CLASS_WARRIOR]	=	"전사",

	[LOC.STR_OTHER]	= 	"기타",
	[LOC.STR_OPTIONS]	= 	"Decursive 설정",
	[LOC.STR_CLOSE]	= 	"닫기",
	[LOC.STR_DCR_PRIO]  = 	"Decursive 우선순위",
	[LOC.STR_DCR_SKIP]  = 	"Decursive 제외",
	[LOC.STR_QUICK_POP] = 	"빠른 추가",
	[LOC.STR_POP]	= 	"추가 목록",
	[LOC.STR_GROUP]	= 	"파티 ",




	[LOC.PRIORITY_SHOW] = "P",
	[LOC.POPULATE]	    = "p",
	[LOC.SKIP_SHOW]	    = "S",
	[LOC.CLEAR_PRIO]	= "C",
	[LOC.CLEAR_SKIP]	= "C",

	[LOC.PET_FEL_CAST]	=	"마법 삼키기",
	[LOC.PET_DOOM_CAST]	=	"마법 무효화",

	[BINDING_NAME_DCRSHOW]    	= "Decursive 메인바 표시/숨김\n(실시간 목록 고정위치)",
    
	[BINDING_NAME_DCRMUFSHOWHIDE] =	"작은 유닛 프레임 표시/숨김",

	[BINDING_NAME_DCRPRADD]     = "대상을 우선순위 목록에 추가",
	[BINDING_NAME_DCRPRCLEAR]   = "우선순위 목록 초기화",
	[BINDING_NAME_DCRPRLIST]    = "우선순위 목록 출력",
	[BINDING_NAME_DCRPRSHOW]    = "우선순위 목록 표시/숨김",

	[BINDING_NAME_DCRSKADD]   	= "대상을 제외 목록에 추가",
	[BINDING_NAME_DCRSKCLEAR] 	= "제외 목록 초기화",
	[BINDING_NAME_DCRSKLIST]  	= "제외 목록 출력",
	[BINDING_NAME_DCRSKSHOW]  	= "제외 목록 표시/숨김",
    
	[BINDING_NAME_DCRSHOWOPTION]=	"고정창 옵션 표시",



	[LOC.PRIORITY_LIST]  	= "Decursive 우선순위 목록",
	[LOC.SKIP_LIST_STR]  	= "Decursive 제외 목록",
	[LOC.OPTION_MENU]   	= "Decursive 설정 메뉴",
	[LOC.POPULATE_LIST]  	= "Decursive 목록에 빠른 추가",
	[LOC.LIST_ENTRY_ACTIONS]	= "|cFF33AA33[CTRL]|r 클릭: 해당 플레이어 제거\n|cFF33AA33좌|r-클릭: 해당 플레이어를 위로\n|cFF33AA33우|r-클릭: 해당 플레이어를 아래로\n|cFF33AA33[SHIFT] 좌|r-클릭: 해당 플레이어를 최상위로\n|cFF33AA33[SHIFT] 우|r-클릭: 해당 플레이어를 최하위로",
	[LOC.HIDE_MAIN]      	= "Decursive 창 닫기",
	[LOC.SHOW_MSG]	   	= "Decursive 창 표시, /dcrshow 명령어를 입력하세요.",
	[LOC.IS_HERE_MSG]	   	= "Decursive가 초기화 되었습니다. 옵션을 설정하세요.",

	[LOC.PRINT_CHATFRAME] 	= "기본 대화창에 메세지 표시",
	[LOC.PRINT_CUSTOM]    	= "Decursive 창에 메세지 표시",
	[LOC.PRINT_ERRORS]    	= "오류 메세지 출력",

	[LOC.SHOW_TOOLTIP]    	= "툴팁 표시",
	[LOC.REVERSE_LIVELIST]	= "실시간 목록 표시 반전",
	[LOC.TIE_LIVELIST]    	= "실시간 목록 표시를 DCR 창과 함께 표시",
	[LOC.HIDE_LIVELIST]   	= "실시간 목록 숨김",

	[LOC.AMOUNT_AFFLIC]   	= "표시할 대상의 수 : ",
	[LOC.BLACK_LENGTH]    	= "블랙리스트 추가 시간(초) : ",
	[LOC.SCAN_LENGTH]     	= "실시간 탐색 시간(초) : ",
	[LOC.ABOLISH_CHECK]   	= "해제전 \"해제 주문\" 검사",
	[LOC.RANDOM_ORDER]    	= "무작위 해제",
	[LOC.CURE_PETS]       	= "소환수 탐색과 해제",
	[LOC.IGNORE_STEALTH]  	= "은신 대상 무시",
	[LOC.PLAY_SOUND]	    	= "효과음 재생",
	[LOC.ANCHOR]          	= "Decursive 글자 위치",
	[LOC.DONOT_BL_PRIO]   	= "우선순위 블랙리스트 제외",

	-- $s is spell name
	-- $a is affliction name/type
	-- $t is target name
	[LOC.SPELL_FOUND]      	= "%s 주문 발견!",

	
	-- NEW LOCALS FOR 2.0
	[LOC.DEFAULT_MACROKEY] = "NONE", -- Ideally the key just beneath the "escape" key. Leave to "NONE" (do not translate) if you don't set a real key name.
	[LOC.OPT_LIVELIST] = "실시간 목록",
	[LOC.OPT_LIVELIST_DESC] = "실시간 목록에 대한 설정입니다.",
	[LOC.OPT_HIDELIVELIST_DESC] = "숨긴다면 해제된 대상의 정보를 표시합니다.",
	[LOC.OPT_SHOWTOOLTIP_DESC] = "실시간 목록과 작은 유닛 프레임에 디버프에 대한 자세한 툴팁을 표시합니다.",
	[LOC.OPT_PLAYSOUND_DESC]  = "해제 가능한 디버프 발견시 효과음을 재생합니다.",
	[LOC.OPT_AMOUNT_AFFLIC_DESC] = "실시간 목록에 표시할 유닛의 최대 수를 지정합니다.",
	[LOC.OPT_BLACKLENTGH_DESC] =  "블랙리스트에 등록할 시간을 지정합니다.",
	[LOC.OPT_SCANLENGTH_DESC] = "각 탐색의 시간 간격을 지정합니다.",
	[LOC.OPT_REVERSE_LIVELIST_DESC] = "실시간 목록을 아래에서 위로 생성합니다.",
	[LOC.OPT_TIE_LIVELIST_DESC] = "실시간 목록을 아래에서 위로 생성합니다.",
	[LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "시각적인 테스트 디버프 생성",
	[LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "디버프 발생 시 어떻게 보여지는 지를 표시하도록 합니다.",
	[LOC.OPT_MESSAGES]	= "메세지",
	[LOC.OPT_MESSAGES_DESC] = "메세지 표시에 대한 설정입니다.",
	[LOC.OPT_CHATFRAME_DESC] = "Decursive의 메세지가 기본 대화창에 표시됩니다.",
	[LOC.OPT_PRINT_CUSTOM_DESC] = "Decursive의 메세지가 사용자 정의 대화창에 표시됩니다.",
	[LOC.OPT_PRINT_ERRORS_DESC] = "오류를 표시합니다.",
	[LOC.OPT_ANCHOR_DESC]	= "사용자 정의 메세지창의 고정위치를 표시합니다.",
	[LOC.OPT_MFSETTINGS] = "작은 유닛 프레임 설정",
	[LOC.OPT_MFSETTINGS_DESC] = "작은 유닛 프레임에 대한 설정입니다.",
	[LOC.OPT_DISPLAYOPTIONS] = "디스플레이 옵션",
	[LOC.OPT_SHOWMFS] = "작은 유닛 프레임 표시",
	[LOC.OPT_SHOWMFS_DESC] = "클릭으로 해제하려면 반드시 활성화 되어야 합니다.",
	[LOC.OPT_GROWDIRECTION] = "MUF 표시 반전",
	[LOC.OPT_GROWDIRECTION_DESC] = "MUF를 하단에서 상단으로 표시합니다.",

	[LOC.OPT_STICKTORIGHT]		= "MUF창 오른쪽으로 정렬",
	[LOC.OPT_STICKTORIGHT_DESC]	= "MUF창은 오른쪽에서 왼쪽으로 증가되며 동작은 자동적으로 이루어질 것입니다.",
	[LOC.OPT_MUFSCOLORS]		= "색상",
	[LOC.OPT_MUFSCOLORS_DESC]	= "작은 유닛 프레임의 색상을 변경합니다.",
	[LOC.MISSINGUNIT]		= "잘못된 대상",
	[LOC.COLORALERT]		= "'%s'이 필요할때의 알림 색상을 설정합니다.",
	[LOC.COLORSTATUS]		= "MUF 상태가 '%s'일때 색상을 설정합니다.",
	[LOC.COLORCHRONOS]		= LOC.COLORCHRONOS,
	[LOC.COLORCHRONOS_DESC]		= LOC.COLORCHRONOS_DESC,

    [LOC.OPT_AUTOHIDEMFS]	    = LOC.OPT_AUTOHIDEMFS,
    [LOC.OPT_AUTOHIDEMFS_DESC]	    = LOC.OPT_AUTOHIDEMFS_DESC,
    [LOC.OPT_HIDEMFS_SOLO]	    = LOC.OPT_HIDEMFS_SOLO,
    [LOC.OPT_HIDEMFS_SOLO_DESC]	    = LOC.OPT_HIDEMFS_SOLO_DESC,
    [LOC.OPT_HIDEMFS_GROUP]	    = LOC.OPT_HIDEMFS_GROUP,
    [LOC.OPT_HIDEMFS_GROUP_DESC]    = LOC.OPT_HIDEMFS_GROUP_DESC,
    [LOC.OPT_HIDEMFS_NEVER]	    = LOC.OPT_HIDEMFS_NEVER,
    [LOC.OPT_HIDEMFS_NEVER_DESC]    = LOC.OPT_HIDEMFS_NEVER_DESC,

    [LOC.OPT_ADDDEBUFFFHIST]		= LOC.OPT_ADDDEBUFFFHIST,
    [LOC.OPT_ADDDEBUFFFHIST_DESC]	= LOC.OPT_ADDDEBUFFFHIST_DESC,

	[LOC.OPT_SHOWBORDER] = "직업 색상 테두리 표시",
	[LOC.OPT_SHOWBORDER_DESC] = "MUF에 유닛의 직업에 따른 색상을 테두리로 표시합니다.",
    [LOC.OPT_SHOWCHRONO] = LOC.OPT_SHOWCHRONO,
    [LOC.OPT_SHOWCHRONO_DESC] = LOC.OPT_SHOWCHRONO_DESC,
	[LOC.OPT_MAXMFS]  = "표시할 최대 유닛",
	[LOC.OPT_MAXMFS_DESC] = "표시할 작은 유닛 프레임의 최대 개수를 지정합니다.",
	[LOC.OPT_UNITPERLINES] = "한줄에 표시할 유닛의 수",
	[LOC.OPT_UNITPERLINES_DESC] = "한줄에 표시할 작은 유닛 프레임의 최대 개수를 지정합니다.",
	[LOC.OPT_MFSCALE] = "작은 유닛 프레임의 크기",
	[LOC.OPT_MFSCALE_DESC] = "작은 유닛 프레임의 크기를 설정합니다.",
	[LOC.OPT_LLSCALE] = "실시간 목록 크기",
	[LOC.OPT_LLSCALE_DESC] = "Decursive 메인바와 실시간 목록의 크기를 설정합니다. (메인바가 표시되어 있어야 함)",
	[LOC.OPT_SHOWHELP] = "도움말 표시",
	[LOC.OPT_SHOWHELP_DESC] = "작은 유닛 프레임에 마우스를 올리면 정보 툴팁을 표시합니다.",
	[LOC.OPT_MFPERFOPT] = "성능 설정",
	[LOC.OPT_MFREFRESHRATE] = "갱신 주기",
	[LOC.OPT_MFREFRESHRATE_DESC] = "갱신할 시간 간격(한번에 1 혹은 그 이상 작은 유닛 프레임을 갱신할 수 있습니다.)",
	[LOC.OPT_MFREFRESHSPEED] = "갱신 속도",
	[LOC.OPT_MFREFRESHSPEED_DESC] = "한번에 갱신할 작은 유닛 프레임의 개수",
	[LOC.OPT_CURINGOPTIONS] = "해제 옵션",
	[LOC.OPT_CURINGOPTIONS_DESC] = "해제의 다양한 형태를 설정합니다.",
	[LOC.OPT_ABOLISHCHECK_DESC] = "'해제' 주문을 가진 대상을 표시하고 치유 할 지를 선택합니다.",
	[LOC.OPT_DONOTBLPRIO_DESC] = "우선순위에 등록된 유닛은 블랙리스트에 추가하지 않습니다.",
	[LOC.OPT_RANDOMORDER_DESC] = "대상을 무작위로 표시하고 치료합니다.(비추천)",
	[LOC.OPT_CUREPETS_DESC] = "소환수를 관리하고 해제합니다.",
	[LOC.OPT_IGNORESTEALTHED_DESC] = "은신한 대상을 무시합니다.",
	[LOC.OPT_CURINGORDEROPTIONS] = "해제 순서 설정",
	[LOC.OPT_MAGICCHECK_DESC]	= "체크 시 마법에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_MAGICCHARMEDCHECK_DESC] = "체크 시 지배에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_CHARMEDCHECK_DESC] = "체크 시 지배에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_POISONCHECK_DESC] = "체크 시 독에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_DISEASECHECK_DESC] = "체크 시 질병에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_CURSECHECK_DESC] = "체크 시 저주에 걸린 대상을 표시하고 치료합니다.",
	[LOC.OPT_DEBUFFFILTER] = "디버프 필터링",
	[LOC.OPT_DEBUFFFILTER_DESC] = "이름과 직업에 의해 필터링 할 디버프를 선택합니다.",
	[LOC.OPT_MACROOPTIONS] = "매크로 설정",
	[LOC.OPT_MACROOPTIONS_DESC] = "Decursive에 의해 생성된 매크로의 동작을 설정합니다.",
	[LOC.OPT_MACROBIND] = "매크로 단축키 설정",
	[LOC.OPT_MACROBIND_DESC] = "'Decursive' 매크로를 호출 할 키을 지정합니다.\n\n키를 누르고 키보드의 'Enter'키를 누르면 새롭게 지정된 키가 저장됩니다.(당신의 마우스 커서가 편집 구역내에 있어야 합니다)",
	[LOC.OPT_RESETOPTIONS] = "기본값으로 설정 초기화",
	[LOC.OPT_RESETOPTIONS_DESC] =  "현재 프로파일을 기본값으로 초기화합니다.",
	[LOC.OPT_REMOVESKDEBCONF] = "정말로 Decursive의 디버프 제외 목록에서\n %s|1을;를; 를 제거 하시겠습니까?",
	[LOC.OPT_RESTPROFILECONF] = "정말로 '(%s) %s'\n 프로파일을 기본 설정으로\n 초기화 하시겠습니까?",
	[LOC.OPT_PROFILERESET] = "프로파일 초기화...",
	[LOC.OPT_AFFLICTEDBYSKIPPED] = "%s - %s에 걸리면 무시합니다.",
	[LOC.OPT_DEBCHECKEDBYDEF] = "\n\n기본값으로 설정됨",
	[LOC.OPT_ALWAYSIGNORE] = "비전투시에도 항상 무시",
	[LOC.OPT_ALWAYSIGNORE_DESC] = "선택시, 해당 디버프는 전투 중이 아닐 때에도 무시됩니다.",
	[LOC.OPT_REMOVETHISDEBUFF] = "해당 디버프 제거",
	[LOC.OPT_REMOVETHISDEBUFF_DESC] = "Skip 목록에서 '%s' 제거",
	[LOC.OPT_RESETDEBUFF] = "해당 디버프 초기화",
	[LOC.OPT_RESETDTDCRDEFAULT] = "'%s' Decursive 기본으로 초기화",
	[LOC.OPT_USERDEBUFF] = "해당 디버프는 Decursive의 기본 디버프가 아닙니다.",
	[LOC.OPT_DEBUFFENTRY_DESC] = "해당 디버프에 걸렸을 때 전투 중 무시할 직업을 선택하세요.",
	[LOC.OPT_ADDDEBUFF] = "목록에 디버프 추가",
	[LOC.OPT_ADDDEBUFF_DESC] = "이 목록에 새로운 디버프 추가",
	[LOC.OPT_ADDDEBUFF_USAGE] = "<디버프명>",
	[LOC.OPT_READDDEFAULTSD] = "기본 디버프 재추가",
	[LOC.OPT_READDDEFAULTSD_DESC1] = "해당 목록에 누락된 Decursive의 기본 디버프를 추가합니다.\n설정은 변하지 않습니다.",
	[LOC.OPT_READDDEFAULTSD_DESC2] = "Decursive의 모든 기본 디버프는 해당 목록에 있습니다.",

	[LOC.OPT_LVONLYINRANGE] = "범위내 대상",
	[LOC.OPT_LVONLYINRANGE_DESC] = "해제 범위내 대상만 실시간 목록에 표시합니다.",

	[LOC.OPT_MFALPHA] = "투명도",
	[LOC.OPT_MFALPHA_DESC] = "디버프의 걸린 대상이 없을 때 MUF의 투명도를 지정합니다.",

	[LOC.OPT_LLALPHA] = "실시간 목록 투명도",
	[LOC.OPT_LLALPHA_DESC] = "Decursive 메인바와 실시간 목록의 투명도를 변경합니다. (메인바가 표시되어 있어야 함)",

   
	[LOC.OPT_ADVDISP] = "고급 표시 설정",
	[LOC.OPT_ADVDISP_DESC] = "각 MUF 사이 간격 설정을 위해 테두리와 가운데 구분의 투명도를 설정할 수 있습니다.",
	[LOC.OPT_TIECENTERANDBORDER] = "가운데와 테두리의 투명도",
	[LOC.OPT_TIECENTERANDBORDER_OPT] = "체크 시 테두리의 투명도가 가운데 투명도의 반이됩니다.",
	[LOC.OPT_BORDERTRANSP] = "테두리 투명도",
	[LOC.OPT_BORDERTRANSP_DESC] = "테두리의 투명도를 설정합니다.",
	[LOC.OPT_CENTERTRANSP] = "가운데 투명도",
	[LOC.OPT_CENTERTRANSP_DESC] = "가운데의 투명도를 설정합니다.",
	[LOC.OPT_TIEXYSPACING] = "수평/수직 간격",
	[LOC.OPT_TIEXYSPACING_DESC] = "MUF의 수평과 수직 간격이 같아 집니다.",
	[LOC.OPT_XSPACING] = "수평 간격",
	[LOC.OPT_XSPACING_DESC] = "MUF 사이의 수평 간격을 설정하니다.",
	[LOC.OPT_YSPACING] = "수직 간격",
	[LOC.OPT_YSPACING_DESC] = "MUF 사이의 수직 간격을 설정합니다.",


	[LOC.HLP_LL_ONCLICK_TEXT] = "실시간 목록을 클릭하는 것은 WoW 2.0 이후 사용할 수 없습니다. Decursive 폴더에 위치한 \"Readme.txt\" 읽어 보세요...\n(해당 목록을 이동하려면 /dcrshow 혹은 ALT-좌-클릭하세요.)",
	[LOC.HLP_LEFTCLICK] 	= "좌-클릭",
	[LOC.HLP_RIGHTCLICK] 	= "우-클릭",
	[LOC.HLP_MIDDLECLICK] 	= "가운데-클릭",

	[LOC.HLP_NOTHINGTOCURE] = "치료할 것이 없습니다!",
	[LOC.HLP_WRONGMBUTTON] = "잘못된 마우스 버튼입니다!",
	[LOC.HLP_USEXBUTTONTOCURE] = "해당 디버프를 치료하려면 \"%s\" 버튼을 사용하세요",

	[LOC.CTRL] 	= "CTRL",
	[LOC.ALT] 	= "ALT",
	[LOC.SHIFT] = "SHIFT",

	[LOC.TARGETUNIT] 	= "대상",
	[LOC.FOCUSUNIT] 	= "주시 대상",

	[LOC.ABSENT] 	= "(%s) 자리비움",
	[LOC.TOOFAR] 	= "거리 벗어남",
	[LOC.NORMAL] 	= "정상",
	[LOC.STEALTHED] 	= "은신상태",
	[LOC.BLACKLISTED] 	= "블랙리스트됨",
	[LOC.UNITSTATUS] 	= "상태: ",
	[LOC.AFFLICTEDBY] 	= "%s에 걸림",

	[LOC.SUCCESSCAST] 	= "|cFF22FFFF%s %s|r|1으로;로; %s |cFF00AA00치료 성공!|r",
	[LOC.FAILEDCAST]	= LOC.FAILEDCAST,
	[LOC.HANDLEHELP] 	= "작은 유닛 프레임(MUFs) 모두 이동",

	[LOC.MACROKEYALREADYMAPPED] = "경고: Decursive 매크로에 지정한 [%s]키는 '%s'를 위해 지정되어 있었습니다.\n당신이 매크로에 다른 키를 지정하면 Decursive는 이전 설정을 복원할 것입니다.",
	[LOC.MACROKEYMAPPINGSUCCESS] = "[%s] 키가 Decursive 매크로로 성공적으로 지정되었습니다.",
	[LOC.MACROKEYMAPPINGFAILED] = "[%s] 키는 Decursive 매크로로 지정할 수 없습니다!",
	[LOC.MACROKEYNOTMAPPED] = "Decursive 매크로가 지정되지 않았습니다. 설정 메뉴를 통해 키를 지정할 수 있습니다.",

	[LOC.OPT_NOKEYWARN] = "키 없음 경고",
	[LOC.OPT_NOKEYWARN_DESC] = "지정된 키가 없다면 경고를 표시합니다.",
	[LOC.NOSPELL] = "이용가능한 주문이 없습니다.",

	[LOC.FUBARMENU]  = "FuBar 메뉴",
	[LOC.FUBARMENU_DESC]  = "FuBar 아이콘에 관련된 옵션을 설정합니다.",
    
    -- OPTIONS

} end);

-- // }}}

DcrLoadedFiles["localization.kr.lua"] = "@file-abbreviated-hash@";
