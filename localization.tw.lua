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
-- Chinese localization (Revised)  By Whocare (losomelian@yahoo.com.tw) 2007/04/19
-----------------------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date$", "$Revision$");

-- Acelocal register for zhTW // {{{
local L = Dcr.L;
L:RegisterTranslations("zhTW", function() return {

    [Dcr.LOC.DISEASE]                   = '疾病';
    [Dcr.LOC.MAGIC]                     = '魔法';
    [Dcr.LOC.POISON]                    = '中毒';
    [Dcr.LOC.CURSE]                     = '詛咒';
    [Dcr.LOC.MAGICCHARMED]              = '魔法魅惑';
    [Dcr.LOC.CHARMED]                   = '魅惑';


    [Dcr.LOC.CLASS_DRUID]       	= '德魯伊',
    [Dcr.LOC.CLASS_HUNTER]      	= '獵人',
    [Dcr.LOC.CLASS_MAGE]        	= '法師',
    [Dcr.LOC.CLASS_PALADIN]     	= '聖騎士',
    [Dcr.LOC.CLASS_PRIEST]      	= '牧師',
    [Dcr.LOC.CLASS_ROGUE]       	= '盜賊',
    [Dcr.LOC.CLASS_SHAMAN]       	= '薩滿',
    [Dcr.LOC.CLASS_WARLOCK]	        = '術士',
    [Dcr.LOC.CLASS_WARRIOR]	        = '戰士',

    [Dcr.LOC.STR_OTHER]	                = '其他',
    [Dcr.LOC.STR_OPTIONS]	        = '選項',
    [Dcr.LOC.STR_CLOSE]	                = '關閉',
    [Dcr.LOC.STR_DCR_PRIO]       	= 'Decursive 優先選單',
    [Dcr.LOC.STR_DCR_SKIP]	        = 'Decursive 忽略選單',
    [Dcr.LOC.STR_QUICK_POP]      	= '快速添加介面',
    [Dcr.LOC.STR_POP]	                = '快速添加清單',
    [Dcr.LOC.STR_GROUP]	                = '隊伍 ',

    [Dcr.LOC.PRIORITY_SHOW]	        = 'P',
    [Dcr.LOC.POPULATE]	                = 'P',
    [Dcr.LOC.SKIP_SHOW]	                = 'S',
    [Dcr.LOC.CLEAR_PRIO]	        = 'C',
    [Dcr.LOC.CLEAR_SKIP]	        = 'C',

    [Dcr.LOC.PET_FEL_CAST]	        = "吞噬魔法",
    [Dcr.LOC.PET_DOOM_CAST]	        = "驅散魔法",

    [Dcr.LOC.SPELL_POLYMORPH]	        = "變形術",
    [Dcr.LOC.SPELL_CURE_DISEASE]        = '祛病術',
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]	= '驅除疾病',
    [Dcr.LOC.SPELL_PURIFY]	        = '純淨術',
    [Dcr.LOC.SPELL_CLEANSE]	        = '清潔術',
    [Dcr.LOC.SPELL_DISPELL_MAGIC]	= '驅散魔法',
    [Dcr.LOC.SPELL_CURE_POISON]	        = '消毒術',
    [Dcr.LOC.SPELL_ABOLISH_POISON]	= '驅毒術',
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]	= '解除次級詛咒',
    [Dcr.LOC.SPELL_REMOVE_CURSE]	= '解除詛咒',
    [Dcr.LOC.SPELL_PURGE]	        = '淨化術',

    [BINDING_NAME_DCRSHOW]	        = "顯示或隱藏 Decursive 工作條",

    [BINDING_NAME_DCRMUFSHOWHIDE]       = "顯示或隱藏單位格式";

    [BINDING_NAME_DCRPRADD]	        = "添加目標至優先列表",
    [BINDING_NAME_DCRPRCLEAR]	        = "清空優先列表",
    [BINDING_NAME_DCRPRLIST]	        = "顯示優先列表至聊天視窗",
    [BINDING_NAME_DCRPRSHOW]	        = "關閉優先列表",

    [BINDING_NAME_DCRSKADD]	        = "添加目標至忽略列表",
    [BINDING_NAME_DCRSKCLEAR]	        = "清空忽略列表",
    [BINDING_NAME_DCRSKLIST]	        = "顯示忽略列表至聊天視窗",
    [BINDING_NAME_DCRSKSHOW]	        = "關閉忽略列表",
    [BINDING_NAME_DCRSHOWOPTION]        = "顯示選項統計窗口";

    [Dcr.LOC.PRIORITY_LIST]	        = "Decursive 優先列表",
    [Dcr.LOC.SKIP_LIST_STR]	        = "Decursive 忽略列表",
    [Dcr.LOC.OPTION_MENU]	        = "Decursive 選項",
    [Dcr.LOC.POPULATE_LIST]	        = "Decursive 列表快速添加介面",
    [Dcr.LOC.HIDE_MAIN]	                = "隱藏 Decursive 視窗",
    [Dcr.LOC.SHOW_MSG]	                = "要顯示 Decursive 視窗，請輸入 /dcrshow",
    [Dcr.LOC.IS_HERE_MSG]               = "Decursive 已經啟動，請核對設定選項",

    [Dcr.LOC.LIST_ENTRY_ACTIONS]        = "|cFF33AA33[CTRL]|r+點擊: 移除這個玩家\n|cFF33AA33左鍵|r+點擊: 提升這位玩家的排序\n|cFF33AA33右鍵|r+點擊: 降低這位玩家的排序\n|cFF33AA33[SHIFT]+左鍵|r+點擊: 將此玩家排序置頂\n|cFF33AA33[SHIFT]+右鍵|r+點擊: 將此玩家排序沈底";

    [Dcr.LOC.PRINT_CHATFRAME]	        = "在聊天視窗顯示訊息",
    [Dcr.LOC.PRINT_CUSTOM]	        = "在遊戲畫面中顯示訊息",
    [Dcr.LOC.PRINT_ERRORS]	        = "顯示錯誤訊息",

    [Dcr.LOC.SHOW_TOOLTIP]	        = "在即時清單顯示簡要說明",
    [Dcr.LOC.REVERSE_LIVELIST]	        = "反向顯示即時清單",
    [Dcr.LOC.TIE_LIVELIST]	        = "即時清單顯示與 DCR 視窗連結",
    [Dcr.LOC.HIDE_LIVELIST]	        = "隱藏即時清單",

    [Dcr.LOC.AMOUNT_AFFLIC]	        = "即時清單顯示人數: ",
    [Dcr.LOC.BLACK_LENGTH]	        = "失敗幾次後加入黑名單: ",
    [Dcr.LOC.SCAN_LENGTH]	        = "即時檢測時間間隔(秒): ",
    [Dcr.LOC.ABOLISH_CHECK]	        = "施法前檢查是否需要淨化",
    [Dcr.LOC.RANDOM_ORDER]	        = "隨機淨化玩家",
    [Dcr.LOC.CURE_PETS]	                = "檢測並淨化寵物",
    [Dcr.LOC.IGNORE_STEALTH]	        = "忽略潛行的玩家",
    [Dcr.LOC.PLAY_SOUND]	        = "有玩家需要淨化時發出音效",
    [Dcr.LOC.ANCHOR]	                = "Decursive 文字定位點",
    [Dcr.LOC.DONOT_BL_PRIO]     	= "不添加優先名單的玩家到黑名單",

    [Dcr.LOC.SPELL_FOUND]	       = "找到 %s 法術",

-- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP]           = "無夢睡眠",
    [Dcr.LOC.GDREAMLESSSLEEP]          = "強效昏睡",
    [Dcr.LOC.ANCIENTHYSTERIA]          = "上古狂亂",
    [Dcr.LOC.IGNITE]                   = "點燃法力",
    [Dcr.LOC.TAINTEDMIND]              = "污濁之魂",
    [Dcr.LOC.MAGMASHAKLES]             = "熔岩鐐銬",
    [Dcr.LOC.CRIPLES]                  = "殘廢術",
    [Dcr.LOC.DUSTCLOUD]                = "灰塵之雲",
    [Dcr.LOC.WIDOWSEMBRACE]            = "黑女巫的擁抱",
    [Dcr.LOC.CURSEOFTONGUES]           = "語言詛咒",
    [Dcr.LOC.SONICBURST]               = "音爆",
    [Dcr.LOC.THUNDERCLAP]              = "雷霆一擊",
    [Dcr.LOC.DELUSIONOFJINDO]          = "金度的欺騙",

    [Dcr.LOC.MUTATINGINJECTION]        = "突變注射";

-- [DCR_LOC_SILENCE]                  = "沈默";  -- Improper translation exists. "Silence" is likely misspelled for locale zhTW.
-- [DCR_LOC_MINDVISION]               = "心靈視界"; -- Improper translation exists. "Mind Vision" is likely misspelled for locale zhTW.

