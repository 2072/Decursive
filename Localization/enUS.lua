--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2009 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
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


--[=[
--			YOUR ATTENTION PLEASE
--
--	   !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--	################################################################
--	#  http://wow.curseforge.com/projects/decursive/localization/  #
--	################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]


if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_utils.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_utils.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

--Dcr:SetDateAndRevision("$Date: 2008-08-15 07:21:36 +0200 (ven., 15 août 2008) $", "$Revision: 80467 $");

Dcr.LOC = {};

local LOC = Dcr.LOC;

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

"DISEASE" = 'Disease';
"MAGIC"   = 'Magic';
"POISON"  = 'Poison';
"CURSE"   = 'Curse';
"MAGICCHARMED" = 'Magic Charm';
"CHARMED" = 'Charm';


"CLASS_DRUID"   = 'Druid';
"CLASS_HUNTER"  = 'Hunter';
"CLASS_MAGE"    = 'Mage';
"CLASS_PALADIN" = 'Paladin';
"CLASS_PRIEST"  = 'Priest';
"CLASS_ROGUE"   = 'Rogue';
"CLASS_SHAMAN"  = 'Shaman';
"CLASS_WARLOCK" = 'Warlock';
"CLASS_WARRIOR" = 'Warrior';
"CLASS_DEATHKNIGHT" = 'Deathknight';

"STR_OTHER"	    = 'Other';
"STR_OPTIONS"	    = "Decursive's Options";
"STR_CLOSE"	    = 'Close';
"STR_DCR_PRIO"    = 'Decursive Priority';
"STR_DCR_SKIP"    = 'Decursive Skip';
"STR_QUICK_POP"   = 'Quickly Populate';
"STR_POP"	    = 'Populate List';
"STR_GROUP"	    = 'Group ';




"PRIORITY_SHOW"   = 'P';
"POPULATE"	    = 'p';
"SKIP_SHOW"	    = 'S';
"CLEAR_PRIO"	    = 'C';
"CLEAR_SKIP"	    = 'C';





"PET_FEL_CAST"  = "Devour Magic"; -- NO NEED TO TRANSLATE
"PET_DOOM_CAST" = "Dispel Magic"; -- NO NEED TO TRANSLATE


"SPELL_POLYMORPH"	      = 'Polymorph'; -- NO NEED TO TRANSLATE
"SPELL_CURE_DISEASE"        = 'Cure Disease'; -- NO NEED TO TRANSLATE
"SPELL_ABOLISH_DISEASE"     = 'Abolish Disease'; -- NO NEED TO TRANSLATE
"SPELL_PURIFY"              = 'Purify'; -- NO NEED TO TRANSLATE
"SPELL_CLEANSE"             = 'Cleanse'; -- NO NEED TO TRANSLATE
"SPELL_DISPELL_MAGIC"       = 'Dispel Magic'; -- NO NEED TO TRANSLATE
"SPELL_CURE_POISON"         = 'Cure Poison'; -- NO NEED TO TRANSLATE
"SPELL_ABOLISH_POISON"      = 'Abolish Poison';-- NO NEED TO TRANSLATE
"SPELL_REMOVE_LESSER_CURSE" = 'Remove Lesser Curse'; -- NO NEED TO TRANSLATE
"SPELL_REMOVE_CURSE"        = 'Remove Curse'; -- NO NEED TO TRANSLATE
"SPELL_PURGE"               = 'Purge'; -- NO NEED TO TRANSLATE
"SPELL_CYCLONE"	      = 'Cyclone'; -- NO NEED TO TRANSLATE
"CLEANSE_SPIRIT"	      = "Cleanse Spirit"; -- NO NEED TO TRANSLATE

"BINDING_NAME_DCRSHOW"    = "Show or hide Decursive Main Bar\n(live-list anchor)";

"BINDING_NAME_DCRMUFSHOWHIDE" = "Show or hide the micro-unit frames";

"BINDING_NAME_DCRPRADD"     = "Add target to priority list";
"BINDING_NAME_DCRPRCLEAR"   = "Clear the priority list";
"BINDING_NAME_DCRPRLIST"    = "Print the priority list";
"BINDING_NAME_DCRPRSHOW"    = "Show or hide the priority list";

"BINDING_NAME_DCRSKADD"   = "Add target to skip list";
"BINDING_NAME_DCRSKCLEAR" = "Clear the skip list";
"BINDING_NAME_DCRSKLIST"  = "Print the skip list";
"BINDING_NAME_DCRSKSHOW"  = "Show or hide the skip list";
"BINDING_NAME_DCRSHOWOPTION" = "Display the option static panel";


"PRIORITY_LIST"  = "Decursive Priority List";
"SKIP_LIST_STR"  = "Decursive Skip List";
"OPTION_MENU"   = "Decursive Options Menu";
"POPULATE_LIST"  = "Quickly populate the Decursive list";
"LIST_ENTRY_ACTIONS"     = "|cFF33AA33[CTRL]|r-Click: Remove this player\n|cFF33AA33LEFT|r-Click: Rise this player\n|cFF33AA33RIGHT|r-Click: Come down this player\n|cFF33AA33[SHIFT] LEFT|r-Click: Put this player at the top\n|cFF33AA33[SHIFT] RIGHT|r-Click: Put this player at the bottom";
"HIDE_MAIN"      = "Hide Decursive Window";
"SHOW_MSG"	   = "To show Decursive's frame, type /dcrshow";
"IS_HERE_MSG"	   = "Decursive is now initialized, remember to check the options";

"PRINT_CHATFRAME" = "Print messages in default chat";
"PRINT_CUSTOM"    = "Print messages in the window";
"PRINT_ERRORS"    = "Print error messages";

"SHOW_TOOLTIP"    = "Show Tooltips on afflicted units";
"REVERSE_LIVELIST"= "Reverse live-list display";
"HIDE_LIVELIST"   = "Hide the live-list";
"TIE_LIVELIST"    = "Tie live-list visibility to DCR window";
"OPT_CREATE_VIRTUAL_DEBUFF" = "Create a virtual test affliction";
"OPT_CREATE_VIRTUAL_DEBUFF_DESC" = "Lets you see how it looks like when an affliction is found";

"AMOUNT_AFFLIC"   = "The amount of afflicted to show : ";
"BLACK_LENGTH"    = "Seconds on the blacklist : ";
"SCAN_LENGTH"     = "Seconds between live scans : ";
"ABOLISH_CHECK"   = "Check for \"Abolish\" before curing";
"RANDOM_ORDER"    = "Cure in a random order";
"CURE_PETS"       = "Scan and cure pets";
"IGNORE_STEALTH"  = "Ignore cloaked Units";
"PLAY_SOUND"	    = "Play a sound when there is someone to cure";
"ANCHOR"          = "Decursive Text Anchor";
"DONOT_BL_PRIO"   = "Don't blacklist priority list names";

"SPELL_FOUND"      = "%s spell found!";



-- spells and potions
"DREAMLESSSLEEP"	= "Dreamless Sleep";		-- NO NEED TO TRANSLATE 
"GDREAMLESSSLEEP"	= "Greater Dreamless Sleep";	-- NO NEED TO TRANSLATE 
"MDREAMLESSSLEEP"	= "Major Dreamless Sleep";	-- NO NEED TO TRANSLATE
"ANCIENTHYSTERIA"	= "Ancient Hysteria";		-- NO NEED TO TRANSLATE
"IGNITE"		= "Ignite Mana";		-- NO NEED TO TRANSLATE
"TAINTEDMIND"		= "Tainted Mind";		-- NO NEED TO TRANSLATE
"MAGMASHAKLES"	= "Magma Shackles";		-- NO NEED TO TRANSLATE
"CRIPLES"		= "Cripple";			-- NO NEED TO TRANSLATE
"DUSTCLOUD"		= "Dust Cloud";			-- NO NEED TO TRANSLATE
"WIDOWSEMBRACE"	= "Widow's Embrace";		-- NO NEED TO TRANSLATE
"CURSEOFTONGUES"	= "Curse of Tongues";		-- NO NEED TO TRANSLATE
"SONICBURST"		= "Sonic Burst";		-- NO NEED TO TRANSLATE
"THUNDERCLAP"		= "Thunderclap";		-- NO NEED TO TRANSLATE -- unused
"DELUSIONOFJINDO"	= "Delusions of Jin'do";	-- NO NEED TO TRANSLATE
"MUTATINGINJECTION"	= "Mutating Injection";		-- NO NEED TO TRANSLATE
"DCR_LOC_SILENCE"	= "Silence";			-- NO NEED TO TRANSLATE
"DCR_LOC_MINDVISION"	= "Mind Vision";		-- NO NEED TO TRANSLATE

-- NEW LOCALS FOR 2.0


"OPT_LIVELIST" = "Live list";
"OPT_LIVELIST_DESC" = "Options for the live list";
"OPT_HIDELIVELIST_DESC" = "If not hidden, displays an informative list of cursed people";
"OPT_SHOWTOOLTIP_DESC" = "Shows a detailed tooltips about curses in the live-list and on the MUFs";
"OPT_PLAYSOUND_DESC"  = "Play a sound if someone get cursed";
"OPT_AMOUNT_AFFLIC_DESC" = "Defines the max number of cursed to display in the live-list";
"OPT_BLACKLENTGH_DESC" =  "Defines how long someone stays on the blacklist";
"OPT_SCANLENGTH_DESC" = "Defines the time between each scan";
"OPT_REVERSE_LIVELIST_DESC" = "The live-list fills itself from bottom to top";
"OPT_TIE_LIVELIST_DESC" = "The live-list display is tied to \"Decursive\" bar display";
"OPT_MESSAGES"	= "Messages";
"OPT_MESSAGES_DESC" = "Options about messages display";
"OPT_CHATFRAME_DESC" = "Decursive's messages will be printed to the default chat frame";
"OPT_PRINT_CUSTOM_DESC" = "Decursive's messages will be printed in a custom chat frame";
"OPT_PRINT_ERRORS_DESC" = "Errors will be displayed";
"OPT_ANCHOR_DESC"	= "Shows the anchor of the custom message frame";
"OPT_MFSETTINGS" = "Micro Unit Frame Settings";
"OPT_MFSETTINGS_DESC" = "Set the micro units frame window options to suit your needs";
"OPT_DISPLAYOPTIONS" = "Display options";

"OPT_SHOWMFS" = "Show the Micro Units Frame";
"OPT_SHOWMFS_DESC" = "This must be enabled if you want to cure by clicking";

"OPT_AUTOHIDEMFS"	    = "Auto-Hide";
"OPT_AUTOHIDEMFS_DESC"    = "Choose when to hide the MUF window";

"OPT_HIDEMFS_SOLO"		= "Solo";
"OPT_HIDEMFS_SOLO_DESC"	= "Hide the MUF window when you are not in a party or raid";

"OPT_HIDEMFS_GROUP"		= "Solo/Party";
"OPT_HIDEMFS_GROUP_DESC"	= "Hide the MUF window when you are not in a raid";

"OPT_HIDEMFS_NEVER"		= "Never";
"OPT_HIDEMFS_NEVER_DESC"	= "Never auto-hide the MUF window";

"OPT_ADDDEBUFFFHIST"		= "Add a recent affliction";
"OPT_ADDDEBUFFFHIST_DESC"	= "Add an affliction using the history";

"OPT_GROWDIRECTION" = "Reverse MUFs Display";
"OPT_GROWDIRECTION_DESC" = "The MUFs will be displayed from bottom to top";

"OPT_STICKTORIGHT" = "Align MUF window to the right";
"OPT_STICKTORIGHT_DESC" = "The MUF window will grow from right to left, the handle will be moved as necessary.";
"OPT_MUFSCOLORS" = "Colors";
"OPT_MUFSCOLORS_DESC" = "Change the colors of the Micro Unit Frames.";
"MISSINGUNIT" = "Missing unit";
"COLORALERT" = "Set the color alert when a '%s' is required.";
"COLORSTATUS" = "Set the color for the '%s' MUF status.";
"COLORCHRONOS" = "Chronometers";
"COLORCHRONOS_DESC" = "Set the chronometers' color";

"OPT_SHOWBORDER" = "Show the class-colored borders";
"OPT_SHOWBORDER_DESC" = "A colored border will be displayed around the MUFs representing the unit's class";
"OPT_SHOWCHRONO" = "Show chronometers";
"OPT_SHOWCHRONO_DESC" = "The number of seconds elapsed since a unit has been afflicted is displayed";
"OPT_MAXMFS"  = "Max units shown";
"OPT_MAXMFS_DESC" = "Defines the max number of micro unit frame to display";
"OPT_UNITPERLINES" = 'Number of units per line';
"OPT_UNITPERLINES_DESC" = "Defines the max number of micro-unit-frames to display per line";
"OPT_MFSCALE" = 'Scale of the micro-unit-frames';
"OPT_MFSCALE_DESC" = "Set the size of the micro-unit-frames";
"OPT_LLSCALE" = 'Scale of the Live-list';
"OPT_LLSCALE_DESC" = "Set the size of the Decursive main bar and of the Live-list (Main bar must be displayed)";
"OPT_SHOWHELP" = "Show help";
"OPT_SHOWHELP_DESC" = "Shows an detailed tooltip when you mouse-over a micro-unit-frame"
"OPT_MFPERFOPT" = "Performance options";
"OPT_MFREFRESHRATE" = 'Refresh rate'
"OPT_MFREFRESHRATE_DESC" = "Time between each refresh call (1 or several micro-unit-frames can be refreshed at once)";
"OPT_MFREFRESHSPEED" = 'Refresh speed';
"OPT_MFREFRESHSPEED_DESC" = "Number of micro-unit-frames to refresh on a single pass";
"OPT_CURINGOPTIONS" = "Curing options";
"OPT_CURINGOPTIONS_DESC" = "Set different aspects of the curing process";
"OPT_ABOLISHCHECK_DESC" = "select whether units with an active 'Abolish' spell are shown and cured";
"OPT_DONOTBLPRIO_DESC" = "Prioritized units won't be blacklisted";
"OPT_RANDOMORDER_DESC" = "Units will be displayed and cured randomly (not recommended)";
"OPT_CUREPETS_DESC" = "Pets will be managed and cured";
"OPT_IGNORESTEALTHED_DESC" = "Cloaked units will be ignored";
"OPT_CURINGORDEROPTIONS" = "Curing Order Options";
"OPT_MAGICCHECK_DESC"	= "If checked you'll be able to see and cure magic afflicted units";
"OPT_MAGICCHARMEDCHECK_DESC" = "If checked you'll be able to see and cure magic-charmed units";
"OPT_CHARMEDCHECK_DESC" = "If checked you'll be able to see and deal with charmed units";
"OPT_POISONCHECK_DESC" = "If checked you'll be able to see and cure poisoned units";
"OPT_DISEASECHECK_DESC" = "If checked you'll be able to see and cure diseased units";
"OPT_CURSECHECK_DESC" = "If checked you'll be able to see and cure cursed units";
"OPT_DEBUFFFILTER" = "Affliction filtering";
"OPT_DEBUFFFILTER_DESC" = "Select afflictions to filter out by name and class while you are in combat";
"OPT_MACROOPTIONS" = "Macro options";
"OPT_MACROOPTIONS_DESC" = "Set the behaviour of the macro created by Decursive";
"OPT_MACROBIND" = "Set the macro binding key";
"OPT_MACROBIND_DESC" = "Defines the key on which the 'Decursive' macro will be called.\n\nPress the key and hit your 'Enter' keyboard key to save the new assignment (with your mouse cursor over the edit field)";
"OPT_RESETOPTIONS" = "Reset options to defaults";
"OPT_RESETOPTIONS_DESC" =  "Reset the current profile to the default values";
"OPT_REMOVESKDEBCONF" = "Are you sure you want to remove\n '%s' \nfrom Decursive's affliction skip list?";
"OPT_RESTPROFILECONF" = "Are you sure you want to reset the profile\n '(%s) %s'\n to default options?";
"OPT_PROFILERESET" = "Profile reset...";
"OPT_AFFLICTEDBYSKIPPED" = "%s afflicted by %s will be skipped";
"OPT_DEBCHECKEDBYDEF" = "\n\nChecked by default";
"OPT_ALWAYSIGNORE" = "Also ignore when not in combat";
"OPT_ALWAYSIGNORE_DESC" = "If checked, this affliction will also be ignored when you are not in combat";
"OPT_REMOVETHISDEBUFF" = "Remove this affliction";
"OPT_REMOVETHISDEBUFF_DESC" = "Removes '%s' from the skip list";
"OPT_RESETDEBUFF" = "Reset this affliction";
"OPT_RESETDTDCRDEFAULT" = "Resets '%s' to Decursive default";
"OPT_USERDEBUFF" = "This affliction is not part of Decursive's default afflictions";
"OPT_DEBUFFENTRY_DESC" = "Select what class should be ignored in combat when afflicted by this affliction";
"OPT_ADDDEBUFF" = "Add a custom affliction";
"OPT_ADDDEBUFF_DESC" = "Adds a new affliction to this list";
"OPT_ADDDEBUFF_USAGE" = "<Affliction name>";
"OPT_READDDEFAULTSD" = "Re-add default afflictions";
"OPT_READDDEFAULTSD_DESC1" = "Add missing Decursive's default afflictions to this list\nYour settings won't be changed";
"OPT_READDDEFAULTSD_DESC2" = "All Decursive's default afflictions are in this list";

"OPT_LVONLYINRANGE" = "Units in range only";
"OPT_LVONLYINRANGE_DESC" = "Only units in dispel range will be shown in the live-list";

"OPT_MFALPHA" = "Transparency";
"OPT_MFALPHA_DESC" = "Defines the transparency of the MUFs when units are not afflicted";

"OPT_LLALPHA" = "Live-list transparency";
"OPT_LLALPHA_DESC" = "Changes Decursive main bar and live-list transparency (Main bar must be displayed)";

"OPT_ADVDISP" = "Advance display Options";
"OPT_ADVDISP_DESC" = "Allow to set Transparency of the border and center separately, to set the space between each MUF";
"OPT_TIECENTERANDBORDER" = "Tie center and border transparency";
"OPT_TIECENTERANDBORDER_OPT" = "The transparency of the border is half the center transparency when checked";
"OPT_BORDERTRANSP" = "Border transparency";
"OPT_BORDERTRANSP_DESC" = "Set the transparency of the border";
"OPT_CENTERTRANSP" = "Center transparency";
"OPT_CENTERTRANSP_DESC" = "Set the transparency of the center";
"OPT_TIEXYSPACING" = "Tie horizontal and vertical spacing";
"OPT_TIEXYSPACING_DESC" = "The horizontal and vertical space between MUFs are the same";
"OPT_XSPACING" = "Horizontal spacing";
"OPT_XSPACING_DESC" = "Set the Horizontal space between MUFs";
"OPT_YSPACING" = "Vertical spacing";
"OPT_YSPACING_DESC" = "Set the Vertical space between MUFs";

"OPT_SHOWMINIMAPICON" = "Minimap Icon";
"OPT_SHOWMINIMAPICON_DESC" = "Toggle the minimap icon.";



"HLP_LL_ONCLICK_TEXT" = "Clicking on the live-list is useless since WoW 2.0. You should read the FAQ in the \"Readme.txt\" file located in Decursive folder...\n(To move this list move the Decursive bar, /dcrshow and left-alt-click to move)";
"HLP_LEFTCLICK" = "Left-Click";
"HLP_RIGHTCLICK" = "Right-Click";
"HLP_MIDDLECLICK" = "Middle-Click";

"HLP_NOTHINGTOCURE" = "There is nothing to cure!";
"HLP_WRONGMBUTTON" = "Wrong mouse button!";
"HLP_USEXBUTTONTOCURE" = "Use \"%s\" to cure this affliction!";
  
"CTRL" = "Ctrl";
"ALT" = "ALt";
"SHIFT" = "Shift";

"TARGETUNIT" = "Target Unit";
"FOCUSUNIT" = "Focus Unit";

"ABSENT" = "Missing (%s)";
"TOOFAR" = "Too far";
"NORMAL" = "Normal";
"STEALTHED" = "cloaked";
"BLACKLISTED" = "Black-listed";
"UNITSTATUS" = "Unit Status: ";
"AFFLICTEDBY" = "%s Afflicted";

"SUCCESSCAST" = "|cFF22FFFF%s %s|r |cFF00AA00succeeded on|r %s";
"FAILEDCAST" = "|cFF22FFFF%s %s|r |cFFAA0000failed on|r %s\n|cFF00AAAA%s|r";

"HANDLEHELP" = "Drag all the Micro-UnitFrames (MUFs)";

"MACROKEYALREADYMAPPED" = "WARNING: The key mapped to Decursive macro [%s] was mapped to action '%s'.\nDecursive will restore the previous mapping if you set another key for its macro.";
"MACROKEYMAPPINGSUCCESS" = "The key [%s] has been successfully mapped to Decursive macro.";
"MACROKEYMAPPINGFAILED" = "The key [%s] could not be mapped to Decursive macro!";
"MACROKEYNOTMAPPED" = "Decursive mouse-over macro is not mapped to a key, take a look at the 'Macro' options!";

"DEFAULT_MACROKEY" = "`"; -- the key just beneath the escape key on a QWERTY keyboard
"OPT_NOKEYWARN" = "Warn if no key";
"OPT_NOKEYWARN_DESC" = "Display a warning if no key is mapped.";
"NOSPELL" = "No spell available";

"FUBARMENU" = "FuBar Menu";
"FUBARMENU_DESC" = "Set options relative to FuBar icon";


"GLOR1" = "In memory of Glorfindal";
"GLOR2" = "Decursive is dedicated to the memory of Bertrand who left way too soon.\nHe will always be remembered.";
"GLOR3" = "In remembrance of Bertrand Sense\n1969 - 2007";
"GLOR4" =  "Friendship and affection can take their roots anywhere, those who met Glorfindal in World of Warcraft knew a man of great commitment and a charismatic leader.\n\nHe was in life as he was in game, selfless, generous, dedicated to his friends and most of all, a passionate man.\n\nHe left us at the age of 38 leaving behind him not just anonymous players in a virtual world but, a group of true friends who will miss him forever.";
"GLOR5" = "He will always be remembered...";

"DISABLEWARNING" = "Decursive has been disabled!\n\nTo enable it again, type |cFFFFAA44/DCR STANDBY|r";


-- Acelocal register for enUS // {{{
local L = Dcr.L;
L:RegisterTranslations("enUS", function() return {


    ["CLASS_DRUID"]	=	true,
    ["CLASS_HUNTER"]	=	true,
    ["CLASS_MAGE"]	=	true,
    ["CLASS_PALADIN"]	=	true,
    ["CLASS_PRIEST"]	=	true,
    ["CLASS_ROGUE"]	=	true,
    ["CLASS_SHAMAN"]	=	true,
    ["CLASS_WARLOCK"]	=	true,
    ["CLASS_WARRIOR"]	=	true,
    ["CLASS_DEATHKNIGHT"]=	true,

    ["DISEASE"]	    =	true,
    ["MAGIC"]	    =	true,
    ["POISON"]	    =	true,
    ["CURSE"]	    =	true,
    ["MAGICCHARMED"]  =	true,
    ["CHARMED"]	    =	true,

    -------------------------------------------------------------------------------
    -- English localization (Default)
    -------------------------------------------------------------------------------


    ["STR_OTHER"]		=	true,
    ["STR_OPTIONS"]	=	true,
    ["STR_CLOSE"]		=	true,
    ["STR_DCR_PRIO"]	=	true,
    ["STR_DCR_SKIP"]	=	true,
    ["STR_QUICK_POP"]	=	true,
    ["STR_POP"]		=	true,
    ["STR_GROUP"]		=	true,




    ["PRIORITY_SHOW"]	=	true,
    ["POPULATE"]		=	true,
    ["SKIP_SHOW"]		=	true,
    ["CLEAR_PRIO"]	=	true,
    ["CLEAR_SKIP"]	=	true,

    ["PET_FEL_CAST"]	=	true,
    ["PET_DOOM_CAST"]	=	true,

    ["SPELL_POLYMORPH"]		=	true,
    ["SPELL_CURE_DISEASE"]	=	true,
    ["SPELL_ABOLISH_DISEASE"]	=	true,
    ["SPELL_PURIFY"]		=	true,
    ["SPELL_CLEANSE"]		=	true,
    ["SPELL_DISPELL_MAGIC"]	=	true,
    ["SPELL_CURE_POISON"]		=	true,
    ["SPELL_ABOLISH_POISON"]	=	true,
    ["SPELL_REMOVE_LESSER_CURSE"]	=	true,
    ["SPELL_REMOVE_CURSE"]	=	true,
    ["SPELL_PURGE"]	=	true,
    ["SPELL_CYCLONE"]	=	true,
    ["CLEANSE_SPIRIT"]	=	true,

    ["BINDING_NAME_DCRSHOW"]	=	true,
    
    ["BINDING_NAME_DCRMUFSHOWHIDE"] =	true,

    ["BINDING_NAME_DCRPRADD"]	=	true,
    ["BINDING_NAME_DCRPRCLEAR"]	=	true,
    ["BINDING_NAME_DCRPRLIST"]	=	true,
    ["BINDING_NAME_DCRPRSHOW"]	=	true,

    ["BINDING_NAME_DCRSKADD"]	=	true,
    ["BINDING_NAME_DCRSKCLEAR"]	=	true,
    ["BINDING_NAME_DCRSKLIST"]	=	true,
    ["BINDING_NAME_DCRSKSHOW"]	=	true,
    
    ["BINDING_NAME_DCRSHOWOPTION"]=	true,



    ["PRIORITY_LIST"]	=	true,
    ["SKIP_LIST_STR"]	=	true,
    ["OPTION_MENU"]	=	true,
    ["POPULATE_LIST"]	=	true,
    ["LIST_ENTRY_ACTIONS"]=	true,
    ["HIDE_MAIN"]		=	true,
    ["SHOW_MSG"]		=	true,
    ["IS_HERE_MSG"]	=	true,

    ["PRINT_CHATFRAME"]	=	true,
    ["PRINT_CUSTOM"]	=	true,
    ["PRINT_ERRORS"]	=	true,

    ["SHOW_TOOLTIP"]	=	true,
    ["REVERSE_LIVELIST"]	=	true,
    ["TIE_LIVELIST"]	=	true,
    ["HIDE_LIVELIST"]	=	true,

    ["AMOUNT_AFFLIC"]	=	true,
    ["BLACK_LENGTH"]	=	true,
    ["SCAN_LENGTH"]	=	true,
    ["ABOLISH_CHECK"]	=	true,
    ["RANDOM_ORDER"]	=	true,
    ["CURE_PETS"]		=	true,
    ["IGNORE_STEALTH"]	=	true,
    ["PLAY_SOUND"]	=	true,
    ["ANCHOR"]		=	true,
    ["DONOT_BL_PRIO"]	=	true,

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    ["SPELL_FOUND"]	=	true,

    -- spells and potions
    ["DREAMLESSSLEEP"] = true,
    ["GDREAMLESSSLEEP"] = true,
    ["MDREAMLESSSLEEP"] = true,
    ["ANCIENTHYSTERIA"] = true,
    ["IGNITE"] = true,
    ["TAINTEDMIND"] = true,
    ["MAGMASHAKLES"] = true,
    ["CRIPLES"] = true,
    ["DUSTCLOUD"] = true,
    ["WIDOWSEMBRACE"] = true,
    ["CURSEOFTONGUES"] = true,
    ["SONICBURST"] = true,
    ["THUNDERCLAP"] = true,
    ["DELUSIONOFJINDO"] = true,
    ["MUTATINGINJECTION"] = true,
    -- NEW LOCALS FOR 2.0
    ["DEFAULT_MACROKEY"] = true,
    ["OPT_LIVELIST"] = true,
    ["OPT_LIVELIST_DESC"] = true,
    ["OPT_HIDELIVELIST_DESC"] = true,
    ["OPT_SHOWTOOLTIP_DESC"] = true,
    ["OPT_PLAYSOUND_DESC"] = true,
    ["OPT_AMOUNT_AFFLIC_DESC"] = true,
    ["OPT_BLACKLENTGH_DESC"] = true,
    ["OPT_SCANLENGTH_DESC"] = true,
    ["OPT_REVERSE_LIVELIST_DESC"] = true,
    ["OPT_TIE_LIVELIST_DESC"] = true,
    ["OPT_CREATE_VIRTUAL_DEBUFF"] = true,
    ["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = true,
    ["OPT_MESSAGES"] = true,
    ["OPT_MESSAGES_DESC"] = true,
    ["OPT_CHATFRAME_DESC"] = true,
    ["OPT_PRINT_CUSTOM_DESC"] = true,
    ["OPT_PRINT_ERRORS_DESC"] = true,
    ["OPT_ANCHOR_DESC"] = true,
    ["OPT_MFSETTINGS"] = true,
    ["OPT_MFSETTINGS_DESC"] = true,
    ["OPT_DISPLAYOPTIONS"] = true,
    ["OPT_SHOWMFS"] = true,
    ["OPT_SHOWMFS_DESC"] = true,

    ["OPT_AUTOHIDEMFS"] = true,
    ["OPT_AUTOHIDEMFS_DESC"] = true,
    ["OPT_HIDEMFS_SOLO"] = true,
    ["OPT_HIDEMFS_SOLO_DESC"] = true,
    ["OPT_HIDEMFS_GROUP"] = true,
    ["OPT_HIDEMFS_GROUP_DESC"] = true,
    ["OPT_HIDEMFS_NEVER"] = true,
    ["OPT_HIDEMFS_NEVER_DESC"] = true,

    ["OPT_ADDDEBUFFFHIST"]		= true,
    ["OPT_ADDDEBUFFFHIST_DESC"]	= true,

    ["OPT_GROWDIRECTION"] = true,
    ["OPT_GROWDIRECTION_DESC"] = true,

    ["OPT_STICKTORIGHT_DESC"]	= true,
    ["OPT_STICKTORIGHT"]	= true,
    ["OPT_MUFSCOLORS_DESC"]	= true,
    ["OPT_MUFSCOLORS"]	= true,
    ["MISSINGUNIT"]		= true,
    ["COLORALERT"]		= true,
    ["COLORSTATUS"]		= true,
    ["COLORCHRONOS"]		= true,
    ["COLORCHRONOS_DESC"]	= true,

    ["OPT_MUFSCOLORS"] = true,
    ["OPT_SHOWBORDER"] = true,
    ["OPT_SHOWBORDER_DESC"] = true,
    ["OPT_SHOWCHRONO"] = true,
    ["OPT_SHOWCHRONO_DESC"] = true,
    ["OPT_MAXMFS"] = true,
    ["OPT_MAXMFS_DESC"] = true,
    ["OPT_UNITPERLINES"] = true,
    ["OPT_UNITPERLINES_DESC"] = true,
    ["OPT_MFSCALE"] = true,
    ["OPT_MFSCALE_DESC"] = true,
    ["OPT_LLSCALE"] = true,
    ["OPT_LLSCALE_DESC"] = true,
    ["OPT_SHOWHELP"] = true,
    ["OPT_SHOWHELP_DESC"] = true,
    ["OPT_MFPERFOPT"] = true,
    ["OPT_MFREFRESHRATE"] = true,
    ["OPT_MFREFRESHRATE_DESC"] = true,
    ["OPT_MFREFRESHSPEED"] = true,
    ["OPT_MFREFRESHSPEED_DESC"] = true,
    ["OPT_CURINGOPTIONS"] = true,
    ["OPT_CURINGOPTIONS_DESC"] = true,
    ["OPT_ABOLISHCHECK_DESC"] = true,
    ["OPT_DONOTBLPRIO_DESC"] = true,
    ["OPT_RANDOMORDER_DESC"] = true,
    ["OPT_CUREPETS_DESC"] = true,
    ["OPT_IGNORESTEALTHED_DESC"] = true,
    ["OPT_CURINGORDEROPTIONS"] = true,
    ["OPT_MAGICCHECK_DESC"] = true,
    ["OPT_MAGICCHARMEDCHECK_DESC"] = true,
    ["OPT_CHARMEDCHECK_DESC"] = true,
    ["OPT_POISONCHECK_DESC"] = true,
    ["OPT_DISEASECHECK_DESC"] = true,
    ["OPT_CURSECHECK_DESC"] = true,
    ["OPT_DEBUFFFILTER"] = true,
    ["OPT_DEBUFFFILTER_DESC"] = true,
    ["OPT_MACROOPTIONS"] = true,
    ["OPT_MACROOPTIONS_DESC"] = true,
    ["OPT_MACROBIND"] = true,
    ["OPT_MACROBIND_DESC"] = true,
    ["OPT_RESETOPTIONS"] = true,
    ["OPT_RESETOPTIONS_DESC"] = true,
    ["OPT_REMOVESKDEBCONF"] = true,
    ["OPT_RESTPROFILECONF"] = true,
    ["OPT_PROFILERESET"] = true,
    ["OPT_AFFLICTEDBYSKIPPED"] = true,
    ["OPT_DEBCHECKEDBYDEF"] = true,
    ["OPT_ALWAYSIGNORE"] = true,
    ["OPT_ALWAYSIGNORE_DESC"] = true,
    ["OPT_REMOVETHISDEBUFF"] = true,
    ["OPT_REMOVETHISDEBUFF_DESC"] = true,
    ["OPT_RESETDEBUFF"] = true,
    ["OPT_RESETDTDCRDEFAULT"] = true,
    ["OPT_USERDEBUFF"] = true,
    ["OPT_DEBUFFENTRY_DESC"] = true,
    ["OPT_ADDDEBUFF"] = true,
    ["OPT_ADDDEBUFF_DESC"] = true,
    ["OPT_ADDDEBUFF_USAGE"] = true,
    ["OPT_READDDEFAULTSD"] = true,
    ["OPT_READDDEFAULTSD_DESC1"] = true,
    ["OPT_READDDEFAULTSD_DESC2"] = true,

    ["OPT_LVONLYINRANGE"] = true,
    ["OPT_LVONLYINRANGE_DESC"] = true,
    
    ["OPT_MFALPHA"] = true,
    ["OPT_MFALPHA_DESC"] = true,

    ["OPT_LLALPHA"] = true,
    ["OPT_LLALPHA_DESC"] = true,

   
    ["OPT_ADVDISP"]		 = true,
    ["OPT_ADVDISP_DESC"]		 = true,
    ["OPT_TIECENTERANDBORDER"]	 = true,
    ["OPT_TIECENTERANDBORDER_OPT"] = true,
    ["OPT_BORDERTRANSP"]		 = true,
    ["OPT_BORDERTRANSP_DESC"]	 = true,
    ["OPT_CENTERTRANSP"]		 = true,
    ["OPT_CENTERTRANSP_DESC"]	 = true,
    ["OPT_TIEXYSPACING"]		 = true,
    ["OPT_TIEXYSPACING_DESC"]	 = true,
    ["OPT_XSPACING"]		 = true,
    ["OPT_XSPACING_DESC"]		 = true,
    ["OPT_YSPACING"]		 = true,
    ["OPT_YSPACING_DESC"]		 = true,
    ["OPT_SHOWMINIMAPICON"]		 = true,
    ["OPT_SHOWMINIMAPICON_DESC"]	 = true,


    ["HLP_LL_ONCLICK_TEXT"] = true,
    ["HLP_LEFTCLICK"] = true,
    ["HLP_RIGHTCLICK"] = true,
    ["HLP_MIDDLECLICK"] = true,

    ["HLP_NOTHINGTOCURE"] = true,
    ["HLP_WRONGMBUTTON"] = true,
    ["HLP_USEXBUTTONTOCURE"] = true,

    ["CTRL"] = true,
    ["ALT"] = true,
    ["SHIFT"] = true,

    ["TARGETUNIT"] = true,
    ["FOCUSUNIT"] = true,
    
    ["ABSENT"] = true,
    ["TOOFAR"] = true,
    ["NORMAL"] = true,
    ["STEALTHED"] = true,
    ["BLACKLISTED"] = true,
    ["UNITSTATUS"] = true,
    ["AFFLICTEDBY"] = true,
    
    ["SUCCESSCAST"] = true,
    ["FAILEDCAST"] = true,
    ["HANDLEHELP"] = true,

    ["MACROKEYALREADYMAPPED"] = true,
    ["MACROKEYMAPPINGSUCCESS"] = true,
    ["MACROKEYMAPPINGFAILED"] = true,
    ["MACROKEYNOTMAPPED"] = true,

    ["OPT_NOKEYWARN"] = true,
    ["OPT_NOKEYWARN_DESC"] = true,
    ["NOSPELL"] = true,

    ["FUBARMENU"]  = true,
    ["FUBARMENU_DESC"]  = true,

    ["GLOR1"] = true,
    ["GLOR2"] = true,
    ["GLOR3"] = true,
    ["GLOR4"] = true,
    ["GLOR5"] = true,
    -- OPTIONS

    ["DISABLEWARNING"] = true,

} end);

-- // }}}


DcrLoadedFiles["enUS.lua"] = "@project-version@";
