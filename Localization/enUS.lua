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

LOC.DISEASE = 'Disease';
LOC.MAGIC   = 'Magic';
LOC.POISON  = 'Poison';
LOC.CURSE   = 'Curse';
LOC.MAGICCHARMED = 'Magic Charm';
LOC.CHARMED = 'Charm';


LOC.CLASS_DRUID   = 'Druid';
LOC.CLASS_HUNTER  = 'Hunter';
LOC.CLASS_MAGE    = 'Mage';
LOC.CLASS_PALADIN = 'Paladin';
LOC.CLASS_PRIEST  = 'Priest';
LOC.CLASS_ROGUE   = 'Rogue';
LOC.CLASS_SHAMAN  = 'Shaman';
LOC.CLASS_WARLOCK = 'Warlock';
LOC.CLASS_WARRIOR = 'Warrior';
LOC.CLASS_DEATHKNIGHT = 'Deathknight';

LOC.STR_OTHER	    = 'Other';
LOC.STR_OPTIONS	    = "Decursive's Options";
LOC.STR_CLOSE	    = 'Close';
LOC.STR_DCR_PRIO    = 'Decursive Priority';
LOC.STR_DCR_SKIP    = 'Decursive Skip';
LOC.STR_QUICK_POP   = 'Quickly Populate';
LOC.STR_POP	    = 'Populate List';
LOC.STR_GROUP	    = 'Group ';




LOC.PRIORITY_SHOW   = 'P';
LOC.POPULATE	    = 'p';
LOC.SKIP_SHOW	    = 'S';
LOC.CLEAR_PRIO	    = 'C';
LOC.CLEAR_SKIP	    = 'C';





LOC.PET_FEL_CAST  = "Devour Magic"; -- NO NEED TO TRANSLATE
LOC.PET_DOOM_CAST = "Dispel Magic"; -- NO NEED TO TRANSLATE


LOC.SPELL_POLYMORPH	      = 'Polymorph'; -- NO NEED TO TRANSLATE
LOC.SPELL_CURE_DISEASE        = 'Cure Disease'; -- NO NEED TO TRANSLATE
LOC.SPELL_ABOLISH_DISEASE     = 'Abolish Disease'; -- NO NEED TO TRANSLATE
LOC.SPELL_PURIFY              = 'Purify'; -- NO NEED TO TRANSLATE
LOC.SPELL_CLEANSE             = 'Cleanse'; -- NO NEED TO TRANSLATE
LOC.SPELL_DISPELL_MAGIC       = 'Dispel Magic'; -- NO NEED TO TRANSLATE
LOC.SPELL_CURE_POISON         = 'Cure Poison'; -- NO NEED TO TRANSLATE
LOC.SPELL_ABOLISH_POISON      = 'Abolish Poison';-- NO NEED TO TRANSLATE
LOC.SPELL_REMOVE_LESSER_CURSE = 'Remove Lesser Curse'; -- NO NEED TO TRANSLATE
LOC.SPELL_REMOVE_CURSE        = 'Remove Curse'; -- NO NEED TO TRANSLATE
LOC.SPELL_PURGE               = 'Purge'; -- NO NEED TO TRANSLATE
LOC.SPELL_CYCLONE	      = 'Cyclone'; -- NO NEED TO TRANSLATE
LOC.CLEANSE_SPIRIT	      = "Cleanse Spirit"; -- NO NEED TO TRANSLATE

LOC.BINDING_NAME_DCRSHOW    = "Show or hide Decursive Main Bar\n(live-list anchor)";

LOC.BINDING_NAME_DCRMUFSHOWHIDE = "Show or hide the micro-unit frames";

LOC.BINDING_NAME_DCRPRADD     = "Add target to priority list";
LOC.BINDING_NAME_DCRPRCLEAR   = "Clear the priority list";
LOC.BINDING_NAME_DCRPRLIST    = "Print the priority list";
LOC.BINDING_NAME_DCRPRSHOW    = "Show or hide the priority list";

LOC.BINDING_NAME_DCRSKADD   = "Add target to skip list";
LOC.BINDING_NAME_DCRSKCLEAR = "Clear the skip list";
LOC.BINDING_NAME_DCRSKLIST  = "Print the skip list";
LOC.BINDING_NAME_DCRSKSHOW  = "Show or hide the skip list";
LOC.BINDING_NAME_DCRSHOWOPTION = "Display the option static panel";


LOC.PRIORITY_LIST  = "Decursive Priority List";
LOC.SKIP_LIST_STR  = "Decursive Skip List";
LOC.OPTION_MENU   = "Decursive Options Menu";
LOC.POPULATE_LIST  = "Quickly populate the Decursive list";
LOC.LIST_ENTRY_ACTIONS     = "|cFF33AA33[CTRL]|r-Click: Remove this player\n|cFF33AA33LEFT|r-Click: Rise this player\n|cFF33AA33RIGHT|r-Click: Come down this player\n|cFF33AA33[SHIFT] LEFT|r-Click: Put this player at the top\n|cFF33AA33[SHIFT] RIGHT|r-Click: Put this player at the bottom";
LOC.HIDE_MAIN      = "Hide Decursive Window";
LOC.SHOW_MSG	   = "To show Decursive's frame, type /dcrshow";
LOC.IS_HERE_MSG	   = "Decursive is now initialized, remember to check the options";

