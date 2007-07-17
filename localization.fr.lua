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
local LOC = Dcr.LOC;

L:RegisterTranslations("frFR", function() return {
    --start added in Rc4

    [LOC.CLASS_DRUID]	=	'Druide',
    [LOC.CLASS_HUNTER]	=	'Chasseur',
    [LOC.CLASS_MAGE]	=	'Mage',
    [LOC.CLASS_PALADIN]	=	'Paladin',
    [LOC.CLASS_PRIEST]	=	'Prêtre',
    [LOC.CLASS_ROGUE]	=	'Voleur',
    [LOC.CLASS_SHAMAN]	=	'Shaman',
    [LOC.CLASS_WARLOCK]	=	'Démoniste',
    [LOC.CLASS_WARRIOR]	=	'Guerrier',

    [LOC.STR_OTHER]	=	'Autre',
    [LOC.STR_OPTIONS]	=	'Options de Decursive',
    [LOC.STR_CLOSE]	=	'Fermer',
    [LOC.STR_DCR_PRIO]	=	'Liste de priorités',
    [LOC.STR_DCR_SKIP]	=	'Liste des exceptions',
    [LOC.STR_QUICK_POP]	=	'Remplir rapidement',
    [LOC.STR_POP]	=	'Remplir la liste',
    [LOC.STR_GROUP]	=	'Groupe ',




    [LOC.PRIORITY_SHOW]	=	'P',
    [LOC.POPULATE]	=	'R',
    [LOC.SKIP_SHOW]	=	'S',
    [LOC.CLEAR_PRIO]	=	'E',
    [LOC.CLEAR_SKIP]	=	'E',





    [LOC.PET_FEL_CAST]	=	"Dévorer la magie",
    [LOC.PET_DOOM_CAST]	=	"Dissipation de la magie",

    [LOC.SPELL_POLYMORPH]		  = 'Métamorphose',
    [LOC.SPELL_CURE_DISEASE]	=	'Guérison des maladies',
    [LOC.SPELL_ABOLISH_DISEASE]	=	'Abolir maladie',
    [LOC.SPELL_PURIFY]	=	'Purification',
    [LOC.SPELL_CLEANSE]	=	'Epuration',
    [LOC.SPELL_DISPELL_MAGIC]	=	'Dissipation de la magie',
    [LOC.SPELL_CURE_POISON]	=	'Guérison du poison',
    [LOC.SPELL_ABOLISH_POISON]	=	'Abolir le poison',
    [LOC.SPELL_REMOVE_LESSER_CURSE]	=	'Délivrance de la malédiction mineure',
    [LOC.SPELL_REMOVE_CURSE]	=	'Délivrance de la malédiction',
    [LOC.SPELL_PURGE]	=	'Expiation',
    --[LOC.SPELL_CYCLONE] =	'Cyclone',

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


    [LOC.PRIORITY_LIST]	=	"Liste des priorités",
    [LOC.SKIP_LIST_STR]	=	"Liste des exceptions",
    [LOC.OPTION_MENU]	=	"Menu options",
    [LOC.POPULATE_LIST]	=	"Remplir rapidement la liste",
    [LOC.LIST_ENTRY_ACTIONS]	=	"|cFF33AA33[CTRL]|r Click : Efface ce joueur\nClick |cFF33AA33GAUCHE|r : Monte ce joueur\nClick |cFF33AA33DROIT|r: Descend ce joueur\n|cFF33AA33[MAJ]|r Click |cFF33AA33GAUCHE|r : Met ce joueur en haut\n|cFF33AA33[MAJ]|r Click |cFF33AA33DROIT|r : Met ce joueur en bas",
    [LOC.HIDE_MAIN]	=	"Cacher la fenêtre \"Decursive\"",
    [LOC.SHOW_MSG]	=	"Pour afficher la fenêtre \"Decursive\", tapez /dcrshow.",
    [LOC.IS_HERE_MSG]	=	"Decursive est initialisé, n'oubliez pas de contrôler les options disponibles",

    [LOC.PRINT_CHATFRAME]	=	"Afficher les messages dans le canal par défaut",
    [LOC.PRINT_CUSTOM]	=	"Afficher les messages dans la fenêtre",
    [LOC.PRINT_ERRORS]	=	"Afficher les messages d'erreurs",

    [LOC.SHOW_TOOLTIP]	=	"Afficher les infos-bulles sur les unités affligées",
    [LOC.REVERSE_LIVELIST]	=	"Inverser l'affichage de la liste",
    [LOC.HIDE_LIVELIST]	=	"Cacher la liste",
    [LOC.TIE_LIVELIST]	=	"Lier la visibilité de la liste à \"Decursive\"",

    [LOC.AMOUNT_AFFLIC]	=	"Nombre d'affligés à afficher : ",
    [LOC.BLACK_LENGTH]	=	"Délais (Secs) sur la *blacklist* : ",
    [LOC.SCAN_LENGTH]	=	"Délais (Secs) entre les scans : ",
    [LOC.ABOLISH_CHECK]	=	"Voir si \"Abolir\" sur la cible avant de guérir",
    [LOC.RANDOM_ORDER]	=	"Guérir aléatoirement",
    [LOC.CURE_PETS]	=	"Contrôler et guérir les familiers",
    [LOC.IGNORE_STEALTH]	=	"Ignorer les unités camouflées",
    [LOC.PLAY_SOUND]	=	"Jouer un son quand il y a quelqu'un à guérir",
    [LOC.ANCHOR]	=	"Ancre du texte",
    [LOC.DONOT_BL_PRIO]	=	"Ne pas *blacklister* les gens prioritaires",


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    [LOC.SPELL_FOUND]	=	"%s trouvé !",

    -- spells and potions
    [LOC.DREAMLESSSLEEP]	= "Sommeil sans rêve",
    [LOC.GDREAMLESSSLEEP]	= "Sommeil sans rêve supérieur",
    [LOC.MDREAMLESSSLEEP]	= "Sommeil sans rêve majeur",
    [LOC.ANCIENTHYSTERIA]	= "Hystérie ancienne",
    [LOC.IGNITE]		= "Enflammer le mana",
    [LOC.TAINTEDMIND]	= "Esprit corrompu",
    [LOC.MAGMASHAKLES]	= "Entraves de magma",
    [LOC.CRIPLES]		= "Faiblesse",
    [LOC.DUSTCLOUD]		= "Nuage de poussière",
    [LOC.WIDOWSEMBRACE]	= "Baiser de la veuve",
    [LOC.CURSEOFTONGUES]	= "Malédiction des langages",
    [LOC.SONICBURST]	= "Explosion sonore",
    [LOC.THUNDERCLAP]	= "Coup de tonnerre",
    [LOC.DELUSIONOFJINDO]	= "Illusions de Jin'do",



    [LOC.DISEASE] = 'Maladie',
    [LOC.MAGIC]  = 'Magie',
    [LOC.POISON]  = 'Poison',
    [LOC.CURSE]  = 'Malédiction',
    [LOC.MAGICCHARMED] = 'Contrôle magique',
    [LOC.CHARMED] = 'Possession',


    [LOC.MUTATINGINJECTION] = Dcr.LOC.MUTATINGINJECTION,
    [LOC.DEFAULT_MACROKEY] = "NONE", -- Ideally the key just beneath the "escape" key. Leave to "NONE" (do not translate) if you don't set a real key name.
    [LOC.OPT_LIVELIST] = "Liste des affligés",
    [LOC.OPT_LIVELIST_DESC] = "Options pour la liste des affligés",
    [LOC.OPT_HIDELIVELIST_DESC] = "Si non cochée, affiche une liste des personnes affligés",
    [LOC.OPT_SHOWTOOLTIP_DESC] = "Affiche une bulle d'informations détaillées à propos des afflictions sur les micro-portraits et dans la liste des affligés",
    [LOC.OPT_PLAYSOUND_DESC] = "Joue un son si quelqu'un est affligé",  
    [LOC.OPT_AMOUNT_AFFLIC_DESC] = "Définit le nombre max d'affligés affichés dans la liste des affligés",
    [LOC.OPT_BLACKLENTGH_DESC] = "Définit combien de temps quelqu'un reste sur liste noire",
    [LOC.OPT_SCANLENGTH_DESC] = "Définit le temps entre chaque scan",
    [LOC.OPT_REVERSE_LIVELIST_DESC] = "La liste des affligés se remplit de bas en haut",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "Créer une affliction virtuelle de test",
    [LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "Permet de voir ce qu'il se passe lorsqu'une affliction est détectée",
    [LOC.OPT_TIE_LIVELIST_DESC] = "L'affichage de la liste des affligés est lié à celui de la barre \"Decursive\"",
[LOC.HLP_LL_ONCLICK_TEXT] = "Cliquer sur la liste est inutil depuis WoW 2.0. Vous devriez lire le fichier \"lisez-moi.txt\" qui se trouve dans le répertoire de Decursive.\n(Pour bouger cette liste, bougez la barre de Decursive, /dcrshow et alt-clique-gauche)",
    [LOC.OPT_MESSAGES] = "Messages",
    [LOC.OPT_MESSAGES_DESC] = "Options sur les messages affichés",
    [LOC.OPT_CHATFRAME_DESC] = "Les messages de Decursive seront affichés dans la fenêtre de discussion par défaut",
    [LOC.OPT_PRINT_CUSTOM_DESC] = "Les messages de Decursive seront affichés dans une fenêtre de discussion spéciale",
    [LOC.OPT_PRINT_ERRORS_DESC] = "Les erreurs seront affichées",
    [LOC.OPT_ANCHOR_DESC] = "Montre l'ancre de la fenêtre de discussion spéciale",
    [LOC.OPT_MFSETTINGS] = "Configuration des micro-portraits",
    [LOC.OPT_MFSETTINGS_DESC] = "Réglez les options de la fenêtre des micro-portraits selon vos besoins",
    [LOC.OPT_DISPLAYOPTIONS] = "Options d'affichage",
    [LOC.OPT_SHOWMFS] = "Affiche la fenêtre de micro-portraits",
    [LOC.OPT_SHOWMFS_DESC] = "Cette option doit être activée, si vous voulez guérir en cliquant avec la souris",
    [LOC.OPT_GROWDIRECTION] = "Inverser l'affichage des micro-portraits",
    [LOC.OPT_GROWDIRECTION_DESC] = "Les micro-portraits seront affichés de bas en haut",
    [LOC.OPT_SHOWBORDER] =  "Afficher la bordure colorée des classes",
    [LOC.OPT_SHOWBORDER_DESC] =  "Une bordure colorée représentant la classe de l'unité est affichée autour des micro-portraits",
    [LOC.OPT_MAXMFS] = "Nombre maximum d'unités affichées",
    [LOC.OPT_MAXMFS_DESC] = "Définit le nombre maximum de micro-portraits à afficher",
    [LOC.OPT_UNITPERLINES] = "Nombre d'unités par ligne",
    [LOC.OPT_UNITPERLINES_DESC] = "Définit le nombre max de micro-portraits à afficher par ligne",
    [LOC.OPT_MFSCALE] = 'Echelle des micro-portraits',
    [LOC.OPT_MFSCALE_DESC] = "Définit la taille des micro-portraits",
    [LOC.OPT_LLSCALE] = 'Echelle de la liste des affligés',
    [LOC.OPT_LLSCALE_DESC] = "Définit la taille de la barre principale de Decursive et de la liste des affligés\n(la barre principale doit être affichée)",
    [LOC.OPT_SHOWHELP] = "Affiche l'aide",
    [LOC.OPT_SHOWHELP_DESC] = "Affiche une bulle d'aide lorsque la souris passe au-dessus d'un micro-portrait",
    [LOC.OPT_MFPERFOPT] = "Options de performance",
    [LOC.OPT_MFREFRESHRATE] = 'Taux de rafraîchissement',
    [LOC.OPT_MFREFRESHRATE_DESC] = "Période de rafraîchissement (1 ou plusieurs micro-portraits peuvent être rafraîchis en même temps)",
    [LOC.OPT_MFREFRESHSPEED] = 'Rapidité de rafraîchissement',
    [LOC.OPT_MFREFRESHSPEED_DESC] = "Nombre de micro-portraits à rafraîchir à chaque passage",
    [LOC.OPT_CURINGOPTIONS] = "Options de guérison",
    [LOC.OPT_CURINGOPTIONS_DESC] = "Définit les différents aspects du processus de guérison",
    [LOC.OPT_ABOLISHCHECK_DESC] = "Définit si les unités avec un sort 'Abolir' actif sont affichées et soignées",
    [LOC.OPT_DONOTBLPRIO_DESC] = "Les unités prioritaires ne seront pas blacklistées",
    [LOC.OPT_RANDOMORDER_DESC] = "Les unités seront affichées et guéries au hasard (non recommandé)",
    [LOC.OPT_CUREPETS_DESC] = "Les familiers seront affichés et guéris",
    [LOC.OPT_IGNORESTEALTHED_DESC] = "Les unités camouflées seront ignorées",
    [LOC.OPT_CURINGORDEROPTIONS] = "Options sur l'ordre de guérison",
    [LOC.OPT_MAGICCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités affligées par la magie",
    [LOC.OPT_MAGICCHARMEDCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités contrôlées par magie",
    [LOC.OPT_CHARMEDCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités possédées",
    [LOC.OPT_POISONCHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités empoisonnées",
    [LOC.OPT_DISEASECHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités malade",
    [LOC.OPT_CURSECHECK_DESC] = "Si cochée, vous pourrez voir et guérir les unités maudites",
    [LOC.OPT_DEBUFFFILTER] = "Filtrage des afflictions",
    [LOC.OPT_DEBUFFFILTER_DESC] = "Sélectionner les afflictions à filtrer par nom et par classe pendant les combat",
    [LOC.OPT_MACROOPTIONS] = "Options de la macro",
    [LOC.OPT_MACROOPTIONS_DESC] = "Définit le comportement de la macro créée par Decursive",
    [LOC.OPT_MACROBIND] = "Définit la touche liée à la macro",
    [LOC.OPT_MACROBIND_DESC] = "Définit la touche à partir de laquelle la macro 'Decursive' sera appelée.\n\nAppuyer sur la touche puis sur 'Entrée' pour sauvegarder la nouvelle affectation.",
    [LOC.OPT_RESETOPTIONS] = "Remet les options par défaut",
    [LOC.OPT_RESETOPTIONS_DESC] = "Met les options du profil courant aux valeurs par défaut",
    [LOC.OPT_REMOVESKDEBCONF] = "Êtes-vous sûr de vouloir enlever \n '%s' \nde la liste des exceptions ?",
    [LOC.OPT_RESTPROFILECONF] = "Êtes-vous sûr de vouloir remettre votre profil\n '(%s) %s'\n aux valeurs par défaut ?",
    [LOC.OPT_PROFILERESET] = "Remise à zéro du profil...",
    [LOC.OPT_AFFLICTEDBYSKIPPED] = "%s affligé(e) par %s sera ignoré",
    [LOC.OPT_DEBCHECKEDBYDEF] = "\n\nCochée par défaut",
    [LOC.OPT_ALWAYSIGNORE] = "Ignorer aussi hors combat",
    [LOC.OPT_ALWAYSIGNORE_DESC] = "Si cochée, cette affliction sera aussi ignorée en dehors des combats",
    [LOC.OPT_REMOVETHISDEBUFF] = "Enlever cette affliction",
    [LOC.OPT_REMOVETHISDEBUFF_DESC] = "Supprime '%s' de la liste d'exception",
    [LOC.OPT_RESETDEBUFF] = "Remettre à zéro cette affliction",
    [LOC.OPT_RESETDTDCRDEFAULT] = "Met '%s' aux valeurs par défaut de Decursive",
    [LOC.OPT_USERDEBUFF] = "Cette affliction ne fait pas partie de la liste des afflictions par défaut de Decursive",
    [LOC.OPT_DEBUFFENTRY_DESC] = "Sélectionnez quelle classe doit être ignorée pour cette affliction",
    [LOC.OPT_ADDDEBUFF] = "Ajouter une affliction à la liste",
    [LOC.OPT_ADDDEBUFF_DESC] = "Ajoute une nouvelle affliction à cette liste",
    [LOC.OPT_ADDDEBUFF_USAGE] = "<Nom de l'affliction>",
    [LOC.OPT_READDDEFAULTSD] = "Ré-ajouter les afflictions par défaut",
    [LOC.OPT_READDDEFAULTSD_DESC1] = "Ajoute les afflictions de Decursive manquant à cette liste\nVotre configuration ne sera pas changée",
    [LOC.OPT_READDDEFAULTSD_DESC2] = "Toutes les afflictions par défaut de Decursive sont dans cette liste",

    [LOC.OPT_LVONLYINRANGE] = "Unités à portée seulement",
    [LOC.OPT_LVONLYINRANGE_DESC] = "Si cette option est activée, uniquement les unités à portée de sorts seront affichées dans la liste",

    [LOC.OPT_MFALPHA] = "Transparence",
    [LOC.OPT_MFALPHA_DESC] = "Définit la transparence des micro-portraits, lorsque l'unité n'est pas affligée",
    
    [LOC.OPT_LLALPHA] = "Transparence",
    [LOC.OPT_LLALPHA_DESC] = "Définit la transparence de la barre principale de Decursive et de la liste des affligés\n(la barre principale doit être affichée)",


    [LOC.OPT_ADVDISP] = "Options avancées",
    [LOC.OPT_ADVDISP_DESC] = "Permet de régler la transparence de la bordure et du centre séparemment, permet de régler l'espace entre les micro-portraits",
    [LOC.OPT_TIECENTERANDBORDER] = "Lier le centre et la bordure",
    [LOC.OPT_TIECENTERANDBORDER_OPT] = "Quand activée, la transparence de la bordure vaut la moitiée de celle du centre",
    [LOC.OPT_BORDERTRANSP] = "Transparence de la bordure",
    [LOC.OPT_BORDERTRANSP_DESC] = "Règle la transparence de la bordure",
    [LOC.OPT_CENTERTRANSP] = "Transparence du centre",
    [LOC.OPT_CENTERTRANSP_DESC] = "Règle la transparence du centre",
    [LOC.OPT_TIEXYSPACING] = "Lier l'espacement horizontale et verticale",
    [LOC.OPT_TIEXYSPACING_DESC] = "L'espacement horizontale et verticale entre les micro-portraits sont identiques",
    [LOC.OPT_XSPACING] = "Espacement horizontale",
    [LOC.OPT_XSPACING_DESC] = "Règle l'espacement horizontale entre les micro-portraits",
    [LOC.OPT_YSPACING] = "Espacement verticale",
    [LOC.OPT_YSPACING_DESC] = "Règle l'espacement verticale entre les micro-portraits",

    [LOC.HLP_LEFTCLICK] = "Clic Gauche",
    [LOC.HLP_RIGHTCLICK] = "Clic Droit",
    [LOC.HLP_MIDDLECLICK] = "Clic Milieu",

    [LOC.HLP_NOTHINGTOCURE] = "Il n'y a rien à guérir !",
    [LOC.HLP_WRONGMBUTTON] = "Mauvais clique !",
    [LOC.HLP_USEXBUTTONTOCURE] = "Utilisez \"%s\" pour guérir cette affliction !",

    [LOC.CTRL] = "Ctrl",
    [LOC.ALT] = "Alt",
    [LOC.SHIFT] = "Maj",

    [LOC.TARGETUNIT] = "Cible l'unité",
    [LOC.FOCUSUNIT] = "Focalise l'unité",

    [LOC.ABSENT] = "Absente (%s)",
    [LOC.TOOFAR] = "Hors de portée",
    [LOC.NORMAL] = "Normal",
    [LOC.STEALTHED] = "Camouflée",
    [LOC.BLACKLISTED] = "Sur liste noire",
    [LOC.UNITSTATUS] = "Statut de l'unité : ",
    [LOC.AFFLICTEDBY] = "Affligée par %s",
    
    [LOC.SUCCESSCAST] = "|cFF22FFFF%s %s|r sur %s |cFF00AA00réussi !|r",

    [LOC.HANDLEHELP] = "Déplacer tous les micro-portraits",

    [LOC.MACROKEYALREADYMAPPED] = "ATTENTION: La touche affectée à la macro de Decursive [%s] était affectée à l'action '%s'.\nDecursive restaurera l'action originale si vous affectez une autre touche à la macro.",
    [LOC.MACROKEYMAPPINGSUCCESS] = "La touche [%s] a été correctement affectée à la macro de Decursive.",
    [LOC.MACROKEYMAPPINGFAILED] = "La touche [%s] n'a pas pu être affectée à la macro de Decursive",
    [LOC.MACROKEYNOTMAPPED] = "Aucune touche n'est actuellement affectée à la macro de Decursive, vous pouvez affecter une touche par le menu des options (ne passez pas à coté de cette merveilleuse capacité)",

    [LOC.OPT_NOKEYWARN] = "Avertir si aucune touche",
    [LOC.OPT_NOKEYWARN_DESC] = "Affiche un avertissement si aucune touche n'est affectée à la macro.",
    [LOC.NOSPELL] = "Aucun sort disponible",

} end);
