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

if not DcrLoadedFiles or not DcrLoadedFiles["localization.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (localization.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D = Dcr;
D:SetDateAndRevision("$Date$", "$Revision$");

local L  = D.L;
local BS = D.BS;
local BC = D.BC;
local DC = DcrC;

-- Default values for the option

D.defaults = { -- {{{
    debugging = false,
    -- this is the priority list of people to cure
    PriorityList = { },
    PriorityListClass = { },
    -- this is the people to skip
    SkipList = { },
    SkipListClass = { },

    -- The micro units debuffs frame
    ShowDebuffsFrame = true,

    -- The maximum number of MUFs to be displayed
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

    -- The time between each MUF update
    DebuffsFrameRefreshRate = 0.10,

    -- The number of MUFs updated every DebuffsFrameRefreshRate
    DebuffsFramePerUPdate = 10,

    DebuffsFrameShowHelp = true,

    -- position x save
    DebuffsFrame_x = false,

    -- position y save
    DebuffsFrame_y = false,

    -- reverse MUFs disaplay
    DebuffsFrameGrowToTop = false,

    -- this is wether or not to show the live-list	
    Hide_LiveList = false,

    LiveListAlpha = 0.7;

    LiveListScale = 1.0;

    -- position of the "Decursive" main bar, the live-list is anchored to this bar.
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

    -- Will randomize the order of the live-list and of the MUFs
    Random_Order = false,

    -- should we scan pets
    Scan_Pets = true,

    -- should we ignore stealthed units
    Ingore_Stealthed = true,

    -- how many to show in the livelist
    Amount_Of_Afflicted = 3,

    -- The live-list will only display units in range of your curring spell
    LV_OnlyInRange = true,

    -- how many seconds to "black list" someone with a failed spell
    CureBlacklist	= 5.0,

    -- how often to poll for afflictions in seconds (for the live-list only)
    ScanTime = 0.3,

    -- Are prio list members protected from blacklisting?
    DoNot_Blacklist_Prio_List = false,

    -- Play a sound when there is something to decurse
    PlaySound = true,

    -- The sound file to use
    SoundFile = "Sound\\Doodad\\BellTollTribal.wav";

    -- Hide the buttons
    HideButtons = false,

    -- Display text above in the custom frame
    CustomeFrameInsertBottom = false,

    -- Disable tooltips in affliction list
    AfflictionTooltips = true,

    -- Reverse LiveList Display
    ReverseLiveDisplay = false,

    -- Hide the "Decursive" bar
    Hidden = false,

    -- if true then the live list will show only if the "Decursive" bar is shown
    LiveListTied = false,

    -- allow to changes the default output window
    OutputWindow = "DEFAULT_CHAT_FRAME", -- ACEDB CRASHES if we set it directly

    -- Are we using the macro?
    UseMacro = true,

    -- the key to bind the macro to
    MacroBind = false, --L[D.LOC.DEFAULT_MACROKEY], -- there were too many unhappy people with this option

    -- Display a warning if no key is mapped.
    NoKeyWarn = true,


    -- Curring order (1 is the most important, 6 the lesser...)
    CureOrder = {
	[DC.ENEMYMAGIC]   = 1,
	[DC.MAGIC]	    = 2,
	[DC.CURSE]	    = 3,
	[DC.POISON]	    = 4,
	[DC.DISEASE]	    = 5,
	[DC.CHARMED]	    = 6,
    },


    -- Debuffs {{{

    DebuffsToIgnore = { -- those debuffs prevent us from curing the unit
	[BS["Phase Shift"]]		= true,
	[BS["Banish"]]			= true,
	[BS["Frost Trap Aura"]]		= true,
    },

    BuffDebuff = { -- thoses debuffs are in fact buffs...
	[L[D.LOC.DREAMLESSSLEEP]]	= true,
	[L[D.LOC.GDREAMLESSSLEEP]]	= true,
	[L[D.LOC.MDREAMLESSSLEEP]]	= true,
	[BS[DCR_LOC_MINDVISION]]	= true,
	[L[D.LOC.MUTATINGINJECTION]]	= true,
	[BS["Arcane Blast"]]		= true,
    },

    DebuffAlwaysSkipList = {
    },

    DebuffsSkipList = {
	BS[DCR_LOC_SILENCE],
	L[D.LOC.ANCIENTHYSTERIA],
	L[D.LOC.IGNITE],
	L[D.LOC.TAINTEDMIND],
	L[D.LOC.MAGMASHAKLES],
	L[D.LOC.CRIPLES],
	L[D.LOC.DUSTCLOUD],
	L[D.LOC.WIDOWSEMBRACE],
	BS[D.LOC.CURSEOFTONGUES],
	L[D.LOC.SONICBURST],
	L[D.LOC.THUNDERCLAP],
	L[D.LOC.DELUSIONOFJINDO]
    },
    skipByClass = {
	["WARRIOR"] = {
	    [L[D.LOC.ANCIENTHYSTERIA]]   = true,
	    [L[D.LOC.IGNITE]]        = true,
	    [L[D.LOC.TAINTEDMIND]]       = true,
	    [L[D.LOC.WIDOWSEMBRACE]]    = true,
	    [BS[D.LOC.CURSEOFTONGUES]]   = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["ROGUE"] = {
	    [BS[DCR_LOC_SILENCE]]           = true,
	    [L[D.LOC.ANCIENTHYSTERIA]]   = true,
	    [L[D.LOC.IGNITE]]        = true,
	    [L[D.LOC.TAINTEDMIND]]       = true,
	    [L[D.LOC.WIDOWSEMBRACE]]    = true,
	    [BS[D.LOC.CURSEOFTONGUES]]   = true,
	    [L[D.LOC.SONICBURST]]        = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["HUNTER"] = {
	    [L[D.LOC.MAGMASHAKLES]]     = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["MAGE"] = {
	    [L[D.LOC.MAGMASHAKLES]]     = true,
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.THUNDERCLAP]]        = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["WARLOCK"] = {
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.THUNDERCLAP]]        = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["DRUID"] = {
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.THUNDERCLAP]]        = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["PALADIN"] = {
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["PRIEST"] = {
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.THUNDERCLAP]]        = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	},
	["SHAMAN"] = {
	    [L[D.LOC.CRIPLES]]            = true,
	    [L[D.LOC.DUSTCLOUD]]         = true,
	    [L[D.LOC.DELUSIONOFJINDO]]= true,
	}
    }
    -- }}}

} -- }}}