LOC.PRINT_CHATFRAME = "Print messages in default chat";
LOC.PRINT_CUSTOM    = "Print messages in the window";
LOC.PRINT_ERRORS    = "Print error messages";

LOC.SHOW_TOOLTIP    = "Show Tooltips on afflicted units";
LOC.REVERSE_LIVELIST= "Reverse live-list display";
LOC.HIDE_LIVELIST   = "Hide the live-list";
LOC.TIE_LIVELIST    = "Tie live-list visibility to DCR window";
LOC.OPT_CREATE_VIRTUAL_DEBUFF = "Create a virtual test affliction";
LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC = "Lets you see how it looks like when an affliction is found";

LOC.AMOUNT_AFFLIC   = "The amount of afflicted to show : ";
LOC.BLACK_LENGTH    = "Seconds on the blacklist : ";
LOC.SCAN_LENGTH     = "Seconds between live scans : ";
LOC.ABOLISH_CHECK   = "Check for \"Abolish\" before curing";
LOC.RANDOM_ORDER    = "Cure in a random order";
LOC.CURE_PETS       = "Scan and cure pets";
LOC.IGNORE_STEALTH  = "Ignore cloaked Units";
LOC.PLAY_SOUND	    = "Play a sound when there is someone to cure";
LOC.ANCHOR          = "Decursive Text Anchor";
LOC.DONOT_BL_PRIO   = "Don't blacklist priority list names";

LOC.SPELL_FOUND      = "%s spell found!";



-- spells and potions
LOC.DREAMLESSSLEEP	= "Dreamless Sleep";		-- NO NEED TO TRANSLATE 
LOC.GDREAMLESSSLEEP	= "Greater Dreamless Sleep";	-- NO NEED TO TRANSLATE 
LOC.MDREAMLESSSLEEP	= "Major Dreamless Sleep";	-- NO NEED TO TRANSLATE
LOC.ANCIENTHYSTERIA	= "Ancient Hysteria";		-- NO NEED TO TRANSLATE
LOC.IGNITE		= "Ignite Mana";		-- NO NEED TO TRANSLATE
LOC.TAINTEDMIND		= "Tainted Mind";		-- NO NEED TO TRANSLATE
LOC.MAGMASHAKLES	= "Magma Shackles";		-- NO NEED TO TRANSLATE
LOC.CRIPLES		= "Cripple";			-- NO NEED TO TRANSLATE
LOC.DUSTCLOUD		= "Dust Cloud";			-- NO NEED TO TRANSLATE
LOC.WIDOWSEMBRACE	= "Widow's Embrace";		-- NO NEED TO TRANSLATE
LOC.CURSEOFTONGUES	= "Curse of Tongues";		-- NO NEED TO TRANSLATE
LOC.SONICBURST		= "Sonic Burst";		-- NO NEED TO TRANSLATE
LOC.THUNDERCLAP		= "Thunderclap";		-- NO NEED TO TRANSLATE -- unused
LOC.DELUSIONOFJINDO	= "Delusions of Jin'do";	-- NO NEED TO TRANSLATE
LOC.MUTATINGINJECTION	= "Mutating Injection";		-- NO NEED TO TRANSLATE
LOC.DCR_LOC_SILENCE	= "Silence";			-- NO NEED TO TRANSLATE
LOC.DCR_LOC_MINDVISION	= "Mind Vision";		-- NO NEED TO TRANSLATE

-- NEW LOCALS FOR 2.0


LOC.OPT_LIVELIST = "Live list";
LOC.OPT_LIVELIST_DESC = "Options for the live list";
LOC.OPT_HIDELIVELIST_DESC = "If not hidden, displays an informative list of cursed people";
LOC.OPT_SHOWTOOLTIP_DESC = "Shows a detailed tooltips about curses in the live-list and on the MUFs";
LOC.OPT_PLAYSOUND_DESC  = "Play a sound if someone get cursed";
LOC.OPT_AMOUNT_AFFLIC_DESC = "Defines the max number of cursed to display in the live-list";
LOC.OPT_BLACKLENTGH_DESC =  "Defines how long someone stays on the blacklist";
LOC.OPT_SCANLENGTH_DESC = "Defines the time between each scan";
LOC.OPT_REVERSE_LIVELIST_DESC = "The live-list fills itself from bottom to top";
LOC.OPT_TIE_LIVELIST_DESC = "The live-list display is tied to \"Decursive\" bar display";
LOC.OPT_MESSAGES	= "Messages";
LOC.OPT_MESSAGES_DESC = "Options about messages display";
LOC.OPT_CHATFRAME_DESC = "Decursive's messages will be printed to the default chat frame";
LOC.OPT_PRINT_CUSTOM_DESC = "Decursive's messages will be printed in a custom chat frame";
LOC.OPT_PRINT_ERRORS_DESC = "Errors will be displayed";
LOC.OPT_ANCHOR_DESC	= "Shows the anchor of the custom message frame";
LOC.OPT_MFSETTINGS = "Micro Unit Frame Settings";
LOC.OPT_MFSETTINGS_DESC = "Set the micro units frame window options to suit your needs";
LOC.OPT_DISPLAYOPTIONS = "Display options";

