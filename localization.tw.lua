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
local LOC = Dcr.LOC;
L:RegisterTranslations("zhTW", function() return {


    [LOC.DISEASE] = '疾病',
    [LOC.MAGIC]   = '魔法',
    [LOC.POISON]  = '中毒',
    [LOC.CURSE]   = '詛咒',
    [LOC.MAGICCHARMED] = '魔法誘惑',
    [LOC.CHARMED] = '誘惑',


    [LOC.CLASS_DRUID]   = '德魯伊',
    [LOC.CLASS_HUNTER]  = '獵人',
    [LOC.CLASS_MAGE]    = '法師',
    [LOC.CLASS_PALADIN] = '聖騎士',
    [LOC.CLASS_PRIEST]  = '牧師',
    [LOC.CLASS_ROGUE]   = '盜賊',
    [LOC.CLASS_SHAMAN]  = '薩滿',
    [LOC.CLASS_WARLOCK] = '術士',
    [LOC.CLASS_WARRIOR] = '戰士',

    [LOC.STR_OTHER]	    = '其他',
    [LOC.STR_OPTIONS]	    = "Decursive 設定選項",
    [LOC.STR_CLOSE]	    = '關閉',
    [LOC.STR_DCR_PRIO]    = 'Decursive 優先選單',
    [LOC.STR_DCR_SKIP]    = 'Decursive 忽略選單',
    [LOC.STR_QUICK_POP]   = '快速添加介面',
    [LOC.STR_POP]	    = '快速添加清單',
    [LOC.STR_GROUP]	    = '隊伍 ',




    [LOC.PRIORITY_SHOW]   = 'P',
    [LOC.POPULATE]	    = 'p',
    [LOC.SKIP_SHOW]	    = 'S',
    [LOC.CLEAR_PRIO]	    = 'C',
    [LOC.CLEAR_SKIP]	    = 'C',





    [LOC.PET_FEL_CAST]  = "吞噬魔法",
    [LOC.PET_DOOM_CAST] = "驅散魔法",


    [LOC.SPELL_POLYMORPH]	    = '變形術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_DISEASE]        = '祛病術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_DISEASE]     = '驅除疾病', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURIFY]              = '純淨術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CLEANSE]             = '淨化術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_DISPELL_MAGIC]       = '驅散魔法', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_POISON]         = '消毒術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_POISON]      = '驅毒術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_LESSER_CURSE] = '解除次級詛咒', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_CURSE]        = '解除詛咒', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURGE]               = '淨化術', -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CYCLONE]             = '龍捲風',  -- This translation is for reference only the one used is from the library BabbleSpell

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


    [LOC.PRIORITY_LIST]  = "Decursive 優先名單",
    [LOC.SKIP_LIST_STR]  = "Decursive 忽略名單",
    [LOC.OPTION_MENU]   = "Decursive 選項",
    [LOC.POPULATE_LIST]  = "Decursive 名單快速添加介面",
    [LOC.LIST_ENTRY_ACTIONS]     = "|cFF33AA33[CTRL]|r-左鍵: 移除該玩家\n |cFF33AA33左|r-鍵: 提升該玩家順序\n |cFF33AA33右|r-鍵: 降低該玩家順序\n |cFF33AA33[SHIFT] 左|r-鍵: 將該玩家置頂\n |cFF33AA33[SHIFT] 右|r-鍵: 將該玩家置底",
    [LOC.HIDE_MAIN]      = "隱藏 Decursive 視窗",
    [LOC.SHOW_MSG]	   = "要顯示 Decursive 視窗，請輸入 /dcrshow。",
    [LOC.IS_HERE_MSG]	   = "Decursive 已經啟動，請核對設定選項。",

    [LOC.PRINT_CHATFRAME] = "在聊天視窗顯示訊息",
    [LOC.PRINT_CUSTOM]    = "在遊戲畫面中顯示訊息",
    [LOC.PRINT_ERRORS]    = "顯示錯誤訊息",

    [LOC.SHOW_TOOLTIP]    = "在即時清單顯示簡要說明",
    [LOC.REVERSE_LIVELIST]= "反向顯示即時清單",
    [LOC.TIE_LIVELIST]    = "即時清單顯示與 DCR 視窗連結",
    [LOC.HIDE_LIVELIST]   = "隱藏即時清單",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF]		= "建立虛擬效果測試",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC]	= "讓你看到產生這個效果的情況",

    [LOC.AMOUNT_AFFLIC]   = "即時清單顯示人數: ",
    [LOC.BLACK_LENGTH]    = "停留在排除名單的時間: ",
    [LOC.SCAN_LENGTH]     = "即時檢測時間間隔(秒): ",
    [LOC.ABOLISH_CHECK]   = "施法前檢查是否需要淨化",
    [LOC.RANDOM_ORDER]    = "隨機淨化玩家",
    [LOC.CURE_PETS]       = "檢測並淨化寵物",
    [LOC.IGNORE_STEALTH]  = "忽略潛行的玩家",
    [LOC.PLAY_SOUND]	    = "有玩家需要淨化時發出音效",
    [LOC.ANCHOR]          = "Decursive 文字定位點",
    [LOC.DONOT_BL_PRIO]   = "不添加優先名單的玩家到排除名單",

    [LOC.SPELL_FOUND]      = "找到 %s 法術",



    -- spells and potions
    [LOC.DREAMLESSSLEEP] = "無夢睡眠",
    [LOC.GDREAMLESSSLEEP] = "強效昏睡",
    [LOC.MDREAMLESSSLEEP]	= LOC.MDREAMLESSSLEEP,
    [LOC.ANCIENTHYSTERIA] = "上古狂亂",
    [LOC.IGNITE]	= "點燃法力",
    [LOC.TAINTEDMIND]	= "污濁之魂",
    [LOC.MAGMASHAKLES]	= "熔岩鐐銬",
    [LOC.CRIPLES]		= "殘廢術",
    [LOC.DUSTCLOUD]	= "灰塵之雲",
    [LOC.WIDOWSEMBRACE]	= "寡婦之擁",
    [LOC.CURSEOFTONGUES]	= "語言詛咒",  -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SONICBURST]	= "音爆",
    [LOC.THUNDERCLAP]	= "雷霆一擊",
    [LOC.DELUSIONOFJINDO] = "金度的欺騙",

    [LOC.MUTATINGINJECTION] = "突變注射",

