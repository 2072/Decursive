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
-- Simplified Chinese by CWDG 剜刀

if not DcrLoadedFiles or not DcrLoadedFiles["localization.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (localization.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

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
    [LOC.CLASS_ROGUE]	=	"潜行者",
    [LOC.CLASS_SHAMAN]	=	"萨满祭司",
    [LOC.CLASS_WARLOCK]	=	"术士",
    [LOC.CLASS_WARRIOR]	=	"战士",

    [LOC.STR_OTHER]	    = "其他",
    [LOC.STR_OPTIONS]	    = "设置选项",
    [LOC.STR_CLOSE]	    = "关闭",
    [LOC.STR_DCR_PRIO]    = "优先列表",
    [LOC.STR_DCR_SKIP]    = "忽略列表",
    [LOC.STR_QUICK_POP]   = "快速添加器",
    [LOC.STR_POP]	    = "快速添加列表",
    [LOC.STR_GROUP]	    = "小队",

    [LOC.PRIORITY_SHOW]   = "P",
    [LOC.POPULATE]	    = "p",
    [LOC.SKIP_SHOW]	    = "S",
    [LOC.CLEAR_PRIO]	    = "C",
    [LOC.CLEAR_SKIP]	    = "C",

    [LOC.PET_FEL_CAST]	=	"吞噬魔法",
    [LOC.PET_DOOM_CAST]	=	"驱散魔法",

    [LOC.SPELL_POLYMORPH]		=	"变形术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_DISEASE]	=	"祛病术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_DISEASE]	=	"驱除疾病", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURIFY]		=	"纯净术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CLEANSE]		=	"清洁术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_DISPELL_MAGIC]	=	"驱散魔法", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CURE_POISON]		=	"消毒术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_ABOLISH_POISON]	=	"驱毒术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_LESSER_CURSE]	=	"解除次级诅咒", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_REMOVE_CURSE]	=	"解除诅咒", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_PURGE]		=	"净化术", -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SPELL_CYCLONE]             = '飓风术',  -- This translation is for reference only the one used is from the library BabbleSpell

    [BINDING_NAME_DCRSHOW]    = "显示或隐藏一键驱散状态条",

    [BINDING_NAME_DCRMUFSHOWHIDE] = "显示或隐藏微单元面板(MUF)",

    [BINDING_NAME_DCRPRADD]     = "将目标加入优先列表",
    [BINDING_NAME_DCRPRCLEAR]   = "清空优先列表",
    [BINDING_NAME_DCRPRLIST]    = "显示优先列表明细条目",
    [BINDING_NAME_DCRPRSHOW]    = "显示/隐藏 优先列表",

    [BINDING_NAME_DCRSKADD]   = "将目标加入忽略列表",
    [BINDING_NAME_DCRSKCLEAR] = "清空忽略列表",
    [BINDING_NAME_DCRSKLIST]  = "显示忽略列表明细条目",
    [BINDING_NAME_DCRSKSHOW]  = "显示/隐藏 忽略列表",
    [BINDING_NAME_DCRSHOWOPTION] = "显示选项设置窗口",

    [LOC.PRIORITY_LIST]  = "设置 优先列表",
    [LOC.SKIP_LIST_STR]  = "设置 忽略列表",
    [LOC.OPTION_MENU]   = "选项设置",
    [LOC.POPULATE_LIST]  = "列表快速添加器",
    [LOC.LIST_ENTRY_ACTIONS]     = "|cFF33AA33[CTRL]|r+单击：删除\n|cFF33AA33左键|r单击：上移\n|cFF33AA33右键|r单击：下移\n|cFF33AA33[SHIFT]+左键|r单击：移到顶端\n|cFF33AA33[SHIFT]+右键|r单击：移到底端",
    [LOC.HIDE_MAIN]      = "隐藏状态条",
    [LOC.SHOW_MSG]	   = "如果需要显示状态条，请输入 /dcrshow。",
    [LOC.IS_HERE_MSG]	   = "一键驱散已经启动，请核对相关设置。",

    [LOC.PRINT_CHATFRAME] = "在聊天窗口显示信息",
    [LOC.PRINT_CUSTOM]    = "在游戏画面显示信息",
    [LOC.PRINT_ERRORS]    = "显示错误信息",

    [LOC.SHOW_TOOLTIP]    = "在实时列表中显示信息提示",
    [LOC.REVERSE_LIVELIST]= "反向显示实时列表",
    [LOC.TIE_LIVELIST]    = "根据状态条是否可见 显示/隐藏 实时列表",
    [LOC.HIDE_LIVELIST]   = "隐藏实时列表",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF]		= "建立虚拟效果测试",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC]	= "让你看到产生这个效果的情况",

    [LOC.AMOUNT_AFFLIC]   = "实时列表显示人数: ",
    [LOC.BLACK_LENGTH]    = "黑名单持续时间: ",
    [LOC.SCAN_LENGTH]     = "实时检测时间间隔（秒）: ",
    [LOC.ABOLISH_CHECK]   = "在施法前检测是否需要净化",
    [LOC.RANDOM_ORDER]    = "随机净化玩家",
    [LOC.CURE_PETS]       = "检测并净化宠物",
    [LOC.IGNORE_STEALTH]  = "忽略潜行的玩家",
    [LOC.PLAY_SOUND]	    = "有玩家需要净化时播放声音提示",
    [LOC.ANCHOR]          = "一键驱散 文字定位点",
    [LOC.DONOT_BL_PRIO]   = "不将优先列表中的玩家加入黑名单",

    [LOC.SPELL_FOUND]      = "找到 %s 法术。",

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
    [LOC.CURSEOFTONGUES]	= "语言诅咒",  -- This translation is for reference only the one used is from the library BabbleSpell
    [LOC.SONICBURST]	= "音爆",
    [LOC.THUNDERCLAP]	= "雷霆一击",
    [LOC.DELUSIONOFJINDO]	= "金度的欺骗",
    [LOC.MUTATINGINJECTION] = "变异注射",



    -- NEW LOCALS FOR 2.0
    [LOC.DEFAULT_MACROKEY] = "`", -- the key just beneath the escape key on a QWERTY keyboard
    [LOC.OPT_LIVELIST] = "实时列表",
    [LOC.OPT_LIVELIST_DESC] = "关于实时列表的选项设置。",
    [LOC.OPT_HIDELIVELIST_DESC] = "显示所有受到负面效果影响的玩家列表。",
    [LOC.OPT_SHOWTOOLTIP_DESC] = "在实时列表以及微单元面板(MUF)上显示信息提示。",
    [LOC.OPT_PLAYSOUND_DESC]  = "有玩家受到负面效果影响时播放声音提示。",
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = "设置实时列表显示的最大玩家数目。",
    [LOC.OPT_BLACKLENTGH_DESC] =  "设置被暂时加入黑名单的玩家在名单中停留的时间。",
    [LOC.OPT_SCANLENGTH_DESC] = "设置实时检测的时间间隔。",
    [LOC.OPT_REVERSE_LIVELIST_DESC] = "实时列表将从下往上显示。",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "创建一个虚拟的测试用负面效果",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "让你看看出现负面效果时的界面是什么样子",
    [LOC.OPT_TIE_LIVELIST_DESC] = "实时列表将和状态条一起 显示/隐藏。",
    [LOC.OPT_MESSAGES]	= "信息设置",
    [LOC.OPT_MESSAGES_DESC] = "关于提示信息的选项设置。",
    [LOC.OPT_CHATFRAME_DESC] = "提示信息将显示在默认聊天窗口中。",
    [LOC.OPT_PRINT_CUSTOM_DESC] = "提示信息将显示在自定义聊天窗口中。",
    [LOC.OPT_PRINT_ERRORS_DESC] = "错误信息将被显示。",
    [LOC.OPT_ANCHOR_DESC]	= "设置自定义信息面板的定位点。",
    [LOC.OPT_MFSETTINGS] = "微单元面板(MUF) 选项",
    [LOC.OPT_MFSETTINGS_DESC] = "关于微单元面板(MUF)的选项设置。",
    [LOC.OPT_DISPLAYOPTIONS] = "显示选项",
    [LOC.OPT_SHOWMFS] = "在屏幕上显示 MUF",
    [LOC.OPT_SHOWMFS_DESC] = "如果你要打地鼠就必須选择这项。",
    [LOC.OPT_GROWDIRECTION] = "反向显示 MUF",
 
    [LOC.OPT_STICKTORIGHT]	= LOC.OPT_STICKTORIGHT,
    [LOC.OPT_STICKTORIGHT_DESC]	= LOC.OPT_STICKTORIGHT_DESC,
    [LOC.OPT_MUFSCOLORS]	= "颜色",
    [LOC.OPT_MUFSCOLORS_DESC]	= "更改关于微单元面板(MUF)的颜色",
    [LOC.MISSINGUNIT]		= "丢失单位",
    [LOC.COLORALERT]		= "预警颜色",
    [LOC.COLORSTATUS]		= LOC.COLORSTATUS,

    [LOC.OPT_AUTOHIDEMFS]	    = "自动隐藏",
    [LOC.OPT_AUTOHIDEMFS_DESC]	    = "选择何时自动隐藏微单元面板(MUF)",
    [LOC.OPT_HIDEMFS_SOLO]	    = "单人",
    [LOC.OPT_HIDEMFS_SOLO_DESC]	    = "在没有组队或者团队时隐藏微单元面板(MUF)",
    [LOC.OPT_HIDEMFS_GROUP]	    = "单人/小队",
    [LOC.OPT_HIDEMFS_GROUP_DESC]    = "不在团队中时隐藏微单元面板(MUF)",
    [LOC.OPT_HIDEMFS_NEVER]	    = "从不",
    [LOC.OPT_HIDEMFS_NEVER_DESC]    = "从不隐藏",

    [LOC.OPT_ADDDEBUFFFHIST]		= LOC.OPT_ADDDEBUFFFHIST,
    [LOC.OPT_ADDDEBUFFFHIST_DESC]	= LOC.OPT_ADDDEBUFFFHIST_DESC,

    [LOC.OPT_GROWDIRECTION_DESC] = "MUF将从下向上显示。",
    [LOC.OPT_SHOWBORDER] = "显示职业彩色边框",
    [LOC.OPT_SHOWBORDER_DESC] = "MUF边框将会显示出代表该玩家职业的颜色。",
    [LOC.OPT_MAXMFS]  = "最大MUF数",
    [LOC.OPT_MAXMFS_DESC] = "设置在屏幕上显示的MUF的个数。",
    [LOC.OPT_UNITPERLINES] = '每行MUF数',
    [LOC.OPT_UNITPERLINES_DESC] = "设置每行最多可显示MUF的个数。",
    [LOC.OPT_MFSCALE] = 'MUF 缩放比例',
    [LOC.OPT_MFSCALE_DESC] = "设置微单元面板(MUF)的大小。",
    [LOC.OPT_LLSCALE] = "设置实时列表缩放比例",
    [LOC.OPT_LLSCALE_DESC] = "设置状态条以及其实时列表的大小（状态条必须显示）",
    [LOC.OPT_SHOWHELP] = "显示帮助信息",
    [LOC.OPT_SHOWHELP_DESC] = "当鼠标移动到 MUF 上时显示信息提示窗口。",
    [LOC.OPT_MFPERFOPT] = "性能选项",
    [LOC.OPT_MFREFRESHRATE] = '刷新率',
    [LOC.OPT_MFREFRESHRATE_DESC] = "每两次刷新之间的时间间隔",
    [LOC.OPT_MFREFRESHSPEED] = '刷新速度',
    [LOC.OPT_MFREFRESHSPEED_DESC] = "设置每次刷新多少个MUF。",
    [LOC.OPT_CURINGOPTIONS] = "净化选项",
    [LOC.OPT_CURINGOPTIONS_DESC] = "关于净化过程的选项设置。",
    [LOC.OPT_ABOLISHCHECK_DESC] = "设置是否显示和净化带有“驱毒术”增益效果的玩家。",
    [LOC.OPT_DONOTBLPRIO_DESC] = "优先列表中的玩家不会被加入黑名单。",
    [LOC.OPT_RANDOMORDER_DESC] = "随机净化玩家(不推荐使用)。",
    [LOC.OPT_CUREPETS_DESC] = "宠物也会被检查和净化。",
    [LOC.OPT_IGNORESTEALTHED_DESC] = "处于潜行状态的玩家会被忽略。",
    [LOC.OPT_CURINGORDEROPTIONS] = "净化顺序设置",
    [LOC.OPT_MAGICCHECK_DESC]	= "选中后你将可以查看和净化受到不良魔法效果影响的玩家。",
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = "选中后你将可以查看和净化受到魔法诱惑效果影响的玩家。",
    [LOC.OPT_CHARMEDCHECK_DESC] = "选中后你将可以查看和处理被诱惑的玩家。",
    [LOC.OPT_POISONCHECK_DESC] = "选中后你将可以查看和净化受到中毒效果影响的玩家。",
    [LOC.OPT_DISEASECHECK_DESC] = "选中后你将可以查看和净化受到疾病效果影响的玩家。",
    [LOC.OPT_CURSECHECK_DESC] = "选中后你将可以查看和净化受到诅咒效果影响的玩家。",
    [LOC.OPT_DEBUFFFILTER] = "负面效果过滤",
    [LOC.OPT_DEBUFFFILTER_DESC] = "根据名称和职业选择在战斗中要过滤掉的负面效果",
    [LOC.OPT_MACROOPTIONS] = "宏选项",
    [LOC.OPT_MACROOPTIONS_DESC] = "有关Decursive创建的宏的选项设置",
    [LOC.OPT_MACROBIND] = "设置宏按键",
    [LOC.OPT_MACROBIND_DESC] = "绑定一键驱散宏的按键。\n\n按你想設定的按键后按 'Enter' 键保存设置(鼠标需要移动到编辑区域之外)",
    [LOC.OPT_RESETOPTIONS] = "恢复默认设置",
    [LOC.OPT_RESETOPTIONS_DESC] =  "将当前选项设置方案恢复到默认值",
    [LOC.OPT_REMOVESKDEBCONF] = "你确定要将“%s”从不良状态忽略列表中删除吗？",
    [LOC.OPT_RESTPROFILECONF] = "你确定要将选项设置方案“(%s) %s”恢复默认值吗？",
    [LOC.OPT_PROFILERESET] = "正在重置选项设置方案……",
    [LOC.OPT_AFFLICTEDBYSKIPPED] = "%s 受到 %s 的影响，但将被忽略。",
    [LOC.OPT_DEBCHECKEDBYDEF] = "\n\n默认被选中",
    [LOC.OPT_ALWAYSIGNORE] = "不在战斗状态时也忽略",
    [LOC.OPT_ALWAYSIGNORE_DESC] = "选中后不在状态时此负面效果也会被忽略。",
    [LOC.OPT_REMOVETHISDEBUFF] = "删除",
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = "从忽略列表中删除“%s”。",
    [LOC.OPT_RESETDEBUFF] = "重置",
    [LOC.OPT_RESETDTDCRDEFAULT] = "将\n%s\n恢复默认值。",
    [LOC.OPT_USERDEBUFF] = "该负面效果不是<一键驱散>预设的效果之一",
    [LOC.OPT_DEBUFFENTRY_DESC] = "选择在战斗中哪些受到此负面效果影响的职业将被忽略。",
    [LOC.OPT_ADDDEBUFF] = "新增",
    [LOC.OPT_ADDDEBUFF_DESC] = "向列表中新增一个负面效果。",
    [LOC.OPT_ADDDEBUFF_USAGE] = "<负面效果名称>",
    [LOC.OPT_READDDEFAULTSD] = "重新加入缺省负面效果",
    [LOC.OPT_READDDEFAULTSD_DESC1] = "向列表中加入所有缺失的默认负面效果。\n你的自定义项目不会丢失",
    [LOC.OPT_READDDEFAULTSD_DESC2] = "所有缺省负面效果都已加入列表。",

    [LOC.OPT_LVONLYINRANGE] = "只显示法术有效范围内的目标",
    [LOC.OPT_LVONLYINRANGE_DESC] = "实时列表将只显示法术有效范围内的目标,超出范围的目标将被忽略。",

    [LOC.OPT_MFALPHA] = "透明度",
    [LOC.OPT_MFALPHA_DESC] = "定义玩家没有受到负面效果影响时MUF的透明度。",

    [LOC.OPT_LLALPHA] = "实时列表透明度",
    [LOC.OPT_LLALPHA_DESC] = "改变一键驱散状态条面和实时列表的透明度（状态条必须可见）",

    [LOC.OPT_ADVDISP] = "高级显示选项",
    [LOC.OPT_ADVDISP_DESC] = "允许分别设置面板和边框的透明度，以及MUF的间距。",
    [LOC.OPT_TIECENTERANDBORDER] = "绑定面板和边框的透明度",
    [LOC.OPT_TIECENTERANDBORDER_OPT] = "选中时边框的透明度为面板的一半。",
    [LOC.OPT_BORDERTRANSP] = "边框透明度",
    [LOC.OPT_BORDERTRANSP_DESC] = "设置边框的透明度。",
    [LOC.OPT_CENTERTRANSP] = "面板透明度",
    [LOC.OPT_CENTERTRANSP_DESC] = "设置面板的透明度",
    [LOC.OPT_TIEXYSPACING] = "绑定水平和垂直间距。",
    [LOC.OPT_TIEXYSPACING_DESC] = "MUF之间的水平和垂直间距相同。",
    [LOC.OPT_XSPACING] = "水平距离",
    [LOC.OPT_XSPACING_DESC] = "设置 MUF 间的水平距离。",
    [LOC.OPT_YSPACING] = "垂直距离",
    [LOC.OPT_YSPACING_DESC] = "设置 MUF 间的垂直距离。",



    [LOC.HLP_LL_ONCLICK_TEXT] = "由于BLZ禁用函数的缘故，点击实时列表已经不能驱散负面效果了",
    [LOC.HLP_LEFTCLICK] = "鼠标左键",
    [LOC.HLP_RIGHTCLICK] = "鼠标右键",
    [LOC.HLP_MIDDLECLICK] = "鼠标中键",

    [LOC.HLP_NOTHINGTOCURE] = "没有可处理的负面效果！",
    [LOC.HLP_WRONGMBUTTON] = "错误的鼠标按键！",
    [LOC.HLP_USEXBUTTONTOCURE] = "用 \"%s\" 來净化这个负面效果！",

    [LOC.CTRL] = "Ctrl",
    [LOC.ALT] = "ALt",
    [LOC.SHIFT] = "Shift",

    [LOC.TARGETUNIT] = "设为目标",
    [LOC.FOCUSUNIT] = "设为焦点",

    [LOC.ABSENT] = "不存在 (%s)",
    [LOC.TOOFAR] = "太远",
    [LOC.NORMAL] = "一般",
    [LOC.STEALTHED] = "已潜行",
    [LOC.BLACKLISTED] = "黑名单",
    [LOC.UNITSTATUS] = "玩家状态: ",
    [LOC.AFFLICTEDBY] = "受 %s 影响",

    [LOC.SUCCESSCAST] = "%s %s|cFF00AA00成功施放于|r|cFF22FFFF %s|r。",

    [LOC.HANDLEHELP] = "拖拽移动 MUF",

    [LOC.MACROKEYALREADYMAPPED] = "警告: 一键驱散的宏绑定按键 [%s] 先前绑定到 '%s' 。\n当你设置別的宏按键后一键驱散会恢复此按键原有的动作。",
    [LOC.MACROKEYMAPPINGSUCCESS] = "按键 [%s] 已成功绑定到一键驱散的宏。",
    [LOC.MACROKEYMAPPINGFAILED] = "按键 [%s] 不能绑定到一键驱散的宏！",
    [LOC.MACROKEYNOTMAPPED] = "未绑定一键驱散的宏按键，你可以通过设置选项来设置该功能。",

    [LOC.OPT_NOKEYWARN] = "没有映射按键",
    [LOC.OPT_NOKEYWARN_DESC] = "没有映射按键",
    [LOC.NOSPELL] = "没有相关技能",
    
    [LOC.FUBARMENU]  = LOC.FUBARMENU,
    [LOC.FUBARMENU_DESC]  = LOC.FUBARMENU_DESC,
	
    [LOC.GLOR1] = "纪念 Glorfindal",
    [LOC.GLOR2] = "献给匆匆离我们而去的Bertrand；他将永远被我们所铭记。",
    [LOC.GLOR3] = "纪念 Bertrand （１９６９－２００７）",
    [LOC.GLOR4] =  "对于那些在魔兽世界里遇见过Glorfindal的人来说，他是一个重承诺的男人，也是一个有超凡魅力的领袖。友谊和慈爱将永植于他们的心中。他在游戏中就如同在他生活中一样的无私，彬彬有礼，乐于奉献，最重要的是他对生活充满热情。他离开我们的时候才仅仅３８岁，随他离去的绝不会是虚拟世界匿名的角色；在这里还有一群忠实的朋友在永远想念他。",
    [LOC.GLOR5] = "他将永远被我们所铭记。",

} end);

DcrLoadedFiles["localization.cn.lua"] = true;