LOC.OPT_SHOWMFS = "Show the Micro Units Frame";
LOC.OPT_SHOWMFS_DESC = "This must be enabled if you want to cure by clicking";

LOC.OPT_AUTOHIDEMFS	    = "Auto-Hide";
LOC.OPT_AUTOHIDEMFS_DESC    = "Choose when to hide the MUF window";

LOC.OPT_HIDEMFS_SOLO		= "Solo";
LOC.OPT_HIDEMFS_SOLO_DESC	= "Hide the MUF window when you are not in a party or raid";

LOC.OPT_HIDEMFS_GROUP		= "Solo/Party";
LOC.OPT_HIDEMFS_GROUP_DESC	= "Hide the MUF window when you are not in a raid";

LOC.OPT_HIDEMFS_NEVER		= "Never";
LOC.OPT_HIDEMFS_NEVER_DESC	= "Never auto-hide the MUF window";

LOC.OPT_ADDDEBUFFFHIST		= "Add a recent affliction";
LOC.OPT_ADDDEBUFFFHIST_DESC	= "Add an affliction using the history";

LOC.OPT_GROWDIRECTION = "Reverse MUFs Display";
LOC.OPT_GROWDIRECTION_DESC = "The MUFs will be displayed from bottom to top";

LOC.OPT_STICKTORIGHT = "Align MUF window to the right";
LOC.OPT_STICKTORIGHT_DESC = "The MUF window will grow from right to left, the handle will be moved as necessary.";
LOC.OPT_MUFSCOLORS = "Colors";
LOC.OPT_MUFSCOLORS_DESC = "Change the colors of the Micro Unit Frames.";
LOC.MISSINGUNIT = "Missing unit";
LOC.COLORALERT = "Set the color alert when a '%s' is required.";
LOC.COLORSTATUS = "Set the color for the '%s' MUF status.";
LOC.COLORCHRONOS = "Chronometers";
LOC.COLORCHRONOS_DESC = "Set the chronometers' color";