D.options = { -- {{{
    type = "group",
    handler = D,
    args = {
	title = {
	    type = "header",
	    name = L[D.LOC.STR_OPTIONS],
	    textHeight = 13,
	    justifyH = "CENTER",
	    order = 50,
	},
	spacer1 = {
	    type = "header",
	},
	livelistoptions = { -- {{{
	    type = "group",
	    name = D:ColorText(L[D.LOC.OPT_LIVELIST], "FF22EE33"),
	    desc = L[D.LOC.OPT_LIVELIST_DESC],
	    order = 100,
	    disabled = function() return  not D.Status.Enabled end,

	    args = {
		show = {
		    type = "toggle",
		    name = L[D.LOC.HIDE_LIVELIST],
		    desc = L[D.LOC.OPT_HIDELIVELIST_DESC],
		    get = function() return  D.profile.Hide_LiveList end,
		    set = function()
			D:ShowHideLiveList()
			if D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame then
			    D:SetIcon(DC.IconOFF);
			else
			    D:SetIcon(DC.IconON);
			end
		    end,
		    disabled = function() return D.profile.LiveListTied end,
		    order = 100
		},
		OnlyInRange = {
		    type = "toggle",
		    name = L[D.LOC.OPT_LVONLYINRANGE],
		    desc = L[D.LOC.OPT_LVONLYINRANGE_DESC],
		    get = function() return D.profile.LV_OnlyInRange end,
		    set = function() D.profile.LV_OnlyInRange = not D.profile.LV_OnlyInRange end,
		    disabled = function() return D.profile.Hide_LiveList end,
		    order = 100.5
		},
		ToolTips = {
		    type = "toggle",
		    name = L[D.LOC.SHOW_TOOLTIP],
		    desc = L[D.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return D.profile.AfflictionTooltips end,
		    set = function()
			D.profile.AfflictionTooltips = not D.profile.AfflictionTooltips
		    end,
		    disabled = function() return  D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame end,
		    order = 102
		},
		Sound = {
		    type = "toggle",
		    name = L[D.LOC.PLAY_SOUND],
		    desc = L[D.LOC.OPT_PLAYSOUND_DESC],
		    get = function() return D.profile.PlaySound end,
		    set = function()
			D.profile.PlaySound = not D.profile.PlaySound
		    end,
		    disabled = function() return  D.profile.Hide_LiveList and not  D.profile.ShowDebuffsFrame end,
		    order = 103
		},
		livenum = {
		    type = 'range',
		    name = L[D.LOC.AMOUNT_AFFLIC],
		    desc = L[D.LOC.OPT_AMOUNT_AFFLIC_DESC],
		    get = function() return D.profile.Amount_Of_Afflicted end,
		    set = function(v) 
			D.profile.Amount_Of_Afflicted = v;
			D.LiveList:RestAllPosition();
		    end,
		    disabled = function() return  D.profile.Hide_LiveList end,
		    min = 1,
		    max = D.CONF.MAX_LIVE_SLOTS,
		    step = 1,
		    isPercent = false,
		    order = 104,
		},
		BlacklistedTime = {
		    type = 'range',
		    name = L[D.LOC.BLACK_LENGTH],
		    desc = L[D.LOC.OPT_BLACKLENTGH_DESC],
		    get = function() return D.profile.CureBlacklist end,
		    set = function(v) 
			D.profile.CureBlacklist = v
		    end,
		    min = 1,
		    max = 20,
		    step = 0.1,
		    isPercent = false,
		    order = 105,
		},
		ScanFreq = {
		    type = 'range',
		    name = L[D.LOC.SCAN_LENGTH],
		    desc = L[D.LOC.OPT_SCANLENGTH_DESC],
		    get = function() return D.profile.ScanTime end,
		    set = function(v)
			if (v ~= D.profile.ScanTime) then
			    D.profile.ScanTime = v;
			    D:ScheduleRepeatingEvent("LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
			    D:Debug("LV scan delay changed:", D.profile.ScanTime, v);
			end
		    end,
		    disabled = function() return  D.profile.Hide_LiveList end,
		    min = 0.1,
		    max = 1,
		    step = 0.1,
		    isPercent = false,
		    order = 106,
		},
		ReverseLL = {
		    type = "toggle",
		    name = L[D.LOC.REVERSE_LIVELIST],
		    desc = L[D.LOC.OPT_REVERSE_LIVELIST_DESC],
		    get = function() return D.profile.ReverseLiveDisplay end,
		    set = function()
			D.profile.ReverseLiveDisplay = not D.profile.ReverseLiveDisplay
			D.LiveList:RestAllPosition();
		    end,
		    disabled = function() return  D.profile.Hide_LiveList end,
		    order = 107
		},
		TieLLVisibility = {
		    type = "toggle",
		    name = L[D.LOC.TIE_LIVELIST],
		    desc = L[D.LOC.OPT_TIE_LIVELIST_DESC],
		    get = function() return D.profile.LiveListTied end,
		    set = function()
			D.profile.LiveListTied = not D.profile.LiveListTied
		    end,
		    disabled = function() return  D.profile.Hide_LiveList end,
		    order = 108
		},
		{
		    type = "header",
		    order = 999,
		},
		ShowTestItem = {
		    type = "toggle",
		    name = L[D.LOC.OPT_CREATE_VIRTUAL_DEBUFF],
		    desc = L[D.LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC],
		    get = function() return  D.LiveList.TestItemDisplayed end,
		    set = function()
			if not D.LiveList.TestItemDisplayed then
			    D.LiveList:DisplayTestItem();
			else
			    D.LiveList:HideTestItem();
			end
		    end,
		    disabled = function() return D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame or not D.Status.HasSpell end,
		    order = 1000
		},
		FrameScaleLL = {
		    type = 'range',
		    name = L[D.LOC.OPT_LLSCALE],
		    desc = L[D.LOC.OPT_LLSCALE_DESC],
		    get = function() return D.profile.LiveListScale end, -- D.profile.DebuffsFrameElemScale end,
		    set = function(v) 
			if (v ~= D.profile.LiveListScale) then
			    D.profile.LiveListScale = v;

			    D:SetLLScale(D.profile.LiveListScale);
			end
		    end,
		    disabled = function() return D.profile.Hide_LiveList or D.profile.Hidden end,
		    min = 0.3,
		    max = 4,
		    step = 0.01,
		    isPercent = true,
		    order = 1009,
		},
		AlphaLL = {
		     type = 'range',
		    name = L[D.LOC.OPT_LLALPHA],
		    desc = L[D.LOC.OPT_LLALPHA_DESC],
		    get = function() return 1 - D.profile.LiveListAlpha end,
		    set = function(v) 
			if (v ~= D.profile.LiveListAlpha) then
			    D.profile.LiveListAlpha = 1 - v;
			    DecursiveMainBar:SetAlpha(D.profile.LiveListAlpha);
			    DcrLiveList:SetAlpha(D.profile.LiveListAlpha);
			end
		    end,
		    disabled = function() return D.profile.Hide_LiveList or D.profile.Hidden end,
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
	    name = D:ColorText(L[D.LOC.OPT_MESSAGES], "FF229966"),
	    desc = L[D.LOC.OPT_MESSAGES_DESC],
	    order = 110,
	    disabled = function() return  not D.Status.Enabled end,
	    args = {
		PrintToDefaultChat = {
		    type = "toggle",
		    name =  L[D.LOC.PRINT_CHATFRAME],
		    desc = L[D.LOC.OPT_CHATFRAME_DESC],
		    get = function() return D.profile.Print_ChatFrame end,
		    set = function()
			D.profile.Print_ChatFrame = not D.profile.Print_ChatFrame;
		    end,
		    order = 120
		},
		PrintToCustomChat = {
		    type = "toggle",
		    name =  L[D.LOC.PRINT_CUSTOM],
		    desc = L[D.LOC.OPT_PRINT_CUSTOM_DESC],
		    get = function() return D.profile.Print_CustomFrame end,
		    set = function()
			D.profile.Print_CustomFrame = not D.profile.Print_CustomFrame;
		    end,
		    order = 121
		},
		PrintErrors = {
		    type = "toggle",
		    name =  L[D.LOC.PRINT_ERRORS],
		    desc =  L[D.LOC.OPT_PRINT_ERRORS_DESC],
		    get = function() return D.profile.Print_Error end,
		    set = function()
			D.profile.Print_Error = not D.profile.Print_Error;
		    end,
		    order = 122
		},
		ShowCustomFAnchor = {
		    type = "toggle",
		    name =  L[D.LOC.ANCHOR],
		    desc = L[D.LOC.OPT_ANCHOR_DESC],
		    get = function() return DecursiveAnchor:IsVisible() end,
		    set = function()
			D:ShowHideTextAnchor();
		    end,
		    order = 123
		},
	    }
	}, -- }}}


	MicroFrameOpt = { -- {{{
	    type = "group",
	    name = D:ColorText(L[D.LOC.OPT_MFSETTINGS], "FFBBCC33"),
	    desc =		 L[D.LOC.OPT_MFSETTINGS_DESC],
	    order = 130,
	    disabled = function() return  not D.Status.Enabled end,
	    args = {
		title1 = {
		    type = "header",
		    name = L[D.LOC.OPT_DISPLAYOPTIONS],
		    textHeight = 13,
		    justifyH = "CENTER",
		    order = 1100,
		},
		Show = {
		    type = "toggle",
		    name = L[D.LOC.OPT_SHOWMFS],
		    desc = L[D.LOC.OPT_SHOWMFS_DESC],
		    get = function() return D.profile.ShowDebuffsFrame end,
		    set = function()
			D:ShowHideDebuffsFrame ();
			if D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame then
			    D:SetIcon(DC.IconOFF);
			else
			    D:SetIcon(DC.IconON);
			end
		    end,
		    disabled = function() return D.Status.Combat end,
		    order = 1200,
		},
		GrowToTop = {
		    type = "toggle",
		    name = L[D.LOC.OPT_GROWDIRECTION],
		    desc = L[D.LOC.OPT_GROWDIRECTION_DESC],
		    get = function() return D.profile.DebuffsFrameGrowToTop end,
		    set = function(v)
			if (v ~= D.profile.DebuffsFrameGrowToTop) then
			    D.profile.DebuffsFrameGrowToTop = v;
			    D.MicroUnitF:ResetAllPositions ();
			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
		    order = 1300,
		},
		ShowBorder = {
		    type = "toggle",
		    name = L[D.LOC.OPT_SHOWBORDER],
		    desc = L[D.LOC.OPT_SHOWBORDER_DESC],
		    get = function() return D.profile.DebuffsFrameElemBorderShow end,
		    set = function(v)
			if (v ~= D.profile.DebuffsFrameElemBorderShow) then
			    D.profile.DebuffsFrameElemBorderShow = v;
			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
		    order = 1350,
		},
		{
		    type = "header",
		    order = 1400,
		},
		MaxCount = {
		    type = 'range',
		    name = L[D.LOC.OPT_MAXMFS],
		    desc = L[D.LOC.OPT_MAXMFS_DESC],
		    get = function() return D.profile.DebuffsFrameMaxCount end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFrameMaxCount) then
			    D.profile.DebuffsFrameMaxCount = v;
			    D.MicroUnitF.MaxUnit = v;
			    -- D.Status.SpellsChanged = GetTime(); -- to force old previously unshown unit frames to update XXX useful??
			    D.MicroUnitF:Delayed_MFsDisplay_Update();
			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
		    min = 1,
		    max = 82,
		    step = 1,
		    isPercent = false,
		    order = 1500,
		},
		MFPerline = {
		    type = 'range',
		    name = L[D.LOC.OPT_UNITPERLINES],
		    desc = L[D.LOC.OPT_UNITPERLINES_DESC],
		    get = function() return D.profile.DebuffsFramePerline end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFramePerline) then
			    D.profile.DebuffsFramePerline = v;
			    D.MicroUnitF:ResetAllPositions ();
			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
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
		    name = L[D.LOC.OPT_MFSCALE],
		    desc = L[D.LOC.OPT_MFSCALE_DESC],
		    get = function() return D.profile.DebuffsFrameElemScale end, -- D.profile.DebuffsFrameElemScale end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFrameElemScale) then
			    D.profile.DebuffsFrameElemScale = v;


			    D.MicroUnitF:SetScale(D.profile.DebuffsFrameElemScale);

			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
		    min = 0.3,
		    max = 4,
		    step = 0.01,
		    isPercent = true,
		    order = 1800,
		},
		Alpha = {
		    type = 'range',
		    name = L[D.LOC.OPT_MFALPHA],
		    desc = L[D.LOC.OPT_MFALPHA_DESC],
		    get = function() return 1 - D.profile.DebuffsFrameElemAlpha end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFrameElemAlpha) then
			    D.profile.DebuffsFrameElemAlpha = 1 - v;
			    D.profile.DebuffsFrameElemBorderAlpha = (1 - v) / 2;
			end
		    end,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame or not D.profile.DebuffsFrameElemTieTransparency end,
		    min = 0,
		    max = 1,
		    step = 0.01,
		    isPercent = true,
		    order = 1900,
		},
		AdvDispOptions = {
		    type = "group",
		    name = L[D.LOC.OPT_ADVDISP],
		    desc = L[D.LOC.OPT_ADVDISP_DESC],
		    order = 2000,
		    disabled = function() return D.Status.Combat or not D.profile.ShowDebuffsFrame end,
		    args = {
			TieTransparency = {
			    type = "toggle",
			    name = L[D.LOC.OPT_TIECENTERANDBORDER],
			    desc = L[D.LOC.OPT_TIECENTERANDBORDER_OPT],
			    get = function() return D.profile.DebuffsFrameElemTieTransparency end,
			    set = function(v)
				if (v ~= D.profile.DebuffsFrameElemTieTransparency) then
				    D.profile.DebuffsFrameElemTieTransparency = v;
				    if v then
					D.profile.DebuffsFrameElemBorderAlpha = (D.profile.DebuffsFrameElemAlpha / 2);
				    end
				end
			    end,
			    disabled = function() return D.Status.Combat end,
			    order = 100
			},
			BorderAlpha = {
			    type = 'range',
			    name = L[D.LOC.OPT_BORDERTRANSP],
			    desc = L[D.LOC.OPT_BORDERTRANSP_DESC],
			    get = function() return 1 - D.profile.DebuffsFrameElemBorderAlpha end,
			    set = function(v) 
				if (v ~= D.profile.DebuffsFrameElemBorderAlpha) then
				    D.profile.DebuffsFrameElemBorderAlpha = 1 - v;
				end
			    end,
			    disabled = function() return D.Status.Combat or D.profile.DebuffsFrameElemTieTransparency end,
			    min = 0,
			    max = 1,
			    step = 0.01,
			    isPercent = true,
			    order = 102,
			},
			CenterAlpha = {
			    type = 'range',
			    name = L[D.LOC.OPT_CENTERTRANSP],
			    desc = L[D.LOC.OPT_CENTERTRANSP_DESC],
			    get = function() return 1 - D.profile.DebuffsFrameElemAlpha end,
			    set = function(v) 
				if (v ~= D.profile.DebuffsFrameElemAlpha) then
				    D.profile.DebuffsFrameElemAlpha = 1 - v;
				    if D.profile.DebuffsFrameElemTieTransparency then
					D.profile.DebuffsFrameElemBorderAlpha = (1 - v) / 2;
				    end
				end
			    end,
			    disabled = function() return D.Status.Combat end,
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
			    name = L[D.LOC.OPT_TIEXYSPACING],
			    desc = L[D.LOC.OPT_TIEXYSPACING_DESC],
			    get = function() return D.profile.DebuffsFrameTieSpacing end,
			    set = function(v)
				if (v ~= D.profile.DebuffsFrameTieSpacing) then
				    D.profile.DebuffsFrameTieSpacing = v;
				    if v then
					D.profile.DebuffsFrameYSpacing = D.profile.DebuffsFrameXSpacing;
				    end
				    D.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return D.Status.Combat end,
			    order = 104
			},
			XSpace = {
			    type = 'range',
			    name = L[D.LOC.OPT_XSPACING],
			    desc = L[D.LOC.OPT_XSPACING_DESC],
			    get = function() return D.profile.DebuffsFrameXSpacing end,
			    set = function(v) 
				if (v ~= D.profile.DebuffsFrameXSpacing) then
				    D.profile.DebuffsFrameXSpacing = v;
				    if D.profile.DebuffsFrameTieSpacing then
					D.profile.DebuffsFrameYSpacing = v;
				    end
				    D.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return D.Status.Combat end,
			    min = 0,
			    max = 100,
			    step = 1,
			    isPercent = false,
			    order = 105,
			},
			YSpace = {
			    type = 'range',
			    name = L[D.LOC.OPT_YSPACING],
			    desc = L[D.LOC.OPT_YSPACING_DESC],
			    get = function() return D.profile.DebuffsFrameYSpacing end,
			    set = function(v) 
				if (v ~= D.profile.DebuffsFrameYSpacing) then
				    D.profile.DebuffsFrameYSpacing = v;
				    D.MicroUnitF:ResetAllPositions ();
				end
			    end,
			    disabled = function() return D.Status.Combat or D.profile.DebuffsFrameTieSpacing end,
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
		    name = L[D.LOC.SHOW_TOOLTIP],
		    desc = L[D.LOC.OPT_SHOWTOOLTIP_DESC],
		    get = function() return D.profile.AfflictionTooltips end,
		    set = function()
			D.profile.AfflictionTooltips = not D.profile.AfflictionTooltips
		    end,
		    disabled = function() return  D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame end,
		    order = 2200
		},
		ShowHelp = {
		    type = "toggle",
		    name = L[D.LOC.OPT_SHOWHELP],
		    desc = L[D.LOC.OPT_SHOWHELP_DESC],
		    get = function() return D.profile.DebuffsFrameShowHelp end,
		    set = function()
			D.profile.DebuffsFrameShowHelp = not D.profile.DebuffsFrameShowHelp;

		    end,
		    disabled = function() return not D.profile.ShowDebuffsFrame end,
		    order = 2300,
		},
		{
		    type = "header",
		    order = 2400,
		},
		title2 = {
		    type = "header",
		    name = L[D.LOC.OPT_MFPERFOPT],
		    textHeight = 13,
		    justifyH = "CENTER",
		    order = 2500,
		},
		UpdateRate = {
		    type = 'range',
		    name = L[D.LOC.OPT_MFREFRESHRATE],
		    desc = L[D.LOC.OPT_MFREFRESHRATE_DESC],
		    get = function() return D.profile.DebuffsFrameRefreshRate end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFrameRefreshRate) then
			    D.profile.DebuffsFrameRefreshRate = v;

			    D:ScheduleRepeatingEvent("MUFupdate", D.DebuffsFrame_Update, D.profile.DebuffsFrameRefreshRate, D);
			    D:Debug("MUFs refresh rate changed:", D.profile.DebuffsFrameRefreshRate, v);
			end
		    end,
		    disabled = function() return not D.profile.ShowDebuffsFrame end,
		    min = 0.017,
		    max = 0.2,
		    step = 0.01,
		    isPercent = false,
		    order = 2600,
		},
		PerUpdate = {
		    type = 'range',
		    name = L[D.LOC.OPT_MFREFRESHSPEED],
		    desc = L[D.LOC.OPT_MFREFRESHSPEED_DESC],
		    get = function() return D.profile.DebuffsFramePerUPdate end,
		    set = function(v) 
			if (v ~= D.profile.DebuffsFramePerUPdate) then
			    D.profile.DebuffsFramePerUPdate = v;
			end
		    end,
		    disabled = function() return not D.profile.ShowDebuffsFrame end,
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
	    name = D:ColorText(L[D.LOC.OPT_CURINGOPTIONS], "FFFF5533"),
	    desc = L[D.LOC.OPT_CURINGOPTIONS_DESC],
	    order = 120,
	    disabled = function() return  not D.Status.Enabled end,
	    args = {
		AbolishCheck = {
		    type = "toggle",
		    name =  L[D.LOC.ABOLISH_CHECK],
		    desc = L[D.LOC.OPT_ABOLISHCHECK_DESC],
		    get = function() return D.profile.Check_For_Abolish end,
		    set = function()
			D.profile.Check_For_Abolish = not D.profile.Check_For_Abolish;
		    end,
		    order = 130
		},
		DoNotBlPrios = {
		    type = "toggle",
		    name =  L[D.LOC.DONOT_BL_PRIO],
		    desc = L[D.LOC.OPT_DONOTBLPRIO_DESC],
		    get = function() return D.profile.DoNot_Blacklist_Prio_List end,
		    set = function()
			D.profile.DoNot_Blacklist_Prio_List = not D.profile.DoNot_Blacklist_Prio_List;
		    end,
		    order = 131
		},
		RandomCure = {
		    type = "toggle",
		    name =  L[D.LOC.RANDOM_ORDER],
		    desc =  L[D.LOC.OPT_RANDOMORDER_DESC],
		    get = function() return D.profile.Random_Order end,
		    set = function()
			D.profile.Random_Order = not D.profile.Random_Order;
			D.Groups_datas_are_invalid = true;
		    end,
		    order = 132
		},
		CurePets = {
		    type = "toggle",
		    name =  L[D.LOC.CURE_PETS],
		    desc = L[D.LOC.OPT_CUREPETS_DESC],
		    get = function() return D.profile.Scan_Pets end,
		    set = function()
			D.profile.Scan_Pets = not D.profile.Scan_Pets;
			D.Groups_datas_are_invalid = true;
			D.MicroUnitF:Delayed_MFsDisplay_Update();
		    end,
		    order = 133
		},
		SkipStealthed = {
		    type = "toggle",
		    name =  L[D.LOC.IGNORE_STEALTH],
		    desc = L[D.LOC.OPT_IGNORESTEALTHED_DESC],
		    get = function() return D.profile.Ingore_Stealthed end,
		    set = function()
			D.profile.Ingore_Stealthed = not D.profile.Ingore_Stealthed;
		    end,
		    order = 134
		},



		{
		    type = "header", order = 138,}, Title2 = {
			type="header",  textHeight = 13,
			name = L[D.LOC.OPT_CURINGORDEROPTIONS],
		    order = 139,
		},
		{ type = "header", order = 140,   },

		CureMagic = {
		    type = "toggle",
		    name = D.L[D.LOC.MAGIC],
		    desc = L[D.LOC.OPT_MAGICCHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.MAGIC) end,
		    set = function()
			D:SetCureOrder (DC.MAGIC);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.MAGIC] end,
		    CureType = DC.MAGIC,
		    order = 141
		},
		CureEnemyMagic = {
		    type = "toggle",
		    name = D.L[D.LOC.MAGICCHARMED],
		    desc = L[D.LOC.OPT_MAGICCHARMEDCHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.ENEMYMAGIC) end,
		    set = function()
			D:SetCureOrder (DC.ENEMYMAGIC);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.ENEMYMAGIC] end,
		    CureType = DC.ENEMYMAGIC,
		    order = 142
		},
		CurePoison = {
		    type = "toggle",
		    name = D.L[D.LOC.POISON],
		    desc = L[D.LOC.OPT_POISONCHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.POISON) end,
		    set = function()
			D:SetCureOrder (DC.POISON);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.POISON] end,
		    CureType = DC.POISON,
		    order = 143
		},
		CureDisease = {
		    type = "toggle",
		    name = D.L[D.LOC.DISEASE],
		    desc = L[D.LOC.OPT_DISEASECHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.DISEASE) end,
		    set = function()
			D:SetCureOrder (DC.DISEASE);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.DISEASE] end,
		    CureType = DC.DISEASE,
		    order = 144
		},
		CureCurse = {
		    type = "toggle",
		    name = D.L[D.LOC.CURSE],
		    desc = L[D.LOC.OPT_CURSECHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.CURSE) end,
		    set = function()
			D:SetCureOrder (DC.CURSE);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.CURSE] end,
		    CureType = DC.CURSE,
		    order = 145
		},
		CureCharmed = {
		    type = "toggle",
		    name = D.L[D.LOC.CHARMED],
		    desc = L[D.LOC.OPT_CHARMEDCHECK_DESC],
		    get = function() return D:GetCureCheckBoxStatus(DC.CHARMED) end,
		    set = function()
			D:SetCureOrder (DC.CHARMED);
		    end,
		    disabled = function() return not D.Status.CuringSpells[DC.CHARMED] end,
		    CureType = DC.CHARMED,
		    order = 146
		},
	    }
	}, -- }}}

	DebuffSkip = {
	    type = "group",
	    name = D:ColorText(L[D.LOC.OPT_DEBUFFFILTER], "FF99CCAA"),
	    desc = L[D.LOC.OPT_DEBUFFFILTER_DESC],
	    order = 145,
	    disabled = function() return  not D.Status.Enabled end,
	    args = {}
	},
	spacer3 = {
	    type = "header",
	    order = 146
	},
	Macro = {
	    type = "group",
	    name = D:ColorText(L[D.LOC.OPT_MACROOPTIONS], "FFCC99BB"),
	    desc = L[D.LOC.OPT_MACROOPTIONS_DESC],
	    order = 147,
	    disabled = function() return  not D.Status.Enabled or D.Status.Combat end,
	    args = {
		SetKey = {
		    type = "text",
		    name = L[D.LOC.OPT_MACROBIND],
		    desc = L[D.LOC.OPT_MACROBIND_DESC],
		    validate = "keybinding",
		    get = function ()
			local key = (GetBindingKey(D.CONF.MACROCOMMAND));
			D.profile.MacroBind = key;
			return key;
		    end,
		    set = function (key)
			 D:SetMacroKey ( key );
		    end,
		    order = 200,
		},
		NoKeyWarn = {
		    type = "toggle",
		    name = D.L[D.LOC.OPT_NOKEYWARN],
		    desc = L[D.LOC.OPT_NOKEYWARN_DESC],
		    get = function() return D.profile.NoKeyWarn end,
		    set = function(v)
			D.profile.NoKeyWarn = v;
		    end,
		    order = 300
		}
	    }
	},
	spacer4 = {
	    type = "header",
	    order = 148
	},
	reset = {
	    type = "execute",
	    name = D:ColorText(L[D.LOC.OPT_RESETOPTIONS], "FF00AAAA"),
	    desc = L[D.LOC.OPT_RESETOPTIONS_DESC],
	    func = function ()
		D.Tmp.Profile = D:GetProfile();
		StaticPopup_Show ("DCR_CONFIRM_RESET", D:GetProfile());
		D.DewDrop:Close(1);

	    end,
	    disabled = function() return  not D.Status.Enabled end,
	    order = 150
	},
	spacer6 = {
	    type = "header",
	    order = 151
	},
	spacer7 = {
	    type = "header",
	    order = 152
	},
	spacer8 = {
	    type = "header",
	    order = 153
	},
	GlorfindalMemorium = { -- {{{
	    type = "execute",
	    name = D:ColorText(L[D.LOC.GLOR1], "FF" .. BC:GetHexColor( "WARRIOR" )),
	    desc = L[D.LOC.GLOR2],
	    func = function ()

		if not Dcr.MemoriumFrame then
		    Dcr.MemoriumFrame = CreateFrame("Frame", "DcrMemorium", UIParent);
		    local f = Dcr.MemoriumFrame;
		    local w = 512; local h = 390;
		    
		    f:SetFrameStrata("DIALOG");
		    f:EnableKeyboard(true);
		    --f:EnableMouse(true);
		    f:SetScript("OnKeyUp", function (frame, event, arg1, arg2) Dcr.MemoriumFrame:Hide(); end);
		    --f:SetScript("OnMouseUp", function (frame, event, arg1, arg2) Dcr.MemoriumFrame:Hide(); end);
		    --[[
		    f:SetScript("OnShow",
			function ()
			    -- I wanted to make the shadow to move over the marble very slowly as clouds
			    -- I tried to make it rotate but the way I found would only make it rotate around its origin (which is rearely useful)
			    -- so leaving it staedy for now... if someone got an idea, let me know.
			    D:ScheduleRepeatingEvent("GlorMoveShadow",
				function (f)
				    local cos, sin = math.cos, math.sin;
				    f.Shadow.Angle = f.Shadow.Angle + 1;
				    if f.Shadow.Angle == 360 then f.Shadow.Angle = 0; end
				    local angle = math.rad(f.Shadow.Angle);
				    D:SetCoords(f.Shadow, cos(angle), sin(angle), 0, -sin(angle), cos(angle), 0);

				end
			    , 1/50, f);
			end);
			--]]
		    --f:SetScript("OnHide", function() D:CancelScheduledEvent("GlorMoveShadow"); end)			
		    f:SetWidth(w);
		    f:SetHeight(h);
		    f.tTL = f:CreateTexture("DcrMmTopLeft","BACKGROUND")
		    f.tTL:SetTexture("Interface\\ItemTextFrame\\ItemText-Marble-TopLeft")
		    f.tTL:SetWidth(w - w / 5);
		    f.tTL:SetHeight(h - h / 3);
		    f.tTL:SetTexCoord(0, 1, 5/256, 1);
		    f.tTL:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -10);

		    f.tTR = f:CreateTexture("DcrMmTopRight","BACKGROUND")
		    f.tTR:SetTexture("Interface\\ItemTextFrame\\ItemText-Marble-TopRight")
		    f.tTR:SetWidth(w / 5 - 3);
		    f.tTR:SetHeight(h - h / 3);
		    f.tTR:SetTexCoord(0, 1, 5/256, 1);
		    f.tTR:SetPoint("TOPLEFT", f.tTL, "TOPRIGHT", 0, 0);

		    f.tBL = f:CreateTexture("DcrMmBotLeft","BACKGROUND")
		    f.tBL:SetTexture("Interface\\ItemTextFrame\\ItemText-Marble-BotLeft")
		    f.tBL:SetWidth(w - w / 5);
		    f.tBL:SetHeight(h / 3 - 20);
		    f.tBL:SetTexCoord(0,1,0, 408/512);
		    f.tBL:SetPoint("TOPLEFT", f.tTL, "BOTTOMLEFT", 0, 0);

		    f.tBR = f:CreateTexture("DcrMmBotRight","BACKGROUND")
		    f.tBR:SetTexture("Interface\\ItemTextFrame\\ItemText-Marble-BotRight")
		    f.tBR:SetWidth(w / 5 - 3);
		    f.tBR:SetHeight(h / 3 - 20);
		    f.tBR:SetTexCoord(0,1,0, 408/512);
		    f.tBR:SetPoint("TOPLEFT", f.tBL, "TOPRIGHT", 0, 0);

		    f.Shadow = f:CreateTexture("DcrMmShadow", "ARTWORK");
		    f.Shadow:SetTexture("Interface\\TabardFrame\\TabardFrameBackground")
		    f.Shadow:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -9);
		    f.Shadow:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 9);
		    f.Shadow:SetAlpha(0.1);
		    --f.Shadow.Angle = 0;

		    ---[[
		    f.fB = f:CreateTexture("DcrMmGoldBorder","OVERLAY")
		    f.fB:SetTexture("Interface\\AddOns\\Decursive\\Textures\\GoldBorder")
		    f.fB:SetTexCoord(5/512, 324/512, 6/512, 287/512);
		    f.fB:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0);
		    f.fB:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0);
		    --]]


		    f.FSt = f:CreateFontString("DcrMmTitleFont","OVERLAY", "MailTextFontNormal");
		    f.FSt:SetFont("Fonts\\MORPHEUS.TTF", 18 );
		    f.FSt:SetTextColor(0.18, 0.12, 0.06, 1);
		    f.FSt:SetPoint("TOPLEFT", f.tTL, "TOPLEFT", 5, -20);
		    f.FSt:SetPoint("TOPRIGHT", f.tTR, "TOPRIGHT", -5, -20);
		    f.FSt:SetJustifyH("CENTER");
		    f.FSt:SetText(L[D.LOC.GLOR3]);
		    f.FSt:SetAlpha(0.80);

		    f.FSc = f:CreateFontString("DcrMmCntFont","OVERLAY", "MailTextFontNormal");
		    f.FSc:SetFont("Fonts\\MORPHEUS.TTF", 15 );
		    f.FSc:SetTextColor(0.18, 0.12, 0.06, 1);
		    f.FSc:SetHeight(h - 30 - 60);
		    f.FSc:SetPoint("TOP", f.FSt, "BOTTOM", 0, -28);
		    f.FSc:SetPoint("LEFT", f.tTL, "LEFT", 30, 0);
		    f.FSc:SetPoint("RIGHT", f.tTR, "RIGHT", -30, 0);
		    f.FSc:SetJustifyH("CENTER");
		    f.FSc:SetJustifyV("TOP");
		    f.FSc:SetSpacing(5);

		    f.FSc:SetText(L[D.LOC.GLOR4]);


		    f.FSc:SetAlpha(0.80);

		    f.FSl = f:CreateFontString("DcrMmlastFont","OVERLAY", "MailTextFontNormal");
		    f.FSl:SetFont("Fonts\\MORPHEUS.TTF", 15 );
		    f.FSl:SetTextColor(0.18, 0.12, 0.06, 1);
		    f.FSl:SetJustifyH("LEFT");
		    f.FSl:SetJustifyV("BOTTOM");
		    f.FSl:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 30, 33);
		    f.FSl:SetAlpha(0.80);
		    f.FSl:SetText(L[D.LOC.GLOR5]);

		    f:SetPoint("CENTER",0,0);

		end
		Dcr.MemoriumFrame:Show();

		--[[
		
		In remembrance of Bertrand Sense
			1969 - 2007

		
		Friendship and affection can take their roots anywhere, those
		who met Glorfindal in World of Warcraft knew a man of great
		commitment and a charismatic leader.

		He was in life as he was in game, selfless, generous, dedicated
		to his friends and most of all, a passionate man.

		He left us at the age of 38 leaving behind him not just
		anonymous players in a virtual world, but a group of true
		friends who will miss him forever.

		He will always be remembered...

		--

		En souvenir de Bertrand Sense
			1969 - 2007

		L'amitié et l'affection peuvent prendre naissance n'importe où,
		ceux qui ont rencontré Glorfindal dans World Of Warcraft on
		connu un homme engagé et un leader charismatique.

		Il était dans la vie comme dans le jeux, désintéressé,
		généreux, dévoué envers les siens et surtout un homme passionné.

		Il nous a quitté à l'âge de 38 ans laissant derrière lui pas
		seulement des joueurs anonymes dans un monde virtuel, mais un
		groupe de véritables amis à qui il manquera eternellement.

		On ne l'oubliera jamais...

		--]]
		-- }}}
	    end,
	    order = 154
	},
	--[[FuBarOptions = {
	    type = "group",
	    name = L[D.LOC.MENU],
	    desc = L[D.LOC.MENU],
	    order = 402,
	    args = {}
	},--]]
    },
} -- }}}



