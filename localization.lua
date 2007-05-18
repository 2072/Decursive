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


Dcr:SetDateAndRevision("$Date$", "$Revision$");

Dcr.LOC = {};


-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

Dcr.LOC.DISEASE = 'Disease';
Dcr.LOC.MAGIC   = 'Magic';
Dcr.LOC.POISON  = 'Poison';
Dcr.LOC.CURSE   = 'Curse';
Dcr.LOC.MAGICCHARMED = 'Magic Charm';
Dcr.LOC.CHARMED = 'Charm';


Dcr.LOC.CLASS_DRUID   = 'Druid';
Dcr.LOC.CLASS_HUNTER  = 'Hunter';
Dcr.LOC.CLASS_MAGE    = 'Mage';
Dcr.LOC.CLASS_PALADIN = 'Paladin';
Dcr.LOC.CLASS_PRIEST  = 'Priest';
Dcr.LOC.CLASS_ROGUE   = 'Rogue';
Dcr.LOC.CLASS_SHAMAN  = 'Shaman';
Dcr.LOC.CLASS_WARLOCK = 'Warlock';
Dcr.LOC.CLASS_WARRIOR = 'Warrior';

Dcr.LOC.STR_OTHER	    = 'Other';
Dcr.LOC.STR_OPTIONS	    = "Decursive's Options";
Dcr.LOC.STR_CLOSE	    = 'Close';
Dcr.LOC.STR_DCR_PRIO    = 'Decursive Priority';
Dcr.LOC.STR_DCR_SKIP    = 'Decursive Skip';
Dcr.LOC.STR_QUICK_POP   = 'Quickly Populate';
Dcr.LOC.STR_POP	    = 'Populate List';
Dcr.LOC.STR_GROUP	    = 'Group ';




Dcr.LOC.PRIORITY_SHOW   = 'P';
Dcr.LOC.POPULATE	    = 'p';
Dcr.LOC.SKIP_SHOW	    = 'S';
Dcr.LOC.CLEAR_PRIO	    = 'C';
Dcr.LOC.CLEAR_SKIP	    = 'C';





Dcr.LOC.PET_FEL_CAST  = "Devour Magic";
Dcr.LOC.PET_DOOM_CAST = "Dispel Magic";


Dcr.LOC.SPELL_POLYMORPH		  = 'Polymorph';
Dcr.LOC.SPELL_CURE_DISEASE        = 'Cure Disease';
Dcr.LOC.SPELL_ABOLISH_DISEASE     = 'Abolish Disease';
Dcr.LOC.SPELL_PURIFY              = 'Purify';
Dcr.LOC.SPELL_CLEANSE             = 'Cleanse';
Dcr.LOC.SPELL_DISPELL_MAGIC       = 'Dispel Magic';
Dcr.LOC.SPELL_CURE_POISON         = 'Cure Poison';
Dcr.LOC.SPELL_ABOLISH_POISON      = 'Abolish Poison';
Dcr.LOC.SPELL_REMOVE_LESSER_CURSE = 'Remove Lesser Curse';
Dcr.LOC.SPELL_REMOVE_CURSE        = 'Remove Curse';
Dcr.LOC.SPELL_PURGE               = 'Purge';

BINDING_NAME_DCRSHOW    = "Show or hide Decursive Main Bar\n(live-list anchor)";

BINDING_NAME_DCRMUFSHOWHIDE = "Show or hide the micro-unit frames";

BINDING_NAME_DCRPRADD     = "Add target to priority list";
BINDING_NAME_DCRPRCLEAR   = "Clear the priority list";
BINDING_NAME_DCRPRLIST    = "Print the priority list";
BINDING_NAME_DCRPRSHOW    = "Show or hide the priority list";

BINDING_NAME_DCRSKADD   = "Add target to skip list";
BINDING_NAME_DCRSKCLEAR = "Clear the skip list";
BINDING_NAME_DCRSKLIST  = "Print the skip list";
BINDING_NAME_DCRSKSHOW  = "Show or hide the skip list";
BINDING_NAME_DCRSHOWOPTION = "Display the option static pannel";


Dcr.LOC.PRIORITY_LIST  = "Decursive Priority List";
Dcr.LOC.SKIP_LIST_STR  = "Decursive Skip List";
Dcr.LOC.OPTION_MENU   = "Decursive Options Menu";
Dcr.LOC.POPULATE_LIST  = "Quickly populate the Decursive list";
Dcr.LOC.LIST_ENTRY_ACTIONS     = "|cFF33AA33[CTRL]|r-Click: Remove this player\n|cFF33AA33LEFT|r-Click: Rise this player\n|cFF33AA33RIGHT|r-Click: Come down this player\n|cFF33AA33[SHIFT] LEFT|r-Click: Put this player at the top\n|cFF33AA33[SHIFT] RIGHT|r-Click: Put this player at the bottom";
Dcr.LOC.HIDE_MAIN      = "Hide Decursive Window";
Dcr.LOC.SHOW_MSG	   = "To show Decursive's frame, type /dcrshow";
Dcr.LOC.IS_HERE_MSG	   = "Decursive is now initialized, remember to check the options";

