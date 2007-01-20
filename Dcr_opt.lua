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



local L = Dcr.L;
local BS = Dcr.BS;
local BC = Dcr.BC;

-- Default values for the option

Dcr.defaults = { -- {{{
    debugging = false,
    -- this is the priority list of people to cure
    PriorityList = { },
    PriorityListClass = { },
    -- this is the people to skip
    SkipList = { },
    SkipListClass = { },

    -- The micro units debuffs frame
    ShowDebuffsFrame = true,

    DebuffsFrameMaxCount = 80,

    DebuffsFrameElemScale = 1,

    DebuffsFramePerline = 10,

    DebuffsFrameRefreshRate = 0.06,

    DebuffsFramePerUPdate = 10,
    
    DebuffsFrameShowHelp = true,
    
    DebuffsFrame_x = false,
    
    DebuffsFrame_y = false,

    -- this is wether or not to show the "live" list	
    Hide_LiveList = false,

    -- This will turn on and off the sending of messages to the default chat frame
    Print_ChatFrame = true,

    -- this will send the messages to a custom frame that is moveable	
    Print_CustomFrame = true,

    -- this will disable error messages
    Print_Error = true,

    -- check for abolish before curing poison or disease
    Check_For_Abolish = true,


    -- this is "fix" for the fact that rank 1 of dispell magic does not always remove
    -- the high level debuffs properly. This carrys over to other things.
    AlwaysUseBestSpell = true,

    -- should we do the orders randomly?
    Random_Order = false,

    -- should we scan pets
    Scan_Pets = true,

    -- should we ignore stealthed units
    Ingore_Stealthed = true,

    -- how many to show in the livelist
    Amount_Of_Afflicted = 3,

    -- how many seconds to "black list" someone with a failed spell
    CureBlacklist	= 5.0,

    -- how often to poll for afflictions in seconds
    ScanTime = 0.3,

    -- Are prio list members protected from blacklisting?
    DoNot_Blacklist_Prio_List = false,

    -- Play a sound when there is something to decurse
    PlaySound = true,

    -- Hide the buttons
    HideButtons = false,

    -- Cure magic if possible
    CureMagic	= true,
    -- Cure Poison if possible
    CurePoison	= true,
    -- Cure Disease if possible
    CureDisease	= true,
    -- Cure Curse if possible
    CureCurse	= true,

    -- Display text above in the custom frame
    CustomeFrameInsertBottom = false,

    -- Disable tooltips in affliction list
    AfflictionTooltips = true,

    -- Reverse LiveList Display
    ReverseLiveDisplay = false,

    -- Hide everything but the livelist
    Hidden = false,

    -- if true then the live list will show only if the main window is shown
    LiveListTied = false,

    -- allow to changes the default output window
    OutputWindow = "DEFAULT_CHAT_FRAME", -- ACEDB CRASHES if we set it directly


    MacroBind = L[Dcr.LOC.DEFAULT_MACROKEY],

    CureOrder = {
	[DcrC.ENEMYMAGIC]   = 1,
	[DcrC.MAGIC]	    = 2,
	[DcrC.CURSE]	    = 3,
	[DcrC.POISON]	    = 4,
	[DcrC.DISEASE]	    = 5,
    },


    -- Debuffs {{{

    DebuffsToIgnore = {
	[BS["Phase Shift"]]		= true,
	[BS["Banish"]]			= true,
	[BS["Frost Trap Aura"]]		= true,
    },

    BuffDebuff = { -- thoses debuffs are in fact buffs...
	[L[Dcr.LOC.DREAMLESSSLEEP]]	= true,
	[L[Dcr.LOC.GDREAMLESSSLEEP]]	= true,
	[BS[DCR_LOC_MINDVISION]]	= true,
	[L[Dcr.LOC.MUTATINGINJECTION]]	= true,
    },

    DebuffsSkipList = {
	BS[DCR_LOC_SILENCE],
	L[Dcr.LOC.ANCIENTHYSTERIA],
	L[Dcr.LOC.IGNITE],
	L[Dcr.LOC.TAINTEDMIND],
	L[Dcr.LOC.MAGMASHAKLES],
	L[Dcr.LOC.CRIPLES],
	L[Dcr.LOC.DUSTCLOUD],
	L[Dcr.LOC.WIDOWSEMBRACE],
	BS[Dcr.LOC.CURSEOFTONGUES],
	L[Dcr.LOC.SONICBURST],
	L[Dcr.LOC.THUNDERCLAP],
	L[Dcr.LOC.DELUSIONOFJINDO]
    },
    skipByClass = {
	["WARRIoR"] = {
	    [L[Dcr.LOC.ANCIENTHYSTERIA]]   = true,
	    [L[Dcr.LOC.IGNITE]]        = true,
	    [L[Dcr.LOC.TAINTEDMIND]]       = true,
	    [L[Dcr.LOC.WIDOWSEMBRACE]]    = true,
	    [BS[Dcr.LOC.CURSEOFTONGUES]]   = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["ROGUE"] = {
	    [BS[DCR_LOC_SILENCE]]           = true,
	    [L[Dcr.LOC.ANCIENTHYSTERIA]]   = true,
	    [L[Dcr.LOC.IGNITE]]        = true,
	    [L[Dcr.LOC.TAINTEDMIND]]       = true,
	    [L[Dcr.LOC.WIDOWSEMBRACE]]    = true,
	    [BS[Dcr.LOC.CURSEOFTONGUES]]   = true,
	    [L[Dcr.LOC.SONICBURST]]        = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["HUNTER"] = {
	    [L[Dcr.LOC.MAGMASHAKLES]]     = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["MAGE"] = {
	    [L[Dcr.LOC.MAGMASHAKLES]]     = true,
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.THUNDERCLAP]]        = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["WARLOCK"] = {
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.THUNDERCLAP]]        = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["DRUID"] = {
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.THUNDERCLAP]]        = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["PALADIN"] = {
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["PRIEST"] = {
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.THUNDERCLAP]]        = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	},
	["SHAMAN"] = {
	    [L[Dcr.LOC.CRIPLES]]            = true,
	    [L[Dcr.LOC.DUSTCLOUD]]         = true,
	    [L[Dcr.LOC.DELUSIONOFJINDO]]= true,
	}
    }
    -- }}}

} -- }}}

