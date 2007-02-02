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



-----------------------------------------------------------------------------------------------
-- Chinese localization (Default)  By srshyu@seed.net.tw and snowwolf@seed.net.tw and Peter Sun
-----------------------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date$", "$Revision$");

local L = Dcr.L;
L:RegisterTranslations("zhTW", function() return {
    [Dcr.LOC.ALLIANCE_NAME]	=	'聯盟',

    [Dcr.LOC.CLASS_DRUID]	=	'德魯伊',
    [Dcr.LOC.CLASS_HUNTER]	=	'獵人',
    [Dcr.LOC.CLASS_MAGE]	=	'法師',
    [Dcr.LOC.CLASS_PALADIN]	=	'聖騎士',
    [Dcr.LOC.CLASS_PRIEST]	=	'牧師',
    [Dcr.LOC.CLASS_ROGUE]	=	'盜賊',
    [Dcr.LOC.CLASS_SHAMAN]	=	'薩滿',
    [Dcr.LOC.CLASS_WARLOCK]	=	'術士',
    [Dcr.LOC.CLASS_WARRIOR]	=	'戰士',

    [Dcr.LOC.STR_OTHER]	=	'其他',
    [Dcr.LOC.STR_OPTIONS]	=	'選項',
    [Dcr.LOC.STR_CLOSE]	=	'關閉',
    [Dcr.LOC.STR_DCR_PRIO]	=	'Decursive 優先選單',
    [Dcr.LOC.STR_DCR_SKIP]	=	'Decursive 忽略選單',
    [Dcr.LOC.STR_QUICK_POP]	=	'快速添加介面',
    [Dcr.LOC.STR_POP]	=	'快速添加清單',
    [Dcr.LOC.STR_GROUP]	=	'隊伍 ',




    [Dcr.LOC.PRIORITY_SHOW]	=	'P',
    [Dcr.LOC.POPULATE]	=	'P',
    [Dcr.LOC.SKIP_SHOW]	=	'S',
    [Dcr.LOC.CLEAR_PRIO]	=	'C',
    [Dcr.LOC.CLEAR_SKIP]	=	'C',





    [Dcr.LOC.PET_FEL_CAST]	=	"吞噬魔法",
    [Dcr.LOC.PET_DOOM_CAST]	=	"驅散魔法",

    [Dcr.LOC.SPELL_POLYMORPH]		  = "Polymorph",
    [Dcr.LOC.SPELL_CURE_DISEASE]	=	'祛病術',
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]	=	'驅除疾病',
    [Dcr.LOC.SPELL_PURIFY]	=	'純淨術',
    [Dcr.LOC.SPELL_CLEANSE]	=	'清潔術',
    [Dcr.LOC.SPELL_DISPELL_MAGIC]	=	'驅散魔法',
    [Dcr.LOC.SPELL_CURE_POISON]	=	'消毒術',
    [Dcr.LOC.SPELL_ABOLISH_POISON]	=	'驅毒術',
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]	=	'解除次級詛咒',
    [Dcr.LOC.SPELL_REMOVE_CURSE]	=	'解除詛咒',
    [Dcr.LOC.SPELL_PURGE]	=	'淨化術',

    [BINDING_NAME_DCRSHOW]	=	"顯示或隱藏 Decursive 工作條",

    [BINDING_NAME_DCRPRADD]	=	"添加目標至優先列表",
    [BINDING_NAME_DCRPRCLEAR]	=	"清空優先列表",
    [BINDING_NAME_DCRPRLIST]	=	"顯示優先列表至聊天視窗",
    [BINDING_NAME_DCRPRSHOW]	=	"關閉優先列表",

    [BINDING_NAME_DCRSKADD]	=	"添加目標至忽略列表",
    [BINDING_NAME_DCRSKCLEAR]	=	"清空忽略列表",
    [BINDING_NAME_DCRSKLIST]	=	"顯示忽略列表至聊天視窗",
    [BINDING_NAME_DCRSKSHOW]	=	"關閉忽略列表",

    [Dcr.LOC.PRIORITY_LIST]	=	"Decursive 優先列表",
    [Dcr.LOC.SKIP_LIST_STR]	=	"Decursive 忽略列表",
    [Dcr.LOC.OPTION_MENU]	=	"Decursive 選項",
    [Dcr.LOC.POPULATE_LIST]	=	"Decursive 列表快速添加介面",
    [Dcr.LOC.LIST_ENTRY_ACTIONS]	=	Dcr.LOC.LIST_ENTRY_ACTIONS,
    [Dcr.LOC.HIDE_MAIN]	=	"隱藏 Decursive 視窗",
    [Dcr.LOC.SHOW_MSG]	=	"要顯示 Decursive 視窗，請輸入 /dcrshow。",
    [Dcr.LOC.IS_HERE_MSG]	=	"Decursive 已經啟動，請核對設定選項。",

    [Dcr.LOC.PRINT_CHATFRAME]	=	"在聊天視窗顯示訊息",
    [Dcr.LOC.PRINT_CUSTOM]	=	"在遊戲畫面中顯示訊息",
    [Dcr.LOC.PRINT_ERRORS]	=	"顯示錯誤訊息",

    [Dcr.LOC.SHOW_TOOLTIP]	=	"在即時清單顯示簡要說明",
    [Dcr.LOC.REVERSE_LIVELIST]	=	"反向顯示即時清單",
    [Dcr.LOC.TIE_LIVELIST]	=	"即時清單顯示與 DCR 視窗連結",
    [Dcr.LOC.HIDE_LIVELIST]	=	"隱藏即時清單",

    [Dcr.LOC.AMOUNT_AFFLIC]	=	"即時清單顯示人數: ",
    [Dcr.LOC.BLACK_LENGTH]	=	"失敗幾次後加入黑名單: ",
    [Dcr.LOC.SCAN_LENGTH]	=	"即時檢測時間間隔(秒): ",
    [Dcr.LOC.ABOLISH_CHECK]	=	"施法前檢查是否需要淨化",
    [Dcr.LOC.RANDOM_ORDER]	=	"隨機淨化玩家",
    [Dcr.LOC.CURE_PETS]	=	"檢測並淨化寵物",
    [Dcr.LOC.IGNORE_STEALTH]	=	"忽略潛行的玩家",
    [Dcr.LOC.PLAY_SOUND]	=	"有玩家需要淨化時發出音效",
    [Dcr.LOC.ANCHOR]	=	"Decursive 文字定位點",
    [Dcr.LOC.DONOT_BL_PRIO]	=	"不添加優先名單的玩家到黑名單",

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [Dcr.LOC.SPELL_FOUND]	=	"找到 %s 法術",


    -- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP] = "無夢睡眠",
    [Dcr.LOC.GDREAMLESSSLEEP] = "強效昏睡",
    [Dcr.LOC.ANCIENTHYSTERIA] = "上古狂亂",
    [Dcr.LOC.IGNITE] = "點燃法力",
    [Dcr.LOC.TAINTEDMIND] = "污濁之魂",
    [Dcr.LOC.MAGMASHAKLES] = "熔岩鐐銬",
    [Dcr.LOC.CRIPLES] = "殘廢術",
    [Dcr.LOC.DUSTCLOUD] = "灰塵之雲",
    [Dcr.LOC.WIDOWSEMBRACE] = "黑女巫的擁抱",
    [Dcr.LOC.CURSEOFTONGUES] = "語言詛咒",
    [Dcr.LOC.SONICBURST] = "音爆",
    [Dcr.LOC.THUNDERCLAP] = "雷霆一擊",
    [Dcr.LOC.DELUSIONOFJINDO] = "金度的欺騙",

    [Dcr.LOC.DISEASE] = '疾病';
    [Dcr.LOC.MAGIC]  = '魔法';
    [Dcr.LOC.POISON]  = '中毒';
    [Dcr.LOC.CURSE]  = '詛咒';
    [Dcr.LOC.MAGICCHARMED] = Dcr.LOC.MAGICCHARMED;
    [Dcr.LOC.CHARMED] = Dcr.LOC.CHARMED;

    [Dcr.LOC.MUTATINGINJECTION] = Dcr.LOC.MUTATINGINJECTION;
    [Dcr.LOC.DEFAULT_MACROKEY] = "NONE"; -- Ideally the key just beneath the "escape" key. Leave to "NONE" (do not translate) if you don't set a real key name.
    [Dcr.LOC.OPT_LIVELIST] = Dcr.LOC.OPT_LIVELIST,
    [Dcr.LOC.OPT_LIVELIST_DESC] = Dcr.LOC.OPT_LIVELIST_DESC,
    [Dcr.LOC.OPT_HIDELIVELIST_DESC] = Dcr.LOC.OPT_HIDELIVELIST_DESC,
    [Dcr.LOC.OPT_SHOWTOOLTIP_DESC] = Dcr.LOC.OPT_SHOWTOOLTIP_DESC,
    [Dcr.LOC.OPT_PLAYSOUND_DESC] = Dcr.LOC.OPT_PLAYSOUND_DESC,
    [Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC] = Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC,
    [Dcr.LOC.OPT_BLACKLENTGH_DESC] = Dcr.LOC.OPT_BLACKLENTGH_DESC,
    [Dcr.LOC.OPT_SCANLENGTH_DESC] = Dcr.LOC.OPT_SCANLENGTH_DESC,
    [Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = Dcr.LOC.OPT_REVERSE_LIVELIST_DESC,
    [Dcr.LOC.OPT_TIE_LIVELIST_DESC] = Dcr.LOC.OPT_TIE_LIVELIST_DESC,
    [Dcr.LOC.OPT_MESSAGES] = Dcr.LOC.OPT_MESSAGES,
    [Dcr.LOC.OPT_MESSAGES_DESC] = Dcr.LOC.OPT_MESSAGES_DESC,
    [Dcr.LOC.OPT_CHATFRAME_DESC] = Dcr.LOC.OPT_CHATFRAME_DESC,
    [Dcr.LOC.OPT_PRINT_CUSTOM_DESC] = Dcr.LOC.OPT_PRINT_CUSTOM_DESC,
    [Dcr.LOC.OPT_PRINT_ERRORS_DESC] = Dcr.LOC.OPT_PRINT_ERRORS_DESC,
    [Dcr.LOC.OPT_ANCHOR_DESC] = Dcr.LOC.OPT_ANCHOR_DESC,
    [Dcr.LOC.OPT_MFSETTINGS] = Dcr.LOC.OPT_MFSETTINGS,
    [Dcr.LOC.OPT_MFSETTINGS_DESC] = Dcr.LOC.OPT_MFSETTINGS_DESC,
    [Dcr.LOC.OPT_DISPLAYOPTIONS] = Dcr.LOC.OPT_DISPLAYOPTIONS,
    [Dcr.LOC.OPT_SHOWMFS] = Dcr.LOC.OPT_SHOWMFS,
    [Dcr.LOC.OPT_SHOWMFS_DESC] = Dcr.LOC.OPT_SHOWMFS_DESC,
    [Dcr.LOC.OPT_MAXMFS] = Dcr.LOC.OPT_MAXMFS,
    [Dcr.LOC.OPT_MAXMFS_DESC] = Dcr.LOC.OPT_MAXMFS_DESC,
    [Dcr.LOC.OPT_UNITPERLINES] = Dcr.LOC.OPT_UNITPERLINES,
    [Dcr.LOC.OPT_UNITPERLINES_DESC] = Dcr.LOC.OPT_UNITPERLINES_DESC,
    [Dcr.LOC.OPT_MFSCALE] = Dcr.LOC.OPT_MFSCALE,
    [Dcr.LOC.OPT_MFSCALE_DESC] = Dcr.LOC.OPT_MFSCALE_DESC,
    [Dcr.LOC.OPT_SHOWHELP] = Dcr.LOC.OPT_SHOWHELP,
    [Dcr.LOC.OPT_SHOWHELP_DESC] = Dcr.LOC.OPT_SHOWHELP_DESC,
    [Dcr.LOC.OPT_MFPERFOPT] = Dcr.LOC.OPT_MFPERFOPT,
    [Dcr.LOC.OPT_MFREFRESHRATE] = Dcr.LOC.OPT_MFREFRESHRATE,
    [Dcr.LOC.OPT_MFREFRESHRATE_DESC] = Dcr.LOC.OPT_MFREFRESHRATE_DESC,
    [Dcr.LOC.OPT_MFREFRESHSPEED] = Dcr.LOC.OPT_MFREFRESHSPEED,
    [Dcr.LOC.OPT_MFREFRESHSPEED_DESC] = Dcr.LOC.OPT_MFREFRESHSPEED_DESC,
    [Dcr.LOC.OPT_CURINGOPTIONS] = Dcr.LOC.OPT_CURINGOPTIONS,
    [Dcr.LOC.OPT_CURINGOPTIONS_DESC] = Dcr.LOC.OPT_CURINGOPTIONS_DESC,
    [Dcr.LOC.OPT_ABOLISHCHECK_DESC] = Dcr.LOC.OPT_ABOLISHCHECK_DESC,
    [Dcr.LOC.OPT_DONOTBLPRIO_DESC] = Dcr.LOC.OPT_DONOTBLPRIO_DESC,
    [Dcr.LOC.OPT_RANDOMORDER_DESC] = Dcr.LOC.OPT_RANDOMORDER_DESC,
    [Dcr.LOC.OPT_CUREPETS_DESC] = Dcr.LOC.OPT_CUREPETS_DESC,
    [Dcr.LOC.OPT_IGNORESTEALTHED_DESC] = Dcr.LOC.OPT_IGNORESTEALTHED_DESC,
    [Dcr.LOC.OPT_CURINGORDEROPTIONS] = Dcr.LOC.OPT_CURINGORDEROPTIONS,
    [Dcr.LOC.OPT_MAGICCHECK_DESC] = Dcr.LOC.OPT_MAGICCHECK_DESC,
    [Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC] = Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC,
    [Dcr.LOC.OPT_CHARMEDCHECK_DESC] = Dcr.LOC.OPT_CHARMEDCHECK_DESC,
    [Dcr.LOC.OPT_POISONCHECK_DESC] = Dcr.LOC.OPT_POISONCHECK_DESC,
    [Dcr.LOC.OPT_DISEASECHECK_DESC] = Dcr.LOC.OPT_DISEASECHECK_DESC,
    [Dcr.LOC.OPT_CURSECHECK_DESC] = Dcr.LOC.OPT_CURSECHECK_DESC,
    [Dcr.LOC.OPT_DEBUFFFILTER] = Dcr.LOC.OPT_DEBUFFFILTER,
    [Dcr.LOC.OPT_DEBUFFFILTER_DESC] = Dcr.LOC.OPT_DEBUFFFILTER_DESC,
    [Dcr.LOC.OPT_MACROOPTIONS] = Dcr.LOC.OPT_MACROOPTIONS,
    [Dcr.LOC.OPT_MACROOPTIONS_DESC] = Dcr.LOC.OPT_MACROOPTIONS_DESC,
    [Dcr.LOC.OPT_MACROBIND] = Dcr.LOC.OPT_MACROBIND,
    [Dcr.LOC.OPT_MACROBIND_DESC] = Dcr.LOC.OPT_MACROBIND_DESC,
    [Dcr.LOC.OPT_RESETOPTIONS] = Dcr.LOC.OPT_RESETOPTIONS,
    [Dcr.LOC.OPT_RESETOPTIONS_DESC] = Dcr.LOC.OPT_RESETOPTIONS_DESC,
    [Dcr.LOC.OPT_REMOVESKDEBCONF] = Dcr.LOC.OPT_REMOVESKDEBCONF,
    [Dcr.LOC.OPT_RESTPROFILECONF] = Dcr.LOC.OPT_RESTPROFILECONF,
    [Dcr.LOC.OPT_PROFILERESET] = Dcr.LOC.OPT_PROFILERESET,
    [Dcr.LOC.OPT_AFFLICTEDBYSKIPPED] = Dcr.LOC.OPT_AFFLICTEDBYSKIPPED,
    [Dcr.LOC.OPT_DEBCHECKEDBYDEF] = Dcr.LOC.OPT_DEBCHECKEDBYDEF,
    [Dcr.LOC.OPT_REMOVETHISDEBUFF] = Dcr.LOC.OPT_REMOVETHISDEBUFF,
    [Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC,
    [Dcr.LOC.OPT_RESETDEBUFF] = Dcr.LOC.OPT_RESETDEBUFF,
    [Dcr.LOC.OPT_RESETDTDCRDEFAULT] = Dcr.LOC.OPT_RESETDTDCRDEFAULT,
    [Dcr.LOC.OPT_USERDEBUFF] = Dcr.LOC.OPT_USERDEBUFF,
    [Dcr.LOC.OPT_DEBUFFENTRY_DESC] = Dcr.LOC.OPT_DEBUFFENTRY_DESC,
    [Dcr.LOC.OPT_ADDDEBUFF] = Dcr.LOC.OPT_ADDDEBUFF,
    [Dcr.LOC.OPT_ADDDEBUFF_DESC] = Dcr.LOC.OPT_ADDDEBUFF_DESC,
    [Dcr.LOC.OPT_ADDDEBUFF_USAGE] = Dcr.LOC.OPT_ADDDEBUFF_USAGE,
    [Dcr.LOC.OPT_READDDEFAULTSD] = Dcr.LOC.OPT_READDDEFAULTSD,
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC1] = Dcr.LOC.OPT_READDDEFAULTSD_DESC1,
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC2] = Dcr.LOC.OPT_READDDEFAULTSD_DESC2,

    [Dcr.LOC.OPT_LVONLYINRANGE] = Dcr.LOC.OPT_LVONLYINRANGE,
    [Dcr.LOC.OPT_LVONLYINRANGE_DESC] = Dcr.LOC.OPT_LVONLYINRANGE_DESC,

    [Dcr.LOC.OPT_MFALPHA] = OPT_MFALPHA,
    [Dcr.LOC.OPT_MFALPHA_DESC] = OPT_MFALPHA_DESC,

    [Dcr.LOC.HLP_LEFTCLICK] = Dcr.LOC.HLP_LEFTCLICK,
    [Dcr.LOC.HLP_RIGHTCLICK] = Dcr.LOC.HLP_RIGHTCLICK,
    [Dcr.LOC.HLP_MIDDLECLICK] = Dcr.LOC.HLP_MIDDLECLICK,

    [Dcr.LOC.CTRL] = Dcr.LOC.CTRL,
    [Dcr.LOC.ALT] = Dcr.LOC.ALT,
    [Dcr.LOC.SHIFT] = Dcr.LOC.SHIFT,
    
    [Dcr.LOC.TARGETUNIT] = Dcr.LOC.TARGETUNIT,
    [Dcr.LOC.FOCUSUNIT]  = Dcr.LOC.FOCUSUNIT,


    [Dcr.LOC.ABSENT] = Dcr.LOC.ABSENT,
    [Dcr.LOC.TOOFAR] = Dcr.LOC.TOOFAR,
    [Dcr.LOC.NORMAL] = Dcr.LOC.NORMAL,
    [Dcr.LOC.STEALTHED] = Dcr.LOC.STEALTHED,
    [Dcr.LOC.BLACKLISTED] = Dcr.LOC.BLACKLISTED,
    [Dcr.LOC.UNITSTATUS] = Dcr.LOC.UNITSTATUS,
    [Dcr.LOC.AFFLICTEDBY] = Dcr.LOC.AFFLICTEDBY,
    
    [Dcr.LOC.SUCCESSCAST] = Dcr.LOC.SUCCESSCAST,

    [Dcr.LOC.HANDLEHELP] = Dcr.LOC.HANDLEHELP,

    [Dcr.LOC.MACROKEYALREADYMAPPED] = Dcr.LOC.MACROKEYALREADYMAPPED,
    [Dcr.LOC.MACROKEYMAPPINGSUCCESS] = Dcr.LOC.MACROKEYMAPPINGSUCCESS,
    [Dcr.LOC.MACROKEYMAPPINGFAILED] = Dcr.LOC.MACROKEYMAPPINGFAILED,
    [Dcr.LOC.MACROKEYNOTMAPPED] = Dcr.LOC.MACROKEYNOTMAPPED,

} end);


