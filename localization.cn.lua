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
	
   该文件由CWDG剜刀根据files.wowace.com提供的zhTW转化而来	
--]]
-------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date$", "$Revision$");


-- Acelocal register for zhCN // {{{
local L = Dcr.L;
local LOC = Dcr.LOC;
L:RegisterTranslations("zhCN", function() return {

    [LOC.DISEASE]	=	"疾病",
    [LOC.MAGIC]	=	"魔法",
    [LOC.POISON]	=	"中毒",
    [LOC.CURSE]	=	"诅咒",
    [LOC.MAGICCHARMED] =	"魔法魅惑",
    [LOC.CHARMED]	=	"魅惑",

    [LOC.CLASS_DRUID]	=	"德鲁伊",
    [LOC.CLASS_HUNTER]	=	"猎人",
    [LOC.CLASS_MAGE]	=	"法师",
    [LOC.CLASS_PALADIN]	=	"圣骑士",
    [LOC.CLASS_PRIEST]	=	"牧师",
    [LOC.CLASS_ROGUE]	=	"盗贼",
    [LOC.CLASS_SHAMAN]	=	"萨满祭司",
    [LOC.CLASS_WARLOCK]	=	"术士",
    [LOC.CLASS_WARRIOR]	=	"战士",

    [LOC.STR_OTHER]	    = '其他',
    [LOC.STR_OPTIONS]	    = "设置选项",
    [LOC.STR_CLOSE]	    = '关闭',
    [LOC.STR_DCR_PRIO]    = '优先列表',
    [LOC.STR_DCR_SKIP]    = '忽略列表',
    [LOC.STR_QUICK_POP]   = '快速添加界面',
    [LOC.STR_POP]	    = '快速添加列表',
    [LOC.STR_GROUP]	    = '队伍',

    [LOC.PRIORITY_SHOW]   = 'P',
    [LOC.POPULATE]	    = 'p',
    [LOC.SKIP_SHOW]	    = 'S',
    [LOC.CLEAR_PRIO]	    = 'C',
    [LOC.CLEAR_SKIP]	    = 'C',

    [LOC.PET_FEL_CAST]	=	LOC.PET_FEL_CAST,
    [LOC.PET_DOOM_CAST]	=	LOC.PET_DOOM_CAST,

    [LOC.SPELL_POLYMORPH]		=	"变形术",
    [LOC.SPELL_CURE_DISEASE]	=	"祛病术",
    [LOC.SPELL_ABOLISH_DISEASE]	=	"驱除疾病",
    [LOC.SPELL_PURIFY]		=	"纯净术",
    [LOC.SPELL_CLEANSE]		=	"清洁术",
    [LOC.SPELL_DISPELL_MAGIC]	=	"驱散魔法",
    [LOC.SPELL_CURE_POISON]		=	"消毒术",
    [LOC.SPELL_ABOLISH_POISON]	=	"驱毒术",
    [LOC.SPELL_REMOVE_LESSER_CURSE]	=	"解除次级诅咒",
    [LOC.SPELL_REMOVE_CURSE]	=	"解除诅咒",
    [LOC.SPELL_PURGE]		=	"净化术",

    [BINDING_NAME_DCRSHOW]    = "显示或隐藏 Decursive 状态条",
    
    [BINDING_NAME_DCRMUFSHOWHIDE] = "显示或隐藏 micro-unit frames",

    [BINDING_NAME_DCRPRADD]     = "添加目标至优先列表",
    [BINDING_NAME_DCRPRCLEAR]   = "情况优先列表",
    [BINDING_NAME_DCRPRLIST]    = "显示优先名单到聊天窗口",
    [BINDING_NAME_DCRPRSHOW]    = "开/关 优先列表",

    [BINDING_NAME_DCRSKADD]   = "添加目标至忽略列表",
    [BINDING_NAME_DCRSKCLEAR] = "清空忽略列表",
    [BINDING_NAME_DCRSKLIST]  = "显示忽略名单到聊天窗口",
    [BINDING_NAME_DCRSKSHOW]  = "开/关 忽略列表",
    [BINDING_NAME_DCRSHOWOPTION] = "显示静态设置选项",

    [LOC.PRIORITY_LIST]  = "Decursive 优先列表",
    [LOC.SKIP_LIST_STR]  = "Decursive 忽略列表",
    [LOC.OPTION_MENU]   = "Decursive 选项",
    [LOC.POPULATE_LIST]  = "Decursive 名单快速添加界面",
    [LOC.LIST_ENTRY_ACTIONS]     = "|cFF33AA33[CTRL]|r-左键: 删除该玩家\n |cFF33AA33左|r-键: 提升该玩家优先级\n |cFF33AA33右|r-键: 降低该玩家优先级\n |cFF33AA33[SHIFT] 左|r-键: 将该玩家置顶\n |cFF33AA33[SHIFT] 右|r-键: 将该玩家置底",
    [LOC.HIDE_MAIN]      = "隐藏 Decursive 窗口",
    [LOC.SHOW_MSG]	   = "要显示 Decursive 窗口，请输入 /dcrshow。",
    [LOC.IS_HERE_MSG]	   = "Decursive 已经启动，请核对相关设置。",

    [LOC.PRINT_CHATFRAME] = "在聊天窗口显示信息",
    [LOC.PRINT_CUSTOM]    = "在游戏画面显示信息",
    [LOC.PRINT_ERRORS]    = "显示错误信息",

    [LOC.SHOW_TOOLTIP]    = "在即时列表中显示ToolTips",
    [LOC.REVERSE_LIVELIST]= "反向显示即时列表",
    [LOC.TIE_LIVELIST]    = "即时列表显示与 DCR 窗口连接",
    [LOC.HIDE_LIVELIST]   = "隐藏即时列表",

    [LOC.AMOUNT_AFFLIC]   = "即时列表显示人数: ",
    [LOC.BLACK_LENGTH]    = "停留在排除名单的时间: ",
    [LOC.SCAN_LENGTH]     = "即时检测时间间隔（秒）: ",
    [LOC.ABOLISH_CHECK]   = "施法前检测时候需要净化",
    [LOC.RANDOM_ORDER]    = "随机净化玩家",
    [LOC.CURE_PETS]       = "检测并净化宠物",
    [LOC.IGNORE_STEALTH]  = "忽略潜行的玩家",
    [LOC.PLAY_SOUND]	    = "有玩家需要净化时发出声音",
    [LOC.ANCHOR]          = "Decursive 文字定位点",
    [LOC.DONOT_BL_PRIO]   = "不添加优先列表中的玩家到排除列表",

    [LOC.SPELL_FOUND]      = "找到 %s 法术",

    -- spells and potions
    [LOC.DREAMLESSSLEEP]	= "无梦睡眠",
    [LOC.GDREAMLESSSLEEP]	= "强效昏睡",
    [LOC.MDREAMLESSSLEEP]	= "特效无梦睡眠",
    [LOC.ANCIENTHYSTERIA]	= "上古狂乱",
    [LOC.IGNITE]		= "点燃法力",
    [LOC.TAINTEDMIND]	= "污浊之魂",
    [LOC.MAGMASHAKLES]	= "熔岩镣铐",
    [LOC.CRIPLES]		= "残废术",
    [LOC.DUSTCLOUD]		= "尘雾之云",
    [LOC.WIDOWSEMBRACE]	= "黑女巫的拥抱",
    [LOC.CURSEOFTONGUES]	= "语言诅咒",
    [LOC.SONICBURST]	= "音爆",
    [LOC.THUNDERCLAP]	= "雷霆一击",
    [LOC.DELUSIONOFJINDO]	= "金度的欺骗",
    [LOC.MUTATINGINJECTION] = "变异注射",


    -- NEW LOCALS FOR 2.0

    [LOC.DEFAULT_MACROKEY] = "`", -- the key just beneath the escape key on a QWERTY keyboard
    [LOC.OPT_LIVELIST] = "即时列表",
    [LOC.OPT_LIVELIST_DESC] = "即时列表设置选项。",
    [LOC.OPT_HIDELIVELIST_DESC] = "如果未被隐藏则显示需要净化的人。",
    [LOC.OPT_SHOWTOOLTIP_DESC] = "在即时列表以及 MUFs 上显示ToolTips。",
    [LOC.OPT_PLAYSOUND_DESC]  = "有玩家获得Debuff时发出声音。",
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = "设置即时列表最多显示人数。",
    [LOC.OPT_BLACKLENTGH_DESC] =  "设置玩家在排除列表停留的时间。",
    [LOC.OPT_SCANLENGTH_DESC] = "设置即时检测的时间间隔。",
    [LOC.OPT_REVERSE_LIVELIST_DESC] = "由下到上填充即时列表。",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "创建一次可见的测试感染",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "让你看一下当感染被发现时是什么样的",
    [LOC.OPT_TIE_LIVELIST_DESC] = "即时列表显示与否决定于 \"Decursive\" 状态条。",
    [LOC.OPT_MESSAGES]	= "信息设置",
    [LOC.OPT_MESSAGES_DESC] = "设置信息显示。",
    [LOC.OPT_CHATFRAME_DESC] = "显示到预设的聊天窗口。",
    [LOC.OPT_PRINT_CUSTOM_DESC] = "显示到自定义的聊天窗口。",
    [LOC.OPT_PRINT_ERRORS_DESC] = "显示错误信息。",
    [LOC.OPT_ANCHOR_DESC]	= "显示自定义窗口的文字定位点。",
    [LOC.OPT_MFSETTINGS] = "Micro Unit Frame 选项",
    [LOC.OPT_MFSETTINGS_DESC] = "设置 MUF 以符合你的需要。",
    [LOC.OPT_DISPLAYOPTIONS] = "显示设置",
    [LOC.OPT_SHOWMFS] = "在屏幕上显示 micro units Frame (MUF)",
    [LOC.OPT_SHOWMFS_DESC] = "如果你要在屏幕上按按键清除Debuff就必須选择这项。",
    [LOC.OPT_GROWDIRECTION] = "反向显示 MUFs",
    [LOC.OPT_GROWDIRECTION_DESC] = "MUFs 从末尾开始。",
    [LOC.OPT_SHOWBORDER] = "显示职业颜色边框",
    [LOC.OPT_SHOWBORDER_DESC] = "MUFs 边框会显示出代表该玩家职业的颜色。",
    [LOC.OPT_MAXMFS]  = "最多显示个数",
    [LOC.OPT_MAXMFS_DESC] = "设置在屏幕上显示的 micro unit frames 个数。",
    [LOC.OPT_UNITPERLINES] = '每行显示 MUF 的数量',
    [LOC.OPT_UNITPERLINES_DESC] = "设置每行最多可显示Muf的个数。",
    [LOC.OPT_MFSCALE] = 'MUF 大小',
    [LOC.OPT_MFSCALE_DESC] = "设置 micro-unit-frames 的大小。",
    [LOC.OPT_SHOWHELP] = "显示ToolTips",
    [LOC.OPT_SHOWHELP_DESC] = "当鼠标移动到 micro-unit-frame 上时显示ToolTips。",
    [LOC.OPT_MFPERFOPT] = "功能设置选项",
    [LOC.OPT_MFREFRESHRATE] = '刷新时间',
    [LOC.OPT_MFREFRESHRATE_DESC] = "设置刷新时间",
    [LOC.OPT_MFREFRESHSPEED] = '刷新数量',
    [LOC.OPT_MFREFRESHSPEED_DESC] = "设置每次刷新几个 micro-unit-frames。",
    [LOC.OPT_CURINGOPTIONS] = "净化选项",
    [LOC.OPT_CURINGOPTIONS_DESC] = "设置净化选项。",
    [LOC.OPT_ABOLISHCHECK_DESC] = "检测玩家时候有净化法术正在作用中。",
    [LOC.OPT_DONOTBLPRIO_DESC] = "添加到优先列表的玩家不会被加入排除列表。",
    [LOC.OPT_RANDOMORDER_DESC] = "随机净化玩家。",
    [LOC.OPT_CUREPETS_DESC] = "显示宠物并可净化。",
    [LOC.OPT_IGNORESTEALTHED_DESC] = "忽略潜行的玩家。",
    [LOC.OPT_CURINGORDEROPTIONS] = "净化顺序设置",
    [LOC.OPT_MAGICCHECK_DESC]	= "选择后你可以看见并处理受到Debuff影响的玩家。",
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = "選择后你可以看见并处理受被魔法媚惑的玩家。",
    [LOC.OPT_CHARMEDCHECK_DESC] = "選择后你可以看见并处理受被媚惑的玩家。",
    [LOC.OPT_POISONCHECK_DESC] = "选取后你可以看见并处理中毒的玩家。",
    [LOC.OPT_DISEASECHECK_DESC] = "选取后你可以看见并处理 疾病 的玩家。",
    [LOC.OPT_CURSECHECK_DESC] = "选取后你可以看见并处理 诅咒 的玩家。",
    [LOC.OPT_DEBUFFFILTER] = "Debuff过滤",
    [LOC.OPT_DEBUFFFILTER_DESC] = "设置战斗中需要忽略的职业和Debuff",
    [LOC.OPT_MACROOPTIONS] = "宏选项",
    [LOC.OPT_MACROOPTIONS_DESC] = "设置 Decursive 产生的宏的作用",
    [LOC.OPT_MACROBIND] = "设置宏按键",
    [LOC.OPT_MACROBIND_DESC] = "绑定 Decursive 宏的按键。\n\n按你想設定的按键后按 'Enter' 键保存设置(鼠标需要移动到编辑区域之外)",
    [LOC.OPT_RESETOPTIONS] = "重置为初始设置",
    [LOC.OPT_RESETOPTIONS_DESC] =  "恢复目前设置为初始设置",
    [LOC.OPT_REMOVESKDEBCONF] = "你确定要把\n '%s' \n 从Debuff忽略清单中移出？",
    [LOC.OPT_RESTPROFILECONF] = "你确定要重置\n '(%s) %s'\n 为初始设置?",
    [LOC.OPT_PROFILERESET] = "重置配置...",
    [LOC.OPT_AFFLICTEDBYSKIPPED] = "%s 受到 %s 的影响，但将被忽略。",
    [LOC.OPT_DEBCHECKEDBYDEF] = "\n\nChecked by default",
    [LOC.OPT_ALWAYSIGNORE] = "即使不在战斗中也忽略",
    [LOC.OPT_ALWAYSIGNORE_DESC] = "选中该项，即使脱离战斗状态也忽略该Debuff",
    [LOC.OPT_REMOVETHISDEBUFF] = "删除该Debuff",
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = "将 '%s' 从忽略清单删除。",
    [LOC.OPT_RESETDEBUFF] = "重置此负面效果",
    [LOC.OPT_RESETDTDCRDEFAULT] = "重置 '%s' 为 Decursive 预设。",
    [LOC.OPT_USERDEBUFF] = "该负面效果不是 Decursive 预设的效果之一",
    [LOC.OPT_DEBUFFENTRY_DESC] = "选择战斗中要忽略该效果影响的职业。",
    [LOC.OPT_ADDDEBUFF] = "添加负面效果到清单中",
    [LOC.OPT_ADDDEBUFF_DESC] = "将一个负面效果新增到清单中。",
    [LOC.OPT_ADDDEBUFF_USAGE] = "<Debuff name>",
    [LOC.OPT_READDDEFAULTSD] = "重置负面效果",
    [LOC.OPT_READDDEFAULTSD_DESC1] = "添加被删除的Debuff\n你的设置不会改变。",
    [LOC.OPT_READDDEFAULTSD_DESC2] = "所有的预设Debuff均在清单中。",

    [LOC.OPT_LVONLYINRANGE] = "只显示法术有效范围内的目标",
    [LOC.OPT_LVONLYINRANGE_DESC] = "即时列表只显示法术有效范围内的目标。",

    [LOC.OPT_MFALPHA] = "透明度",
    [LOC.OPT_MFALPHA_DESC] = "设置没有 debuff 时 MUFs 的透明度。",

    [LOC.OPT_ADVDISP] = "高级显示选项",
    [LOC.OPT_ADVDISP_DESC] = "可设置边框与中央色块的透明度，以及 MUFs 间的距离。",
    [LOC.OPT_TIECENTERANDBORDER] = "固定 MUF 中央与边框的透明度",
    [LOC.OPT_TIECENTERANDBORDER_OPT] = "选择该项，边框的透明度将固定为中央的一半。",
    [LOC.OPT_BORDERTRANSP] = "边框透明度",
    [LOC.OPT_BORDERTRANSP_DESC] = "设置边框的透明度。",
    [LOC.OPT_CENTERTRANSP] = "中央透明度",
    [LOC.OPT_CENTERTRANSP_DESC] = "设置中央色块的透明度",
    [LOC.OPT_TIEXYSPACING] = "固定水平与垂直距离。",
    [LOC.OPT_TIEXYSPACING_DESC] = "固定 MUFs 间的水平与垂直距离(空白)。",
    [LOC.OPT_XSPACING] = "水平距离",
    [LOC.OPT_XSPACING_DESC] = "设置 MUFs 间的水平距离。",
    [LOC.OPT_YSPACING] = "垂直距离",
    [LOC.OPT_YSPACING_DESC] = "设置 MUFs 间的垂直距离。",



    [LOC.HLP_LL_ONCLICK_TEXT] = "由于BLZ禁用函数的缘故，点击即时列表已经不能驱散Debuff了",
    [LOC.HLP_LEFTCLICK] = "左-键",
    [LOC.HLP_RIGHTCLICK] = "右-键",
    [LOC.HLP_MIDDLECLICK] = "中-键",
  
    [LOC.HLP_NOTHINGTOCURE] = "没有可处理的Debuff！",
    [LOC.HLP_WRONGMBUTTON] = "错误的鼠标按键！",
    [LOC.HLP_USEXBUTTONTOCURE] = "用 \"%s\" 來净化这个Debuff！",

    [LOC.CTRL] = "Ctrl",
    [LOC.ALT] = "ALt",
    [LOC.SHIFT] = "Shift",

    [LOC.TARGETUNIT] = "选择目标",
    [LOC.FOCUSUNIT] = "监视目标",

    [LOC.ABSENT] = "不存在 (%s)",
    [LOC.TOOFAR] = "太远",
    [LOC.NORMAL] = "一般",
    [LOC.STEALTHED] = "已潜行",
    [LOC.BLACKLISTED] = "在排除名单",
    [LOC.UNITSTATUS] = "玩家状态: ",
    [LOC.AFFLICTEDBY] = "受 %s 影响",

    [LOC.SUCCESSCAST] = "|cFF22FFFF%s %s|r |cFF00AA00成功净化|r %s",

    [LOC.HANDLEHELP] = "拖拽移动 Micro-UnitFrames (MUFs)",

    [LOC.MACROKEYALREADYMAPPED] = "警告: Decursive 宏绑定按键 [%s] 先前绑定到 '%s' 。\n当你设置別的宏按键后 Decursive 会恢复此按键原有的动作。",
    [LOC.MACROKEYMAPPINGSUCCESS] = "按键 [%s] 已成功绑定到 Decursive 宏。",
    [LOC.MACROKEYMAPPINGFAILED] = "按键 [%s] 不能绑定到 Decursive 宏！",
    [LOC.MACROKEYNOTMAPPED] = "Decursive 宏未绑定按键，你可以通过设置选项来设置该功能。(別错过这个神奇的功能)",

    [LOC.OPT_NOKEYWARN] = "没有映射按键",
    [LOC.OPT_NOKEYWARN_DESC] = "没有映射按键",
    [LOC.NOSPELL] = "没有相关技能",

} end);