Dcr.options = { -- {{{
    type = "group",
    args = {
	title = {
	    type = "header",
	    name = L[Dcr.LOC.STR_OPTIONS],
	    textHeight = 13,
	    justifyH = "CENTER",
	    order = 50,
	},
	spacer1 = {
	    type = "header",
	},
	livelistoptions = { -- {{{
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_LIVELIST], "FF22EE33"),
	    desc = L[Dcr.LOC.OPT_LIVELIST_DESC],
	    order = 100,
	    disabled = function() return  not Dcr.Status.Enabled end,

	    args = {
		show = {
		    type = "toggle",
		    name = L[Dcr.LOC.HIDE_LIVELIST],
		    desc = L[Dcr.LOC.OPT_HIDELIVELIST_DESC],
		    get = function() return  Dcr.db.profile.Hide_LiveList end,
		    set = function() Dcr:ShowHideLiveList() end, -- XXX not sure if it works correctly
		    disabled = function() return Dcr.db.profile.LiveListTied end,
		    order = 100
		},
		ToolTips = {
		    type = "toggle",
		    name = L[Dcr.LOC.SHOW_TOOLTIP],
		    desc = L[Dcr.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return Dcr.db.profile.AfflictionTooltips end,
		    set = function()
			Dcr.db.profile.AfflictionTooltips = not Dcr.db.profile.AfflictionTooltips
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList and not Dcr.db.profile.ShowDebuffsFrame end,
		    order = 102
		},
		Sound = {
		    type = "toggle",
		    name = L[Dcr.LOC.PLAY_SOUND],
		    desc = L[Dcr.LOC.OPT_PLAYSOUND_DESC],
		    get = function() return Dcr.db.profile.PlaySound end,
		    set = function()
			Dcr.db.profile.PlaySound = not Dcr.db.profile.PlaySound
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList end,
		    order = 103
		},
		livenum = {
		    type = 'range',
		    name = L[Dcr.LOC.AMOUNT_AFFLIC],
		    desc = L[Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC],
		    get = function() return Dcr.db.profile.Amount_Of_Afflicted end,
		    set = function(v) 
			Dcr.db.profile.Amount_Of_Afflicted = v
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList end,
		    min = 1,
		    max = Dcr.CONF.MAX_LIVE_SLOTS,
		    step = 1,
		    isPercent = false,
		    order = 104,
		},
		BlacklistedTime = {
		    type = 'range',
		    name = L[Dcr.LOC.BLACK_LENGTH],
		    desc = L[Dcr.LOC.OPT_BLACKLENTGH_DESC],
		    get = function() return Dcr.db.profile.CureBlacklist end,
		    set = function(v) 
			Dcr.db.profile.CureBlacklist = v
		    end,
		    min = 1,
		    max = 20,
		    step = 0.1,
		    isPercent = false,
		    order = 105,
		},
		ScanFreq = {
		    type = 'range',
		    name = L[Dcr.LOC.SCAN_LENGTH],
		    desc = L[Dcr.LOC.OPT_SCANLENGTH_DESC],
		    get = function() return Dcr.db.profile.ScanTime end,
		    set = function(v) 
			Dcr:Debug("Scan delay changed");
			Dcr.db.profile.ScanTime = v;
			Dcr:CancelScheduledEvent(Dcr.Status.ScanShedule);
			Dcr.Status.ScanShedule = Dcr:ScheduleRepeatingEvent(Dcr.RaidScanner_SC, Dcr.db.profile.ScanTime);
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList end,
		    min = 0.1,
		    max = 1,
		    step = 0.1,
		    isPercent = false,
		    order = 106,
		},
		ReverseLL = {
		    type = "toggle",
		    name = L[Dcr.LOC.REVERSE_LIVELIST],
		    desc = L[Dcr.LOC.OPT_REVERSE_LIVELIST_DESC],
		    get = function() return Dcr.db.profile.ReverseLiveDisplay end,
		    set = function()
			Dcr.db.profile.ReverseLiveDisplay = not Dcr.db.profile.ReverseLiveDisplay
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList end,
		    order = 107
		},
		TieLLVisibility = {
		    type = "toggle",
		    name = L[Dcr.LOC.TIE_LIVELIST],
		    desc = L[Dcr.LOC.OPT_TIE_LIVELIST_DESC],
		    get = function() return Dcr.db.profile.LiveListTied end,
		    set = function()
			Dcr.db.profile.LiveListTied = not Dcr.db.profile.LiveListTied
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList end,
		    order = 108
		},
	    },
	}, -- // }}}

	MessageOptions = { -- {{{
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_MESSAGES], "FF229966"),
	    desc = L[Dcr.LOC.OPT_MESSAGES_DESC],
	    order = 110,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    args = {
		PrintToDefaultChat = {
		    type = "toggle",
		    name =  L[Dcr.LOC.PRINT_CHATFRAME],
		    desc = L[Dcr.LOC.OPT_CHATFRAME_DESC],
		    get = function() return Dcr.db.profile.Print_ChatFrame end,
		    set = function()
			Dcr.db.profile.Print_ChatFrame = not Dcr.db.profile.Print_ChatFrame;
		    end,
		    order = 120
		},
		PrintToCustomChat = {
		    type = "toggle",
		    name =  L[Dcr.LOC.PRINT_CUSTOM],
		    desc = L[Dcr.LOC.OPT_PRINT_CUSTOM_DESC],
		    get = function() return Dcr.db.profile.Print_CustomFrame end,
		    set = function()
			Dcr.db.profile.Print_CustomFrame = not Dcr.db.profile.Print_CustomFrame;
		    end,
		    order = 121
		},
		PrintErrors = {
		    type = "toggle",
		    name =  L[Dcr.LOC.PRINT_ERRORS],
		    desc =  L[Dcr.LOC.OPT_PRINT_ERRORS_DESC],
		    get = function() return Dcr.db.profile.Print_Error end,
		    set = function()
			Dcr.db.profile.Print_Error = not Dcr.db.profile.Print_Error;
		    end,
		    order = 122
		},
		ShowCustomFAnchor = {
		    type = "toggle",
		    name =  L[Dcr.LOC.ANCHOR],
		    desc = L[Dcr.LOC.OPT_ANCHOR_DESC],
		    get = function() return DecursiveAnchor:IsVisible() end,
		    set = function()
			Dcr:ShowHideTextAnchor();
		    end,
		    order = 123
		},
	    }
	}, -- }}}


	MicroFrameOpt = { -- {{{
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_MFSETTINGS], "FFBBCC33"),
	    desc =		 L[Dcr.LOC.OPT_MFSETTINGS_DESC],
	    order = 130,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    args = {
		title1 = {
		    type = "header",
		    name = L[Dcr.LOC.OPT_DISPLAYOPTIONS],
		    textHeight = 13,
		    justifyH = "CENTER",
		    order = 101,
		},
		Show = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_SHOWMFS],
		    desc = L[Dcr.LOC.OPT_SHOWMFS_DESC],
		    get = function() return Dcr.db.profile.ShowDebuffsFrame end,
		    set = function()
			Dcr.db.profile.ShowDebuffsFrame = not Dcr.db.profile.ShowDebuffsFrame;
			Dcr:ShowHideDebuffsFrame ();
			if (not Dcr.db.profile.ShowDebuffsFrame) then
			    Dcr:CancelScheduledEvent(Dcr.Status.MicroFrameUpdateSchedule);
			    Dcr.Status.MicroFrameUpdateSchedule = false;
			elseif (not Dcr.Status.MicroFrameUpdateSchedule) then
			    Dcr.Status.MicroFrameUpdateSchedule =
			    Dcr:ScheduleRepeatingEvent(Dcr.DebuffsFrame_Update, Dcr.db.profile.DebuffsFrameRefreshRate);
			end
		    end,
		    disabled = function() return Dcr.Status.Combat end,
		    order = 102,
		},
		MaxCount = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MAXMFS],
		    desc = L[Dcr.LOC.OPT_MAXMFS_DESC],
		    get = function() return Dcr.db.profile.DebuffsFrameMaxCount end,
		    set = function(v) 
			if (v ~= Dcr.db.profile.DebuffsFrameMaxCount) then
			    Dcr.db.profile.DebuffsFrameMaxCount = v;
			    Dcr.Status.SpellsChanged = GetTime(); -- to force old previously unshown unit frames to update
			    Dcr.MFContainer.UpdateYourself = true;
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.db.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 82,
		    step = 1,
		    isPercent = false,
		    order = 104,
		},
		MFPerline = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_UNITPERLINES],
		    desc = L[Dcr.LOC.OPT_UNITPERLINES_DESC],
		    get = function() return Dcr.db.profile.DebuffsFramePerline end,
		    set = function(v) 
			if (v ~= Dcr.db.profile.DebuffsFramePerline) then
			    Dcr.db.profile.DebuffsFramePerline = v;
			    Dcr.MicroUnitF:ResetAllPositions ();
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.db.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 40,
		    step = 1,
		    isPercent = false,
		    order = 105,
		},
		FrameScale = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFSCALE],
		    desc = L[Dcr.LOC.OPT_MFSCALE_DESC],
		    get = function() return Dcr.db.profile.DebuffsFrameElemScale end, -- Dcr.db.profile.DebuffsFrameElemScale end,
		    set = function(v) 
			if (v ~= Dcr.db.profile.DebuffsFrameElemScale) then
			    Dcr.db.profile.DebuffsFrameElemScale = v;
			    

			    Dcr.MicroUnitF:SetScale(Dcr.db.profile.DebuffsFrameElemScale);

			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.db.profile.ShowDebuffsFrame end,
		    min = 0.3,
		    max = 4,
		    step = 0.01,
		    isPercent = true,
		    order = 105,
		},
		ToolTips = {
		    type = "toggle",
		    name = L[Dcr.LOC.SHOW_TOOLTIP],
		    desc = L[Dcr.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return Dcr.db.profile.AfflictionTooltips end,
		    set = function()
			Dcr.db.profile.AfflictionTooltips = not Dcr.db.profile.AfflictionTooltips
		    end,
		    disabled = function() return  Dcr.db.profile.Hide_LiveList and not Dcr.db.profile.ShowDebuffsFrame end,
		    order = 105.1
		},
		ShowHelp = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_SHOWHELP],
		    desc = L[Dcr.LOC.OPT_SHOWHELP_DESC],
		    get = function() return Dcr.db.profile.DebuffsFrameShowHelp end,
		    set = function()
			Dcr.db.profile.DebuffsFrameShowHelp = not Dcr.db.profile.DebuffsFrameShowHelp;
		
		    end,
		    disabled = function() return not Dcr.db.profile.ShowDebuffsFrame end,
		    order = 105.3,
		},
		spacer2 = {
		    type = "header",
		    order = 106,
		},
		title2 = {
		    type = "header",
		    name = L[Dcr.LOC.OPT_MFPERFOPT],
		    textHeight = 13,
		    justifyH = "CENTER",
		    order = 107,
		},
		UpdateRate = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFREFRESHRATE],
		    desc = L[Dcr.LOC.OPT_MFREFRESHRATE_DESC],
		    get = function() return Dcr.db.profile.DebuffsFrameRefreshRate end,
		    set = function(v) 
			if (v ~= Dcr.db.profile.DebuffsFrameRefreshRate) then
			    Dcr.db.profile.DebuffsFrameRefreshRate = v;
			
			    Dcr:CancelScheduledEvent(Dcr.Status.MicroFrameUpdateSchedule);
			    Dcr.Status.MicroFrameUpdateSchedule =
			    Dcr:ScheduleRepeatingEvent(Dcr.DebuffsFrame_Update, Dcr.db.profile.DebuffsFrameRefreshRate);
			end
		    end,
		    disabled = function() return not Dcr.db.profile.ShowDebuffsFrame end,
		    min = 0.017,
		    max = 0.2,
		    step = 0.01,
		    isPercent = false,
		    order = 108,
		},
		PerUpdate = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFREFRESHSPEED],
		    desc = L[Dcr.LOC.OPT_MFREFRESHSPEED_DESC],
		    get = function() return Dcr.db.profile.DebuffsFramePerUPdate end,
		    set = function(v) 
			if (v ~= Dcr.db.profile.DebuffsFramePerUPdate) then
			    Dcr.db.profile.DebuffsFramePerUPdate = v;
			end
		    end,
		    disabled = function() return not Dcr.db.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 20,
		    step = 1,
		    isPercent = false,
		    order = 110,
		},
	    }
	}, -- }}}
	
	spacer5 = {
	    type = "header",
	    order = 131
	},


	CureOptions = { -- {{{
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_CURINGOPTIONS], "FFFF5533"),
	    desc = L[Dcr.LOC.OPT_CURINGOPTIONS_DESC],
	    order = 120,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    args = {
		AbolishCheck = {
		    type = "toggle",
		    name =  L[Dcr.LOC.ABOLISH_CHECK],
		    desc = L[Dcr.LOC.OPT_ABOLISHCHECK_DESC],
		    get = function() return Dcr.db.profile.Check_For_Abolish end,
		    set = function()
			Dcr.db.profile.Check_For_Abolish = not Dcr.db.profile.Check_For_Abolish;
		    end,
		    order = 130
		},
		DoNotBlPrios = {
		    type = "toggle",
		    name =  L[Dcr.LOC.DONOT_BL_PRIO],
		    desc = L[Dcr.LOC.OPT_DONOTBLPRIO_DESC],
		    get = function() return Dcr.db.profile.DoNot_Blacklist_Prio_List end,
		    set = function()
			Dcr.db.profile.DoNot_Blacklist_Prio_List = not Dcr.db.profile.DoNot_Blacklist_Prio_List;
		    end,
		    order = 131
		},
		RandomCure = {
		    type = "toggle",
		    name =  L[Dcr.LOC.RANDOM_ORDER],
		    desc =  L[Dcr.LOC.OPT_RANDOMORDER_DESC],
		    get = function() return Dcr.db.profile.Random_Order end,
		    set = function()
			Dcr.db.profile.Random_Order = not Dcr.db.profile.Random_Order;
			Dcr.Groups_datas_are_invalid = true;
		    end,
		    order = 132
		},
		CurePets = {
		    type = "toggle",
		    name =  L[Dcr.LOC.CURE_PETS],
		    desc = L[Dcr.LOC.OPT_CUREPETS_DESC],
		    get = function() return Dcr.db.profile.Scan_Pets end,
		    set = function()
			Dcr.db.profile.Scan_Pets = not Dcr.db.profile.Scan_Pets;
			Dcr.Groups_datas_are_invalid = true;
		    end,
		    order = 133
		},
		SkipStealthed = {
		    type = "toggle",
		    name =  L[Dcr.LOC.IGNORE_STEALTH],
		    desc = L[Dcr.LOC.OPT_IGNORESTEALTHED_DESC],
		    get = function() return Dcr.db.profile.Ingore_Stealthed end,
		    set = function()
			Dcr.db.profile.Ingore_Stealthed = not Dcr.db.profile.Ingore_Stealthed;
		    end,
		    order = 134
		},
		
		

		spacer2 = {type = "header", order = 138,}, Title2 = {
		    type="header",  textHeight = 13,
		    name = L[Dcr.LOC.OPT_CURINGORDEROPTIONS],
		    order = 139,
		}, spacer3 = { type = "header", order = 140,   },

		CureMagic = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.MAGIC],
		    desc = L[Dcr.LOC.OPT_MAGICCHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.MAGIC) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.MAGIC);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.MAGIC] end,
		    CureType = DcrC.MAGIC,
		    order = 141
		},
		CureEnemyMagic = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.CHARMED],
		    desc = L[Dcr.LOC.OPT_CHARMEDCHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.ENEMYMAGIC) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.ENEMYMAGIC);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.ENEMYMAGIC] end,
		    CureType = DcrC.ENEMYMAGIC,
		    order = 142
		},
		CurePoison = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.POISON],
		    desc = L[Dcr.LOC.OPT_POISONCHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.POISON) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.POISON);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.POISON] end,
		    CureType = DcrC.POISON,
		    order = 143
		},
		CureDisease = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.DISEASE],
		    desc = L[Dcr.LOC.OPT_DISEASECHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.DISEASE) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.DISEASE);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.DISEASE] end,
		    CureType = DcrC.DISEASE,
		    order = 144
		},
		CureCurse = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.CURSE],
		    desc = L[Dcr.LOC.OPT_CURSECHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.CURSE) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.CURSE);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.CURSE] end,
		    CureType = DcrC.CURSE,
		    order = 145
		},
	    }
	}, -- }}}

	DebuffSkip = {
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_DEBUFFFILTER], "FF99CCAA"),
	    desc = L[Dcr.LOC.OPT_DEBUFFFILTER_DESC],
	    order = 145,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    args = {}
	},
	spacer3 = {
	    type = "header",
	    order = 146
	},
	Macro = {
	    type = "group",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_MACROOPTIONS], "FFCC99BB"),
	    desc = L[Dcr.LOC.OPT_MACROOPTIONS_DESC],
	    order = 147,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    args = {
		SetKey = {
		    type = "text",
		    name = L[Dcr.LOC.OPT_MACROBIND],
		    desc = L[Dcr.LOC.OPT_MACROBIND_DESC],
		    validate = "keybinding",
		    get = function ()
			-- local key = GetBindingKey("MACRO %s", Dcr.CONF.MACRONAME);
			-- return key;
			return Dcr.db.profile.MacroBind;
		    end,
		    set = function (key)
			if (key == Dcr.db.profile.MacroBind) then
			    return;
			end
			-- Restore previous key state
			if (not Dcr.db.profile.PreviousMacroKeyAction or Dcr.db.profile.PreviousMacroKeyAction == "") then
			    SetBinding(Dcr.db.profile.MacroBind);
			else
			    SetBinding(Dcr.db.profile.MacroBind, Dcr.db.profile.PreviousMacroKeyAction);
			end
			Dcr.db.profile.MacroBind = key;
			-- save current key assignement
			Dcr.db.profile.PreviousMacroKeyAction = GetBindingAction(Dcr.db.profile.MacroBind)
			-- set
			SetBindingMacro(Dcr.db.profile.MacroBind, Dcr.CONF.MACRONAME);
		    end,
		    order = 100,
		}
	    }
	},
	spacer4 = {
	    type = "header",
	    order = 148
	},
	reset = {
	    type = "execute",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_RESETOPTIONS], "FF00AAAA"),
	    desc = L[Dcr.LOC.OPT_RESETOPTIONS_DESC],
	    func = function ()
		Dcr.Tmp.Profile = Dcr:GetProfile();
		StaticPopup_Show ("DCR_CONFIRM_RESET", Dcr:GetProfile());
		Dcr.DewDrop:Close(1);
		
	    end,
	    disabled = function() return  not Dcr.Status.Enabled end,
	    order = 150
	},
	spacer4 = {
	    type = "header",
	    order = 151
	},
    },
} -- }}}



