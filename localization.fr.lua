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
-- Traduit de l'anglais par Sylvin (Last translation 2007-JAN-31)
-------------------------------------------------------------------------------
Dcr:SetDateAndRevision("$Date$", "$Revision$");

local L = Dcr.L;
L:RegisterTranslations("frFR", function() return {
    --start added in Rc4

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

    [BINDING_NAME_DCRSHOW]	=	"Afficher ou Cacher la barre Decursive\n(Ancre de la liste des affligés)",
    
    [BINDING_NAME_DCRMUFSHOWHIDE] =	BINDING_NAME_DCRMUFSHOWHIDE,

    [BINDING_NAME_DCRPRADD]	=	"Ajouter la cible à la liste de priorités",
    [BINDING_NAME_DCRPRCLEAR]	=	"Effacer la liste de priorités",
    [BINDING_NAME_DCRPRLIST]	=	"Afficher la liste de priorités",
    [BINDING_NAME_DCRPRSHOW]	=	"Afficher ou Cacher la liste de priorités",

    [BINDING_NAME_DCRSKADD]	=	"Ajouter la cible à la liste des exceptions",
    [BINDING_NAME_DCRSKCLEAR]	=	"Effacer la liste des exceptions",
    [BINDING_NAME_DCRSKLIST]	=	"Afficher la liste des exceptions",
    [BINDING_NAME_DCRSKSHOW]	=	"Afficher ou Cacher la liste des exceptions",

    [BINDING_NAME_DCRSHOWOPTION]=	"Affiche le panneau des options",


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
    [Dcr.LOC.ABOLISH_CHECK]	=	"Voir si \"Abolir\" sur la cible avant de guérir",
    [Dcr.LOC.RANDOM_ORDER]	=	"Guérir aléatoirement",
    [Dcr.LOC.CURE_PETS]	=	"Contrôler et guérir les familiers",
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
    [Dcr.LOC.MDREAMLESSSLEEP]	= "Sommeil sans rêve majeur",
    [Dcr.LOC.ANCIENTHYSTERIA]	= "Hystérie ancienne",
    [Dcr.LOC.IGNITE]		= "Enflammer le mana",
    [Dcr.LOC.TAINTEDMIND]	= "Esprit corrompu",
    [Dcr.LOC.MAGMASHAKLES]	= "Entraves de magma",
    [Dcr.LOC.CRIPLES]		= "Faiblesse",
    [Dcr.LOC.DUSTCLOUD]		= "Nuage de poussière",
    [Dcr.LOC.WIDOWSEMBRACE]	= "Baiser de la veuve",
    [Dcr.LOC.CURSEOFTONGUES]	= "Malédiction des langages",
    [Dcr.LOC.SONICBURST]	= "Explosion sonore",
    [Dcr.LOC.THUNDERCLAP]	= "Coup de tonnerre",
    [Dcr.LOC.DELUSIONOFJINDO]	= "Illusions de Jin'do",



    [Dcr.LOC.DISEASE] = 'Maladie',
    [Dcr.LOC.MAGIC]  = 'Magie',
    [Dcr.LOC.POISON]  = 'Poison',
    [Dcr.LOC.CURSE]  = 'Malédiction',
    [Dcr.LOC.MAGICCHARMED] = 'Contrôle magique',
    [Dcr.LOC.CHARMED] = 'Possession',


    [Dcr.LOC.MUTATINGINJECTION] = Dcr.LOC.MUTATINGINJECTION,
    [Dcr.LOC.DEFAULT_MACROKEY] = "NONE", -- Ideally the key just beneath the "escape" key. Leave to "NONE" (do not translate) if you don't set a real key name.
    [Dcr.LOC.OPT_LIVELIST] = "Liste des affligés",
    [Dcr.LOC.OPT_LIVELIST_DESC] = "Options pour la liste des affligés",
    [Dcr.LOC.OPT_HIDELIVELIST_DESC] = "Si non cochée, affiche une liste des personnes affligés",
    [Dcr.LOC.OPT_SHOWTOOLTIP_DESC] = "Affiche une bulle d'informations détaillées à propos des afflictions sur les micro-portraits et dans la liste des affligés",
    [Dcr.LOC.OPT_PLAYSOUND_DESC] = "Joue un son si quelqu'un est affligé",  
    [Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC] = "Définit le nombre max d'affligés affichés dans la liste des affligés",
    [Dcr.LOC.OPT_BLACKLENTGH_DESC] = "Définit combien de temps quelqu'un reste sur liste noire",
    [Dcr.LOC.OPT_SCANLENGTH_DESC] = "Définit le temps entre chaque scan",
    [Dcr.LOC.OPT_REVERSE_LIVELIST_DESC] = "La liste des affligés se remplit de bas en haut",
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "Créer une affliction virtuelle de test",
    [Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "Permet de voir ce qu'il se passe lorsqu'une affliction est détectée",
    [Dcr.LOC.OPT_TIE_LIVELIST_DESC] = "L'affichage de la liste des affligés est lié à celui de la barre \"Decursive\"",
[Dcr.LOC.HLP_LL_ONCLICK_TEXT] = "Cliquer sur la liste est inutil depuis WoW 2.0. Vous devriez lire le fichier \"lisez-moi.txt\" qui se trouve dans le répertoire de Decursive",
    [Dcr.LOC.OPT_MESSAGES] = "Messages",
    [Dcr.LOC.OPT_MESSAGES_DESC] = "Options sur les messages affichés",
    [Dcr.LOC.OPT_CHATFRAME_DESC] = "Les messages de Decursive seront affichés dans la fenêtre de discussion par défaut",
    [Dcr.LOC.OPT_PRINT_CUSTOM_DESC] = "Les messages de Decursive seront affichés dans une fenêtre de discussion spéciale",
    [Dcr.LOC.OPT_PRINT_ERRORS_DESC] = "Les erreurs seront affichées",
    [Dcr.LOC.OPT_ANCHOR_DESC] = "Montre l'ancre de la fenêtre de discussion spéciale",
    [Dcr.LOC.OPT_MFSETTINGS] = "Configuration des micro-portraits",
    [Dcr.LOC.OPT_MFSETTINGS_DESC] = "Réglez les options de la fenêtre des micro-portraits selon vos besoins",
    [Dcr.LOC.OPT_DISPLAYOPTIONS] = "Options d'affichage",
    [Dcr.LOC.OPT_SHOWMFS] = "Affiche la fenêtre de micro-portraits",
    [Dcr.LOC.OPT_SHOWMFS_DESC] = "Cette option doit être activée, si vous voulez guérir en cliquant avec la souris",
    [Dcr.LOC.OPT_GROWDIRECTION] = "Inverser l'affichage des micro-portraits",
    [Dcr.LOC.OPT_GROWDIRECTION_DESC] = "Les micro-portraits seront affichés de bas en haut",
    [Dcr.LOC.OPT_SHOWBORDER] =  "Afficher la bordure colorée des classes",
    [Dcr.LOC.OPT_SHOWBORDER_DESC] =  "Une bordure colorée représentant la classe de l'unité est affichée autour des micro-portraits",
    [Dcr.LOC.OPT_MAXMFS] = "Nombre maximum d'unités affichées",
    [Dcr.LOC.OPT_MAXMFS_DESC] = "Définit le nombre maximum de micro-portraits à afficher",
    [Dcr.LOC.OPT_UNITPERLINES] = "Nombre d'unités par ligne",
    [Dcr.LOC.OPT_UNITPERLINES_DESC] = "Définit le nombre max de micro-portraits à afficher par ligne",
    [Dcr.LOC.OPT_MFSCALE] = 'Echelle des micro-portraits',
    [Dcr.LOC.OPT_MFSCALE_DESC] = "Définit la taille des micro-portraits",
    [Dcr.LOC.OPT_LLSCALE] = 'Echelle de la liste des affligés',
    [Dcr.LOC.OPT_LLSCALE_DESC] = "Définit la taille de la barre principale de Decursive et de la liste des affligés\n(la barre principale doit être affichée)",
    [Dcr.LOC.OPT_SHOWHELP] = "Affiche l'aide",
    [Dcr.LOC.OPT_SHOWHELP_DESC] = "Affiche une bulle d'aide lorsque la souris passe au-dessus d'un micro-portrait",
    [Dcr.LOC.OPT_MFPERFOPT] = "Options de performance",
    [Dcr.LOC.OPT_MFREFRESHRATE] = 'Taux de rafraîchissement',
    [Dcr.LOC.OPT_MFREFRESHRATE_DESC] = "Période de rafraîchissement (1 ou plusieurs micro-portraits peuvent être rafraîchis en même temps)",
    [Dcr.LOC.OPT_MFREFRESHSPEED] = 'Rapidité de rafraîchissement',
    [Dcr.LOC.OPT_MFREFRESHSPEED_DESC] = "Nombre de micro-portraits à rafraîchir à chaque passage",
    [Dcr.LOC.OPT_CURINGOPTIONS] = "Options de guérison",
    [Dcr.LOC.OPT_CURINGOPTIONS_DESC] = "Définit les différents aspects du processus de guérison",
    [Dcr.LOC.OPT_ABOLISHCHECK_DESC] = "Définit si les unités avec un sort 'Abolir' actif sont affichées et soignées",
    [Dcr.LOC.OPT_DONOTBLPRIO_DESC] = "Les unités prioritaires ne seront pas blacklistées",
    [Dcr.LOC.OPT_RANDOMORDER_DESC] = "Les unités seront affichées et guéries au hasard (non recommandé)",
    [Dcr.LOC.OPT_CUREPETS_DESC] = "Les familiers seront affichés et guéris",
    [Dcr.LOC.OPT_IGNORESTEALTHED_DESC] = "Les unités camouflées seront ignorées",
    [Dcr.LOC.OPT_CURINGORDEROPTIONS] = "Options sur l'ordre de guérison",
    [Dcr.LOC.OPT_MAGICCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités affligées par la magie",
    [Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités contrôlées par magie",
    [Dcr.LOC.OPT_CHARMEDCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités possédées",
    [Dcr.LOC.OPT_POISONCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités empoisonnées",
    [Dcr.LOC.OPT_DISEASECHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités malade",
    [Dcr.LOC.OPT_CURSECHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités maudites",
    [Dcr.LOC.OPT_DEBUFFFILTER] = "Filtrage des afflictions",
    [Dcr.LOC.OPT_DEBUFFFILTER_DESC] = "Sélectionner les afflictions à filtrer par nom et par classe pendant les combat",
    [Dcr.LOC.OPT_MACROOPTIONS] = "Options de la macro",
    [Dcr.LOC.OPT_MACROOPTIONS_DESC] = "Définit le comportement de la macro créée par Decursive",
    [Dcr.LOC.OPT_MACROBIND] = "Définit la touche liée à la macro",
    [Dcr.LOC.OPT_MACROBIND_DESC] = "Définit la touche à partir de laquelle la macro 'Decursive' sera appelée.\n\nAppuyer sur la touche puis sur 'Entrée' pour sauvegarder la nouvelle affectation.",
    [Dcr.LOC.OPT_RESETOPTIONS] = "Remet les options par défaut",
    [Dcr.LOC.OPT_RESETOPTIONS_DESC] = "Met les options du profil courant aux valeurs par défaut",
    [Dcr.LOC.OPT_REMOVESKDEBCONF] = "Êtes-vous sûr de vouloir enlever \n '%s' \nde la liste des exceptions ?",
    [Dcr.LOC.OPT_RESTPROFILECONF] = "Êtes-vous sûr de vouloir remettre votre profil\n '(%s) %s'\n aux valeurs par défaut ?",
    [Dcr.LOC.OPT_PROFILERESET] = "Remise à zéro du profil...",
    [Dcr.LOC.OPT_AFFLICTEDBYSKIPPED] = "%s affligé(e) par %s sera ignoré",
    [Dcr.LOC.OPT_DEBCHECKEDBYDEF] = "\n\nCochée par défaut",
    [Dcr.LOC.OPT_ALWAYSIGNORE] = "Ignorer aussi hors combat",
    [Dcr.LOC.OPT_ALWAYSIGNORE_DESC] = "Si cochée, cette affliction sera aussi ignorée en dehors des combats",
    [Dcr.LOC.OPT_REMOVETHISDEBUFF] = "Enlever cette affliction",
    [Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC] = "Supprime '%s' de la liste d'exception",
    [Dcr.LOC.OPT_RESETDEBUFF] = "Remettre à zéro cette affliction",
    [Dcr.LOC.OPT_RESETDTDCRDEFAULT] = "Met '%s' aux valeurs par défaut de Decursive",
    [Dcr.LOC.OPT_USERDEBUFF] = "Cette affliction ne fait pas partie de la liste des afflictions par défaut de Decursive",
    [Dcr.LOC.OPT_DEBUFFENTRY_DESC] = "Sélectionnez quelle classe doit être ignorée pour cette affliction",
    [Dcr.LOC.OPT_ADDDEBUFF] = "Ajouter une affliction à la liste",
    [Dcr.LOC.OPT_ADDDEBUFF_DESC] = "Ajoute une nouvelle affliction à cette liste",
    [Dcr.LOC.OPT_ADDDEBUFF_USAGE] = "<Nom de l'affliction>",
    [Dcr.LOC.OPT_READDDEFAULTSD] = "Ré-ajouter les afflictions par défaut",
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC1] = "Ajoute les afflictions de Decursive manquant à cette liste\nVotre configuration ne sera pas changée",
    [Dcr.LOC.OPT_READDDEFAULTSD_DESC2] = "Toutes les afflictions par défaut de Decursive sont dans cette liste",

    [Dcr.LOC.OPT_LVONLYINRANGE] = "Unités à portée seulement",
    [Dcr.LOC.OPT_LVONLYINRANGE_DESC] = "Si cette option est activée, uniquement les unités à portée de sorts seront affichées dans la liste",

    [Dcr.LOC.OPT_MFALPHA] = "Transparence",
    [Dcr.LOC.OPT_MFALPHA_DESC] = "Définit la transparence des micro-portraits, lorsque l'unité n'est pas affligée",
    
    [Dcr.LOC.OPT_LLALPHA] = "Transparence",
    [Dcr.LOC.OPT_LLALPHA_DESC] = "Définit la transparence de la barre principale de Decursive et de la liste des affligés\n(la barre principale doit être affichée)",


    [Dcr.LOC.OPT_ADVDISP] = "Options avancées",
    [Dcr.LOC.OPT_ADVDISP_DESC] = "Permet de régler la transparence de la bordure et du centre séparemment, permet de régler l'espace entre les micro-portraits",
    [Dcr.LOC.OPT_TIECENTERANDBORDER] = "Lier le centre et la bordure",
    [Dcr.LOC.OPT_TIECENTERANDBORDER_OPT] = "Quand activée, la transparence de la bordure vaut la moitiée de celle du centre",
    [Dcr.LOC.OPT_BORDERTRANSP] = "Transparence de la bordure",
    [Dcr.LOC.OPT_BORDERTRANSP_DESC] = "Règle la transparence de la bordure",
    [Dcr.LOC.OPT_CENTERTRANSP] = "Transparence du centre",
    [Dcr.LOC.OPT_CENTERTRANSP_DESC] = "Règle la transparence du centre",
    [Dcr.LOC.OPT_TIEXYSPACING] = "Lier l'espacement horizontale et verticale",
    [Dcr.LOC.OPT_TIEXYSPACING_DESC] = "L'espacement horizontale et verticale entre les micro-portraits sont identiques",
    [Dcr.LOC.OPT_XSPACING] = "Espacement horizontale",
    [Dcr.LOC.OPT_XSPACING_DESC] = "Règle l'espacement horizontale entre les micro-portraits",
    [Dcr.LOC.OPT_YSPACING] = "Espacement verticale",
    [Dcr.LOC.OPT_YSPACING_DESC] = "Règle l'espacement verticale entre les micro-portraits",

    [Dcr.LOC.HLP_LEFTCLICK] = "Clic Gauche",
    [Dcr.LOC.HLP_RIGHTCLICK] = "Clic Droit",
    [Dcr.LOC.HLP_MIDDLECLICK] = "Clic Milieu",

    [Dcr.LOC.HLP_NOTHINGTOCURE] = "Il n'y a rien à guérir !",
    [Dcr.LOC.HLP_WRONGMBUTTON] = "Mauvais clique !",
    [Dcr.LOC.HLP_USEXBUTTONTOCURE] = "Utilisez \"%s\" pour guérir cette affliction !",

    [Dcr.LOC.CTRL] = "Ctrl",
    [Dcr.LOC.ALT] = "Alt",
    [Dcr.LOC.SHIFT] = "Maj",

    [Dcr.LOC.TARGETUNIT] = "Cible l'unité",
    [Dcr.LOC.FOCUSUNIT] = "Se Focalise l'unité",

    [Dcr.LOC.ABSENT] = "Absente (%s)",
    [Dcr.LOC.TOOFAR] = "Hors de portée",
    [Dcr.LOC.NORMAL] = "Normal",
    [Dcr.LOC.STEALTHED] = "Camouflée",
    [Dcr.LOC.BLACKLISTED] = "Sur liste noire",
    [Dcr.LOC.UNITSTATUS] = "Statut de l'unité : ",
    [Dcr.LOC.AFFLICTEDBY] = "Affligée par %s",
    
    [Dcr.LOC.SUCCESSCAST] = "%s sur %s |cFF00AA00réussi !|r",

    [Dcr.LOC.HANDLEHELP] = "Déplacer tous les micro-portraits",

    [Dcr.LOC.MACROKEYALREADYMAPPED] = "ATTENTION: La touche affectée à la macro de Decursive [%s] était affectée à l'action '%s'.\nDecursive restaurera l'action originale si vous affectez une autre touche à la macro.",
    [Dcr.LOC.MACROKEYMAPPINGSUCCESS] = "La touche [%s] a été correctement affectée à la macro de Decursive.",
    [Dcr.LOC.MACROKEYMAPPINGFAILED] = "La touche [%s] n'a pas pu être affectée à la macro de Decursive",
    [Dcr.LOC.MACROKEYNOTMAPPED] = "Aucune touche n'est actuellement affectée à la macro de Decursive, vous pouvez affecter une touche par le menu des options (ne passez pas à coté de cette merveilleuse capacité)",


} end);