LOC.OPT_SHOWBORDER = "Show the class-colored borders";
LOC.OPT_SHOWBORDER_DESC = "A colored border will be displayed around the MUFs representing the unit's class";
LOC.OPT_SHOWCHRONO = "Show chronometers";
LOC.OPT_SHOWCHRONO_DESC = "The number of seconds elapsed since a unit has been afflicted is displayed";
LOC.OPT_MAXMFS  = "Max units shown";
LOC.OPT_MAXMFS_DESC = "Defines the max number of micro unit frame to display";
LOC.OPT_UNITPERLINES = 'Number of units per line';
LOC.OPT_UNITPERLINES_DESC = "Defines the max number of micro-unit-frames to display per line";
LOC.OPT_MFSCALE = 'Scale of the micro-unit-frames';
LOC.OPT_MFSCALE_DESC = "Set the size of the micro-unit-frames";
LOC.OPT_LLSCALE = 'Scale of the Live-list';
LOC.OPT_LLSCALE_DESC = "Set the size of the Decursive main bar and of the Live-list (Main bar must be displayed)";
LOC.OPT_SHOWHELP = "Show help";
LOC.OPT_SHOWHELP_DESC = "Shows an detailed tooltip when you mouse-over a micro-unit-frame"
LOC.OPT_MFPERFOPT = "Performance options";
LOC.OPT_MFREFRESHRATE = 'Refresh rate'
LOC.OPT_MFREFRESHRATE_DESC = "Time between each refresh call (1 or several micro-unit-frames can be refreshed at once)";
LOC.OPT_MFREFRESHSPEED = 'Refresh speed';
LOC.OPT_MFREFRESHSPEED_DESC = "Number of micro-unit-frames to refresh on a single pass";
LOC.OPT_CURINGOPTIONS = "Curing options";
LOC.OPT_CURINGOPTIONS_DESC = "Set different aspects of the curing process";
LOC.OPT_ABOLISHCHECK_DESC = "select whether units with an active 'Abolish' spell are shown and cured";
LOC.OPT_DONOTBLPRIO_DESC = "Prioritized units won't be blacklisted";
LOC.OPT_RANDOMORDER_DESC = "Units will be displayed and cured randomly (not recommended)";
LOC.OPT_CUREPETS_DESC = "Pets will be managed and cured";
LOC.OPT_IGNORESTEALTHED_DESC = "Cloaked units will be ignored";
LOC.OPT_CURINGORDEROPTIONS = "Curing Order Options";
LOC.OPT_MAGICCHECK_DESC	= "If checked you'll be able to see and cure magic afflicted units";
LOC.OPT_MAGICCHARMEDCHECK_DESC = "If checked you'll be able to see and cure magic-charmed units";
LOC.OPT_CHARMEDCHECK_DESC = "If checked you'll be able to see and deal with charmed units";
LOC.OPT_POISONCHECK_DESC = "If checked you'll be able to see and cure poisoned units";
LOC.OPT_DISEASECHECK_DESC = "If checked you'll be able to see and cure diseased units";
LOC.OPT_CURSECHECK_DESC = "If checked you'll be able to see and cure cursed units";
LOC.OPT_DEBUFFFILTER = "Affliction filtering";
LOC.OPT_DEBUFFFILTER_DESC = "Select afflictions to filter out by name and class while you are in combat";
LOC.OPT_MACROOPTIONS = "Macro options";
LOC.OPT_MACROOPTIONS_DESC = "Set the behaviour of the macro created by Decursive";
LOC.OPT_MACROBIND = "Set the macro binding key";
LOC.OPT_MACROBIND_DESC = "Defines the key on which the 'Decursive' macro will be called.\n\nPress the key and hit your 'Enter' keyboard key to save the new assignment (with your mouse cursor over the edit field)";
LOC.OPT_RESETOPTIONS = "Reset options to defaults";
LOC.OPT_RESETOPTIONS_DESC =  "Reset the current profile to the default values";
LOC.OPT_REMOVESKDEBCONF = "Are you sure you want to remove\n '%s' \nfrom Decursive's affliction skip list?";
LOC.OPT_RESTPROFILECONF = "Are you sure you want to reset the profile\n '(%s) %s'\n to default options?";
LOC.OPT_PROFILERESET = "Profile reset...";
LOC.OPT_AFFLICTEDBYSKIPPED = "%s afflicted by %s will be skipped";
LOC.OPT_DEBCHECKEDBYDEF = "\n\nChecked by default";
LOC.OPT_ALWAYSIGNORE = "Also ignore when not in combat";
LOC.OPT_ALWAYSIGNORE_DESC = "If checked, this affliction will also be ignored when you are not in combat";
LOC.OPT_REMOVETHISDEBUFF = "Remove this affliction";
LOC.OPT_REMOVETHISDEBUFF_DESC = "Removes '%s' from the skip list";
LOC.OPT_RESETDEBUFF = "Reset this affliction";
LOC.OPT_RESETDTDCRDEFAULT = "Resets '%s' to Decursive default";
LOC.OPT_USERDEBUFF = "This affliction is not part of Decursive's default afflictions";
LOC.OPT_DEBUFFENTRY_DESC = "Select what class should be ignored in combat when afflicted by this affliction";
LOC.OPT_ADDDEBUFF = "Add a custom affliction";
LOC.OPT_ADDDEBUFF_DESC = "Adds a new affliction to this list";
LOC.OPT_ADDDEBUFF_USAGE = "<Affliction name>";
LOC.OPT_READDDEFAULTSD = "Re-add default afflictions";
LOC.OPT_READDDEFAULTSD_DESC1 = "Add missing Decursive's default afflictions to this list\nYour settings won't be changed";
LOC.OPT_READDDEFAULTSD_DESC2 = "All Decursive's default afflictions are in this list";

LOC.OPT_LVONLYINRANGE = "Units in range only";
LOC.OPT_LVONLYINRANGE_DESC = "Only units in dispel range will be shown in the live-list";

LOC.OPT_MFALPHA = "Transparency";
LOC.OPT_MFALPHA_DESC = "Defines the transparency of the MUFs when units are not afflicted";

LOC.OPT_LLALPHA = "Live-list transparency";
LOC.OPT_LLALPHA_DESC = "Changes Decursive main bar and live-list transparency (Main bar must be displayed)";

LOC.OPT_ADVDISP = "Advance display Options";
LOC.OPT_ADVDISP_DESC = "Allow to set Transparency of the border and center separately, to set the space between each MUF";
LOC.OPT_TIECENTERANDBORDER = "Tie center and border transparency";
LOC.OPT_TIECENTERANDBORDER_OPT = "The transparency of the border is half the center transparency when checked";
LOC.OPT_BORDERTRANSP = "Border transparency";
LOC.OPT_BORDERTRANSP_DESC = "Set the transparency of the border";
LOC.OPT_CENTERTRANSP = "Center transparency";
LOC.OPT_CENTERTRANSP_DESC = "Set the transparency of the center";
LOC.OPT_TIEXYSPACING = "Tie horizontal and vertical spacing";
LOC.OPT_TIEXYSPACING_DESC = "The horizontal and vertical space between MUFs are the same";
LOC.OPT_XSPACING = "Horizontal spacing";
LOC.OPT_XSPACING_DESC = "Set the Horizontal space between MUFs";
LOC.OPT_YSPACING = "Vertical spacing";
LOC.OPT_YSPACING_DESC = "Set the Vertical space between MUFs";

