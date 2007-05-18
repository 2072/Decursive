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

    DebuffsFrameElemAlpha = .35,

    DebuffsFrameElemBorderShow = true,

    DebuffsFrameElemBorderAlpha = .2,

    DebuffsFrameElemTieTransparency = true;

    DebuffsFramePerline = 10,

    DebuffsFrameTieSpacing = true,

    DebuffsFrameXSpacing = 3,

    DebuffsFrameYSpacing = 3,

    DebuffsFrameRefreshRate = 0.10,

    DebuffsFramePerUPdate = 10,

    DebuffsFrameShowHelp = true,

    DebuffsFrame_x = false,

    DebuffsFrame_y = false,

    DebuffsFrameGrowToTop = false,

    -- this is wether or not to show the "live" list	
    Hide_LiveList = false,

    LiveListAlpha = 0.7;

    LiveListScale = 1.0;

    MainBarX = false;

    MainBarY = false;

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

    LV_OnlyInRange = true,

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


    MacroBind = false, --L[Dcr.LOC.DEFAULT_MACROKEY], -- there were too many unhappy people with this option

    CureOrder = {
	[DcrC.ENEMYMAGIC]   = 1,
	[DcrC.MAGIC]	    = 2,
	[DcrC.CURSE]	    = 3,
	[DcrC.POISON]	    = 4,
	[DcrC.DISEASE]	    = 5,
	[DcrC.CHARMED]	    = 6,
    },


    -- Debuffs {{{

    DebuffsToIgnore = { -- those debuffs prevent us from curing the unit
	[BS["Phase Shift"]]		= true,
	[BS["Banish"]]			= true,
	[BS["Frost Trap Aura"]]		= true,
    },

    BuffDebuff = { -- thoses debuffs are in fact buffs...
	[L[Dcr.LOC.DREAMLESSSLEEP]]	= true,
	[L[Dcr.LOC.GDREAMLESSSLEEP]]	= true,
	[BS[DCR_LOC_MINDVISION]]	= true,
	[L[Dcr.LOC.MUTATINGINJECTION]]	= true,
	[BS["Arcane Blast"]]		= true,
    },

    DebuffAlwaysSkipList = {
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
	["WARRIOR"] = {
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
		    get = function() return  Dcr.profile.Hide_LiveList end,
		    set = function()
			Dcr:ShowHideLiveList()
			if Dcr.profile.Hide_LiveList and not Dcr.profile.ShowDebuffsFrame then
			    Dcr:SetIcon(DcrC.IconOFF);
			else
			    Dcr:SetIcon(DcrC.IconON);
			end
		    end,
		    disabled = function() return Dcr.profile.LiveListTied end,
		    order = 100
		},
		OnlyInRange = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_LVONLYINRANGE],
		    desc = L[Dcr.LOC.OPT_LVONLYINRANGE_DESC],
		    get = function() return Dcr.profile.LV_OnlyInRange end,
		    set = function() Dcr.profile.LV_OnlyInRange = not Dcr.profile.LV_OnlyInRange end,
		    disabled = function() return Dcr.profile.Hide_LiveList end,
		    order = 100.5
		},
		ToolTips = {
		    type = "toggle",
		    name = L[Dcr.LOC.SHOW_TOOLTIP],
		    desc = L[Dcr.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return Dcr.profile.AfflictionTooltips end,
		    set = function()
			Dcr.profile.AfflictionTooltips = not Dcr.profile.AfflictionTooltips
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList and not Dcr.profile.ShowDebuffsFrame end,
		    order = 102
		},
		Sound = {
		    type = "toggle",
		    name = L[Dcr.LOC.PLAY_SOUND],
		    desc = L[Dcr.LOC.OPT_PLAYSOUND_DESC],
		    get = function() return Dcr.profile.PlaySound end,
		    set = function()
			Dcr.profile.PlaySound = not Dcr.profile.PlaySound
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList and not  Dcr.profile.ShowDebuffsFrame end,
		    order = 103
		},
		livenum = {
		    type = 'range',
		    name = L[Dcr.LOC.AMOUNT_AFFLIC],
		    desc = L[Dcr.LOC.OPT_AMOUNT_AFFLIC_DESC],
		    get = function() return Dcr.profile.Amount_Of_Afflicted end,
		    set = function(v) 
			Dcr.profile.Amount_Of_Afflicted = v;
			Dcr.LiveList:RestAllPosition();
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList end,
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
		    get = function() return Dcr.profile.CureBlacklist end,
		    set = function(v) 
			Dcr.profile.CureBlacklist = v
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
		    get = function() return Dcr.profile.ScanTime end,
		    set = function(v)
			if (Dcr.Status.ScanShedule and v ~= Dcr.profile.ScanTime) then
			    Dcr.profile.ScanTime = v;
			    Dcr:CancelScheduledEvent(Dcr.Status.ScanShedule);
			    Dcr.Status.ScanShedule = Dcr:ScheduleRepeatingEvent("LLupdate", Dcr.LiveList.Update_Display, Dcr.profile.ScanTime, Dcr.LiveList);
			    Dcr:Debug("LV scan delay changed:", Dcr.profile.ScanTime, v);
			end
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList end,
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
		    get = function() return Dcr.profile.ReverseLiveDisplay end,
		    set = function()
			Dcr.profile.ReverseLiveDisplay = not Dcr.profile.ReverseLiveDisplay
			Dcr.LiveList:RestAllPosition();
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList end,
		    order = 107
		},
		TieLLVisibility = {
		    type = "toggle",
		    name = L[Dcr.LOC.TIE_LIVELIST],
		    desc = L[Dcr.LOC.OPT_TIE_LIVELIST_DESC],
		    get = function() return Dcr.profile.LiveListTied end,
		    set = function()
			Dcr.profile.LiveListTied = not Dcr.profile.LiveListTied
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList end,
		    order = 108
		},
		{
		    type = "header",
		    order = 999,
		},
		ShowTestItem = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF],
		    desc = L[Dcr.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC],
		    get = function() return  Dcr.LiveList.TestItemDisplayed end,
		    set = function()
			if not Dcr.LiveList.TestItemDisplayed then
			    Dcr.LiveList:DisplayTestItem();
			else
			    Dcr.LiveList:HideTestItem();
			end
		    end,
		    disabled = function() return Dcr.profile.Hide_LiveList and not Dcr.profile.ShowDebuffsFrame or not Dcr.Status.HasSpell end,
		    order = 1000
		},
		FrameScaleLL = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_LLSCALE],
		    desc = L[Dcr.LOC.OPT_LLSCALE_DESC],
		    get = function() return Dcr.profile.LiveListScale end, -- Dcr.profile.DebuffsFrameElemScale end,
		    set = function(v) 
			if (v ~= Dcr.profile.LiveListScale) then
			    Dcr.profile.LiveListScale = v;

			    Dcr:SetLLScale(Dcr.profile.LiveListScale);
			end
		    end,
		    disabled = function() return Dcr.profile.Hide_LiveList or Dcr.profile.Hidden end,
		    min = 0.3,
		    max = 4,
		    step = 0.01,
		    isPercent = true,
		    order = 1009,
		},
		AlphaLL = {
		     type = 'range',
		    name = L[Dcr.LOC.OPT_LLALPHA],
		    desc = L[Dcr.LOC.OPT_LLALPHA_DESC],
		    get = function() return 1 - Dcr.profile.LiveListAlpha end,
		    set = function(v) 
			if (v ~= Dcr.profile.LiveListAlpha) then
			    Dcr.profile.LiveListAlpha = 1 - v;
			    DecursiveMainBar:SetAlpha(Dcr.profile.LiveListAlpha);
			    DcrLiveList:SetAlpha(Dcr.profile.LiveListAlpha);
			end
		    end,
		    disabled = function() return Dcr.profile.Hide_LiveList or Dcr.profile.Hidden end,
		    min = 0,
		    max = 0.8,
		    step = 0.01,
		    isPercent = true,
		    order = 1010,
		}
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
		    get = function() return Dcr.profile.Print_ChatFrame end,
		    set = function()
			Dcr.profile.Print_ChatFrame = not Dcr.profile.Print_ChatFrame;
		    end,
		    order = 120
		},
		PrintToCustomChat = {
		    type = "toggle",
		    name =  L[Dcr.LOC.PRINT_CUSTOM],
		    desc = L[Dcr.LOC.OPT_PRINT_CUSTOM_DESC],
		    get = function() return Dcr.profile.Print_CustomFrame end,
		    set = function()
			Dcr.profile.Print_CustomFrame = not Dcr.profile.Print_CustomFrame;
		    end,
		    order = 121
		},
		PrintErrors = {
		    type = "toggle",
		    name =  L[Dcr.LOC.PRINT_ERRORS],
		    desc =  L[Dcr.LOC.OPT_PRINT_ERRORS_DESC],
		    get = function() return Dcr.profile.Print_Error end,
		    set = function()
			Dcr.profile.Print_Error = not Dcr.profile.Print_Error;
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
		    order = 1100,
		},
		Show = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_SHOWMFS],
		    desc = L[Dcr.LOC.OPT_SHOWMFS_DESC],
		    get = function() return Dcr.profile.ShowDebuffsFrame end,
		    set = function()
			Dcr:ShowHideDebuffsFrame ();
			if Dcr.profile.Hide_LiveList and not Dcr.profile.ShowDebuffsFrame then
			    Dcr:SetIcon(DcrC.IconOFF);
			else
			    Dcr:SetIcon(DcrC.IconON);
			end
		    end,
		    disabled = function() return Dcr.Status.Combat end,
		    order = 1200,
		},
		GrowToTop = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_GROWDIRECTION],
		    desc = L[Dcr.LOC.OPT_GROWDIRECTION_DESC],
		    get = function() return Dcr.profile.DebuffsFrameGrowToTop end,
		    set = function(v)
			if (v ~= Dcr.profile.DebuffsFrameGrowToTop) then
			    Dcr.profile.DebuffsFrameGrowToTop = v;
			    Dcr.MicroUnitF:ResetAllPositions ();
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    order = 1300,
		},
		ShowBorder = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_SHOWBORDER],
		    desc = L[Dcr.LOC.OPT_SHOWBORDER_DESC],
		    get = function() return Dcr.profile.DebuffsFrameElemBorderShow end,
		    set = function(v)
			if (v ~= Dcr.profile.DebuffsFrameElemBorderShow) then
			    Dcr.profile.DebuffsFrameElemBorderShow = v;
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    order = 1350,
		},
		{
		    type = "header",
		    order = 1400,
		},
		MaxCount = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MAXMFS],
		    desc = L[Dcr.LOC.OPT_MAXMFS_DESC],
		    get = function() return Dcr.profile.DebuffsFrameMaxCount end,
		    set = function(v) 
			if (v ~= Dcr.profile.DebuffsFrameMaxCount) then
			    Dcr.profile.DebuffsFrameMaxCount = v;
			    Dcr.MicroUnitF.MaxUnit = v;
			    -- Dcr.Status.SpellsChanged = GetTime(); -- to force old previously unshown unit frames to update XXX useful??
			    Dcr.MicroUnitF:Delayed_MFsDisplay_Update();
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 82,
		    step = 1,
		    isPercent = false,
		    order = 1500,
		},
		MFPerline = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_UNITPERLINES],
		    desc = L[Dcr.LOC.OPT_UNITPERLINES_DESC],
		    get = function() return Dcr.profile.DebuffsFramePerline end,
		    set = function(v) 
			if (v ~= Dcr.profile.DebuffsFramePerline) then
			    Dcr.profile.DebuffsFramePerline = v;
			    Dcr.MicroUnitF:ResetAllPositions ();
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 40,
		    step = 1,
		    isPercent = false,
		    order = 1600,
		},
		{
		    type = "header",
		    order = 1700,
		},
		FrameScale = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFSCALE],
		    desc = L[Dcr.LOC.OPT_MFSCALE_DESC],
		    get = function() return Dcr.profile.DebuffsFrameElemScale end, -- Dcr.profile.DebuffsFrameElemScale end,
		    set = function(v) 
			if (v ~= Dcr.profile.DebuffsFrameElemScale) then
			    Dcr.profile.DebuffsFrameElemScale = v;


			    Dcr.MicroUnitF:SetScale(Dcr.profile.DebuffsFrameElemScale);

			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    min = 0.3,
		    max = 4,
		    step = 0.01,
		    isPercent = true,
		    order = 1800,
		},
		Alpha = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFALPHA],
		    desc = L[Dcr.LOC.OPT_MFALPHA_DESC],
		    get = function() return 1 - Dcr.profile.DebuffsFrameElemAlpha end,
		    set = function(v) 
			if (v ~= Dcr.profile.DebuffsFrameElemAlpha) then
			    Dcr.profile.DebuffsFrameElemAlpha = 1 - v;
			    Dcr.profile.DebuffsFrameElemBorderAlpha = (1 - v) / 2;
			end
		    end,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame or not Dcr.profile.DebuffsFrameElemTieTransparency end,
		    min = 0,
		    max = 1,
		    step = 0.01,
		    isPercent = true,
		    order = 1900,
		},
		AdvDispOptions = {
		    type = "group",
		    name = L[Dcr.LOC.OPT_ADVDISP],
		    desc = L[Dcr.LOC.OPT_ADVDISP_DESC],
		    order = 2000,
		    disabled = function() return Dcr.Status.Combat or not Dcr.profile.ShowDebuffsFrame end,
		    args = {
			TieTransparency = {
			    type = "toggle",
			    name = L[Dcr.LOC.OPT_TIECENTERANDBORDER],
			    desc = L[Dcr.LOC.OPT_TIECENTERANDBORDER_OPT],
			    get = function() return Dcr.profile.DebuffsFrameElemTieTransparency end,
			    set = function(v)
				if (v ~= Dcr.profile.DebuffsFrameElemTieTransparency) then
				    Dcr.profile.DebuffsFrameElemTieTransparency = v;
				    if v then
					Dcr.profile.DebuffsFrameElemBorderAlpha = (Dcr.profile.DebuffsFrameElemAlpha / 2);
				    end
				end
			    end,
			    disabled = function() return Dcr.Status.Combat end,
			    order = 100
			},
			BorderAlpha = {
			    type = 'range',
			    name = L[Dcr.LOC.OPT_BORDERTRANSP],
			    desc = L[Dcr.LOC.OPT_BORDERTRANSP_DESC],
			    get = function() return 1 - Dcr.profile.DebuffsFrameElemBorderAlpha end,
			    set = function(v) 
				if (v ~= Dcr.profile.DebuffsFrameElemBorderAlpha) then
				    Dcr.profile.DebuffsFrameElemBorderAlpha = 1 - v;
				end
			    end,
			    disabled = function() return Dcr.Status.Combat or Dcr.profile.DebuffsFrameElemTieTransparency end,
			    min = 0,
			    max = 1,
			    step = 0.01,
			    isPercent = true,
			    order = 102,
			},
			CenterAlpha = {
			    type = 'range',
			    name = L[Dcr.LOC.OPT_CENTERTRANSP],
			    desc = L[Dcr.LOC.OPT_CENTERTRANSP_DESC],
			    get = function() return 1 - Dcr.profile.DebuffsFrameElemAlpha end,
			    set = function(v) 
				if (v ~= Dcr.profile.DebuffsFrameElemAlpha) then
				    Dcr.profile.DebuffsFrameElemAlpha = 1 - v;
				    if Dcr.profile.DebuffsFrameElemTieTransparency then
					Dcr.profile.DebuffsFrameElemBorderAlpha = (1 - v) / 2;
				    end
				end
			    end,
			    disabled = function() return Dcr.Status.Combat end,
			    min = 0,
			    max = 1,
			    step = 0.01,
			    isPercent = true,
			    order = 101,
			},
			{
			    type = "header",
			    order = 103,
			},
			TieXY = {
			    type = "toggle",
			    name = L[Dcr.LOC.OPT_TIEXYSPACING],
			    desc = L[Dcr.LOC.OPT_TIEXYSPACING_DESC],
			    get = function() return Dcr.profile.DebuffsFrameTieSpacing end,
			    set = function(v)
				if (v ~= Dcr.profile.DebuffsFrameTieSpacing) then
				    Dcr.profile.DebuffsFrameTieSpacing = v;
				    if v then
					Dcr.profile.DebuffsFrameYSpacing = Dcr.profile.DebuffsFrameXSpacing;
				    end
				    Dcr.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return Dcr.Status.Combat end,
			    order = 104
			},
			XSpace = {
			    type = 'range',
			    name = L[Dcr.LOC.OPT_XSPACING],
			    desc = L[Dcr.LOC.OPT_XSPACING_DESC],
			    get = function() return Dcr.profile.DebuffsFrameXSpacing end,
			    set = function(v) 
				if (v ~= Dcr.profile.DebuffsFrameXSpacing) then
				    Dcr.profile.DebuffsFrameXSpacing = v;
				    if Dcr.profile.DebuffsFrameTieSpacing then
					Dcr.profile.DebuffsFrameYSpacing = v;
				    end
				    Dcr.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return Dcr.Status.Combat end,
			    min = 0,
			    max = 100,
			    step = 1,
			    isPercent = false,
			    order = 105,
			},
			YSpace = {
			    type = 'range',
			    name = L[Dcr.LOC.OPT_YSPACING],
			    desc = L[Dcr.LOC.OPT_YSPACING_DESC],
			    get = function() return Dcr.profile.DebuffsFrameYSpacing end,
			    set = function(v) 
				if (v ~= Dcr.profile.DebuffsFrameYSpacing) then
				    Dcr.profile.DebuffsFrameYSpacing = v;
				    Dcr.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return Dcr.Status.Combat or Dcr.profile.DebuffsFrameTieSpacing end,
			    min = 0,
			    max = 100,
			    step = 1,
			    isPercent = false,
			    order = 106,
			},
		    }
		},
		{
		    type = "header",
		    order = 2100,
		},
		ToolTips = {
		    type = "toggle",
		    name = L[Dcr.LOC.SHOW_TOOLTIP],
		    desc = L[Dcr.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return Dcr.profile.AfflictionTooltips end,
		    set = function()
			Dcr.profile.AfflictionTooltips = not Dcr.profile.AfflictionTooltips
		    end,
		    disabled = function() return  Dcr.profile.Hide_LiveList and not Dcr.profile.ShowDebuffsFrame end,
		    order = 2200
		},
		ShowHelp = {
		    type = "toggle",
		    name = L[Dcr.LOC.OPT_SHOWHELP],
		    desc = L[Dcr.LOC.OPT_SHOWHELP_DESC],
		    get = function() return Dcr.profile.DebuffsFrameShowHelp end,
		    set = function()
			Dcr.profile.DebuffsFrameShowHelp = not Dcr.profile.DebuffsFrameShowHelp;

		    end,
		    disabled = function() return not Dcr.profile.ShowDebuffsFrame end,
		    order = 2300,
		},
		{
		    type = "header",
		    order = 2400,
		},
		title2 = {
		    type = "header",
		    name = L[Dcr.LOC.OPT_MFPERFOPT],
		    textHeight = 13,
		    justifyH = "CENTER",
		    order = 2500,
		},
		UpdateRate = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFREFRESHRATE],
		    desc = L[Dcr.LOC.OPT_MFREFRESHRATE_DESC],
		    get = function() return Dcr.profile.DebuffsFrameRefreshRate end,
		    set = function(v) 
			if (Dcr.Status.MicroFrameUpdateSchedule and v ~= Dcr.profile.DebuffsFrameRefreshRate) then
			    Dcr.profile.DebuffsFrameRefreshRate = v;

			    Dcr:CancelScheduledEvent(Dcr.Status.MicroFrameUpdateSchedule);
			    Dcr.Status.MicroFrameUpdateSchedule =
			    Dcr:ScheduleRepeatingEvent("MUFupdate", Dcr.DebuffsFrame_Update, Dcr.profile.DebuffsFrameRefreshRate);
			    Dcr:Debug("MUFs refresh rate changed:", Dcr.profile.DebuffsFrameRefreshRate, v);
			end
		    end,
		    disabled = function() return not Dcr.profile.ShowDebuffsFrame end,
		    min = 0.017,
		    max = 0.2,
		    step = 0.01,
		    isPercent = false,
		    order = 2600,
		},
		PerUpdate = {
		    type = 'range',
		    name = L[Dcr.LOC.OPT_MFREFRESHSPEED],
		    desc = L[Dcr.LOC.OPT_MFREFRESHSPEED_DESC],
		    get = function() return Dcr.profile.DebuffsFramePerUPdate end,
		    set = function(v) 
			if (v ~= Dcr.profile.DebuffsFramePerUPdate) then
			    Dcr.profile.DebuffsFramePerUPdate = v;
			end
		    end,
		    disabled = function() return not Dcr.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 20,
		    step = 1,
		    isPercent = false,
		    order = 2700,
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
		    get = function() return Dcr.profile.Check_For_Abolish end,
		    set = function()
			Dcr.profile.Check_For_Abolish = not Dcr.profile.Check_For_Abolish;
		    end,
		    order = 130
		},
		DoNotBlPrios = {
		    type = "toggle",
		    name =  L[Dcr.LOC.DONOT_BL_PRIO],
		    desc = L[Dcr.LOC.OPT_DONOTBLPRIO_DESC],
		    get = function() return Dcr.profile.DoNot_Blacklist_Prio_List end,
		    set = function()
			Dcr.profile.DoNot_Blacklist_Prio_List = not Dcr.profile.DoNot_Blacklist_Prio_List;
		    end,
		    order = 131
		},
		RandomCure = {
		    type = "toggle",
		    name =  L[Dcr.LOC.RANDOM_ORDER],
		    desc =  L[Dcr.LOC.OPT_RANDOMORDER_DESC],
		    get = function() return Dcr.profile.Random_Order end,
		    set = function()
			Dcr.profile.Random_Order = not Dcr.profile.Random_Order;
			Dcr.Groups_datas_are_invalid = true;
		    end,
		    order = 132
		},
		CurePets = {
		    type = "toggle",
		    name =  L[Dcr.LOC.CURE_PETS],
		    desc = L[Dcr.LOC.OPT_CUREPETS_DESC],
		    get = function() return Dcr.profile.Scan_Pets end,
		    set = function()
			Dcr.profile.Scan_Pets = not Dcr.profile.Scan_Pets;
			Dcr.Groups_datas_are_invalid = true;
			Dcr.MicroUnitF:Delayed_MFsDisplay_Update();
		    end,
		    order = 133
		},
		SkipStealthed = {
		    type = "toggle",
		    name =  L[Dcr.LOC.IGNORE_STEALTH],
		    desc = L[Dcr.LOC.OPT_IGNORESTEALTHED_DESC],
		    get = function() return Dcr.profile.Ingore_Stealthed end,
		    set = function()
			Dcr.profile.Ingore_Stealthed = not Dcr.profile.Ingore_Stealthed;
		    end,
		    order = 134
		},



		{
		    type = "header", order = 138,}, Title2 = {
			type="header",  textHeight = 13,
			name = L[Dcr.LOC.OPT_CURINGORDEROPTIONS],
		    order = 139,
		},
		{ type = "header", order = 140,   },

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
		    name = Dcr.L[Dcr.LOC.MAGICCHARMED],
		    desc = L[Dcr.LOC.OPT_MAGICCHARMEDCHECK_DESC],
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
		CureCharmed = {
		    type = "toggle",
		    name = Dcr.L[Dcr.LOC.CHARMED],
		    desc = L[Dcr.LOC.OPT_CHARMEDCHECK_DESC],
		    get = function() return Dcr:GetCureCheckBoxStatus(DcrC.CHARMED) end,
		    set = function()
			Dcr:SetCureOrder (DcrC.CHARMED);
		    end,
		    disabled = function() return not Dcr.Status.CuringSpells[DcrC.CHARMED] end,
		    CureType = DcrC.CHARMED,
		    order = 146
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
	    disabled = function() return  not Dcr.Status.Enabled or Dcr.Status.Combat end,
	    args = {
		SetKey = {
		    type = "text",
		    name = L[Dcr.LOC.OPT_MACROBIND],
		    desc = L[Dcr.LOC.OPT_MACROBIND_DESC],
		    validate = "keybinding",
		    get = function ()
			local key = (GetBindingKey(string.format("MACRO %s", Dcr.CONF.MACRONAME)));
			Dcr.profile.MacroBind = key;
			return key;
		    end,
		    set = function (key)
			 Dcr:SetMacroKey ( key );
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
	spacer5 = {
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
[DcrC.CHARMED]	    = Dcr.options.args.CureOptions.args.CureCharmed,
}

function Dcr:GetCureCheckBoxStatus (Type)

    return Dcr.profile.CureOrder[Type] and Dcr.profile.CureOrder[Type] > 0;
end

function Dcr:SetCureCheckBoxNum (Type)
    local CheckBox = Dcr.CureCheckBoxes[Type];

    -- save the old name
    if (not CheckBox.NameOnly) then
	CheckBox.NameOnly = CheckBox.name;
    end

    -- add the number in green before the name if we have a spell available and if we checked the box
    if (Dcr:GetCureCheckBoxStatus(Type)) then
	CheckBox.name = Dcr:ColorText(Dcr.profile.CureOrder[Type], "FF00FF00") .. " " .. CheckBox.NameOnly;
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
	[DcrC.CHARMED]	    = 6,
    };
    local AuthorizedValues = {
	[false]	= true; -- LOL Yes, it's TRUE tnat FALSE is an authorized value xD
	-- Other <0  values are used when there used to be a spell...
	[1]	= DcrC.ENEMYMAGIC,
	[-11]	= DcrC.ENEMYMAGIC,
	[2]	= DcrC.MAGIC,
	[-12]	= DcrC.MAGIC,
	[3]	= DcrC.CURSE,
	[-13]	= DcrC.CURSE,
	[4]	= DcrC.POISON,
	[-14]	= DcrC.POISON,
	[5]	= DcrC.DISEASE,
	[-15]	= DcrC.DISEASE,
	[6]	= DcrC.CHARMED,
	[-16]	= DcrC.CHARMED,
    };
    local GivenValues = {};


    -- add missing entries...
    for key, value in pairs(AuthorizedKeys) do
	if not Dcr.profile.CureOrder[key] then
	    Dcr.profile.CureOrder[key] = false;
	end
    end

    -- Validate existing entries
    local WrongValue = 0;
    for key, value in pairs(Dcr.profile.CureOrder) do

	if (AuthorizedKeys[key]) then -- is this a correct type ?
	    if (AuthorizedValues[value] and not GivenValues[value]) then -- is this value authorized and not already given?
		--TempTable[key] = value;
		GivenValues[value] = true;

	    elseif (value) then -- FALSE is the only value that can be given several times
		Dcr:Debug("Incoherent value for (key, value, Duplicate?)", key, value, GivenValues[value]);

		Dcr.profile.CureOrder[key] = -20 - WrongValue; -- if the value was wrong or already given to another type
		WrongValue = WrongValue + 1;
	    end
	else
	    Dcr.profile.CureOrder[key] = nil; -- remove it from the table
	end
    end

    --Dcr.profile.CureOrder = TempTable;
end

function Dcr:SetCureOrder (ToChange)

    local CureOrder = Dcr.profile.CureOrder;
    local tmpTable = {};
    Dcr:Debug("SetCureOrder called for prio ", CureOrder[ToChange]);

    if (ToChange) then
	-- if there is a positive value, it means we want to disable this type, set it to false (see GetCureCheckBoxStatus())
	if (Dcr:GetCureCheckBoxStatus(ToChange)) then
	    CureOrder[ToChange] = false;
	    Dcr:Debug("SetCureOrder(): set to false");
	else -- else if there was no value (or a negative one), add this type at the end (see GetCureCheckBoxStatus())
	    CureOrder[ToChange] = 20; -- this will cause the spell to be added at the end
	    Dcr:Debug("SetCureOrder(): set to 20");
	end
    end

    local LostSpells = {}; -- an orphanage for the lost spells :'(
    local FoundSpell = 0; -- we wouldn't need that if #table was always returning something meaningful...

    -- re-compute the position of each spell type
    for Type, Num in pairs (CureOrder) do

	-- if we have a spell or if we did not unchecked the checkbox (note the difference between "checked" and "not unchecked")
	if (Dcr.Status.CuringSpells[Type] and CureOrder[Type]) then
	    tmpTable[math.abs(CureOrder[Type])] = Type; -- CureOrder[Type] can have a <0 value if the spell was lost
	    FoundSpell = FoundSpell + 1;
	elseif (CureOrder[Type]) then -- if we don't have a spell for this type
	    LostSpells[math.abs(CureOrder[Type])] = Type;  -- save the position
	end
    end

   -- take care of the lost spells here
   -- Sort the lost spells so that they can be readded in the correct order
   LostSpells =  Dcr:tSortUsingKeys(LostSpells);

   -- Place the lost spells after the found ones but with <0 values so they
   -- can be readded later using their former priorities
   local AvailableSpot = (FoundSpell + 10 + 1) * -1; -- we add 10 so that they'll be re-added after any not-lost spell...

   -- Dcr:PrintLiteral(LostSpells);
   for FormerPrio, Type in ipairs(LostSpells) do
       CureOrder[Type] = AvailableSpot
       AvailableSpot = AvailableSpot - 1;
   end

    -- we sort the tables
    tmpTable = Dcr:tSortUsingKeys(tmpTable);

    -- apply the new priority to the types we can handle, leave their negative value to the others
    for Num, Type in ipairs (tmpTable) do
	CureOrder[Type] = Num;
    end

    -- create / update the ReversedCureOrder table (prio => type, ..., )
    Dcr.Status.ReversedCureOrder = Dcr:tReverse(CureOrder);

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
    for i=1,6 do
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

    if Dcr.Status.Combat then
	return
    end

    Dcr.profile.ShowDebuffsFrame = not Dcr.profile.ShowDebuffsFrame;

    if (Dcr.MFContainer:IsVisible()) then
	Dcr.MFContainer:Hide();
	Dcr.profile.ShowDebuffsFrame = false;
    else
	Dcr.MFContainer:Show();
	Dcr.MFContainer:SetScale(Dcr.profile.DebuffsFrameElemScale);
	Dcr.MicroUnitF:Place ();
	Dcr.profile.ShowDebuffsFrame = true;

	local i = 0;

	for ID, MF in pairs(Dcr.MicroUnitF.ExistingPerID) do
	    if MF.IsDebuffed then
		Dcr:ScheduleEvent("updMUF"..i, Dcr.SpecialEvents_UnitDebuffLost, i * (Dcr.profile.ScanTime / 2), Dcr, MF.CurrUnit, "Test item");
		i = i + 1;
	    end
	end
    end

    if (not Dcr.profile.ShowDebuffsFrame) then
	Dcr:CancelScheduledEvent(Dcr.Status.MicroFrameUpdateSchedule);
	Dcr.Status.MicroFrameUpdateSchedule = false;
    elseif (not Dcr.Status.MicroFrameUpdateSchedule) then
	Dcr.Status.MicroFrameUpdateSchedule =
	Dcr:ScheduleRepeatingEvent("MUFupdate", Dcr.DebuffsFrame_Update, Dcr.profile.DebuffsFrameRefreshRate);
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

	local DebuffsSkipList	= Dcr.profile.DebuffsSkipList;
	local skipByClass	= Dcr.profile.skipByClass;
	local AlwaysSkipList	= Dcr.profile.DebuffAlwaysSkipList;


	Dcr:tremovebyval(DebuffsSkipList, Dcr.Tmp.DebuffToRemove)

	for class, debuffs in pairs (skipByClass) do
	    skipByClass[class][Dcr.Tmp.DebuffToRemove] = nil; -- XXX changed from false to nil on 20070415
	end

	AlwaysSkipList[Dcr.Tmp.DebuffToRemove] = nil; -- remove it from the table

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

    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    ShowAlert = 1,
}; -- // }}}


do -- this is a closure, it's a bit like {} blocks in C

    local DebuffsSkipList, DefaultDebuffsSkipList, skipByClass, AlwaysSkipList, DefaultSkipByClass;

    local spacer = function(num) return { type="header", order = 100 + num } end;

    -- so we can pass arguments to functions like StaticPopupDialogs...
    Dcr.Tmp = {};



    local RemoveFunc = function (handler)
	Dcr:Debug("Removing '%s'...", handler["Debuff"]);
	Dcr.Tmp.DebuffToRemove = handler["Debuff"];
	StaticPopup_Show ("DCR_REMOVE_SKIPPED_DEBUFF_CONFIRMATION", Dcr:ColorText(handler["Debuff"], "FF11AA66"));
	Dcr.DewDrop:Close(1);
    end

    local AddToAlwaysSkippFunc = function (handler, v)
	AlwaysSkipList[handler["Debuff"]] = v;
    end

    local ResetFunc = function (handler)
	local DebuffName = handler["Debuff"];

	Dcr:Debug("Resetting '%s'...", handler["Debuff"]);

	for Classe, Debuffs in pairs(skipByClass) do
	    if (DefaultSkipByClass[Classe][DebuffName]) then
		skipByClass[Classe][DebuffName] = true;
	    else
		skipByClass[Classe][DebuffName] = nil; -- Removes it XXX
	    end
	end
    end

    local function ClassCheckbox (Class, DebuffName, num)
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
		    local skipByClass = Dcr.profile.skipByClass;
		    return skipByClass[args["Class"]][args["Debuff"]]; 
		end,
		["set"] = function  (args, v)
		    local skipByClass = Dcr.profile.skipByClass;
		    skipByClass[args["Class"]][string.trim(args["Debuff"])] = v;
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

	classes["PermIgnore"] = {
	    type = "toggle",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_ALWAYSIGNORE], "FFFF9900"),
	    desc = string.format(L[Dcr.LOC.OPT_ALWAYSIGNORE_DESC], DebuffName),
	    handler = {
		["Debuff"] = DebuffName,
		["get"] = function (args)
		    return AlwaysSkipList[args["Debuff"]];
		end,
		["set"] = AddToAlwaysSkippFunc,
	    },
	    get = "get",
	    set = "set",
	    order = 100 + num;

	};

	num = num + 1;

	classes["spacer1p5"] = spacer(num);

	num = num + 1;

	classes["remove"] = {
	    type = "execute",
	    name = Dcr:ColorText(L[Dcr.LOC.OPT_REMOVETHISDEBUFF], "FFFF0000"),
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
	    desc = not resetDisabled and string.format(L[Dcr.LOC.OPT_RESETDTDCRDEFAULT], DebuffName) or L[Dcr.LOC.OPT_USERDEBUFF],
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
	DebuffsSkipList	    = Dcr.profile.DebuffsSkipList;
	DefaultDebuffsSkipList    = Dcr.defaults.DebuffsSkipList;

	skipByClass		    = Dcr.profile.skipByClass;
	AlwaysSkipList		    = Dcr.profile.DebuffAlwaysSkipList;
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

	Dcr.options.args.DebuffSkip.args = DebuffsSubMenu;

    end
end


function Dcr:SetMacroKey ( key )

    if (key and key == Dcr.profile.MacroBind and GetBindingAction(key) == string.format("MACRO %s",Dcr.CONF.MACRONAME)) then
	return;
    end

    -- if there is current set key currently mapped to Decursive macro (it means we are changing the key)
    if (Dcr.profile.MacroBind and GetBindingAction(Dcr.profile.MacroBind) == string.format("MACRO %s",Dcr.CONF.MACRONAME)) then

	-- clearing redudent mapping to Decursive macro.
	local MappedKeys = {GetBindingKey(string.format("MACRO %s", Dcr.CONF.MACRONAME))};
	for _, key in pairs(MappedKeys) do
	    Dcr:Debug("Unlinking [%s]", key);
	    SetBinding(key, nil); -- clear the binding
	end

	-- Restore previous key state
	if (Dcr.profile.PreviousMacroKeyAction) then
	    Dcr:Debug("Previous key action restored:", Dcr.profile.PreviousMacroKeyAction);
	    if not SetBinding(Dcr.profile.MacroBind, Dcr.profile.PreviousMacroKeyAction) then
		Dcr:Debug("Restoration failed");
	    end
	end
    end


    if (key) then
	if (GetBindingAction(key) ~= "" and GetBindingAction(key) ~= string.format("MACRO %s",Dcr.CONF.MACRONAME)) then
	    -- save current key assignement
	    Dcr.profile.PreviousMacroKeyAction = GetBindingAction(key)
	    Dcr:Debug("Old key action saved:", Dcr.profile.PreviousMacroKeyAction);
	    Dcr:errln(L[Dcr.LOC.MACROKEYALREADYMAPPED], key, Dcr.profile.PreviousMacroKeyAction);
	else
	    Dcr.profile.PreviousMacroKeyAction = false;
	    Dcr:Debug("Old key action not saved because it was mapped to nothing");
	end

	-- set
	if (SetBindingMacro(key, Dcr.CONF.MACRONAME)) then
	    Dcr.profile.MacroBind = key;
	    Dcr:Println(L[Dcr.LOC.MACROKEYMAPPINGSUCCESS], key);
	else
	    Dcr:errln(L[Dcr.LOC.MACROKEYMAPPINGFAILED], key);
	end
    else
	Dcr.profile.MacroBind = false;
	if not (GetBindingKey(string.format("MACRO %s", Dcr.CONF.MACRONAME))) then
	    Dcr:errln(L[Dcr.LOC.MACROKEYNOTMAPPED]);
	end
    end

    -- save the bindings to disk
    SaveBindings(GetCurrentBindingSet());

end