Dcr.LOC.PRINT_CHATFRAME = "Print messages in default chat";
Dcr.LOC.PRINT_CUSTOM    = "Print messages in the window";
Dcr.LOC.PRINT_ERRORS    = "Print error messages";

Dcr.LOC.SHOW_TOOLTIP    = "Show Tooltips on afflicted units";
Dcr.LOC.REVERSE_LIVELIST= "Reverse live-list display";
Dcr.LOC.HIDE_LIVELIST   = "Hide the live-list";
Dcr.LOC.TIE_LIVELIST    = "Tie live-list visibility to DCR window";
Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF = "Create a virtual test affliction";
Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC = "Lets you see how it looks like when an affliction is found";

Dcr.LOC.AMOUNT_AFFLIC   = "The amount of afflicted to show : ";
Dcr.LOC.BLACK_LENGTH    = "Seconds on the blacklist : ";
Dcr.LOC.SCAN_LENGTH     = "Seconds between live scans : ";
Dcr.LOC.ABOLISH_CHECK   = "Check for \"Abolish\" before curing";
Dcr.LOC.RANDOM_ORDER    = "Cure in a random order";
Dcr.LOC.CURE_PETS       = "Scan and cure pets";
Dcr.LOC.IGNORE_STEALTH  = "Ignore Stealthed Units";
Dcr.LOC.PLAY_SOUND	    = "Play a sound when there is someone to cure";
Dcr.LOC.ANCHOR          = "Decursive Text Anchor";
Dcr.LOC.DONOT_BL_PRIO   = "Don't blacklist priority list names";

Dcr.LOC.SPELL_FOUND      = "%s spell found!";



-- spells and potions
Dcr.LOC.DREAMLESSSLEEP = "Dreamless Sleep";
Dcr.LOC.GDREAMLESSSLEEP = "Greater Dreamless Sleep";
Dcr.LOC.MDREAMLESSSLEEP = "Major Dreamless Sleep";
Dcr.LOC.ANCIENTHYSTERIA = "Ancient Hysteria";
Dcr.LOC.IGNITE		= "Ignite Mana";
Dcr.LOC.TAINTEDMIND	= "Tainted Mind";
Dcr.LOC.MAGMASHAKLES	= "Magma Shackles";
Dcr.LOC.CRIPLES		= "Cripple";
Dcr.LOC.DUSTCLOUD	= "Dust Cloud";
Dcr.LOC.WIDOWSEMBRACE	= "Widow's Embrace";
Dcr.LOC.CURSEOFTONGUES	= "Curse of Tongues"; -- further translated by BS
Dcr.LOC.SONICBURST	= "Sonic Burst";
Dcr.LOC.THUNDERCLAP	= "Thunderclap";
Dcr.LOC.DELUSIONOFJINDO = "Delusions of Jin'do";

Dcr.LOC.MUTATINGINJECTION = "Mutating Injection";

DCR_LOC_SILENCE		= "Silence";  -- further translated by BS
DCR_LOC_MINDVISION	= "Mind Vision";  -- further translated by BS

-- NEW LOCALS FOR 2.0

Dcr.LOC.DEFAULT_MACROKEY = "`"; -- the key just beneath the escape key on a QWERTY keyboard