-- NEW LOCALS FOR 2.0

   [Dcr.LOC.DEFAULT_MACROKEY]          = "`";
   [Dcr.LOC.OPT_LIVELIST]              = "即時列表";
   [Dcr.LOC.OPT_LIVELIST_DESC]         = "即時列表選項";
   [Dcr.LOC.OPT_HIDELIVELIST_DESC]     = "若未隱藏，則顯示受詛咒玩家的資料列表";
   [Dcr.LOC.OPT_SHOWTOOLTIP_DESC]      = "在即時列表與微縮圖像顯示詳細詛咒提示";
   [Dcr.LOC.OPT_PLAYSOUND_DESC]        = "當有玩家受到詛咒時發出聲響";
   [Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC]    = "設定即時列表中受到詛咒玩家人數上限";
   [Dcr.LOC.OPT_BLACKLENTGH_DESC]      = "設定進入黑名單的停留時間";
   [Dcr.LOC.OPT_SCANLENGTH_DESC]       = "設定掃瞄時間間距";
   [Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = "反序顯示即時列表";
   [Dcr.LOC.OPT_TIE_LIVELIST_DESC]     = "即時列表與 \"Decursive\" 工作列黏附顯示";
   [Dcr.LOC.OPT_MESSAGES]              = "顯示訊息";
   [Dcr.LOC.OPT_MESSAGES_DESC]         = "顯示訊息選項";
   [Dcr.LOC.OPT_CHATFRAME_DESC]        = "在預設頻道顯示Decursive的訊息";
   [Dcr.LOC.OPT_PRINT_CUSTOM_DESC]     = "在自訂頻道顯示Decursive的訊息";
   [Dcr.LOC.OPT_PRINT_ERRORS_DESC]     = "顯示錯誤訊息";
   [Dcr.LOC.OPT_ANCHOR_DESC]           = "顯示自訂訊息錨點";
   [Dcr.LOC.OPT_MFSETTINGS]            = "微縮圖像";
   [Dcr.LOC.OPT_MFSETTINGS_DESC]       = "自訂微縮圖像格式";
   [Dcr.LOC.OPT_DISPLAYOPTIONS]        = "顯示選項";
   [Dcr.LOC.OPT_SHOWMFS]               = "顯示微縮圖像";
   [Dcr.LOC.OPT_SHOWMFS_DESC]          = "若欲點擊解魔則必須啟動此一選項";
   [Dcr.LOC.OPT_GROWDIRECTION]         = "反向顯示微縮圖像";
   [Dcr.LOC.OPT_GROWDIRECTION_DESC]    = "微縮圖像將反向排序";
   [Dcr.LOC.OPT_SHOWBORDER]            = "顯示職業色彩邊框";
   [Dcr.LOC.OPT_SHOWBORDER_DESC]       = "微縮圖像將依照職業顯示不同顏色邊框";
   [Dcr.LOC.OPT_MAXMFS]                = "微縮圖像數目上限";
   [Dcr.LOC.OPT_MAXMFS_DESC]           = "設定微縮圖像的最大顯示數目";
   [Dcr.LOC.OPT_UNITPERLINES]          = '每行顯示頭像數目';
   [Dcr.LOC.OPT_UNITPERLINES_DESC]     = "設定每行顯示的微縮圖像數目";
   [Dcr.LOC.OPT_MFSCALE]               = '微縮圖像尺寸';
   [Dcr.LOC.OPT_MFSCALE_DESC]          = "設定微縮圖像的尺寸大小";
   [Dcr.LOC.OPT_SHOWHELP]              = "顯示說明";
   [Dcr.LOC.OPT_SHOWHELP_DESC]         = "當滑鼠掠過微縮圖像時顯示詳細提示";
   [Dcr.LOC.OPT_MFPERFOPT]             = "效能選項";
   [Dcr.LOC.OPT_MFREFRESHRATE]         = '重新整理速率';
   [Dcr.LOC.OPT_MFREFRESHRATE_DESC]    = "每次重整所需時間 (每次可以重整一個或數個微縮圖像)";
   [Dcr.LOC.OPT_MFREFRESHSPEED]        = '重整速度';
   [Dcr.LOC.OPT_MFREFRESHSPEED_DESC]   = "單次刷新的微縮圖像數目";
   [Dcr.LOC.OPT_CURINGOPTIONS]         = "治療選項";
   [Dcr.LOC.OPT_CURINGOPTIONS_DESC]    = "設定各種治療程序的面相";
   [Dcr.LOC.OPT_ABOLISHCHECK_DESC]     = "選擇可驅除魔法是否顯示或治癒";
   [Dcr.LOC.OPT_DONOTBLPRIO_DESC]      = "優先列表內之玩家將不會列入黑名單";
   [Dcr.LOC.OPT_RANDOMORDER_DESC]      = "隨機顯示被治癒的玩家(不建議)";
   [Dcr.LOC.OPT_CUREPETS_DESC]         = "處理與治療寵物";
   [Dcr.LOC.OPT_IGNORESTEALTHED_DESC]  = "隱遁玩家將被忽略";
   [Dcr.LOC.OPT_CURINGORDEROPTIONS]    = "治療順序選項";
   [Dcr.LOC.OPT_MAGICCHECK_DESC]       = "發現並解除魔法";
   [Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC]= "發現並治療魅惑";
   [Dcr.LOC.OPT_CHARMEDCHECK_DESC]     = "發現並處理魅惑";
   [Dcr.LOC.OPT_POISONCHECK_DESC]      = "發現並解除中毒";
   [Dcr.LOC.OPT_DISEASECHECK_DESC]     = "發現並治療疾病";
   [Dcr.LOC.OPT_CURSECHECK_DESC]       = "發現並解除詛咒";
   [Dcr.LOC.OPT_DEBUFFFILTER]          = "負面魔法";
   [Dcr.LOC.OPT_DEBUFFFILTER_DESC]     = "戰鬥中依照職業與名字篩選負面魔法";
   [Dcr.LOC.OPT_MACROOPTIONS]          = "巨集選項";
   [Dcr.LOC.OPT_MACROOPTIONS_DESC]     = "設定Decursive功能巨集";
   [Dcr.LOC.OPT_MACROBIND]             = "設定巨集快捷鍵";
   [Dcr.LOC.OPT_MACROBIND_DESC]        = "設定'Decursive'巨集快捷鍵\n\n鍵入指定快捷鍵後，按下'Enter'確認";
   [Dcr.LOC.OPT_RESETOPTIONS]          = "回歸預設";
   [Dcr.LOC.OPT_RESETOPTIONS_DESC]     = "重新載入預設值";
   [Dcr.LOC.OPT_REMOVESKDEBCONF]       = "你確定要將\n '%s' \n移出忽略列表?";
   [Dcr.LOC.OPT_RESTPROFILECONF]       = "你確定要重新載入預設值?";
   [Dcr.LOC.OPT_PROFILERESET]          = "資料重置中...";
   [Dcr.LOC.OPT_AFFLICTEDBYSKIPPED]    = "%s 受到 %s 將被忽略";
   [Dcr.LOC.OPT_DEBCHECKEDBYDEF]       = "\n\n預設檢查";
   [Dcr.LOC.OPT_ALWAYSIGNORE]          = "非戰鬥中忽略負面魔法";
   [Dcr.LOC.OPT_ALWAYSIGNORE_DESC]     = "若不再戰鬥中將忽略負面魔法";
   [Dcr.LOC.OPT_REMOVETHISDEBUFF]      = "解除負面魔法";
   [Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = "將 '%s' 移出忽略列表";
   [Dcr.LOC.OPT_RESETDEBUFF]           = "重置負面魔法";
   [Dcr.LOC.OPT_RESETDTDCRDEFAULT]     = "將 '%s' 重置為Decursive預設值";
   [Dcr.LOC.OPT_USERDEBUFF]            = "此一負面魔法並非Decursive預設項目";
   [Dcr.LOC.OPT_DEBUFFENTRY_DESC]      = "選擇戰鬥中可以忽略負面魔法的職業";
   [Dcr.LOC.OPT_ADDDEBUFF]             = "將此項負面魔法加入列表";
   [Dcr.LOC.OPT_ADDDEBUFF_DESC]        = "將此項負面魔法新增加入到列表中";
   [Dcr.LOC.OPT_ADDDEBUFF_USAGE]       = "<負面魔法名稱>";
   [Dcr.LOC.OPT_READDDEFAULTSD]        = "重新加入預設負面魔法";
   [Dcr.LOC.OPT_READDDEFAULTSD_DESC1]  = "將遺漏的Decursive預設負面魔法列表\n 自訂設置將不會改變";
   [Dcr.LOC.OPT_READDDEFAULTSD_DESC2]  = "所有Decursive預設負面魔法均已在表列中";

   [Dcr.LOC.OPT_LVONLYINRANGE]         = "僅限施法範圍內的玩家";
   [Dcr.LOC.OPT_LVONLYINRANGE_DESC]    = "只有在施法範圍內的玩家才會顯示在即時列表";

   [Dcr.LOC.OPT_MFALPHA]               = "透明度";
   [Dcr.LOC.OPT_MFALPHA_DESC]          = "設定未受魔法侵犯玩家的微縮圖像透明度";

   [Dcr.LOC.OPT_ADVDISP]               = "進階顯示選項";
   [Dcr.LOC.OPT_ADVDISP_DESC]          = "容許分別設定邊框與中心的透明度 另可設定微縮圖像的間距";
   [Dcr.LOC.OPT_TIECENTERANDBORDER]    = "等化邊框與中心的透明度";
   [Dcr.LOC.OPT_TIECENTERANDBORDER_OPT]= "當點擊時邊框透明度減半";
   [Dcr.LOC.OPT_BORDERTRANSP]          = "邊框透明度";
   [Dcr.LOC.OPT_BORDERTRANSP_DESC]     = "設定邊框的透明度";
   [Dcr.LOC.OPT_CENTERTRANSP]          = "中心透明度";
   [Dcr.LOC.OPT_CENTERTRANSP_DESC]     = "設定中心區域的透明度";
   [Dcr.LOC.OPT_TIEXYSPACING]          = "等化垂直與平行間距";
   [Dcr.LOC.OPT_TIEXYSPACING_DESC]     = "將微縮圖像的垂直與平行間距設為相同";
   [Dcr.LOC.OPT_XSPACING]              = "水平間距";
   [Dcr.LOC.OPT_XSPACING_DESC]         = "設定微縮圖像的水平間距";
   [Dcr.LOC.OPT_YSPACING]              = "垂直間距";
   [Dcr.LOC.OPT_YSPACING_DESC]         = "設定微縮圖像的垂直間距";


   [Dcr.LOC.HLP_LEFTCLICK]             = "左鍵點擊";
   [Dcr.LOC.HLP_RIGHTCLICK]            = "右鍵點擊";
   [Dcr.LOC.HLP_MIDDLECLICK]           = "中鍵點擊";

   [Dcr.LOC.HLP_NOTHINGTOCURE] = Dcr.LOC.HLP_NOTHINGTOCURE,
   [Dcr.LOC.HLP_WRONGMBUTTON] = Dcr.LOC.HLP_WRONGMBUTTON,
   [Dcr.LOC.HLP_USEXBUTTONTOCURE] = Dcr.LOC.HLP_USEXBUTTONTOCURE,
  
   [Dcr.LOC.CTRL]                      = "Ctrl";
   [Dcr.LOC.ALT]                       = "ALt";
   [Dcr.LOC.SHIFT]                     = "Shift";

   [Dcr.LOC.TARGETUNIT]                = "目標單位";
   [Dcr.LOC.FOCUSUNIT]                 = "鎖定單位";

   [Dcr.LOC.ABSENT]                    = "缺席 (%s)";
   [Dcr.LOC.TOOFAR]                    = "太遠";
   [Dcr.LOC.NORMAL]                    = "正常";
   [Dcr.LOC.STEALTHED]                 = "隱遁";
   [Dcr.LOC.BLACKLISTED]               = "黑名單中";
   [Dcr.LOC.UNITSTATUS]                = "單位狀態: ";
   [Dcr.LOC.AFFLICTEDBY]               = "%s 受到影響";

   [Dcr.LOC.SUCCESSCAST]               = "%s |cFF00AA00成功施放在|r %s";

   [Dcr.LOC.HANDLEHELP]                = "拖曳所有的微縮圖像(MUFs)";

   [Dcr.LOC.MACROKEYALREADYMAPPED]     = "警告: Decursive巨集鍵 [%s] 對映到 '%s' 動作.\n若您設定為另外按鍵Decursive將會恢復原有鍵盤對映";
   [Dcr.LOC.MACROKEYMAPPINGSUCCESS]    = "按鍵 [%s] 已經對映至Decursive巨集！";
   [Dcr.LOC.MACROKEYMAPPINGFAILED]     = "按鍵 [%s] 無法對映至Decursive巨集！";
   [Dcr.LOC.MACROKEYNOTMAPPED]         = "Decursive巨集並未對映按鍵，您可以經由選項功能表來設定 (請勿遺漏此項優異功能)";

} end);

-- // }}}