Dcr.CureCheckBoxes = { -- just a shortcut
[DcrC.ENEMYMAGIC]   = Dcr.options.args.CureOptions.args.CureEnemyMagic,
[DcrC.MAGIC]	    = Dcr.options.args.CureOptions.args.CureMagic,
[DcrC.CURSE]	    = Dcr.options.args.CureOptions.args.CureCurse,
[DcrC.POISON]	    = Dcr.options.args.CureOptions.args.CurePoison,
[DcrC.DISEASE]	    = Dcr.options.args.CureOptions.args.CureDisease,
}

function Dcr:GetCureCheckBoxStatus (type)

    return (Dcr.db.profile.CureOrder[type] ~= false and Dcr.db.profile.CureOrder[type] ~= -1);
end

function Dcr:SetCureCheckBoxNum (Type)
    local CheckBox = Dcr.CureCheckBoxes[Type];

    -- save the old name
    if (not CheckBox.NameOnly) then
	CheckBox.NameOnly = CheckBox.name;
    end

    -- add the number in green before the name if we have a spell available and if we checked the box
    if (Dcr:GetCureCheckBoxStatus(Type)) then
	CheckBox.name = Dcr:ColorText(Dcr.db.profile.CureOrder[Type], "FF00FF00") .. " " .. CheckBox.NameOnly;
    else
	CheckBox.name = "  " .. CheckBox.NameOnly;
    end