Dcr.LOC.OPT_LIVELIST = "Live list";
Dcr.LOC.OPT_LIVELIST_DESC = "Options for the live list";
Dcr.LOC.OPT_HIDELIVELIST_DESC = "If not hidden, displays an informative list of cursed people";
Dcr.LOC.OPT_SHOWTOOLTIP_DESC = "Shows a detailed tooltips about curses in the live-list and on the MUFs";
Dcr.LOC.OPT_PLAYSOUND_DESC  = "Play a sound if someone get cursed";
Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC = "Defines the max number of cursed to display in the live-list";
Dcr.LOC.OPT_BLACKLENTGH_DESC =  "Defines how long someone stays on the blacklist";
Dcr.LOC.OPT_SCANLENGTH_DESC = "Defines the time between each scan";
Dcr.LOC.OPT_REVERSE_LIVELIST_DESC = "The live-list fills itself from bottom to top";
Dcr.LOC.OPT_TIE_LIVELIST_DESC = "The live-list display is tied to \"Decursive\" bar display";
Dcr.LOC.OPT_MESSAGES	= "Messages";
Dcr.LOC.OPT_MESSAGES_DESC = "Options about messages display";
Dcr.LOC.OPT_CHATFRAME_DESC = "Decursive's messages will be printed to the default chat frame";
Dcr.LOC.OPT_PRINT_CUSTOM_DESC = "Decursive's messages will be printed in a custome chat frame";
Dcr.LOC.OPT_PRINT_ERRORS_DESC = "Errors will be displayed";
Dcr.LOC.OPT_ANCHOR_DESC	= "Shows the anchor of the custom message frame";
Dcr.LOC.OPT_MFSETTINGS = "Micro Unit Frame Settings";
Dcr.LOC.OPT_MFSETTINGS_DESC = "Set the micro units frame window options to suit your needs";
Dcr.LOC.OPT_DISPLAYOPTIONS = "Display options";
Dcr.LOC.OPT_SHOWMFS = "Show the micro units Frame";
Dcr.LOC.OPT_SHOWMFS_DESC = "This must be enabled if you want to cure by clicking";
Dcr.LOC.OPT_GROWDIRECTION = "Reverse MUFs Display";
Dcr.LOC.OPT_GROWDIRECTION_DESC = "The MUFs will be displayed from bottom to top";
Dcr.LOC.OPT_SHOWBORDER = "Show the class-colored borders";
Dcr.LOC.OPT_SHOWBORDER_DESC = "A colored border will be displayed around the MUFs representing the unit's class";
Dcr.LOC.OPT_MAXMFS  = "Max units shown";
Dcr.LOC.OPT_MAXMFS_DESC = "Defines the max number of micro unit frame to display";
Dcr.LOC.OPT_UNITPERLINES = 'Number of units per line';
Dcr.LOC.OPT_UNITPERLINES_DESC = "Defines the max number of micro-unit-frames to display per line";
Dcr.LOC.OPT_MFSCALE = 'Scale of the micro-unit-frames';
Dcr.LOC.OPT_MFSCALE_DESC = "Set the size of the micro-unit-frames";
Dcr.LOC.OPT_LLSCALE = 'Scale of the Live-list';
Dcr.LOC.OPT_LLSCALE_DESC = "Set the size of the Decursive main bar and of the Live-list (Main bar must be displayed)";
Dcr.LOC.OPT_SHOWHELP = "Show help";
Dcr.LOC.OPT_SHOWHELP_DESC = "Shows an detailed tooltip when you mouse-over a micro-unit-frame"
Dcr.LOC.OPT_MFPERFOPT = "Performance options";
Dcr.LOC.OPT_MFREFRESHRATE = 'Refresh rate'
Dcr.LOC.OPT_MFREFRESHRATE_DESC = "Time between each refresh call (1 or several micro-unit-frames can be refreshed at once)";
Dcr.LOC.OPT_MFREFRESHSPEED = 'Refresh speed';
Dcr.LOC.OPT_MFREFRESHSPEED_DESC = "Number of micro-unit-frames to refresh on a single pass";
Dcr.LOC.OPT_CURINGOPTIONS = "Curing options";
Dcr.LOC.OPT_CURINGOPTIONS_DESC = "Set different aspects of the curing process";
Dcr.LOC.OPT_ABOLISHCHECK_DESC = "select whether units with an active 'Abolish' spell are shown and cured";
Dcr.LOC.OPT_DONOTBLPRIO_DESC = "Prioritized units won't be blacklisted";
Dcr.LOC.OPT_RANDOMORDER_DESC = "Units will be displayed and cured randomly (not recomended)";
Dcr.LOC.OPT_CUREPETS_DESC = "Pets will be managed and cured";
Dcr.LOC.OPT_IGNORESTEALTHED_DESC = "Stealthed units will be ignored";
Dcr.LOC.OPT_CURINGORDEROPTIONS = "Curing Order Options";
Dcr.LOC.OPT_MAGICCHECK_DESC	= "If checked you'll be able to see and cure magic afflicted units";
Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC = "If checked you'll be able to see and cure magic-charmed units";
Dcr.LOC.OPT_CHARMEDCHECK_DESC = "If checked you'll be able to see and deal with charmed units";
Dcr.LOC.OPT_POISONCHECK_DESC = "If checked you'll be able to see and cure poisonned units";
Dcr.LOC.OPT_DISEASECHECK_DESC = "If checked you'll be able to see and cure diseased units";
Dcr.LOC.OPT_CURSECHECK_DESC = "If checked you'll be able to see and cure cursed units";
Dcr.LOC.OPT_DEBUFFFILTER = "Debuff filtering";
Dcr.LOC.OPT_DEBUFFFILTER_DESC = "Select debuffs to filter out by name and class while you are in combat";
Dcr.LOC.OPT_MACROOPTIONS = "Macro options";
Dcr.LOC.OPT_MACROOPTIONS_DESC = "Set the behaviour of the macro created by Decursive";
Dcr.LOC.OPT_MACROBIND = "Set the macro binding key";
Dcr.LOC.OPT_MACROBIND_DESC = "Defines the key on which the 'Decursive' macro will be called.\n\nPress the key and hit your 'Enter' keyboard key to save the new assignement (with your mouse cursor over the edit field)";
Dcr.LOC.OPT_RESETOPTIONS = "Reset options to defaults";
Dcr.LOC.OPT_RESETOPTIONS_DESC =  "Reset the current profile to the default values";
Dcr.LOC.OPT_REMOVESKDEBCONF = "Are you sure you want to remove\n '%s' \nfrom Decursive's debuff skip list?";
Dcr.LOC.OPT_RESTPROFILECONF = "Are you sure you want to reset the profile\n '(%s) %s'\n to default options?";
Dcr.LOC.OPT_PROFILERESET = "Profile reset...";
Dcr.LOC.OPT_AFFLICTEDBYSKIPPED = "%s afflicted by %s will be skipped";
Dcr.LOC.OPT_DEBCHECKEDBYDEF = "\n\nChecked by default";
Dcr.LOC.OPT_ALWAYSIGNORE = "Also ignore when not in combat";
Dcr.LOC.OPT_ALWAYSIGNORE_DESC = "If checked, this debuff will also be ignored when you are not in combat";
Dcr.LOC.OPT_REMOVETHISDEBUFF = "Remove this debuff";
Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC = "Removes '%s' from the skip list";
Dcr.LOC.OPT_RESETDEBUFF = "Reset this debuff";
Dcr.LOC.OPT_RESETDTDCRDEFAULT = "Resets '%s' to Decursive default";
Dcr.LOC.OPT_USERDEBUFF = "This Debuff is not part of Decursive's default debuffs";
Dcr.LOC.OPT_DEBUFFENTRY_DESC = "Select what class should be ignored in combat when afflicted by this debuff";
Dcr.LOC.OPT_ADDDEBUFF = "Add a debuff to the list";
Dcr.LOC.OPT_ADDDEBUFF_DESC = "Adds a new debuff to this list";
Dcr.LOC.OPT_ADDDEBUFF_USAGE = "<Debuff name>";
Dcr.LOC.OPT_READDDEFAULTSD = "Re-add default Debuffs";
Dcr.LOC.OPT_READDDEFAULTSD_DESC1 = "Add missing Decursive's default debuffs to this list\nYour settings won't be changed";
Dcr.LOC.OPT_READDDEFAULTSD_DESC2 = "All Decursive's  default debuffs are in this list";