D.CureCheckBoxes = { -- just a shortcut
[DC.ENEMYMAGIC]   = D.options.args.CureOptions.args.CureEnemyMagic,
[DC.MAGIC]	    = D.options.args.CureOptions.args.CureMagic,
[DC.CURSE]	    = D.options.args.CureOptions.args.CureCurse,
[DC.POISON]	    = D.options.args.CureOptions.args.CurePoison,
[DC.DISEASE]	    = D.options.args.CureOptions.args.CureDisease,
[DC.CHARMED]	    = D.options.args.CureOptions.args.CureCharmed,
}

function D:GetCureCheckBoxStatus (Type)
    return D.profile.CureOrder[Type] and D.profile.CureOrder[Type] > 0;
end

function D:SetCureCheckBoxNum (Type)
    local CheckBox = D.CureCheckBoxes[Type];

    -- save the old name
    if (not CheckBox.NameOnly) then
	CheckBox.NameOnly = CheckBox.name;
    end

    -- add the number in green before the name if we have a spell available and if we checked the box
    if (D:GetCureCheckBoxStatus(Type)) then
	CheckBox.name = D:ColorText(D.profile.CureOrder[Type], "FF00FF00") .. " " .. CheckBox.NameOnly;
    else
	CheckBox.name = "  " .. CheckBox.NameOnly;
    end