end

function Dcr:CheckCureOrder ()

    Dcr:Debug("Verifying CureOrder...");

    local TempTable = {};
    local AuthorizedKeys = {
	[DcrC.ENEMYMAGIC]   = 1,
	[DcrC.MAGIC]	    = 2,
	[DcrC.CURSE]	    = 3,
	[DcrC.POISON]	    = 4,
	[DcrC.DISEASE]	    = 5,
    };
    local AuthorizedValues = {
	[false]	= true; -- LOL Yes, it's TRUE tnat FALSE is an authorized value xD
	[-1]	= 0,
	[1]	= DcrC.ENEMYMAGIC,
	[2]	= DcrC.MAGIC,
	[3]	= DcrC.CURSE,
	[4]	= DcrC.POISON,
	[5]	= DcrC.DISEASE,
    };
    local GivenValues = {};


    -- add missing entries...
    for key, value in pairs(AuthorizedKeys) do
	if not Dcr.db.profile.CureOrder[key] then
	    Dcr.db.profile.CureOrder[key] = false;
	end
    end

    -- Validate existing entries
    for key, value in pairs(Dcr.db.profile.CureOrder) do

	if (AuthorizedKeys[key]) then
	    if (AuthorizedValues[value] and not GivenValues[value]) then
		TempTable[key] = value;
		GivenValues[value] = true;
	    else
		TempTable[key] = false;
	    end
	end

    end



    Dcr.db.profile.CureOrder = TempTable;