Dcr.LOC.OPT_LVONLYINRANGE = "Units in range only";
Dcr.LOC.OPT_LVONLYINRANGE_DESC = "Only units in dispel range will be shown in the live-list";

Dcr.LOC.OPT_MFALPHA = "Transparency";
Dcr.LOC.OPT_MFALPHA_DESC = "Defines the transparency of the MUFs when units are not afflicted";

Dcr.LOC.OPT_LLALPHA = "Live-list transparency";
Dcr.LOC.OPT_LLALPHA_DESC = "Changes Decursive main bar and live-list transparency (Main bar must be displayed)";

Dcr.LOC.OPT_ADVDISP = "Advance display Options";
Dcr.LOC.OPT_ADVDISP_DESC = "Allow to set Transparency of the border and center separately, to set the space between each MUF";
Dcr.LOC.OPT_TIECENTERANDBORDER = "Tie center and border transparency";
Dcr.LOC.OPT_TIECENTERANDBORDER_OPT = "The transparency of the border is half the center transparency when checked";
Dcr.LOC.OPT_BORDERTRANSP = "Border transparency";
Dcr.LOC.OPT_BORDERTRANSP_DESC = "Set the transparency of the border";
Dcr.LOC.OPT_CENTERTRANSP = "Center transparency";
Dcr.LOC.OPT_CENTERTRANSP_DESC = "Set the transparency of the center";
Dcr.LOC.OPT_TIEXYSPACING = "Tie horizontal and vertical spacing";
Dcr.LOC.OPT_TIEXYSPACING_DESC = "The horizontal and vertical space between MUFs are the same";
Dcr.LOC.OPT_XSPACING = "Horizontal spacing";
Dcr.LOC.OPT_XSPACING_DESC = "Set the Horizontal space between MUFs";
Dcr.LOC.OPT_YSPACING = "Vertical spacing";
Dcr.LOC.OPT_YSPACING_DESC = "Set the Vertical space between MUFs";