LOC.OPT_SHOWMINIMAPICON = "Minimap Icon";
LOC.OPT_SHOWMINIMAPICON_DESC = "Toggle the minimap icon.";



LOC.HLP_LL_ONCLICK_TEXT = "Clicking on the live-list is useless since WoW 2.0. You should read the FAQ in the \"Readme.txt\" file located in Decursive folder...\n(To move this list move the Decursive bar, /dcrshow and left-alt-click to move)";
LOC.HLP_LEFTCLICK = "Left-Click";
LOC.HLP_RIGHTCLICK = "Right-Click";
LOC.HLP_MIDDLECLICK = "Middle-Click";

LOC.HLP_NOTHINGTOCURE = "There is nothing to cure!";
LOC.HLP_WRONGMBUTTON = "Wrong mouse button!";
LOC.HLP_USEXBUTTONTOCURE = "Use \"%s\" to cure this affliction!";
  
LOC.CTRL = "Ctrl";
LOC.ALT = "ALt";
LOC.SHIFT = "Shift";

LOC.TARGETUNIT = "Target Unit";
LOC.FOCUSUNIT = "Focus Unit";

LOC.ABSENT = "Missing (%s)";
LOC.TOOFAR = "Too far";
LOC.NORMAL = "Normal";
LOC.STEALTHED = "cloaked";
LOC.BLACKLISTED = "Black-listed";
LOC.UNITSTATUS = "Unit Status: ";
LOC.AFFLICTEDBY = "%s Afflicted";

LOC.SUCCESSCAST = "|cFF22FFFF%s %s|r |cFF00AA00succeeded on|r %s";
LOC.FAILEDCAST = "|cFF22FFFF%s %s|r |cFFAA0000failed on|r %s\n|cFF00AAAA%s|r";

LOC.HANDLEHELP = "Drag all the Micro-UnitFrames (MUFs)";

LOC.MACROKEYALREADYMAPPED = "WARNING: The key mapped to Decursive macro [%s] was mapped to action '%s'.\nDecursive will restore the previous mapping if you set another key for its macro.";
LOC.MACROKEYMAPPINGSUCCESS = "The key [%s] has been successfully mapped to Decursive macro.";
LOC.MACROKEYMAPPINGFAILED = "The key [%s] could not be mapped to Decursive macro!";
LOC.MACROKEYNOTMAPPED = "Decursive mouse-over macro is not mapped to a key, take a look at the 'Macro' options!";

LOC.DEFAULT_MACROKEY = "`"; -- the key just beneath the escape key on a QWERTY keyboard
LOC.OPT_NOKEYWARN = "Warn if no key";
LOC.OPT_NOKEYWARN_DESC = "Display a warning if no key is mapped.";
LOC.NOSPELL = "No spell available";

LOC.FUBARMENU = "FuBar Menu";
LOC.FUBARMENU_DESC = "Set options relative to FuBar icon";


LOC.GLOR1 = "In memory of Glorfindal";
LOC.GLOR2 = "Decursive is dedicated to the memory of Bertrand who left way too soon.\nHe will always be remembered.";
LOC.GLOR3 = "In remembrance of Bertrand Sense\n1969 - 2007";
LOC.GLOR4 =  "Friendship and affection can take their roots anywhere, those who met Glorfindal in World of Warcraft knew a man of great commitment and a charismatic leader.\n\nHe was in life as he was in game, selfless, generous, dedicated to his friends and most of all, a passionate man.\n\nHe left us at the age of 38 leaving behind him not just anonymous players in a virtual world but, a group of true friends who will miss him forever.";
LOC.GLOR5 = "He will always be remembered...";

LOC.DISABLEWARNING = "Decursive has been disabled!\n\nTo enable it again, type |cFFFFAA44/DCR STANDBY|r";