end

function Dcr:SetCureOrder (ToChange)

    local CureOrder = Dcr.db.profile.CureOrder;
    local tmpTable = {};
    Dcr:Debug("SetCureOrder called");

    if (ToChange) then
	if (CureOrder[ToChange]) then
	    CureOrder[ToChange] = false;
	else
	    CureOrder[ToChange] = 10;
	end
    end


    -- re-compute the position of each spell type
    for Type, Num in pairs (CureOrder) do
	-- if we have a spell or if we checked the checkbox
	if (CureOrder[Type] and Dcr.Status.CuringSpells[Type]) then
	    --if (CureOrder[Type]) then -- for testing only
	    table.insert(tmpTable, CureOrder[Type], Type);
	elseif (not Dcr.Status.CuringSpells[Type]) then
	    CureOrder[Type] = -1;
	end
    end


    tmpTable = Dcr:tSortUsingKeys(tmpTable);

    for Num, Type in ipairs (tmpTable) do
	CureOrder[Type] = Num;
    end

    Dcr.Status.ReversedCureOrder = Dcr:tReverse(CureOrder);

--    Dcr:PrintLiteral(tmpTable);
    for Type, CheckBox in pairs(Dcr.CureCheckBoxes) do
	Dcr:SetCureCheckBoxNum(Type);
    end


    -- Create spell priority table
    Dcr.Status.CuringSpellsPrio = {};