Dcr.LOC.HLP_LL_ONCLICK_TEXT = "Clicking on the live-list is useless since WoW 2.0. You should read the file \"Readme.txt\" located in Decursive folder...";
Dcr.LOC.HLP_LEFTCLICK = "Left-Click";
Dcr.LOC.HLP_RIGHTCLICK = "Right-Click";
Dcr.LOC.HLP_MIDDLECLICK = "Middle-Click";

Dcr.LOC.HLP_NOTHINGTOCURE = "There is nothing to cure!";
Dcr.LOC.HLP_WRONGMBUTTON = "Wrong mouse button!";
Dcr.LOC.HLP_USEXBUTTONTOCURE = "Use \"%s\" to cure this affliction!";
  
Dcr.LOC.CTRL = "Ctrl";
Dcr.LOC.ALT = "ALt";
Dcr.LOC.SHIFT = "Shift";

Dcr.LOC.TARGETUNIT = "Target Unit";
Dcr.LOC.FOCUSUNIT = "Focus Unit";

Dcr.LOC.ABSENT = "Absent (%s)";
Dcr.LOC.TOOFAR = "Too far";
Dcr.LOC.NORMAL = "Normal";
Dcr.LOC.STEALTHED = "stealthed";
Dcr.LOC.BLACKLISTED = "Black-listed";
Dcr.LOC.UNITSTATUS = "Unit Status: ";
Dcr.LOC.AFFLICTEDBY = "%s Afflicted";

Dcr.LOC.SUCCESSCAST = "%s |cFF00AA00succeeded on|r %s";

Dcr.LOC.HANDLEHELP = "Drag all the Micro-UnitFrames (MUFs)";

Dcr.LOC.MACROKEYALREADYMAPPED = "WARNING: The key mapped to Decursive macro [%s] was mapped to action '%s'.\nDecursive will restore the previous mapping if you set another key for its macro.";
Dcr.LOC.MACROKEYMAPPINGSUCCESS = "The key [%s] has been successfully mapped to Decursive macro.";
Dcr.LOC.MACROKEYMAPPINGFAILED = "The key [%s] could not be mapped to Decursive macro!";
Dcr.LOC.MACROKEYNOTMAPPED = "Decursive macro is not mapped to a key, you can map a key through the option menu. (do not miss this wonderful feauture)";