--    [DCR_LOC_SILENCE]		= "沉默",   -- This translation is for reference only the one used is from the library BabbleSpell
--    [DCR_LOC_MINDVISION]	= "心靈幻象",   -- This translation is for reference only the one used is from the library BabbleSpell

    -- NEW LOCALS FOR 2.0


    [LOC.OPT_LIVELIST] = "即時清單",
    [LOC.OPT_LIVELIST_DESC] = "即時清單設定選項。",
    [LOC.OPT_HIDELIVELIST_DESC] = "如果未被隱藏則顯示清單，列出中了負面效果的人。",
    [LOC.OPT_SHOWTOOLTIP_DESC] = "在即時清單跟 MUFs 上顯示負面效果的小提示。",
    [LOC.OPT_PLAYSOUND_DESC]  = "有玩家中了負面效果時發出音效。",
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = "設定即時清單最多顯示幾人。",
    [LOC.OPT_BLACKLENTGH_DESC] =  "設定一個人停留在排除名單中的時間。",
    [LOC.OPT_SCANLENGTH_DESC] = "設定掃描時間間隔。",
    [LOC.OPT_REVERSE_LIVELIST_DESC] = "由下到上填滿即時清單。",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = LOC.OPT_CREATE_VIRTUAL_DEBUFF,
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC,
    [LOC.OPT_TIE_LIVELIST_DESC] = "即時清單顯示與否取決於 \"Decursive\" 工作條是否顯示。",
    [LOC.OPT_MESSAGES]	= "訊息設定",
    [LOC.OPT_MESSAGES_DESC] = "設定訊息顯示。",
    [LOC.OPT_CHATFRAME_DESC] = "顯示到預設的聊天視窗。",
    [LOC.OPT_PRINT_CUSTOM_DESC] = "顯示到自訂的聊天視窗。",
    [LOC.OPT_PRINT_ERRORS_DESC] = "顯示錯誤訊息。",
    [LOC.OPT_ANCHOR_DESC]	= "顯示自訂視窗的文字定位點。",
    [LOC.OPT_MFSETTINGS] = "Micro Unit Frame 設定選項",
    [LOC.OPT_MFSETTINGS_DESC] = "設定 MUF 視窗以符合你的需求。",
    [LOC.OPT_DISPLAYOPTIONS] = "顯示設定",
    [LOC.OPT_SHOWMFS] = "在螢幕上顯示 micro units Frame (MUF)",
    [LOC.OPT_SHOWMFS_DESC] = "如果你要在螢幕上按按鍵清除就必須點選這個設定。",
    [LOC.OPT_GROWDIRECTION] = "反向顯示 MUFs",
    [LOC.OPT_GROWDIRECTION_DESC] = "MUFs 會從尾巴開始顯示。",
    [LOC.OPT_SHOWBORDER] = "顯示職業顏色邊框",
    [LOC.OPT_SHOWBORDER_DESC] = "MUFs 邊框會顯示出該玩家的職業代表顏色。",
    [LOC.OPT_MAXMFS]  = "最多顯示幾個",
    [LOC.OPT_MAXMFS_DESC] = "設定在螢幕上最多顯示幾個 micro unit frames。",
    [LOC.OPT_UNITPERLINES] = '每一行幾個 MUF',
    [LOC.OPT_UNITPERLINES_DESC] = "設定每行最多顯示幾個 micro-unit- frames。",
    [LOC.OPT_MFSCALE] = 'micro-unit-frames 大小',
    [LOC.OPT_MFSCALE_DESC] = "設定螢幕上 micro-unit-frames 的大小。",
    [LOC.OPT_SHOWHELP] = "顯示小提示",
    [LOC.OPT_SHOWHELP_DESC] = "當滑鼠移到一個 micro-unit-frame 上時顯示小提示。",
    [LOC.OPT_MFPERFOPT] = "效能設定選項",
    [LOC.OPT_MFREFRESHRATE] = '刷新速率',
    [LOC.OPT_MFREFRESHRATE_DESC] = "設定多久刷新一次(一次可刷新一個或數個 micro-unit-frames)。",
    [LOC.OPT_MFREFRESHSPEED] = '刷新速度',
    [LOC.OPT_MFREFRESHSPEED_DESC] = "設定每次刷新多少個 micro-unit-frames。",
    [LOC.OPT_CURINGOPTIONS] = "淨化選項",
    [LOC.OPT_CURINGOPTIONS_DESC] = "設定淨化選項。",
    [LOC.OPT_ABOLISHCHECK_DESC] = "檢查玩家身上是否有淨化法術在運作。",
    [LOC.OPT_DONOTBLPRIO_DESC] = "設定到優先清單的玩家不會被移入排除清單中。",
    [LOC.OPT_RANDOMORDER_DESC] = "隨機顯示與淨化玩家(不推薦使用)。",
    [LOC.OPT_CUREPETS_DESC] = "寵物會被顯示出來也可淨化。",
    [LOC.OPT_IGNORESTEALTHED_DESC] = "忽略潛行的玩家。",
    [LOC.OPT_CURINGORDEROPTIONS] = "淨化順序設定",
    [LOC.OPT_MAGICCHECK_DESC]	= "選取後你可以看見並處理受魔法影響的玩家。",
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = "選取後你可以看見並處理被魔法媚惑的玩家。",
    [LOC.OPT_CHARMEDCHECK_DESC] = "選取後你可以看見並處理被媚惑的玩家。",
    [LOC.OPT_POISONCHECK_DESC] = "選取後你可以看見並清除中毒的玩家。",
    [LOC.OPT_DISEASECHECK_DESC] = "選取後你可以看見並治療生病的玩家。",
    [LOC.OPT_CURSECHECK_DESC] = "選取後你可以看見並解除被詛咒的玩家。",
    [LOC.OPT_DEBUFFFILTER] = "負面效果過濾設定",
    [LOC.OPT_DEBUFFFILTER_DESC] = "設定戰鬥中要忽略的職業與負面效果",
    [LOC.OPT_MACROOPTIONS] = "巨集設定選項",
    [LOC.OPT_MACROOPTIONS_DESC] = "設定 Decursive 產生的巨集如何動作",
    [LOC.OPT_MACROBIND] = "設定巨集按鍵",
    [LOC.OPT_MACROBIND_DESC] = "定義呼叫 Decursive 巨集的按鍵。\n\n按你想設定的按鍵然後按 'Enter' 鍵儲存設定(滑鼠要移動到編輯區域)",
    [LOC.OPT_RESETOPTIONS] = "重置為原始設定",
    [LOC.OPT_RESETOPTIONS_DESC] =  "回復目前的設定檔為原始設定",
    [LOC.OPT_REMOVESKDEBCONF] = "你確定要把\n '%s' \n 從負面效果忽略清單中移除？",
    [LOC.OPT_RESTPROFILECONF] = "你確定要重置\n '(%s) %s'\n 為原始設定?",
    [LOC.OPT_PROFILERESET] = "重置設定檔...",
    [LOC.OPT_AFFLICTEDBYSKIPPED] = "%s 受到 %s 的影響，但將被忽略。",
    [LOC.OPT_DEBCHECKEDBYDEF] = "\n\nChecked by default",
    [LOC.OPT_ALWAYSIGNORE] = "即使不在戰鬥中也忽略之",
    [LOC.OPT_ALWAYSIGNORE_DESC] = "如果選取該選項，即使脫離戰鬥也忽略該負面效果而不解除",
    [LOC.OPT_REMOVETHISDEBUFF] = "移除此負面效果",
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = "將 '%s' 從忽略清單移除。",
    [LOC.OPT_RESETDEBUFF] = "重置此負面效果",
    [LOC.OPT_RESETDTDCRDEFAULT] = "重置 '%s' 為 Decursive 預設值。",
    [LOC.OPT_USERDEBUFF] = "這項負面效果不是 Decursive 預設的效果之一",
    [LOC.OPT_DEBUFFENTRY_DESC] = "選擇戰鬥中要忽略受到此負面效果影響的職業。",
    [LOC.OPT_ADDDEBUFF] = "添加一負面效果到清單中",
    [LOC.OPT_ADDDEBUFF_DESC] = "將一個新的負面效果新增到清單中。",
    [LOC.OPT_ADDDEBUFF_USAGE] = "<Debuff name>",
    [LOC.OPT_READDDEFAULTSD] = "回復預設負面效果",
    [LOC.OPT_READDDEFAULTSD_DESC1] = "添加被移除的預設負面效果\n你的設定不會被改變。",
    [LOC.OPT_READDDEFAULTSD_DESC2] = "所有的預設負面效果都在此清單中。",

    [LOC.OPT_LVONLYINRANGE] = "只顯示法術有效範圍內的目標",
    [LOC.OPT_LVONLYINRANGE_DESC] = "即時清單只顯示淨化法術有效範圍內的目標。",

    [LOC.OPT_MFALPHA] = "透明度",
    [LOC.OPT_MFALPHA_DESC] = "設定無 debuff 時 MUFs 的透明度。",

    [LOC.OPT_LLALPHA]		= "實況清單的透明度",
    [LOC.OPT_LLALPHA_DESC]	= "變更 Decursive 工作條及實況清單的透明度(工作條必須設定為顯示)",

    [LOC.OPT_ADVDISP] = "進階顯示選項",
    [LOC.OPT_ADVDISP_DESC] = "可設定邊框與中央色塊各自的透明度，以及 MUFs 之間的距離。",
    [LOC.OPT_TIECENTERANDBORDER] = "固定 MUF 中央與邊框的透明度",
    [LOC.OPT_TIECENTERANDBORDER_OPT] = "選取時邊界的透明度固定為中央的一半。",
    [LOC.OPT_BORDERTRANSP] = "邊框透明度",
    [LOC.OPT_BORDERTRANSP_DESC] = "設定邊框的透明度。",
    [LOC.OPT_CENTERTRANSP] = "中央透明度",
    [LOC.OPT_CENTERTRANSP_DESC] = "設定中間色塊的透明度",
    [LOC.OPT_TIEXYSPACING] = "固定水平與垂直距離。",
    [LOC.OPT_TIEXYSPACING_DESC] = "固定 MUFs 之間的水平與垂直距離(空白)。",
    [LOC.OPT_XSPACING] = "水平距離",
    [LOC.OPT_XSPACING_DESC] = "設定 MUFs 之間的水平距離。",
    [LOC.OPT_YSPACING] = "垂直距離",
    [LOC.OPT_YSPACING_DESC] = "設定 MUFs 之間的垂直距離。",



    [LOC.HLP_LL_ONCLICK_TEXT] = LOC.HLP_LL_ONCLICK_TEXT,
    [LOC.HLP_LEFTCLICK] = "左-鍵",
    [LOC.HLP_RIGHTCLICK] = "右-鍵",
    [LOC.HLP_MIDDLECLICK] = "中-鍵",
  
    [LOC.HLP_NOTHINGTOCURE] = "沒有可處理的負面效果！",
    [LOC.HLP_WRONGMBUTTON] = "錯誤的滑鼠按鍵！",
    [LOC.HLP_USEXBUTTONTOCURE] = "用 \"%s\" 來淨化這個負面效果！",

    [LOC.CTRL] = "Ctrl",
    [LOC.ALT] = "ALt",
    [LOC.SHIFT] = "Shift",

    [LOC.TARGETUNIT] = "選取目標",
    [LOC.FOCUSUNIT] = "監控目標",

    [LOC.ABSENT] = "不存在 (%s)",
    [LOC.TOOFAR] = "太遠",
    [LOC.NORMAL] = "一般",
    [LOC.STEALTHED] = "已潛行",
    [LOC.BLACKLISTED] = "在排除名單",
    [LOC.UNITSTATUS] = "玩家狀態: ",
    [LOC.AFFLICTEDBY] = "受 %s 影響",

    [LOC.SUCCESSCAST] = "|cFF22FFFF%s %s|r |cFF00AA00成功淨化|r %s",

    [LOC.HANDLEHELP] = "拖曳移動所有的 Micro-UnitFrames (MUFs)",

    [LOC.MACROKEYALREADYMAPPED] = "警告: Decursive 巨集對應按鍵 [%s] 先前對應到 '%s' 動作。\n當你設定別的巨集按鍵後 Decursive 會回復此按鍵原有的對應動作。",
    [LOC.MACROKEYMAPPINGSUCCESS] = "按鍵 [%s] 已成功對應到 Decursive 巨集。",
    [LOC.MACROKEYMAPPINGFAILED] = "按鍵 [%s] 不能被對應到 Decursive 巨集！",
    [LOC.MACROKEYNOTMAPPED] = "Decursive 巨集未對應到一個按鍵，你可以透過設定選單來設定此一按鍵。(別錯過這個神奇的功能)",

    [LOC.DEFAULT_MACROKEY] = "`", -- the key just beneath the escape key on a QWERTY keyboard
    [LOC.OPT_NOKEYWARN] = LOC.OPT_NOKEYWARN,
    [LOC.OPT_NOKEYWARN_DESC] = LOC.OPT_NOKEYWARN_DESC,
    [LOC.NOSPELL] = LOC.NOSPELL,
    
    [LOC.FUBARMENU]  = LOC.FUBARMENU,
    [LOC.FUBARMENU_DESC]  = LOC.FUBARMENU_DESC,

    [LOC.GLOR1] = "紀念 Glorfindal",
    [LOC.GLOR2] = "獻給匆匆離我們而去的Bertrand；他將永遠被我們所銘記。",
    [LOC.GLOR3] = "紀念 Bertrand （１９６９－２００７）",
    [LOC.GLOR4] =  "對於那些在魔獸世界裡遇見過Glorfindal的人來說，他是一個重承諾的男人，也是一個有超凡魅力的領袖。友誼和慈愛將永植於他們的心中。他在遊戲中就如同在他生活中一樣的無私，彬彬有禮，樂於奉獻，最重要的是他對生活充滿熱情。他離開我們的時候才僅僅３８歲，隨他離去的絕不會是虛擬世界匿名的角色；在這裡還有一群忠實的朋友在永遠想念他。",
    [LOC.GLOR5] = "他將永遠被我們所銘記。",

} end);