end

function D:CheckCureOrder ()

    D:Debug("Verifying CureOrder...");

    local TempTable = {};
    local AuthorizedKeys = {
	[DC.ENEMYMAGIC]   = 1,
	[DC.MAGIC]	    = 2,
	[DC.CURSE]	    = 3,
	[DC.POISON]	    = 4,
	[DC.DISEASE]	    = 5,
	[DC.CHARMED]	    = 6,
    };
    local AuthorizedValues = {
	[false]	= true; -- LOL Yes, it's TRUE tnat FALSE is an authorized value xD
	-- Other <0  values are used when there used to be a spell...
	[1]	= DC.ENEMYMAGIC,
	[-11]	= DC.ENEMYMAGIC,
	[2]	= DC.MAGIC,
	[-12]	= DC.MAGIC,
	[3]	= DC.CURSE,
	[-13]	= DC.CURSE,
	[4]	= DC.POISON,
	[-14]	= DC.POISON,
	[5]	= DC.DISEASE,
	[-15]	= DC.DISEASE,
	[6]	= DC.CHARMED,
	[-16]	= DC.CHARMED,
    };
    local GivenValues = {};


    -- add missing entries...
    for key, value in pairs(AuthorizedKeys) do
	if not D.profile.CureOrder[key] then
	    D.profile.CureOrder[key] = false;
	end
    end

    -- Validate existing entries
    local WrongValue = 0;
    for key, value in pairs(D.profile.CureOrder) do

	if (AuthorizedKeys[key]) then -- is this a correct type ?
	    if (AuthorizedValues[value] and not GivenValues[value]) then -- is this value authorized and not already given?
		--TempTable[key] = value;
		GivenValues[value] = true;

	    elseif (value) then -- FALSE is the only value that can be given several times
		D:Debug("Incoherent value for (key, value, Duplicate?)", key, value, GivenValues[value]);

		D.profile.CureOrder[key] = -20 - WrongValue; -- if the value was wrong or already given to another type
		WrongValue = WrongValue + 1;
	    end
	else
	    D.profile.CureOrder[key] = nil; -- remove it from the table
	end
    end

    --D.profile.CureOrder = TempTable;