-- Acelocal register for enUS // {{{
local L = Dcr.L;
L:RegisterTranslations("enUS", function() return {


    [Dcr.LOC.CLASS_DRUID]	=	true,
    [Dcr.LOC.CLASS_HUNTER]	=	true,
    [Dcr.LOC.CLASS_MAGE]	=	true,
    [Dcr.LOC.CLASS_PALADIN]	=	true,
    [Dcr.LOC.CLASS_PRIEST]	=	true,
    [Dcr.LOC.CLASS_ROGUE]	=	true,
    [Dcr.LOC.CLASS_SHAMAN]	=	true,
    [Dcr.LOC.CLASS_WARLOCK]	=	true,
    [Dcr.LOC.CLASS_WARRIOR]	=	true,

    [Dcr.LOC.DISEASE]	    =	true,
    [Dcr.LOC.MAGIC]	    =	true,
    [Dcr.LOC.POISON]	    =	true,
    [Dcr.LOC.CURSE]	    =	true,
    [Dcr.LOC.MAGICCHARMED]  =	true,
    [Dcr.LOC.CHARMED]	    =	true,

    -------------------------------------------------------------------------------
    -- English localization (Default)
    -------------------------------------------------------------------------------

    --start added in Rc4

    [Dcr.LOC.CLASS_DRUID]	=	true,
    [Dcr.LOC.CLASS_HUNTER]	=	true,
    [Dcr.LOC.CLASS_MAGE]	=	true,
    [Dcr.LOC.CLASS_PALADIN]	=	true,
    [Dcr.LOC.CLASS_PRIEST]	=	true,
    [Dcr.LOC.CLASS_ROGUE]	=	true,
    [Dcr.LOC.CLASS_SHAMAN]	=	true,
    [Dcr.LOC.CLASS_WARLOCK]	=	true,
    [Dcr.LOC.CLASS_WARRIOR]	=	true,

    [Dcr.LOC.STR_OTHER]		=	true,
    [Dcr.LOC.STR_OPTIONS]	=	true,
    [Dcr.LOC.STR_CLOSE]		=	true,
    [Dcr.LOC.STR_DCR_PRIO]	=	true,
    [Dcr.LOC.STR_DCR_SKIP]	=	true,
    [Dcr.LOC.STR_QUICK_POP]	=	true,
    [Dcr.LOC.STR_POP]		=	true,
    [Dcr.LOC.STR_GROUP]		=	true,




    [Dcr.LOC.PRIORITY_SHOW]	=	true,
    [Dcr.LOC.POPULATE]		=	true,
    [Dcr.LOC.SKIP_SHOW]		=	true,
    [Dcr.LOC.CLEAR_PRIO]	=	true,
    [Dcr.LOC.CLEAR_SKIP]	=	true,

    [Dcr.LOC.PET_FEL_CAST]	=	true,
    [Dcr.LOC.PET_DOOM_CAST]	=	true,

    [Dcr.LOC.SPELL_POLYMORPH]		=	true,
    [Dcr.LOC.SPELL_CURE_DISEASE]	=	true,
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]	=	true,
    [Dcr.LOC.SPELL_PURIFY]		=	true,
    [Dcr.LOC.SPELL_CLEANSE]		=	true,
    [Dcr.LOC.SPELL_DISPELL_MAGIC]	=	true,
    [Dcr.LOC.SPELL_CURE_POISON]		=	true,
    [Dcr.LOC.SPELL_ABOLISH_POISON]	=	true,
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]	=	true,
    [Dcr.LOC.SPELL_REMOVE_CURSE]	=	true,
    [Dcr.LOC.SPELL_PURGE]	=	true,

    [BINDING_NAME_DCRSHOW]	=	true,
    
    [BINDING_NAME_DCRMUFSHOWHIDE] =	true,

    [BINDING_NAME_DCRPRADD]	=	true,
    [BINDING_NAME_DCRPRCLEAR]	=	true,
    [BINDING_NAME_DCRPRLIST]	=	true,
    [BINDING_NAME_DCRPRSHOW]	=	true,

    [BINDING_NAME_DCRSKADD]	=	true,
    [BINDING_NAME_DCRSKCLEAR]	=	true,
    [BINDING_NAME_DCRSKLIST]	=	true,
    [BINDING_NAME_DCRSKSHOW]	=	true,
    
    [BINDING_NAME_DCRSHOWOPTION]=	true,



    [Dcr.LOC.PRIORITY_LIST]	=	true,
    [Dcr.LOC.SKIP_LIST_STR]	=	true,
    [Dcr.LOC.OPTION_MENU]	=	true,
    [Dcr.LOC.POPULATE_LIST]	=	true,
    [Dcr.LOC.LIST_ENTRY_ACTIONS]=	true,
    [Dcr.LOC.HIDE_MAIN]		=	true,
    [Dcr.LOC.SHOW_MSG]		=	true,
    [Dcr.LOC.IS_HERE_MSG]	=	true,

    [Dcr.LOC.PRINT_CHATFRAME]	=	true,
    [Dcr.LOC.PRINT_CUSTOM]	=	true,
    [Dcr.LOC.PRINT_ERRORS]	=	true,

    [Dcr.LOC.SHOW_TOOLTIP]	=	true,
    [Dcr.LOC.REVERSE_LIVELIST]	=	true,
    [Dcr.LOC.TIE_LIVELIST]	=	true,
    [Dcr.LOC.HIDE_LIVELIST]	=	true,

    [Dcr.LOC.AMOUNT_AFFLIC]	=	true,
    [Dcr.LOC.BLACK_LENGTH]	=	true,
    [Dcr.LOC.SCAN_LENGTH]	=	true,
    [Dcr.LOC.ABOLISH_CHECK]	=	true,
    [Dcr.LOC.RANDOM_ORDER]	=	true,
    [Dcr.LOC.CURE_PETS]		=	true,
    [Dcr.LOC.IGNORE_STEALTH]	=	true,
    [Dcr.LOC.PLAY_SOUND]	=	true,
    [Dcr.LOC.ANCHOR]		=	true,
    [Dcr.LOC.DONOT_BL_PRIO]	=	true,

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [Dcr.LOC.SPELL_FOUND]	=	true,

    -- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP] = true,
    [Dcr.LOC.GDREAMLESSSLEEP] = true,
    [Dcr.LOC.MDREAMLESSSLEEP] = true,
    [Dcr.LOC.ANCIENTHYSTERIA] = true,
    [Dcr.LOC.IGNITE] = true,
    [Dcr.LOC.TAINTEDMIND] = true,
    [Dcr.LOC.MAGMASHAKLES] = true,
    [Dcr.LOC.CRIPLES] = true,
    [Dcr.LOC.DUSTCLOUD] = true,
    [Dcr.LOC.WIDOWSEMBRACE] = true,
    [Dcr.LOC.CURSEOFTONGUES] = true,
    [Dcr.LOC.SONICBURST] = true,
    [Dcr.LOC.THUNDERCLAP] = true,
    [Dcr.LOC.DELUSIONOFJINDO] = true,
    [Dcr.LOC.MUTATINGINJECTION] = true,
    -- NEW LOCALS FOR 2.0
    [Dcr.LOC.DEFAULT_MACROKEY] = true,
    [Dcr.LOC.OPT_LIVELIST] = true,
    [Dcr.LOC.OPT_LIVELIST_DESC] = true,
    [Dcr.LOC.OPT_HIDELIVELIST_DESC] = true,
    [Dcr.LOC.OPT_SHOWTOOLTIP_DESC] = true,
    [Dcr.LOC.OPT_PLAYSOUND_DESC] = true,
    [Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC] = true,
    [Dcr.LOC.OPT_BLACKLENTGH_DESC] = true,
    [Dcr.LOC.OPT_SCANLENGTH_DESC] = true,
    [Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = true,
    [Dcr.LOC.OPT_TIE_LIVELIST_DESC] = true,
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF] = true,
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = true,
    [Dcr.LOC.OPT_MESSAGES] = true,
    [Dcr.LOC.OPT_MESSAGES_DESC] = true,
    [Dcr.LOC.OPT_CHATFRAME_DESC] = true,
    [Dcr.LOC.OPT_PRINT_CUSTOM_DESC] = true,
    [Dcr.LOC.OPT_PRINT_ERRORS_DESC] = true,
    [Dcr.LOC.OPT_ANCHOR_DESC] = true,
    [Dcr.LOC.OPT_MFSETTINGS] = true,
    [Dcr.LOC.OPT_MFSETTINGS_DESC] = true,
    [Dcr.LOC.OPT_DISPLAYOPTIONS] = true,
    [Dcr.LOC.OPT_SHOWMFS] = true,
    [Dcr.LOC.OPT_SHOWMFS_DESC] = true,
    [Dcr.LOC.OPT_GROWDIRECTION] = true,
    [Dcr.LOC.OPT_GROWDIRECTION_DESC] = true,
    [Dcr.LOC.OPT_SHOWBORDER] = true,
    [Dcr.LOC.OPT_SHOWBORDER_DESC] = true,
    [Dcr.LOC.OPT_MAXMFS] = true,
    [Dcr.LOC.OPT_MAXMFS_DESC] = true,
    [Dcr.LOC.OPT_UNITPERLINES] = true,
    [Dcr.LOC.OPT_UNITPERLINES_DESC] = true,
    [Dcr.LOC.OPT_MFSCALE] = true,
    [Dcr.LOC.OPT_MFSCALE_DESC] = true,
    [Dcr.LOC.OPT_LLSCALE] = true,
    [Dcr.LOC.OPT_LLSCALE_DESC] = true,
    [Dcr.LOC.OPT_SHOWHELP] = true,
    [Dcr.LOC.OPT_SHOWHELP_DESC] = true,
    [Dcr.LOC.OPT_MFPERFOPT] = true,
    [Dcr.LOC.OPT_MFREFRESHRATE] = true,
    [Dcr.LOC.OPT_MFREFRESHRATE_DESC] = true,
    [Dcr.LOC.OPT_MFREFRESHSPEED] = true,
    [Dcr.LOC.OPT_MFREFRESHSPEED_DESC] = true,
    [Dcr.LOC.OPT_CURINGOPTIONS] = true,
    [Dcr.LOC.OPT_CURINGOPTIONS_DESC] = true,
    [Dcr.LOC.OPT_ABOLISHCHECK_DESC] = true,
    [Dcr.LOC.OPT_DONOTBLPRIO_DESC] = true,
    [Dcr.LOC.OPT_RANDOMORDER_DESC] = true,
    [Dcr.LOC.OPT_CUREPETS_DESC] = true,
    [Dcr.LOC.OPT_IGNORESTEALTHED_DESC] = true,
    [Dcr.LOC.OPT_CURINGORDEROPTIONS] = true,
    [Dcr.LOC.OPT_MAGICCHECK_DESC] = true,
    [Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC] = true,
    [Dcr.LOC.OPT_CHARMEDCHECK_DESC] = true,
    [Dcr.LOC.OPT_POISONCHECK_DESC] = true,
    [Dcr.LOC.OPT_DISEASECHECK_DESC] = true,
    [Dcr.LOC.OPT_CURSECHECK_DESC] = true,
    [Dcr.LOC.OPT_DEBUFFFILTER] = true,
    [Dcr.LOC.OPT_DEBUFFFILTER_DESC] = true,
    [Dcr.LOC.OPT_MACROOPTIONS] = true,
    [Dcr.LOC.OPT_MACROOPTIONS_DESC] = true,
    [Dcr.LOC.OPT_MACROBIND] = true,
    [Dcr.LOC.OPT_MACROBIND_DESC] = true,
    [Dcr.LOC.OPT_RESETOPTIONS] = true,
    [Dcr.LOC.OPT_RESETOPTIONS_DESC] = true,
    [Dcr.LOC.OPT_REMOVESKDEBCONF] = true,
    [Dcr.LOC.OPT_RESTPROFILECONF] = true,
    [Dcr.LOC.OPT_PROFILERESET] = true,
    [Dcr.LOC.OPT_AFFLICTEDBYSKIPPED] = true,
    [Dcr.LOC.OPT_DEBCHECKEDBYDEF] = true,
    [Dcr.LOC.OPT_ALWAYSIGNORE] = true,
    [Dcr.LOC.OPT_ALWAYSIGNORE_DESC] = true,
    [Dcr.LOC.OPT_REMOVETHISDEBUFF] = true,
    [Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = true,
    [Dcr.LOC.OPT_RESETDEBUFF] = true,
    [Dcr.LOC.OPT_RESETDTDCRDEFAULT] = true,
    [Dcr.LOC.OPT_USERDEBUFF] = true,
    [Dcr.LOC.OPT_DEBUFFENTRY_DESC] = true,
    [Dcr.LOC.OPT_ADDDEBUFF] = true,
    [Dcr.LOC.OPT_ADDDEBUFF_DESC] = true,
    [Dcr.LOC.OPT_ADDDEBUFF_USAGE] = true,
    [Dcr.LOC.OPT_READDDEFAULTSD] = true,
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC1] = true,
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC2] = true,

    [Dcr.LOC.OPT_LVONLYINRANGE] = true,
    [Dcr.LOC.OPT_LVONLYINRANGE_DESC] = true,
    
    [Dcr.LOC.OPT_MFALPHA] = true,
    [Dcr.LOC.OPT_MFALPHA_DESC] = true,

    [Dcr.LOC.OPT_LLALPHA] = true,
    [Dcr.LOC.OPT_LLALPHA_DESC] = true,

   
    [Dcr.LOC.OPT_ADVDISP]		 = true,
    [Dcr.LOC.OPT_ADVDISP_DESC]		 = true,
    [Dcr.LOC.OPT_TIECENTERANDBORDER]	 = true,
    [Dcr.LOC.OPT_TIECENTERANDBORDER_OPT] = true,
    [Dcr.LOC.OPT_BORDERTRANSP]		 = true,
    [Dcr.LOC.OPT_BORDERTRANSP_DESC]	 = true,
    [Dcr.LOC.OPT_CENTERTRANSP]		 = true,
    [Dcr.LOC.OPT_CENTERTRANSP_DESC]	 = true,
    [Dcr.LOC.OPT_TIEXYSPACING]		 = true,
    [Dcr.LOC.OPT_TIEXYSPACING_DESC]	 = true,
    [Dcr.LOC.OPT_XSPACING]		 = true,
    [Dcr.LOC.OPT_XSPACING_DESC]		 = true,
    [Dcr.LOC.OPT_YSPACING]		 = true,
    [Dcr.LOC.OPT_YSPACING_DESC]		 = true,


    [Dcr.LOC.HLP_LL_ONCLICK_TEXT] = true;
    [Dcr.LOC.HLP_LEFTCLICK] = true,
    [Dcr.LOC.HLP_RIGHTCLICK] = true,
    [Dcr.LOC.HLP_MIDDLECLICK] = true,

    [Dcr.LOC.HLP_NOTHINGTOCURE] = true,
    [Dcr.LOC.HLP_WRONGMBUTTON] = true,
    [Dcr.LOC.HLP_USEXBUTTONTOCURE] = true,

    [Dcr.LOC.CTRL] = true,
    [Dcr.LOC.ALT] = true,
    [Dcr.LOC.SHIFT] = true,

    [Dcr.LOC.TARGETUNIT] = true,
    [Dcr.LOC.FOCUSUNIT] = true,
    
    [Dcr.LOC.ABSENT] = true,
    [Dcr.LOC.TOOFAR] = true,
    [Dcr.LOC.NORMAL] = true,
    [Dcr.LOC.STEALTHED] = true,
    [Dcr.LOC.BLACKLISTED] = true,
    [Dcr.LOC.UNITSTATUS] = true,
    [Dcr.LOC.AFFLICTEDBY] = true,
    
    [Dcr.LOC.SUCCESSCAST] = true,
    [Dcr.LOC.HANDLEHELP] = true,

    [Dcr.LOC.MACROKEYALREADYMAPPED] = true,
    [Dcr.LOC.MACROKEYMAPPINGSUCCESS] = true,
    [Dcr.LOC.MACROKEYMAPPINGFAILED] = true,
    [Dcr.LOC.MACROKEYNOTMAPPED] = true,
    
    -- OPTIONS

} end);

-- // }}}

