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
-- Chinese localization (Default)
-------------------------------------------------------------------------------

local L = Dcr.L;
L:RegisterTranslations("zhTW", function() return {


    [Dcr.LOC.DISEASE] = '疾病',
    [Dcr.LOC.MAGIC]   = '魔法',
    [Dcr.LOC.POISON]  = '中毒',
    [Dcr.LOC.CURSE]   = '詛咒',
    [Dcr.LOC.MAGICCHARMED] = '魔法誘惑',
    [Dcr.LOC.CHARMED] = '誘惑',


    [Dcr.LOC.CLASS_DRUID]   = '德魯伊',
    [Dcr.LOC.CLASS_HUNTER]  = '獵人',
    [Dcr.LOC.CLASS_MAGE]    = '法師',
    [Dcr.LOC.CLASS_PALADIN] = '聖騎士',
    [Dcr.LOC.CLASS_PRIEST]  = '牧師',
    [Dcr.LOC.CLASS_ROGUE]   = '盜賊',
    [Dcr.LOC.CLASS_SHAMAN]  = '薩滿',
    [Dcr.LOC.CLASS_WARLOCK] = '術士',
    [Dcr.LOC.CLASS_WARRIOR] = '戰士',

    [Dcr.LOC.STR_OTHER]	    = '其他',
    [Dcr.LOC.STR_OPTIONS]	    = "Decursive 設定選項",
    [Dcr.LOC.STR_CLOSE]	    = '關閉',
    [Dcr.LOC.STR_DCR_PRIO]    = 'Decursive 優先選單',
    [Dcr.LOC.STR_DCR_SKIP]    = 'Decursive 忽略選單',
    [Dcr.LOC.STR_QUICK_POP]   = '快速添加介面',
    [Dcr.LOC.STR_POP]	    = '快速添加清單',
    [Dcr.LOC.STR_GROUP]	    = '隊伍 ',




    [Dcr.LOC.PRIORITY_SHOW]   = 'P',
    [Dcr.LOC.POPULATE]	    = 'p',
    [Dcr.LOC.SKIP_SHOW]	    = 'S',
    [Dcr.LOC.CLEAR_PRIO]	    = 'C',
    [Dcr.LOC.CLEAR_SKIP]	    = 'C',





    [Dcr.LOC.PET_FEL_CAST]  = "吞噬魔法",
    [Dcr.LOC.PET_DOOM_CAST] = "驅散魔法",


    [Dcr.LOC.SPELL_POLYMORPH]		  = '變形術',
    [Dcr.LOC.SPELL_CURE_DISEASE]        = '祛病術',
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]     = '驅除疾病',
    [Dcr.LOC.SPELL_PURIFY]              = '純淨術',
    [Dcr.LOC.SPELL_CLEANSE]            = '淨化術',
    [Dcr.LOC.SPELL_DISPELL_MAGIC]       = '驅散魔法',
    [Dcr.LOC.SPELL_CURE_POISON]         = '消毒術',
    [Dcr.LOC.SPELL_ABOLISH_POISON]      = '驅毒術',
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE] = '解除次級詛咒',
    [Dcr.LOC.SPELL_REMOVE_CURSE]        = '解除詛咒',
    [Dcr.LOC.SPELL_PURGE]               = '淨化術',

    [BINDING_NAME_DCRSHOW]    = "顯示或隱藏 Decursive 工作條",

    [BINDING_NAME_DCRMUFSHOWHIDE] = "顯示或隱藏 micro-unit frames",

    [BINDING_NAME_DCRPRADD]     = "添加目標至優先名單",
    [BINDING_NAME_DCRPRCLEAR]   = "清空優先名單",
    [BINDING_NAME_DCRPRLIST]    = "顯示優先名單至聊天視窗",
    [BINDING_NAME_DCRPRSHOW]    = "開/關優先名單",

    [BINDING_NAME_DCRSKADD]   = "添加目標至忽略名單",
    [BINDING_NAME_DCRSKCLEAR] = "清空忽略名單",
    [BINDING_NAME_DCRSKLIST]  = "顯示忽略名單至聊天視窗",
    [BINDING_NAME_DCRSKSHOW]  = "開/關忽略名單",
    [BINDING_NAME_DCRSHOWOPTION] = "顯示靜態設定選單",


    [Dcr.LOC.PRIORITY_LIST]  = "Decursive 優先名單",
    [Dcr.LOC.SKIP_LIST_STR]  = "Decursive 忽略名單",
    [Dcr.LOC.OPTION_MENU]   = "Decursive 選項",
    [Dcr.LOC.POPULATE_LIST]  = "Decursive 名單快速添加介面",
    [Dcr.LOC.LIST_ENTRY_ACTIONS]     = "|cFF33AA33[CTRL]|r-左鍵: 移除該玩家\n |cFF33AA33左|r-鍵: 提升該玩家順序\n |cFF33AA33右|r-鍵: 降低該玩家順序\n |cFF33AA33[SHIFT] 左|r-鍵: 將該玩家置頂\n |cFF33AA33[SHIFT] 右|r-鍵: 將該玩家置底",
    [Dcr.LOC.HIDE_MAIN]      = "隱藏 Decursive 視窗",
    [Dcr.LOC.SHOW_MSG]	   = "要顯示 Decursive 視窗，請輸入 /dcrshow。",
    [Dcr.LOC.IS_HERE_MSG]	   = "Decursive 已經啟動，請核對設定選項。",

    [Dcr.LOC.PRINT_CHATFRAME] = "在聊天視窗顯示訊息",
    [Dcr.LOC.PRINT_CUSTOM]    = "在遊戲畫面中顯示訊息",
    [Dcr.LOC.PRINT_ERRORS]    = "顯示錯誤訊息",

    [Dcr.LOC.SHOW_TOOLTIP]    = "在即時清單顯示簡要說明",
    [Dcr.LOC.REVERSE_LIVELIST]= "反向顯示即時清單",
    [Dcr.LOC.TIE_LIVELIST]    = "即時清單顯示與 DCR 視窗連結",
    [Dcr.LOC.HIDE_LIVELIST]   = "隱藏即時清單",

    [Dcr.LOC.AMOUNT_AFFLIC]   = "即時清單顯示人數: ",
    [Dcr.LOC.BLACK_LENGTH]    = "停留在排除名單的時間: ",
    [Dcr.LOC.SCAN_LENGTH]     = "即時檢測時間間隔(秒): ",
    [Dcr.LOC.ABOLISH_CHECK]   = "施法前檢查是否需要淨化",
    [Dcr.LOC.RANDOM_ORDER]    = "隨機淨化玩家",
    [Dcr.LOC.CURE_PETS]       = "檢測並淨化寵物",
    [Dcr.LOC.IGNORE_STEALTH]  = "忽略潛行的玩家",
    [Dcr.LOC.PLAY_SOUND]	    = "有玩家需要淨化時發出音效",
    [Dcr.LOC.ANCHOR]          = "Decursive 文字定位點",
    [Dcr.LOC.DONOT_BL_PRIO]   = "不添加優先名單的玩家到排除名單",


    [Dcr.LOC.SPELL_FOUND]      = "找到 %s 法術",


    -- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP] = "無夢睡眠",
    [Dcr.LOC.GDREAMLESSSLEEP] = "強效昏睡",
    [Dcr.LOC.ANCIENTHYSTERIA] = "上古狂亂",
    [Dcr.LOC.IGNITE]	= "點燃法力",
    [Dcr.LOC.TAINTEDMIND]	= "污濁之魂",
    [Dcr.LOC.MAGMASHAKLES]	= "熔岩鐐銬",
    [Dcr.LOC.CRIPLES]		= "殘廢術",
    [Dcr.LOC.DUSTCLOUD]	= "灰塵之雲",
    [Dcr.LOC.WIDOWSEMBRACE]	= "寡婦之擁",
    [Dcr.LOC.CURSEOFTONGUES]	= "語言詛咒", -- further translated by BS
    [Dcr.LOC.SONICBURST]	= "音爆",
    [Dcr.LOC.THUNDERCLAP]	= "雷霆一擊",
    [Dcr.LOC.DELUSIONOFJINDO] = "金度的欺騙",

    [Dcr.LOC.MUTATINGINJECTION] = "突變注射",


    -- NEW LOCALS FOR 2.0

    [Dcr.LOC.DEFAULT_MACROKEY] = "`", -- the key just beneath the escape key on a QWERTY keyboard

    [Dcr.LOC.OPT_LIVELIST] = "即時清單",
    [Dcr.LOC.OPT_LIVELIST_DESC] = "即時清單設定選項。",
    [Dcr.LOC.OPT_HIDELIVELIST_DESC] = "如果未被隱藏則顯示清單，列出中了負面效果的人。",
    [Dcr.LOC.OPT_SHOWTOOLTIP_DESC] = "在即時清單跟 MUFs 上顯示負面效果的小提示。",
    [Dcr.LOC.OPT_PLAYSOUND_DESC]  = "有玩家中了負面效果時發出音效。",
    [Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC] = "設定即時清單最多顯示幾人。",
    [Dcr.LOC.OPT_BLACKLENTGH_DESC] =  "設定一個人停留在排除名單中的時間。",
    [Dcr.LOC.OPT_SCANLENGTH_DESC] = "設定掃描時間間隔。",
    [Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = "由下到上填滿即時清單。",
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF] = Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF,
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC,
    [Dcr.LOC.OPT_TIE_LIVELIST_DESC] = "即時清單顯示與否取決於 \"Decursive\" 工作條是否顯示。",
    [Dcr.LOC.OPT_MESSAGES]	= "訊息設定",
    [Dcr.LOC.OPT_MESSAGES_DESC] = "設定訊息顯示。",
    [Dcr.LOC.OPT_CHATFRAME_DESC] = "顯示到預設的聊天視窗。",
    [Dcr.LOC.OPT_PRINT_CUSTOM_DESC] = "顯示到自訂的聊天視窗。",
    [Dcr.LOC.OPT_PRINT_ERRORS_DESC] = "顯示錯誤訊息。",
    [Dcr.LOC.OPT_ANCHOR_DESC]	= "顯示自訂視窗的文字定位點。",
    [Dcr.LOC.OPT_MFSETTINGS] = "Micro Unit Frame 設定選項",
    [Dcr.LOC.OPT_MFSETTINGS_DESC] = "設定 MUF 視窗以符合你的需求。",
    [Dcr.LOC.OPT_DISPLAYOPTIONS] = "顯示設定",
    [Dcr.LOC.OPT_SHOWMFS] = "在螢幕上顯示 micro units Frame (MUF)",
    [Dcr.LOC.OPT_SHOWMFS_DESC] = "如果你要在螢幕上按按鍵清除就必須點選這個設定。",
    [Dcr.LOC.OPT_GROWDIRECTION] = "反向顯示 MUFs",
    [Dcr.LOC.OPT_GROWDIRECTION_DESC] = "MUFs 會從尾巴開始顯示。",
    [Dcr.LOC.OPT_SHOWBORDER] = "顯示職業顏色邊框",
    [Dcr.LOC.OPT_SHOWBORDER_DESC] = "MUFs 邊框會顯示出該玩家的職業代表顏色。",
    [Dcr.LOC.OPT_MAXMFS]  = "最多顯示幾個",
    [Dcr.LOC.OPT_MAXMFS_DESC] = "設定在螢幕上最多顯示幾個 micro unit frames。",
    [Dcr.LOC.OPT_UNITPERLINES] = '每一行幾個 MUF',
    [Dcr.LOC.OPT_UNITPERLINES_DESC] = "設定每行最多顯示幾個 micro-unit- frames。",
    [Dcr.LOC.OPT_MFSCALE] = 'micro-unit-frames 大小',
    [Dcr.LOC.OPT_MFSCALE_DESC] = "設定螢幕上 micro-unit-frames 的大小。",
    [Dcr.LOC.OPT_SHOWHELP] = "顯示小提示",
    [Dcr.LOC.OPT_SHOWHELP_DESC] = "當滑鼠移到一個 micro-unit-frame 上時顯示小提示。",
    [Dcr.LOC.OPT_MFPERFOPT] = "效能設定選項",
    [Dcr.LOC.OPT_MFREFRESHRATE] = '刷新速率',
    [Dcr.LOC.OPT_MFREFRESHRATE_DESC] = "設定多久刷新一次(一次可刷新一個或數個 micro-unit-frames)。",
    [Dcr.LOC.OPT_MFREFRESHSPEED] = '刷新速度',
    [Dcr.LOC.OPT_MFREFRESHSPEED_DESC] = "設定每次刷新多少個 micro-unit-frames。",
    [Dcr.LOC.OPT_CURINGOPTIONS] = "淨化選項",
    [Dcr.LOC.OPT_CURINGOPTIONS_DESC] = "設定淨化選項。",
    [Dcr.LOC.OPT_ABOLISHCHECK_DESC] = "檢查玩家身上是否有淨化法術在運作。",
    [Dcr.LOC.OPT_DONOTBLPRIO_DESC] = "設定到優先清單的玩家不會被移入排除清單中。",
    [Dcr.LOC.OPT_RANDOMORDER_DESC] = "隨機顯示與淨化玩家(不推薦使用)。",
    [Dcr.LOC.OPT_CUREPETS_DESC] = "寵物會被顯示出來也可淨化。",
    [Dcr.LOC.OPT_IGNORESTEALTHED_DESC] = "忽略潛行的玩家。",
    [Dcr.LOC.OPT_CURINGORDEROPTIONS] = "淨化順序設定",
    [Dcr.LOC.OPT_MAGICCHECK_DESC]	= "選取後你可以看見並處理受魔法影響的玩家。",
    [Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC] = "選取後你可以看見並處理被魔法媚惑的玩家。",
    [Dcr.LOC.OPT_CHARMEDCHECK_DESC] = "選取後你可以看見並處理被媚惑的玩家。",
    [Dcr.LOC.OPT_POISONCHECK_DESC] = "選取後你可以看見並清除中毒的玩家。",
    [Dcr.LOC.OPT_DISEASECHECK_DESC] = "選取後你可以看見並治療生病的玩家。",
    [Dcr.LOC.OPT_CURSECHECK_DESC] = "選取後你可以看見並解除被詛咒的玩家。",
    [Dcr.LOC.OPT_DEBUFFFILTER] = "負面效果過濾設定",
    [Dcr.LOC.OPT_DEBUFFFILTER_DESC] = "設定戰鬥中要忽略的職業與負面效果",
    [Dcr.LOC.OPT_MACROOPTIONS] = "巨集設定選項",
    [Dcr.LOC.OPT_MACROOPTIONS_DESC] = "設定 Decursive 產生的巨集如何動作",
    [Dcr.LOC.OPT_MACROBIND] = "設定巨集按鍵",
    [Dcr.LOC.OPT_MACROBIND_DESC] = "定義呼叫 Decursive 巨集的按鍵。\n\n按你想設定的按鍵然後按 'Enter' 鍵儲存設定(滑鼠要移動到編輯區域)",
    [Dcr.LOC.OPT_RESETOPTIONS] = "重置為原始設定",
    [Dcr.LOC.OPT_RESETOPTIONS_DESC] =  "回復目前的設定檔為原始設定",
    [Dcr.LOC.OPT_REMOVESKDEBCONF] = "你確定要把\n '%s' \n 從負面效果忽略清單中移除？",
    [Dcr.LOC.OPT_RESTPROFILECONF] = "你確定要重置\n '(%s) %s'\n 為原始設定?",
    [Dcr.LOC.OPT_PROFILERESET] = "重置設定檔...",
    [Dcr.LOC.OPT_AFFLICTEDBYSKIPPED] = "%s 受到 %s 的影響，但將被忽略。",
    [Dcr.LOC.OPT_DEBCHECKEDBYDEF] = "\n\nChecked by default",
    [Dcr.LOC.OPT_ALWAYSIGNORE] = "即使不在戰鬥中也忽略之",
    [Dcr.LOC.OPT_ALWAYSIGNORE_DESC] = "如果選取該選項，即使脫離戰鬥也忽略該負面效果而不解除",
    [Dcr.LOC.OPT_REMOVETHISDEBUFF] = "移除此負面效果",
    [Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = "將 '%s' 從忽略清單移除。",
    [Dcr.LOC.OPT_RESETDEBUFF] = "重置此負面效果",
    [Dcr.LOC.OPT_RESETDTDCRDEFAULT] = "重置 '%s' 為 Decursive 預設值。",
    [Dcr.LOC.OPT_USERDEBUFF] = "這項負面效果不是 Decursive 預設的效果之一",
    [Dcr.LOC.OPT_DEBUFFENTRY_DESC] = "選擇戰鬥中要忽略受到此負面效果影響的職業。",
    [Dcr.LOC.OPT_ADDDEBUFF] = "添加一負面效果到清單中",
    [Dcr.LOC.OPT_ADDDEBUFF_DESC] = "將一個新的負面效果新增到清單中。",
    [Dcr.LOC.OPT_ADDDEBUFF_USAGE] = "<Debuff name>",
    [Dcr.LOC.OPT_READDDEFAULTSD] = "回復預設負面效果",
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC1] = "添加被移除的預設負面效果\n你的設定不會被改變。",
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC2] = "所有的預設負面效果都在此清單中。",

    [Dcr.LOC.OPT_LVONLYINRANGE] = "只顯示法術有效範圍內的目標",
    [Dcr.LOC.OPT_LVONLYINRANGE_DESC] = "即時清單只顯示淨化法術有效範圍內的目標。",

    [Dcr.LOC.OPT_MFALPHA] = "透明度",
    [Dcr.LOC.OPT_MFALPHA_DESC] = "設定無 debuff 時 MUFs 的透明度。",

    [Dcr.LOC.OPT_ADVDISP] = "進階顯示選項",
    [Dcr.LOC.OPT_ADVDISP_DESC] = "可設定邊框與中央色塊各自的透明度，以及 MUFs 之間的距離。",
    [Dcr.LOC.OPT_TIECENTERANDBORDER] = "固定 MUF 中央與邊框的透明度",
    [Dcr.LOC.OPT_TIECENTERANDBORDER_OPT] = "選取時邊界的透明度固定為中央的一半。",
    [Dcr.LOC.OPT_BORDERTRANSP] = "邊框透明度",
    [Dcr.LOC.OPT_BORDERTRANSP_DESC] = "設定邊框的透明度。",
    [Dcr.LOC.OPT_CENTERTRANSP] = "中央透明度",
    [Dcr.LOC.OPT_CENTERTRANSP_DESC] = "設定中間色塊的透明度",
    [Dcr.LOC.OPT_TIEXYSPACING] = "固定水平與垂直距離。",
    [Dcr.LOC.OPT_TIEXYSPACING_DESC] = "固定 MUFs 之間的水平與垂直距離(空白)。",
    [Dcr.LOC.OPT_XSPACING] = "水平距離",
    [Dcr.LOC.OPT_XSPACING_DESC] = "設定 MUFs 之間的水平距離。",
    [Dcr.LOC.OPT_YSPACING] = "垂直距離",
    [Dcr.LOC.OPT_YSPACING_DESC] = "設定 MUFs 之間的垂直距離。",



    [Dcr.LOC.HLP_LL_ONCLICK_TEXT] = Dcr.LOC.HLP_LL_ONCLICK_TEXT,
    [Dcr.LOC.HLP_LEFTCLICK] = "左-鍵",
    [Dcr.LOC.HLP_RIGHTCLICK] = "右-鍵",
    [Dcr.LOC.HLP_MIDDLECLICK] = "中-鍵",
  
    [Dcr.LOC.HLP_NOTHINGTOCURE] = "沒有可處理的負面效果！",
    [Dcr.LOC.HLP_WRONGMBUTTON] = "錯誤的滑鼠按鍵！",
    [Dcr.LOC.HLP_USEXBUTTONTOCURE] = "用 \"%s\" 來淨化這個負面效果！",

    [Dcr.LOC.CTRL] = "Ctrl",
    [Dcr.LOC.ALT] = "ALt",
    [Dcr.LOC.SHIFT] = "Shift",

    [Dcr.LOC.TARGETUNIT] = "選取目標",
    [Dcr.LOC.FOCUSUNIT] = "監控目標",

    [Dcr.LOC.ABSENT] = "不存在 (%s)",
    [Dcr.LOC.TOOFAR] = "太遠",
    [Dcr.LOC.NORMAL] = "一般",
    [Dcr.LOC.STEALTHED] = "已潛行",
    [Dcr.LOC.BLACKLISTED] = "在排除名單",
    [Dcr.LOC.UNITSTATUS] = "玩家狀態: ",
    [Dcr.LOC.AFFLICTEDBY] = "受 %s 影響",

    [Dcr.LOC.SUCCESSCAST] = "%s |cFF00AA00成功淨化|r %s",

    [Dcr.LOC.HANDLEHELP] = "拖曳移動所有的 Micro-UnitFrames (MUFs)",

    [Dcr.LOC.MACROKEYALREADYMAPPED] = "警告: Decursive 巨集對應按鍵 [%s] 先前對應到 '%s' 動作。\n當你設定別的巨集按鍵後 Decursive 會回復此按鍵原有的對應動作。",
    [Dcr.LOC.MACROKEYMAPPINGSUCCESS] = "按鍵 [%s] 已成功對應到 Decursive 巨集。",
    [Dcr.LOC.MACROKEYMAPPINGFAILED] = "按鍵 [%s] 不能被對應到 Decursive 巨集！",
    [Dcr.LOC.MACROKEYNOTMAPPED] = "Decursive 巨集未對應到一個按鍵，你可以透過設定選單來設定此一按鍵。(別錯過這個神奇的功能)",

} end);