end

function D:SetCureOrder (ToChange)

    local CureOrder = D.profile.CureOrder;
    local tmpTable = {};
    D:Debug("SetCureOrder called for prio ", CureOrder[ToChange]);

    if (ToChange) then
	-- if there is a positive value, it means we want to disable this type, set it to false (see GetCureCheckBoxStatus())
	if (D:GetCureCheckBoxStatus(ToChange)) then
	    CureOrder[ToChange] = false;
	    D:Debug("SetCureOrder(): set to false");
	else -- else if there was no value (or a negative one), add this type at the end (see GetCureCheckBoxStatus())
	    CureOrder[ToChange] = 20; -- this will cause the spell to be added at the end
	    D:Debug("SetCureOrder(): set to 20");
	end
    end

    local LostSpells = {}; -- an orphanage for the lost spells :'(
    local FoundSpell = 0; -- we wouldn't need that if #table was always returning something meaningful...

    -- re-compute the position of each spell type
    for Type, Num in pairs (CureOrder) do

	-- if we have a spell or if we did not unchecked the checkbox (note the difference between "checked" and "not unchecked")
	if (D.Status.CuringSpells[Type] and CureOrder[Type]) then
	    tmpTable[math.abs(CureOrder[Type])] = Type; -- CureOrder[Type] can have a <0 value if the spell was lost
	    FoundSpell = FoundSpell + 1;
	elseif (CureOrder[Type]) then -- if we don't have a spell for this type
	    LostSpells[math.abs(CureOrder[Type])] = Type;  -- save the position
	end
    end

   -- take care of the lost spells here
   -- Sort the lost spells so that they can be readded in the correct order
   LostSpells =  D:tSortUsingKeys(LostSpells);

   -- Place the lost spells after the found ones but with <0 values so they
   -- can be readded later using their former priorities
   local AvailableSpot = (FoundSpell + 10 + 1) * -1; -- we add 10 so that they'll be re-added after any not-lost spell...

   -- D:PrintLiteral(LostSpells);
   for FormerPrio, Type in ipairs(LostSpells) do
       CureOrder[Type] = AvailableSpot
       AvailableSpot = AvailableSpot - 1;
   end

    -- we sort the tables
    tmpTable = D:tSortUsingKeys(tmpTable);

    -- apply the new priority to the types we can handle, leave their negative value to the others
    for Num, Type in ipairs (tmpTable) do
	CureOrder[Type] = Num;
    end

    -- create / update the ReversedCureOrder table (prio => type, ..., )
    D.Status.ReversedCureOrder = D:tReverse(CureOrder);

    for Type, CheckBox in pairs(D.CureCheckBoxes) do
	D:SetCureCheckBoxNum(Type);
    end


    -- Create spell priority table
    D.Status.CuringSpellsPrio = {};