--    if not Dcr.Status.HasSpell then
--	return;
--    end

    -- some shortcuts
    local CuringSpellsPrio = Dcr.Status.CuringSpellsPrio;
    local ReversedCureOrder = Dcr.Status.ReversedCureOrder;
    local CuringSpells	= Dcr.Status.CuringSpells;

    local DebuffType;
    -- set the priority for each spell, Micro frames will use this to determine which button to map
    local affected = 1;
    for i=1,5 do
	DebuffType = ReversedCureOrder[i]; -- there is no gap between indexes
	if (DebuffType and not CuringSpellsPrio[ CuringSpells[DebuffType] ] ) then
	    CuringSpellsPrio[ CuringSpells[DebuffType] ] = affected;
	    affected = affected + 1;
	end
    end

    -- Set the spells shortcut (former decurse key)
    Dcr:UpdateMacro();
    Dcr:Debug("Spell changed");
    Dcr.Status.SpellsChanged = GetTime();



end

function Dcr:ShowHideDebuffsFrame ()
    if (Dcr.MFContainer:IsVisible()) then
	Dcr.MFContainer:Hide();
    else
	Dcr.MFContainer:Show();
	Dcr.MFContainer:SetScale(Dcr.db.profile.DebuffsFrameElemScale);
	Dcr.MicroUnitF:Place ();
    end