-- Acelocal register for enUS // {{{
local L = Dcr.L;
L:RegisterTranslations("enUS", function() return {


    [LOC.CLASS_DRUID]	=	true,
    [LOC.CLASS_HUNTER]	=	true,
    [LOC.CLASS_MAGE]	=	true,
    [LOC.CLASS_PALADIN]	=	true,
    [LOC.CLASS_PRIEST]	=	true,
    [LOC.CLASS_ROGUE]	=	true,
    [LOC.CLASS_SHAMAN]	=	true,
    [LOC.CLASS_WARLOCK]	=	true,
    [LOC.CLASS_WARRIOR]	=	true,
    [LOC.CLASS_DEATHKNIGHT]=	true,

    [LOC.DISEASE]	    =	true,
    [LOC.MAGIC]	    =	true,
    [LOC.POISON]	    =	true,
    [LOC.CURSE]	    =	true,
    [LOC.MAGICCHARMED]  =	true,
    [LOC.CHARMED]	    =	true,

    -------------------------------------------------------------------------------
    -- English localization (Default)
    -------------------------------------------------------------------------------


    [LOC.STR_OTHER]		=	true,
    [LOC.STR_OPTIONS]	=	true,
    [LOC.STR_CLOSE]		=	true,
    [LOC.STR_DCR_PRIO]	=	true,
    [LOC.STR_DCR_SKIP]	=	true,
    [LOC.STR_QUICK_POP]	=	true,
    [LOC.STR_POP]		=	true,
    [LOC.STR_GROUP]		=	true,




    [LOC.PRIORITY_SHOW]	=	true,
    [LOC.POPULATE]		=	true,
    [LOC.SKIP_SHOW]		=	true,
    [LOC.CLEAR_PRIO]	=	true,
    [LOC.CLEAR_SKIP]	=	true,

    [LOC.PET_FEL_CAST]	=	true,
    [LOC.PET_DOOM_CAST]	=	true,

    [LOC.SPELL_POLYMORPH]		=	true,
    [LOC.SPELL_CURE_DISEASE]	=	true,
    [LOC.SPELL_ABOLISH_DISEASE]	=	true,
    [LOC.SPELL_PURIFY]		=	true,
    [LOC.SPELL_CLEANSE]		=	true,
    [LOC.SPELL_DISPELL_MAGIC]	=	true,
    [LOC.SPELL_CURE_POISON]		=	true,
    [LOC.SPELL_ABOLISH_POISON]	=	true,
    [LOC.SPELL_REMOVE_LESSER_CURSE]	=	true,
    [LOC.SPELL_REMOVE_CURSE]	=	true,
    [LOC.SPELL_PURGE]	=	true,
    [LOC.SPELL_CYCLONE]	=	true,
    [LOC.CLEANSE_SPIRIT]	=	true,

    [LOC.BINDING_NAME_DCRSHOW]	=	true,
    
    [LOC.BINDING_NAME_DCRMUFSHOWHIDE] =	true,

    [LOC.BINDING_NAME_DCRPRADD]	=	true,
    [LOC.BINDING_NAME_DCRPRCLEAR]	=	true,
    [LOC.BINDING_NAME_DCRPRLIST]	=	true,
    [LOC.BINDING_NAME_DCRPRSHOW]	=	true,

    [LOC.BINDING_NAME_DCRSKADD]	=	true,
    [LOC.BINDING_NAME_DCRSKCLEAR]	=	true,
    [LOC.BINDING_NAME_DCRSKLIST]	=	true,
    [LOC.BINDING_NAME_DCRSKSHOW]	=	true,
    
    [LOC.BINDING_NAME_DCRSHOWOPTION]=	true,



    [LOC.PRIORITY_LIST]	=	true,
    [LOC.SKIP_LIST_STR]	=	true,
    [LOC.OPTION_MENU]	=	true,
    [LOC.POPULATE_LIST]	=	true,
    [LOC.LIST_ENTRY_ACTIONS]=	true,
    [LOC.HIDE_MAIN]		=	true,
    [LOC.SHOW_MSG]		=	true,
    [LOC.IS_HERE_MSG]	=	true,

    [LOC.PRINT_CHATFRAME]	=	true,
    [LOC.PRINT_CUSTOM]	=	true,
    [LOC.PRINT_ERRORS]	=	true,

    [LOC.SHOW_TOOLTIP]	=	true,
    [LOC.REVERSE_LIVELIST]	=	true,
    [LOC.TIE_LIVELIST]	=	true,
    [LOC.HIDE_LIVELIST]	=	true,

    [LOC.AMOUNT_AFFLIC]	=	true,
    [LOC.BLACK_LENGTH]	=	true,
    [LOC.SCAN_LENGTH]	=	true,
    [LOC.ABOLISH_CHECK]	=	true,
    [LOC.RANDOM_ORDER]	=	true,
    [LOC.CURE_PETS]		=	true,
    [LOC.IGNORE_STEALTH]	=	true,
    [LOC.PLAY_SOUND]	=	true,
    [LOC.ANCHOR]		=	true,
    [LOC.DONOT_BL_PRIO]	=	true,

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [LOC.SPELL_FOUND]	=	true,

    -- spells and potions
    [LOC.DREAMLESSSLEEP] = true,
    [LOC.GDREAMLESSSLEEP] = true,
    [LOC.MDREAMLESSSLEEP] = true,
    [LOC.ANCIENTHYSTERIA] = true,
    [LOC.IGNITE] = true,
    [LOC.TAINTEDMIND] = true,
    [LOC.MAGMASHAKLES] = true,
    [LOC.CRIPLES] = true,
    [LOC.DUSTCLOUD] = true,
    [LOC.WIDOWSEMBRACE] = true,
    [LOC.CURSEOFTONGUES] = true,
    [LOC.SONICBURST] = true,
    [LOC.THUNDERCLAP] = true,
    [LOC.DELUSIONOFJINDO] = true,
    [LOC.MUTATINGINJECTION] = true,
    -- NEW LOCALS FOR 2.0
    [LOC.DEFAULT_MACROKEY] = true,
    [LOC.OPT_LIVELIST] = true,
    [LOC.OPT_LIVELIST_DESC] = true,
    [LOC.OPT_HIDELIVELIST_DESC] = true,
    [LOC.OPT_SHOWTOOLTIP_DESC] = true,
    [LOC.OPT_PLAYSOUND_DESC] = true,
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = true,
    [LOC.OPT_BLACKLENTGH_DESC] = true,
    [LOC.OPT_SCANLENGTH_DESC] = true,
    [LOC.OPT_REVERSE_LIVELIST_DESC] = true,
    [LOC.OPT_TIE_LIVELIST_DESC] = true,
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = true,
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = true,
    [LOC.OPT_MESSAGES] = true,
    [LOC.OPT_MESSAGES_DESC] = true,
    [LOC.OPT_CHATFRAME_DESC] = true,
    [LOC.OPT_PRINT_CUSTOM_DESC] = true,
    [LOC.OPT_PRINT_ERRORS_DESC] = true,
    [LOC.OPT_ANCHOR_DESC] = true,
    [LOC.OPT_MFSETTINGS] = true,
    [LOC.OPT_MFSETTINGS_DESC] = true,
    [LOC.OPT_DISPLAYOPTIONS] = true,
    [LOC.OPT_SHOWMFS] = true,
    [LOC.OPT_SHOWMFS_DESC] = true,

    [LOC.OPT_AUTOHIDEMFS] = true,
    [LOC.OPT_AUTOHIDEMFS_DESC] = true,
    [LOC.OPT_HIDEMFS_SOLO] = true,
    [LOC.OPT_HIDEMFS_SOLO_DESC] = true,
    [LOC.OPT_HIDEMFS_GROUP] = true,
    [LOC.OPT_HIDEMFS_GROUP_DESC] = true,
    [LOC.OPT_HIDEMFS_NEVER] = true,
    [LOC.OPT_HIDEMFS_NEVER_DESC] = true,

    [LOC.OPT_ADDDEBUFFFHIST]		= true,
    [LOC.OPT_ADDDEBUFFFHIST_DESC]	= true,

    [LOC.OPT_GROWDIRECTION] = true,
    [LOC.OPT_GROWDIRECTION_DESC] = true,

    [LOC.OPT_STICKTORIGHT_DESC]	= true,
    [LOC.OPT_STICKTORIGHT]	= true,
    [LOC.OPT_MUFSCOLORS_DESC]	= true,
    [LOC.OPT_MUFSCOLORS]	= true,
    [LOC.MISSINGUNIT]		= true,
    [LOC.COLORALERT]		= true,
    [LOC.COLORSTATUS]		= true,
    [LOC.COLORCHRONOS]		= true,
    [LOC.COLORCHRONOS_DESC]	= true,

    [LOC.OPT_MUFSCOLORS] = true,
    [LOC.OPT_SHOWBORDER] = true,
    [LOC.OPT_SHOWBORDER_DESC] = true,
    [LOC.OPT_SHOWCHRONO] = true,
    [LOC.OPT_SHOWCHRONO_DESC] = true,
    [LOC.OPT_MAXMFS] = true,
    [LOC.OPT_MAXMFS_DESC] = true,
    [LOC.OPT_UNITPERLINES] = true,
    [LOC.OPT_UNITPERLINES_DESC] = true,
    [LOC.OPT_MFSCALE] = true,
    [LOC.OPT_MFSCALE_DESC] = true,
    [LOC.OPT_LLSCALE] = true,
    [LOC.OPT_LLSCALE_DESC] = true,
    [LOC.OPT_SHOWHELP] = true,
    [LOC.OPT_SHOWHELP_DESC] = true,
    [LOC.OPT_MFPERFOPT] = true,
    [LOC.OPT_MFREFRESHRATE] = true,
    [LOC.OPT_MFREFRESHRATE_DESC] = true,
    [LOC.OPT_MFREFRESHSPEED] = true,
    [LOC.OPT_MFREFRESHSPEED_DESC] = true,
    [LOC.OPT_CURINGOPTIONS] = true,
    [LOC.OPT_CURINGOPTIONS_DESC] = true,
    [LOC.OPT_ABOLISHCHECK_DESC] = true,
    [LOC.OPT_DONOTBLPRIO_DESC] = true,
    [LOC.OPT_RANDOMORDER_DESC] = true,
    [LOC.OPT_CUREPETS_DESC] = true,
    [LOC.OPT_IGNORESTEALTHED_DESC] = true,
    [LOC.OPT_CURINGORDEROPTIONS] = true,
    [LOC.OPT_MAGICCHECK_DESC] = true,
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = true,
    [LOC.OPT_CHARMEDCHECK_DESC] = true,
    [LOC.OPT_POISONCHECK_DESC] = true,
    [LOC.OPT_DISEASECHECK_DESC] = true,
    [LOC.OPT_CURSECHECK_DESC] = true,
    [LOC.OPT_DEBUFFFILTER] = true,
    [LOC.OPT_DEBUFFFILTER_DESC] = true,
    [LOC.OPT_MACROOPTIONS] = true,
    [LOC.OPT_MACROOPTIONS_DESC] = true,
    [LOC.OPT_MACROBIND] = true,
    [LOC.OPT_MACROBIND_DESC] = true,
    [LOC.OPT_RESETOPTIONS] = true,
    [LOC.OPT_RESETOPTIONS_DESC] = true,
    [LOC.OPT_REMOVESKDEBCONF] = true,
    [LOC.OPT_RESTPROFILECONF] = true,
    [LOC.OPT_PROFILERESET] = true,
    [LOC.OPT_AFFLICTEDBYSKIPPED] = true,
    [LOC.OPT_DEBCHECKEDBYDEF] = true,
    [LOC.OPT_ALWAYSIGNORE] = true,
    [LOC.OPT_ALWAYSIGNORE_DESC] = true,
    [LOC.OPT_REMOVETHISDEBUFF] = true,
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = true,
    [LOC.OPT_RESETDEBUFF] = true,
    [LOC.OPT_RESETDTDCRDEFAULT] = true,
    [LOC.OPT_USERDEBUFF] = true,
    [LOC.OPT_DEBUFFENTRY_DESC] = true,
    [LOC.OPT_ADDDEBUFF] = true,
    [LOC.OPT_ADDDEBUFF_DESC] = true,
    [LOC.OPT_ADDDEBUFF_USAGE] = true,
    [LOC.OPT_READDDEFAULTSD] = true,
    [LOC.OPT_READDDEFAULTSD_DESC1] = true,
    [LOC.OPT_READDDEFAULTSD_DESC2] = true,

    [LOC.OPT_LVONLYINRANGE] = true,
    [LOC.OPT_LVONLYINRANGE_DESC] = true,
    
    [LOC.OPT_MFALPHA] = true,
    [LOC.OPT_MFALPHA_DESC] = true,

    [LOC.OPT_LLALPHA] = true,
    [LOC.OPT_LLALPHA_DESC] = true,

   
    [LOC.OPT_ADVDISP]		 = true,
    [LOC.OPT_ADVDISP_DESC]		 = true,
    [LOC.OPT_TIECENTERANDBORDER]	 = true,
    [LOC.OPT_TIECENTERANDBORDER_OPT] = true,
    [LOC.OPT_BORDERTRANSP]		 = true,
    [LOC.OPT_BORDERTRANSP_DESC]	 = true,
    [LOC.OPT_CENTERTRANSP]		 = true,
    [LOC.OPT_CENTERTRANSP_DESC]	 = true,
    [LOC.OPT_TIEXYSPACING]		 = true,
    [LOC.OPT_TIEXYSPACING_DESC]	 = true,
    [LOC.OPT_XSPACING]		 = true,
    [LOC.OPT_XSPACING_DESC]		 = true,
    [LOC.OPT_YSPACING]		 = true,
    [LOC.OPT_YSPACING_DESC]		 = true,
    [LOC.OPT_SHOWMINIMAPICON]		 = true,
    [LOC.OPT_SHOWMINIMAPICON_DESC]	 = true,


    [LOC.HLP_LL_ONCLICK_TEXT] = true,
    [LOC.HLP_LEFTCLICK] = true,
    [LOC.HLP_RIGHTCLICK] = true,
    [LOC.HLP_MIDDLECLICK] = true,

    [LOC.HLP_NOTHINGTOCURE] = true,
    [LOC.HLP_WRONGMBUTTON] = true,
    [LOC.HLP_USEXBUTTONTOCURE] = true,

    [LOC.CTRL] = true,
    [LOC.ALT] = true,
    [LOC.SHIFT] = true,

    [LOC.TARGETUNIT] = true,
    [LOC.FOCUSUNIT] = true,
    
    [LOC.ABSENT] = true,
    [LOC.TOOFAR] = true,
    [LOC.NORMAL] = true,
    [LOC.STEALTHED] = true,
    [LOC.BLACKLISTED] = true,
    [LOC.UNITSTATUS] = true,
    [LOC.AFFLICTEDBY] = true,
    
    [LOC.SUCCESSCAST] = true,
    [LOC.FAILEDCAST] = true,
    [LOC.HANDLEHELP] = true,

    [LOC.MACROKEYALREADYMAPPED] = true,
    [LOC.MACROKEYMAPPINGSUCCESS] = true,
    [LOC.MACROKEYMAPPINGFAILED] = true,
    [LOC.MACROKEYNOTMAPPED] = true,

    [LOC.OPT_NOKEYWARN] = true,
    [LOC.OPT_NOKEYWARN_DESC] = true,
    [LOC.NOSPELL] = true,

    [LOC.FUBARMENU]  = true,
    [LOC.FUBARMENU_DESC]  = true,

    [LOC.GLOR1] = true,
    [LOC.GLOR2] = true,
    [LOC.GLOR3] = true,
    [LOC.GLOR4] = true,
    [LOC.GLOR5] = true,
    -- OPTIONS

    [LOC.DISABLEWARNING] = true,

} end);

-- // }}}


DcrLoadedFiles["enUS.lua"] = "@project-version@";
