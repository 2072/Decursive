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
-- French localization {{{
-- Revised by the Grinch 08.24.06 (From Release 1.9.8 RC2)
-------------------------------------------------------------------------------

local L = Dcr.L;
L:RegisterTranslations("frFR", function() return {
    --start added in Rc4
    [Dcr.LOC.ALLIANCE_NAME]	=	'Alliance',

    [Dcr.LOC.CLASS_DRUID]	=	'Druide',
    [Dcr.LOC.CLASS_HUNTER]	=	'Chasseur',
    [Dcr.LOC.CLASS_MAGE]	=	'Mage',
    [Dcr.LOC.CLASS_PALADIN]	=	'Paladin',
    [Dcr.LOC.CLASS_PRIEST]	=	'Prêtre',
    [Dcr.LOC.CLASS_ROGUE]	=	'Voleur',
    [Dcr.LOC.CLASS_SHAMAN]	=	'Shaman',
    [Dcr.LOC.CLASS_WARLOCK]	=	'Démoniste',
    [Dcr.LOC.CLASS_WARRIOR]	=	'Guerrier',

    [Dcr.LOC.STR_OTHER]	=	'Autre',
    [Dcr.LOC.STR_OPTIONS]	=	'Options de Decursive',
    [Dcr.LOC.STR_CLOSE]	=	'Fermer',
    [Dcr.LOC.STR_DCR_PRIO]	=	'Liste de priorités',
    [Dcr.LOC.STR_DCR_SKIP]	=	'Liste des exceptions',
    [Dcr.LOC.STR_QUICK_POP]	=	'Remplir rapidement',
    [Dcr.LOC.STR_POP]	=	'Remplir la liste',
    [Dcr.LOC.STR_GROUP]	=	'Groupe ',




    [Dcr.LOC.PRIORITY_SHOW]	=	'P',
    [Dcr.LOC.POPULATE]	=	'R',
    [Dcr.LOC.SKIP_SHOW]	=	'S',
    [Dcr.LOC.CLEAR_PRIO]	=	'E',
    [Dcr.LOC.CLEAR_SKIP]	=	'E',





    [Dcr.LOC.PET_FEL_CAST]	=	"Dévorer la magie",
    [Dcr.LOC.PET_DOOM_CAST]	=	"Dissipation de la magie",

    [Dcr.LOC.SPELL_POLYMORPH]		  = 'Métamorphose',
    [Dcr.LOC.SPELL_CURE_DISEASE]	=	'Guérison des maladies',
    [Dcr.LOC.SPELL_ABOLISH_DISEASE]	=	'Abolir maladie',
    [Dcr.LOC.SPELL_PURIFY]	=	'Purification',
    [Dcr.LOC.SPELL_CLEANSE]	=	'Epuration',
    [Dcr.LOC.SPELL_DISPELL_MAGIC]	=	'Dissipation de la magie',
    [Dcr.LOC.SPELL_CURE_POISON]	=	'Guérison du poison',
    [Dcr.LOC.SPELL_ABOLISH_POISON]	=	'Abolir le poison',
    [Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]	=	'Délivrance de la malédiction mineure',
    [Dcr.LOC.SPELL_REMOVE_CURSE]	=	'Délivrance de la malédiction',
    [Dcr.LOC.SPELL_PURGE]	=	'Expiation',

    [BINDING_NAME_DCRSHOW]	=	"Afficher ou Cacher la barre Decursive",

    [BINDING_NAME_DCRPRADD]	=	"Ajouter la cible à la liste de priorités",
    [BINDING_NAME_DCRPRCLEAR]	=	"Effacer la liste de priorités",
    [BINDING_NAME_DCRPRLIST]	=	"Afficher la liste de priorités",
    [BINDING_NAME_DCRPRSHOW]	=	"Afficher ou Cacher la liste de priorités",

    [BINDING_NAME_DCRSKADD]	=	"Ajouter la cible à la liste des exceptions",
    [BINDING_NAME_DCRSKCLEAR]	=	"Effacer la liste des exceptions",
    [BINDING_NAME_DCRSKLIST]	=	"Afficher la liste des exceptions",
    [BINDING_NAME_DCRSKSHOW]	=	"Afficher ou Cacher la liste des exceptions",



    [Dcr.LOC.PRIORITY_LIST]	=	"Liste des priorités",
    [Dcr.LOC.SKIP_LIST_STR]	=	"Liste des exceptions",
    [Dcr.LOC.OPTION_MENU]	=	"Menu options",
    [Dcr.LOC.POPULATE_LIST]	=	"Remplir rapidement la liste",
    [Dcr.LOC.LIST_ENTRY_ACTIONS]	=	"|cFF33AA33[CTRL]|r Click : Efface ce joueur\nClick |cFF33AA33GAUCHE|r : Monte ce joueur\nClick |cFF33AA33DROIT|r: Descend ce joueur\n|cFF33AA33[MAJ]|r Click |cFF33AA33GAUCHE|r : Met ce joueur en haut\n|cFF33AA33[MAJ]|r Click |cFF33AA33DROIT|r : Met ce joueur en bas",
    [Dcr.LOC.HIDE_MAIN]	=	"Cacher la fenêtre \"Decursive\"",
    [Dcr.LOC.SHOW_MSG]	=	"Pour afficher la fenêtre \"Decursive\", tapez /dcrshow.",
    [Dcr.LOC.IS_HERE_MSG]	=	"Decursive est initialisé, n'oubliez pas de contrôler les options disponibles",

    [Dcr.LOC.PRINT_CHATFRAME]	=	"Afficher les messages dans le canal par défaut",
    [Dcr.LOC.PRINT_CUSTOM]	=	"Afficher les messages dans la fenêtre",
    [Dcr.LOC.PRINT_ERRORS]	=	"Afficher les messages d'erreurs",

    [Dcr.LOC.SHOW_TOOLTIP]	=	"Afficher les infos-bulles sur les unités affligées",
    [Dcr.LOC.REVERSE_LIVELIST]	=	"Inverser l'affichage de la liste",
    [Dcr.LOC.HIDE_LIVELIST]	=	"Cacher la liste",
    [Dcr.LOC.TIE_LIVELIST]	=	"Lier la visibilité de la liste à \"Decursive\"",

    [Dcr.LOC.AMOUNT_AFFLIC]	=	"Nombre d'affligés à afficher : ",
    [Dcr.LOC.BLACK_LENGTH]	=	"Délais (Secs) sur la *blacklist* : ",
    [Dcr.LOC.SCAN_LENGTH]	=	"Délais (Secs) entre les scans : ",
    [Dcr.LOC.ABOLISH_CHECK]	=	"Voir si \"Abolir\" sur la cible avant de guérir", -- XXX
    [Dcr.LOC.RANDOM_ORDER]	=	"Guérir aléatoirement",
    [Dcr.LOC.CURE_PETS]	=	"Contrôler et guérir les pets",
    [Dcr.LOC.IGNORE_STEALTH]	=	"Ignorer les unités camouflées",
    [Dcr.LOC.PLAY_SOUND]	=	"Jouer un son quand il y a quelqu'un à guérir",
    [Dcr.LOC.ANCHOR]	=	"Ancre du texte",
    [Dcr.LOC.DONOT_BL_PRIO]	=	"Ne pas *blacklister* les gens prioritaires",


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [Dcr.LOC.SPELL_FOUND]	=	"%s trouvé !",

    -- spells and potions
    [Dcr.LOC.DREAMLESSSLEEP]	= "Sommeil sans rêve",
    [Dcr.LOC.GDREAMLESSSLEEP]	= "Sommeil sans rêve supérieur",
    [Dcr.LOC.ANCIENTHYSTERIA]	= "Hystérie ancienne",
    [Dcr.LOC.IGNITE]		= "Enflammer le mana",
    [Dcr.LOC.TAINTEDMIND]	= "Esprit corrompu",
    [Dcr.LOC.MAGMASHAKLES]	= "Entraves de magma",
    [Dcr.LOC.CRIPLES]		= "Faiblesse",
    [Dcr.LOC.DUSTCLOUD]		= "Nuage de poussière",
    [Dcr.LOC.WIDOWSEMBRACE]	= Dcr.LOC.WIDOWSEMBRACE,
    [Dcr.LOC.CURSEOFTONGUES]	= "Malédiction des langages",
    [Dcr.LOC.SONICBURST]	= "Explosion sonore",
    [Dcr.LOC.THUNDERCLAP]	= "Coup de tonnerre",
    [Dcr.LOC.DELUSIONOFJINDO]	= "Illusions de Jin'do",

    [Dcr.LOC.DISEASE] = 'Maladie',
    [Dcr.LOC.MAGIC]  = 'Magie',
    [Dcr.LOC.POISON]  = 'Poison',
    [Dcr.LOC.CURSE]  = 'Malédiction',
    [Dcr.LOC.CHARMED] = 'Contrôle magique',


    [Dcr.LOC.MUTATINGINJECTION] = Dcr.LOC.MUTATINGINJECTION;
    [Dcr.LOC.DEFAULT_MACROKEY] = Dcr.LOC.DEFAULT_MACROKEY; -- Ideally the key just beneath the "escape" key
    [Dcr.LOC.OPT_LIVELIST] = "Liste des affligés",
    [Dcr.LOC.OPT_LIVELIST_DESC] = "Options pour la liste des affligés",
    [Dcr.LOC.OPT_HIDELIVELIST_DESC] = "Si non cochée, affiche une liste des personnes affligés",
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

    [Dcr.LOC.HLP_LEFTCLICK] = "Clique Gauche",
    [Dcr.LOC.HLP_RIGHTCLICK] = "Clique Droit",
    [Dcr.LOC.HLP_MIDDLECLICK] = "Clique Milieu",

    [Dcr.LOC.CTRL] = "Ctrl",
    [Dcr.LOC.ALT] = "ALt",
    [Dcr.LOC.SHIFT] = "Maj",

    [Dcr.LOC.TARGETUNIT] = "Cible l'unité",
    [Dcr.LOC.FOCUSUNIT] = "Focus l'unité",

    [Dcr.LOC.ABSENT] = "Absente (%s)",
    [Dcr.LOC.TOOFAR] = "Hors de porté",
    [Dcr.LOC.NORMAL] = "Normal",
    [Dcr.LOC.STEALTHED] = "Camouflée",
    [Dcr.LOC.BLACKLISTED] = "Sur liste noire",
    [Dcr.LOC.UNITSTATUS] = "Statut de l'unité : ",
    [Dcr.LOC.AFFLICTEDBY] = "Afflifgée par %s",
    
    [Dcr.LOC.SUCCESSCAST] = "%s sur %s |cFF00AA00réussi !|r",

    [Dcr.LOC.HANDLEHELP] = "Déplacer tous les micro-portraits",


} end);


