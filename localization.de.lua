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

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date$", "$Revision$");

local L = Dcr.L;
L:RegisterTranslations("deDE", function() return {
    --start added in Rc4

    [Dcr.LOC.CLASS_DRUID]	=	'Druide',
    [Dcr.LOC.CLASS_HUNTER]	=	'Jäger',
    [Dcr.LOC.CLASS_MAGE]	=	'Magier',
    [Dcr.LOC.CLASS_PALADIN]	=	'Paladin',
    [Dcr.LOC.CLASS_PRIEST]	=	'Priester',
    [Dcr.LOC.CLASS_ROGUE]	=	'Schurke',
    [Dcr.LOC.CLASS_SHAMAN]	=	'Schamane',
    [Dcr.LOC.CLASS_WARLOCK]	=	'Hexenmeister',
    [Dcr.LOC.CLASS_WARRIOR]	=	'Krieger',

    [Dcr.LOC.STR_OTHER]	=	'Sonstige',
    [Dcr.LOC.STR_OPTIONS]	=	'Einstellungen',
    [Dcr.LOC.STR_CLOSE]	=	'Schließen',
    [Dcr.LOC.STR_DCR_PRIO]	=	'Decursive Prioritätenliste',
    [Dcr.LOC.STR_DCR_SKIP]	=	'Decursive Ignorierliste',
    [Dcr.LOC.STR_QUICK_POP]	=	'Schnellbestücken',
    [Dcr.LOC.STR_POP]	=	'Bestückungsliste',
    [Dcr.LOC.STR_GROUP]	=	'Gruppe ',




    [Dcr.LOC.PRIORITY_SHOW]	=	'P',
    [Dcr.LOC.POPULATE]	=	'P',
    [Dcr.LOC.SKIP_SHOW]	=	'S',
    [Dcr.LOC.CLEAR_PRIO]	=	'C',
    [Dcr.LOC.CLEAR_SKIP]	=	'C',





    [Dcr.LOC.PET_FEL_CAST]	=	"Magie verschlingen",
    [Dcr.LOC.PET_DOOM_CAST]	=	"Magiebannung",

    [Dcr.LOC.SPELL_POLYMORPH]		  = "Verwandlung",
    [Dcr.LOC.SPELL_CURE_DISEASE]	=	'Krankheit heilen',
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]	=	'Krankheit aufheben',
    [Dcr.LOC.SPELL_PURIFY]	=	'Läutern',
    [Dcr.LOC.SPELL_CLEANSE]	=	'Reinigung des Glaubens',
    [Dcr.LOC.SPELL_DISPELL_MAGIC]	=	'Magiebannung',
    [Dcr.LOC.SPELL_CURE_POISON]	=	'Vergiftung heilen',
    [Dcr.LOC.SPELL_ABOLISH_POISON]	=	'Vergiftung aufheben',
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]	=	'Geringen Fluch aufheben',
    [Dcr.LOC.SPELL_REMOVE_CURSE]	=	'Fluch aufheben',
    [Dcr.LOC.SPELL_PURGE]	=	'Reinigen',

    [BINDING_NAME_DCRSHOW]	=	"Zeige/Verstecke Decursive Main Bar",
    
    [BINDING_NAME_DCRMUFSHOWHIDE] =	BINDING_NAME_DCRMUFSHOWHIDE,

    [BINDING_NAME_DCRPRADD]	=	"Ziel zur Prioritätenliste hinzufügen",
    [BINDING_NAME_DCRPRCLEAR]	=	"Prioritätenliste leeren",
    [BINDING_NAME_DCRPRLIST]	=	"Prioritätenliste ausgeben",
    [BINDING_NAME_DCRPRSHOW]	=	"Zeige/Verstecke die Prioritätenliste UI",

    [BINDING_NAME_DCRSKADD]	=	"Ziel zur Ignorierliste hinzufügen",
    [BINDING_NAME_DCRSKCLEAR]	=	"Ignorierliste leeren",
    [BINDING_NAME_DCRSKLIST]	=	"Ignorierliste ausgeben",
    [BINDING_NAME_DCRSKSHOW]	=	"Zeige/Verstecke die Ignorierliste UI",


    [Dcr.LOC.PRIORITY_LIST]	=	"Decursive Prioritätenliste",
    [Dcr.LOC.SKIP_LIST_STR]	=	"Decursive Ignorierliste",
    [Dcr.LOC.OPTION_MENU]	=	"Decursive Einstellungen",
    [Dcr.LOC.POPULATE_LIST]	=	"Schnellbestücken der Decursive Liste",
    [Dcr.LOC.LIST_ENTRY_ACTIONS]	=	Dcr.LOC.LIST_ENTRY_ACTIONS,
    [Dcr.LOC.HIDE_MAIN]	=	"Verstecke Decursive Fenster",
    [Dcr.LOC.TIE_LIVELIST]    = Dcr.LOC.TIE_LIVELIST;
    [Dcr.LOC.SHOW_MSG]	=	"Um das Decursive Fenster anzuzeigen, /dcrshow eingeben",
    [Dcr.LOC.IS_HERE_MSG]	=	"Decursive wurde geladen, kontrolliere bitte die Einstellungen",

    [Dcr.LOC.PRINT_CHATFRAME]	=	"Nachrichten im Chat ausgeben",
    [Dcr.LOC.PRINT_CUSTOM]	=	"Nachrichten in Bildschirmmitte ausgeben",
    [Dcr.LOC.PRINT_ERRORS]	=	"Fehlernachrichten ausgeben",

    [Dcr.LOC.SHOW_TOOLTIP]	=	"Zeige Tooltips in der Betroffenenliste",
    [Dcr.LOC.REVERSE_LIVELIST]	=	"Zeige die Live-Liste umgekehrt",
    [Dcr.LOC.HIDE_LIVELIST]	=	"Verstecke die Live-Liste",

    [Dcr.LOC.AMOUNT_AFFLIC]	=	"Zeige Anzahl der Betroffenen: ",
    [Dcr.LOC.BLACK_LENGTH]	=	"Sekunden auf der Blacklist: ",
    [Dcr.LOC.SCAN_LENGTH]	=	"Sekunden zwischen Live-Scans: ",
    [Dcr.LOC.ABOLISH_CHECK]	=	"Zuvor überprüfen ob Reinigung nötig",
    [Dcr.LOC.RANDOM_ORDER]	=	"Reinige in zufälliger Reihenfolge",
    [Dcr.LOC.CURE_PETS]	=	"Scanne und reinige Pets",
    [Dcr.LOC.IGNORE_STEALTH]	=	"Ignoriere getarnte Einheiten",
    [Dcr.LOC.PLAY_SOUND]	=	"Akustische Warnung falls Reinigung nötig",
    [Dcr.LOC.ANCHOR]	=	"Decursive Textfenster",
    [Dcr.LOC.DONOT_BL_PRIO]	=	"Keine Namen der Prioritätenliste bannen",


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [Dcr.LOC.SPELL_FOUND]	=	"Zauber %s gefunden!",


    -- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP]	= "Traumloser Schlaf",
    [Dcr.LOC.GDREAMLESSSLEEP]	= "Großer Trank des traumlosen Schlafs",
    [Dcr.LOC.ANCIENTHYSTERIA]	= "Uralte Hysterie",
    [Dcr.LOC.IGNITE]		= "Mana entzünden",
    [Dcr.LOC.TAINTEDMIND]	= "Verdorbene Gedanken",
    [Dcr.LOC.MAGMASHAKLES]	= "Magma Fesseln",
    [Dcr.LOC.CRIPLES]		= "Verkrüppeln",
    [Dcr.LOC.DUSTCLOUD]		= "Staubwolke",
    [Dcr.LOC.WIDOWSEMBRACE]	= "Umarmung der Witwe",
    [Dcr.LOC.CURSEOFTONGUES]	= "Fluch der Sprachen",
    [Dcr.LOC.SONICBURST]	= "Schallexplosion",
    [Dcr.LOC.THUNDERCLAP]	= "Donnerknall",
    [Dcr.LOC.DELUSIONOFJINDO]	= "Fluch der Schatten",


    [Dcr.LOC.DISEASE] = 'Krankheit';
    [Dcr.LOC.MAGIC]  = 'Magie';
    [Dcr.LOC.POISON]  = 'Gift';
    [Dcr.LOC.CURSE]  = 'Fluch';
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
    [Dcr.LOC.OPT_GROWDIRECTION] = Dcr.LOC.OPT_GROWDIRECTION,
    [Dcr.LOC.OPT_GROWDIRECTION_DESC] = Dcr.LOC.OPT_GROWDIRECTION_DESC,
    [Dcr.LOC.OPT_SHOWBORDER] =  Dcr.LOC.OPT_SHOWBORDER,
    [Dcr.LOC.OPT_SHOWBORDER_DESC] =  Dcr.LOC.OPT_SHOWBORDER_DESC,
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

    [Dcr.LOC.OPT_ADVDISP] = Dcr.LOC.OPT_ADVDISP,
    [Dcr.LOC.OPT_ADVDISP_DESC] = Dcr.LOC.OPT_ADVDISP_DESC,
    [Dcr.LOC.OPT_TIECENTERANDBORDER] = Dcr.LOC.OPT_TIECENTERANDBORDER,
    [Dcr.LOC.OPT_TIECENTERANDBORDER_OPT] = Dcr.LOC.OPT_TIECENTERANDBORDER_OPT,
    [Dcr.LOC.OPT_BORDERTRANSP] = Dcr.LOC.OPT_BORDERTRANSP,
    [Dcr.LOC.OPT_BORDERTRANSP_DESC] = Dcr.LOC.OPT_BORDERTRANSP_DESC,
    [Dcr.LOC.OPT_CENTERTRANSP] = Dcr.LOC.OPT_CENTERTRANSP,
    [Dcr.LOC.OPT_CENTERTRANSP_DESC] = Dcr.LOC.OPT_CENTERTRANSP_DESC,
    [Dcr.LOC.OPT_TIEXYSPACING] = Dcr.LOC.OPT_TIEXYSPACING,
    [Dcr.LOC.OPT_TIEXYSPACING_DESC] = Dcr.LOC.OPT_TIEXYSPACING_DESC,
    [Dcr.LOC.OPT_XSPACING] = Dcr.LOC.OPT_XSPACING,
    [Dcr.LOC.OPT_XSPACING_DESC] = Dcr.LOC.OPT_XSPACING_DESC,
    [Dcr.LOC.OPT_YSPACING] = Dcr.LOC.OPT_YSPACING,
    [Dcr.LOC.OPT_YSPACING_DESC] = Dcr.LOC.OPT_YSPACING_DESC,


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