--    if not D.Status.HasSpell then
--	return;
--    end

    -- some shortcuts
    local CuringSpellsPrio = D.Status.CuringSpellsPrio;
    local ReversedCureOrder = D.Status.ReversedCureOrder;
    local CuringSpells	= D.Status.CuringSpells;

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
    D:UpdateMacro();
    D:Debug("Spell changed");
    D.Status.SpellsChanged = GetTime();

    -- If no spell is selected or none is available set Decursive icon to off
    if FoundSpell ~= 0 then
	D:Debug("icon changed to ON");
	D:SetIcon(DC.IconON);
    else
	D:Debug("icon changed to OFF");
	D:SetIcon(DC.IconOFF);
    end



end

function D:ShowHideDebuffsFrame ()

    if D.Status.Combat then
	return
    end

    D.profile.ShowDebuffsFrame = not D.profile.ShowDebuffsFrame;

    if (D.MFContainer:IsVisible()) then
	D.MFContainer:Hide();
	D.profile.ShowDebuffsFrame = false;
    else
	D.MFContainer:Show();
	D.MFContainer:SetScale(D.profile.DebuffsFrameElemScale);
	D.MicroUnitF:Place ();
	D.profile.ShowDebuffsFrame = true;

	local i = 0;

	for ID, MF in pairs(D.MicroUnitF.ExistingPerID) do
	    if MF.IsDebuffed then
		D:ScheduleEvent("updMUF"..i, D.SpecialEvents_UnitDebuffLost, i * (D.profile.ScanTime / 2), D, MF.CurrUnit, "Test item");
		i = i + 1;
	    end
	end
    end

    if (not D.profile.ShowDebuffsFrame) then
	D:CancelScheduledEvent("MUFupdate");
    else
	D:ScheduleRepeatingEvent("MUFupdate", D.DebuffsFrame_Update, D.profile.DebuffsFrameRefreshRate, D);
    end