end

function Dcr:ShowHideTextAnchor() --{{{
    if (DecursiveAnchor:IsVisible()) then
	DecursiveAnchor:Hide();
    else
	DecursiveAnchor:Show();
    end
end --}}}

function Dcr:ChangeTextFrameDirection(bottom) --{{{
    buton = DecursiveAnchorDirection;
    if (bottom) then
	DecursiveTextFrame:SetInsertMode("BOTTOM");
	buton:SetText("v");
    else
	DecursiveTextFrame:SetInsertMode("TOP");
	buton:SetText("^");
    end
end --}}}

-- Popups definition {{{
StaticPopupDialogs["DCR_REMOVE_SKIPPED_DEBUFF_CONFIRMATION"] = {
    text = L[Dcr.LOC.OPT_REMOVESKDEBCONF],
    button1 = TEXT(ACCEPT),
    button2 = TEXT(CANCEL),
    OnAccept = function()

	local DebuffsSkipList	= Dcr.db.profile.DebuffsSkipList;
	local skipByClass	= Dcr.db.profile.skipByClass;


	Dcr:tremovebyval(DebuffsSkipList, Dcr.Tmp.DebuffToRemove)

	for class, debuffs in pairs (skipByClass) do
	    skipByClass[class][Dcr.Tmp.DebuffToRemove] = false; -- does not remove it completely
	end
	Dcr:Debug("%s removed!", Dcr.Tmp.DebuffToRemove);
	Dcr:CreateDropDownFiltersMenu();
	Dcr.Tmp.DebuffToRemove = false;

    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    ShowAlert = 1,
};

StaticPopupDialogs["DCR_CONFIRM_RESET"] = {
    text = L[Dcr.LOC.OPT_RESTPROFILECONF],
    button1 = TEXT(ACCEPT),
    button2 = TEXT(CANCEL),
    OnAccept = function()

	Dcr:Println(L[Dcr.LOC.OPT_PROFILERESET]);
	Dcr:ResetDB("profile");
	Dcr:OnProfileEnable();

    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    ShowAlert = 1,
}; -- // }}}


do -- this is a closure, it's a bit like {} blocks in C

    local DebuffsSkipList, DefaultDebuffsSkipList, skipByClass, DefaultSkipByClass;

    local spacer = function(num) return { type="header", order = 100 + num } end;

    -- so we can pass arguments to functions like StaticPopupDialogs...
    Dcr.Tmp = {};

    


    local RemoveFunc = function (handler)
	Dcr:Debug("Removing '%s'...", handler["Debuff"]);
	Dcr.Tmp.DebuffToRemove = handler["Debuff"];
	StaticPopup_Show ("DCR_REMOVE_SKIPPED_DEBUFF_CONFIRMATION", Dcr:ColorText(handler["Debuff"], "FF11AA66"));
	Dcr.DewDrop:Close(1);
    end

    local ResetFunc = function (handler)
	local DebuffName = handler["Debuff"];

	Dcr:Debug("Resetting '%s'...", handler["Debuff"]);

	for Classe, Debuffs in pairs(skipByClass) do
	    if (DefaultSkipByClass[Classe][DebuffName]) then
		skipByClass[Classe][DebuffName] = true;
	    else
		skipByClass[Classe][DebuffName] = false;
	    end
	end
    end

    local function ClassCheckbox (Class, DebuffName, num)
	--Dcr:PrintLiteral(num);
	local CheckedByDefault = false;

	if (DefaultSkipByClass[Class][DebuffName]) then
	    CheckedByDefault = true;
	end

	local FormattedClass = Dcr:MakeProperEnglishClassName(Class);

	return {
	    type = "toggle",
	    name = Dcr:ColorText( BC[FormattedClass], "FF"..BC:GetHexColor(FormattedClass)) ..
	    (CheckedByDefault and Dcr:ColorText("  *", "FFFFAA00") or ""),
	    desc = string.format(L[Dcr.LOC.OPT_AFFLICTEDBYSKIPPED], BC[FormattedClass], DebuffName) ..
	    (CheckedByDefault and Dcr:ColorText(L[Dcr.LOC.OPT_DEBCHECKEDBYDEF], "FFFFAA00") or "");
	    -- There is no other way to pass arguments to the set and get functions...
	    handler = {
		["Debuff"]=DebuffName,
		["Class"]=Class,
		["get"] = function  (args)
		    local skipByClass = Dcr.db.profile.skipByClass;
		    return skipByClass[args["Class"]][args["Debuff"]]; 
		end,
		["set"] = function  (args, v)
		    local skipByClass = Dcr.db.profile.skipByClass;
		    skipByClass[args["Class"]][args["Debuff"]] = v;
		end
	    };
	    get = "get",
	    set = "set",
	    order = 100 + num;
	}
    end

    local function DebuffSubmenu (DebuffName, num)
	local classes = {};

	for Classe, Debuffs in pairs(skipByClass) do
	    classes[Classe] = ClassCheckbox(Classe, DebuffName, num);
	    num = num + 1;
	end

	classes["spacer1"] = spacer(num);

	num = num + 1;

	classes["remove"] = {
	    type = "execute",
	    name = Dcr:ColorText(Dcr.LOC.OPT_REMOVETHISDEBUFF, "FFFF0000"),
	    desc = string.format(L[Dcr.LOC.OPT_REMOVETHISDEBUFF_DESC], DebuffName),
	    handler = {
		["Debuff"] = DebuffName,
		["remove"] = RemoveFunc,
	    },
	    func = "remove";
	    order = 100 + num;

	};

	num = num + 1;

	classes["spacer2"] = spacer(num);

	num = num + 1;

	local resetDisabled = false;

	if (not Dcr:tcheckforval(DefaultDebuffsSkipList, DebuffName)) then
	    resetDisabled = true;
	end

	classes["reset"] = {
	    type = "execute",
	    -- the two statements below are like (()?:) in C
	    name = not resetDisabled and Dcr:ColorText(L[Dcr.LOC.OPT_RESETDEBUFF], "FF11FF00") or L[Dcr.LOC.OPT_RESETDEBUFF],
	    desc = not resetDisabled and string.format(Dcr.LOC.OPT_RESETDTDCRDEFAULT, DebuffName) or L[Dcr.LOC.OPT_USERDEBUFF],
	    handler = {
		["Debuff"] = DebuffName,
		["reset"] = ResetFunc,
	    },
	    func = "reset";
	    disabled = resetDisabled,
	    order = 100 + num;

	};

	num = num + 1;

	classes["spacer3"] = spacer(num);

	return classes;
    end

    

    --Entry Templates
    local function DebuffEntryGroup (DebuffName, num)
	local IsADefault = Dcr:tcheckforval(DefaultDebuffsSkipList, DebuffName);
	return {
	    type = "group",
	    name = IsADefault and Dcr:ColorText(DebuffName, "FFFFFFFF") or Dcr:ColorText(DebuffName, "FF99FFFF"),
	    desc = L[Dcr.LOC.OPT_DEBUFFENTRY_DESC],
	    order = 100 + num,
	    args = DebuffSubmenu(DebuffName, num),
	}
    end

    local AddFunc = function (NewDebuff)
	if (not Dcr:tcheckforval(DebuffsSkipList, NewDebuff)) then
	    table.insert(DebuffsSkipList, strtrim(NewDebuff));
	    Dcr:CreateDropDownFiltersMenu();
	    Dcr:Debug("'%s' added to debuff skip list", strtrim(NewDebuff));
	end
    end


    local ReAddDefaultsDebuffs = function ()

	for _, Debuff in ipairs(DefaultDebuffsSkipList) do

	    if (not Dcr:tcheckforval(DebuffsSkipList, Debuff)) then

		table.insert(DebuffsSkipList, Debuff);

		ResetFunc({["Debuff"] = Debuff});

	    end
	end

	Dcr:CreateDropDownFiltersMenu();
    end

    local CheckDefaultsPresence = function ()
	for _, Debuff in ipairs(DefaultDebuffsSkipList) do
	    if (not Dcr:tcheckforval(DebuffsSkipList, Debuff)) then

		return false;
	    end
	end
	return true;
    end

    function Dcr:CreateDropDownFiltersMenu()
	DebuffsSkipList	    = Dcr.db.profile.DebuffsSkipList;
	DefaultDebuffsSkipList    = Dcr.defaults.DebuffsSkipList;

	skipByClass		    = Dcr.db.profile.skipByClass;
	DefaultSkipByClass	    = Dcr.defaults.skipByClass;

	local DebuffsSubMenu = {};
	local num = 1;

	for _, Debuff in ipairs(DebuffsSkipList) do
	    DebuffsSubMenu[string.gsub(Debuff, " ", "")] = DebuffEntryGroup(Debuff, num);
	    num = num + 1;
	end

	DebuffsSubMenu["spacer1"] = spacer(num);
	num = num + 1;

	DebuffsSubMenu["add"] = {
	    type = "text",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_ADDDEBUFF], "FFFF3300"),
	    desc = L[Dcr.LOC.OPT_ADDDEBUFF_DESC],
	    usage = L[Dcr.LOC.OPT_ADDDEBUFF_USAGE],
	    get = false,
	    set = AddFunc,
	    order = 100 + num,
	};


	local ReaddIsDisabled = CheckDefaultsPresence();
	num = num + 1;
	DebuffsSubMenu["ReAddDefaults"] = {
	    type = "execute",
	    name = not ReaddIsDisabled and Dcr:ColorText(L[Dcr.LOC.OPT_READDDEFAULTSD], "FFA75728") or L[Dcr.LOC.OPT_READDDEFAULTSD],
	    desc = not ReaddIsDisabled and L[Dcr.LOC.OPT_READDDEFAULTSD_DESC1]
	    or L[Dcr.LOC.OPT_READDDEFAULTSD_DESC2],
	    func = ReAddDefaultsDebuffs,
	    disabled = CheckDefaultsPresence;
	    order = 100 + num,
	};

	num = num + 1;
	DebuffsSubMenu["spacer2"] = spacer(num);
	num = num + 1;

	-- Dcr:PrintLiteral(DebuffsSubMenu);
	Dcr.options.args.DebuffSkip.args = DebuffsSubMenu;

    end
end