end

function D:ShowHideTextAnchor() --{{{
    if (DecursiveAnchor:IsVisible()) then
	DecursiveAnchor:Hide();
    else
	DecursiveAnchor:Show();
    end
end --}}}

function D:ChangeTextFrameDirection(bottom) --{{{
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
    text = L[D.LOC.OPT_REMOVESKDEBCONF],
    button1 = TEXT(ACCEPT),
    button2 = TEXT(CANCEL),
    OnAccept = function()

	local DebuffsSkipList	= D.profile.DebuffsSkipList;
	local skipByClass	= D.profile.skipByClass;
	local AlwaysSkipList	= D.profile.DebuffAlwaysSkipList;


	D:tremovebyval(DebuffsSkipList, D.Tmp.DebuffToRemove)

	for class, debuffs in pairs (skipByClass) do
	    skipByClass[class][D.Tmp.DebuffToRemove] = nil; -- XXX changed from false to nil on 20070415
	end

	AlwaysSkipList[D.Tmp.DebuffToRemove] = nil; -- remove it from the table

	D:Debug("%s removed!", D.Tmp.DebuffToRemove);
	D:CreateDropDownFiltersMenu();
	D.Tmp.DebuffToRemove = false;

    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    ShowAlert = 1,
};

StaticPopupDialogs["DCR_CONFIRM_RESET"] = {
    text = L[D.LOC.OPT_RESTPROFILECONF],
    button1 = TEXT(ACCEPT),
    button2 = TEXT(CANCEL),
    OnAccept = function()

	D:Println(L[D.LOC.OPT_PROFILERESET]);
	D:ResetDB("profile");

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
    D.Tmp = {};



    local RemoveFunc = function (handler)
	D:Debug("Removing '%s'...", handler["Debuff"]);
	D.Tmp.DebuffToRemove = handler["Debuff"];
	StaticPopup_Show ("DCR_REMOVE_SKIPPED_DEBUFF_CONFIRMATION", D:ColorText(handler["Debuff"], "FF11AA66"));
	D.DewDrop:Close(1);
    end

    local AddToAlwaysSkippFunc = function (handler, v)
	AlwaysSkipList[handler["Debuff"]] = v;
    end

    local ResetFunc = function (handler)
	local DebuffName = handler["Debuff"];

	D:Debug("Resetting '%s'...", handler["Debuff"]);

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

	local FormattedClass = D:MakeProperEnglishClassName(Class);

	return {
	    type = "toggle",
	    name = D:ColorText( BC[FormattedClass], "FF"..BC:GetHexColor(FormattedClass)) ..
	    (CheckedByDefault and D:ColorText("  *", "FFFFAA00") or ""),
	    desc = string.format(L[D.LOC.OPT_AFFLICTEDBYSKIPPED], BC[FormattedClass], DebuffName) ..
	    (CheckedByDefault and D:ColorText(L[D.LOC.OPT_DEBCHECKEDBYDEF], "FFFFAA00") or "");
	    -- There is no other way to pass arguments to the set and get functions...
	    handler = {
		["Debuff"]=DebuffName,
		["Class"]=Class,
		["get"] = function  (args)
		    local skipByClass = D.profile.skipByClass;
		    return skipByClass[args["Class"]][args["Debuff"]]; 
		end,
		["set"] = function  (args, v)
		    local skipByClass = D.profile.skipByClass;
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
	    name = D:ColorText(L[D.LOC.OPT_ALWAYSIGNORE], "FFFF9900"),
	    desc = string.format(L[D.LOC.OPT_ALWAYSIGNORE_DESC], DebuffName),
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
	    name = D:ColorText(L[D.LOC.OPT_REMOVETHISDEBUFF], "FFFF0000"),
	    desc = string.format(L[D.LOC.OPT_REMOVETHISDEBUFF_DESC], DebuffName),
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

	if (not D:tcheckforval(DefaultDebuffsSkipList, DebuffName)) then
	    resetDisabled = true;
	end

	classes["reset"] = {
	    type = "execute",
	    -- the two statements below are like (()?:) in C
	    name = not resetDisabled and D:ColorText(L[D.LOC.OPT_RESETDEBUFF], "FF11FF00") or L[D.LOC.OPT_RESETDEBUFF],
	    desc = not resetDisabled and string.format(L[D.LOC.OPT_RESETDTDCRDEFAULT], DebuffName) or L[D.LOC.OPT_USERDEBUFF],
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
	local IsADefault = D:tcheckforval(DefaultDebuffsSkipList, DebuffName);
	return {
	    type = "group",
	    name = IsADefault and D:ColorText(DebuffName, "FFFFFFFF") or D:ColorText(DebuffName, "FF99FFFF"),
	    desc = L[D.LOC.OPT_DEBUFFENTRY_DESC],
	    order = 100 + num,
	    args = DebuffSubmenu(DebuffName, num),
	}
    end

    local AddFunc = function (NewDebuff)
	if (not D:tcheckforval(DebuffsSkipList, NewDebuff)) then
	    table.insert(DebuffsSkipList, strtrim(NewDebuff));
	    D:CreateDropDownFiltersMenu();
	    D:Debug("'%s' added to debuff skip list", strtrim(NewDebuff));
	end
    end


    local ReAddDefaultsDebuffs = function ()

	for _, Debuff in ipairs(DefaultDebuffsSkipList) do

	    if (not D:tcheckforval(DebuffsSkipList, Debuff)) then

		table.insert(DebuffsSkipList, Debuff);

		ResetFunc({["Debuff"] = Debuff});

	    end
	end

	D:CreateDropDownFiltersMenu();
    end

    local CheckDefaultsPresence = function ()
	for _, Debuff in ipairs(DefaultDebuffsSkipList) do
	    if (not D:tcheckforval(DebuffsSkipList, Debuff)) then

		return false;
	    end
	end
	return true;
    end

    function D:CreateDropDownFiltersMenu()
	DebuffsSkipList	    = D.profile.DebuffsSkipList;
	DefaultDebuffsSkipList    = D.defaults.DebuffsSkipList;

	skipByClass		    = D.profile.skipByClass;
	AlwaysSkipList		    = D.profile.DebuffAlwaysSkipList;
	DefaultSkipByClass	    = D.defaults.skipByClass;

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
	    name = D:ColorText(L[D.LOC.OPT_ADDDEBUFF], "FFFF3300"),
	    desc = L[D.LOC.OPT_ADDDEBUFF_DESC],
	    usage = L[D.LOC.OPT_ADDDEBUFF_USAGE],
	    get = false,
	    set = AddFunc,
	    order = 100 + num,
	};


	local ReaddIsDisabled = CheckDefaultsPresence();
	num = num + 1;
	DebuffsSubMenu["ReAddDefaults"] = {
	    type = "execute",
	    name = not ReaddIsDisabled and D:ColorText(L[D.LOC.OPT_READDDEFAULTSD], "FFA75728") or L[D.LOC.OPT_READDDEFAULTSD],
	    desc = not ReaddIsDisabled and L[D.LOC.OPT_READDDEFAULTSD_DESC1]
	    or L[D.LOC.OPT_READDDEFAULTSD_DESC2],
	    func = ReAddDefaultsDebuffs,
	    disabled = CheckDefaultsPresence;
	    order = 100 + num,
	};

	num = num + 1;
	DebuffsSubMenu["spacer2"] = spacer(num);
	num = num + 1;

	D.options.args.DebuffSkip.args = DebuffsSubMenu;

    end
end

-- to test on 2.3 : /script Dcr:PrintLiteral(GetBindingAction(Dcr.profile.MacroBind));
-- to test on 2.3 : /script Dcr:PrintLiteral(GetBindingKey(D.CONF.MACROCOMMAND));

function D:SetMacroKey ( key )

    -- if the key is already correctly mapp, return here.
    --if (key and key == D.profile.MacroBind and GetBindingAction(key) == D.CONF.MACROCOMMAND) then
    if (key and key == D.profile.MacroBind and D:tcheckforval({GetBindingKey(D.CONF.MACROCOMMAND)}, key) ) then -- change for 2.3 where GetBindingAction() is no longer working
	return;
    end

    -- if the current set key is currently mapped to Decursive macro (it means we are changing the key)
    --if (D.profile.MacroBind and GetBindingAction(D.profile.MacroBind) == D.CONF.MACROCOMMAND) then
    if (D.profile.MacroBind and D:tcheckforval({GetBindingKey(D.CONF.MACROCOMMAND)}, D.profile.MacroBind) ) then -- change for 2.3 where GetBindingAction() is no longer working

	-- clearing redudent mapping to Decursive macro.
	local MappedKeys = {GetBindingKey(D.CONF.MACROCOMMAND)};
	for _, key in pairs(MappedKeys) do
	    D:Debug("Unlinking [%s]", key);
	    SetBinding(key, nil); -- clear the binding
	end

	-- Restore previous key state
	if (D.profile.PreviousMacroKeyAction) then
	    D:Debug("Previous key action restored:", D.profile.PreviousMacroKeyAction);
	    if not SetBinding(D.profile.MacroBind, D.profile.PreviousMacroKeyAction) then
		D:Debug("Restoration failed");
	    end
	end
    end


    if (key) then
	if (GetBindingAction(key) ~= "" and GetBindingAction(key) ~= D.CONF.MACROCOMMAND) then
	    -- save current key assignement
	    D.profile.PreviousMacroKeyAction = GetBindingAction(key)
	    D:Debug("Old key action saved:", D.profile.PreviousMacroKeyAction);
	    D:errln(L[D.LOC.MACROKEYALREADYMAPPED], key, D.profile.PreviousMacroKeyAction);
	else
	    D.profile.PreviousMacroKeyAction = false;
	    D:Debug("Old key action not saved because it was mapped to nothing");
	end

	-- set
	if (SetBindingMacro(key, D.CONF.MACRONAME)) then
	    D.profile.MacroBind = key;
	    D:Println(L[D.LOC.MACROKEYMAPPINGSUCCESS], key);
	else
	    D:errln(L[D.LOC.MACROKEYMAPPINGFAILED], key);
	end
    else
	D.profile.MacroBind = false;
	if D.profile.NoKeyWarn and not GetBindingKey(D.CONF.MACROCOMMAND) then
	    D:errln(L[D.LOC.MACROKEYNOTMAPPED]);
	end
    end

    -- save the bindings to disk
    SaveBindings(GetCurrentBindingSet());

end

DcrLoadedFiles["Dcr_opt.lua"] = true;

