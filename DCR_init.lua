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

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_DIAG.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_DIAG.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

Dcr	    = AceLibrary("AceAddon-2.0"):new ("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "FuBarPlugin-2.0");

local D = Dcr;

D.AOO	    = AceLibrary("AceOO-2.0");
D.L	    = AceLibrary("AceLocale-2.2"):new("Dcr");
D.BC	    = LibStub("LibBabble-Class-3.0"):GetLookupTable();
D.BCR	    = LibStub("LibBabble-Class-3.0"):GetReverseLookupTable();
D.DewDrop   = AceLibrary("Dewdrop-2.0");
D.A	    = AceLibrary("SpecialEvents-Aura-2.0");
D.Waterfall = AceLibrary("Waterfall-1.0");
D.T	    = AceLibrary("Tablet-2.0");

D.DcrFullyInitialized = false;

local L = D.L;
local BC = D.BC;

local BOOKTYPE_PET	= BOOKTYPE_PET;
local BOOKTYPE_SPELL	= BOOKTYPE_SPELL;





-------------------------------------------------------------------------------
-- variables {{{
-------------------------------------------------------------------------------
D.Groups_datas_are_invalid = false;
-------------------------------------------------------------------------------
-- Internal HARD settings for decursive
D.CONF = {};
D.CONF.TEXT_LIFETIME = 4.0;
D.CONF.MAX_LIVE_SLOTS = 10;
D.CONF.MACRONAME = "Decursive";
D.CONF.MACROCOMMAND = string.format("MACRO %s", D.CONF.MACRONAME);

BINDING_HEADER_DECURSIVE = "Decursive";

D.CONF.MACRO_DIAG     = "/dcrdiag";
D.CONF.MACRO_COMMAND  = "/decursive";
D.CONF.MACRO_SHOW     = "/dcrshow";
D.CONF.MACRO_HIDE     = "/dcrhide";
D.CONF.MACRO_OPTION   = "/dcroptions";
D.CONF.MACRO_RESET    = "/dcrreset";

D.CONF.MACRO_PRADD    = "/dcrpradd";
D.CONF.MACRO_PRCLEAR  = "/dcrprclear";
D.CONF.MACRO_PRLIST   = "/dcrprlist";
D.CONF.MACRO_PRSHOW   = "/dcrprshow";

D.CONF.MACRO_SKADD    = "/dcrskadd";
D.CONF.MACRO_SKCLEAR  = "/dcrskclear";
D.CONF.MACRO_SKLIST   = "/dcrsklist";
D.CONF.MACRO_SKSHOW   = "/dcrskshow";
D.CONF.MACRO_DEBUG	   = "/dcrdebug";
D.CONF.MACRO_SHOW_ORDER   = "/dcrshoworder";

-- CONSTANTS
DcrC = {};

local DC = DcrC;

DC.DS = {};

local DS = DC.DS;

DC.IconON = "Interface\\AddOns\\" .. D.folderName .. "\\iconON.tga";
DC.IconOFF = "Interface\\AddOns\\" .. D.folderName .. "\\iconOFF.tga";

DC.MAGIC	= 1;
DC.ENEMYMAGIC	= 2;
DC.CURSE	= 4;
DC.POISON	= 8;
DC.DISEASE	= 16;
DC.CHARMED	= 32;
DC.NOTYPE	= 64;


DC.NORMAL		    = 8;
DC.ABSENT		    = 16;
DC.FAR			    = 32;
DC.STEALTHED		    = 64;
DC.BLACKLISTED		    = 128;
DC.AFFLICTED		    = 256;
DC.AFFLICTED_NIR	    = 512;
DC.CHARMED_STATUS	    = 1024;
DC.AFFLICTED_AND_CHARMED = bit.bor(DC.AFFLICTED, DC.CHARMED_STATUS);

DC.MFSIZE = 20;

-- This value is returned by UnitName when the name of a unit is not available yet
DC.UNKNOWN = UNKNOWNOBJECT;

-- Get the translation for "pet"
DC.PET = SPELL_TARGET_TYPE8_DESC;

-- Holder for 'Rank #' translation
DC.RANKNUMTRANS = false;

DC.DebuffHistoryLength = 40; -- we use a rather high value to avoid garbage creation


D.DebuffHistory = {};

D.MFContainer = false;
D.LLContainer = false;

D.profile = {};
D.classprofile = {};

D.Status = {};

D.Status.CuringSpells = {};
D.Status.CuringSpellsPrio = {};
D.Status.DelayedFunctionCalls = {};
D.Status.DelayedFunctionCallsCount = 0;

D.Status.Blacklisted_Array = {};
D.Status.UnitNum = 0;

-- An acces the debuff table
D.ManagedDebuffUnitCache = {};
-- A table UnitID=>IsDebuffed (boolean)
D.UnitDebuffed = {};

-- // }}}
-------------------------------------------------------------------------------


-- D.Initialized = false;
-------------------------------------------------------------------------------

-- add support for FuBar
D.independentProfile	= true; -- for Fubar
D.hasIcon	    	= DC.IconON;
D.hasNoColor		= true;
D.overrideMenu		= true;
D.defaultMinimapPosition = 250;
D.hideWithoutStandby	= true;
D.defaultPosition	= "LEFT";
D.hideMenuTitle 	= true;
--D.clickableTooltip	= true;

function D:OnMenuRequest (level, value, inTooltip, v1, v2, v3)
   D.DewDrop:FeedAceOptionsTable( D.options );
end

function D:OnInitialize() -- Called on ADDON_LOADED -- {{{

    if DecursiveSelfDiagnostic() == 2 then
	return false;
    end


    self:RegisterDB("DcrDB");
    self:RegisterDefaults('profile', D.defaults );
    self:RegisterDefaults('class', D.defaults.class );
    self:RegisterChatCommand({'/dcr', '/decursive'}, D.options )

    -- Create some useful cache tables
    D:CreateClassColorTables();

    -- add support for FuBar
    -- This will add Fubar relative options into a sub-menu
    ---[[
    do
	local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(self)
	local options = D.options

	if not options.args[L[D.LOC.FUBARMENU] ] then
	    options.args.menuSpacer = {
		type = "header",
		name = " ",
		order = 401,
	    }
	    options.args[L[D.LOC.FUBARMENU] ] = {
		type = "group",
		name =L[D.LOC.FUBARMENU],
		desc = L[D.LOC.FUBARMENU_DESC],
		args = args,
		order = 402,
	    }

	    -- Because FuBarPlugin is a mixin its options are merged with ours
	    -- so remove them...
	    for k,v in pairs(args) do
		options.args[k] = nil;
	    end

	end
    end
    --]]

    D.OnMouseDown = D.MicroUnitF.OnCornerClick;

    D.OnTooltipUpdate = function()
	D:Debug("Updating FuBar tooltip");
	local cat = D.T:AddCategory(
	--'text', "Alpha",
	'columns', 2,
	'child_textR', 0,
	'child_textG', 1,
	'child_textB', 0,
	'child_textR2', 1,
	'child_textG2', 1,
	'child_textB2', 1,
	'child_justify2', 'LEFT'
	);

	cat:AddLine(
	'text', ("%s: "):format(D.L[D.LOC.HLP_RIGHTCLICK]),
	'text2',  D.L[D.LOC.STR_OPTIONS]
	);

	cat:AddLine(
	'text', ("%s-%s: "):format(D.L[D.LOC.ALT],		D.L[D.LOC.HLP_RIGHTCLICK]),
	'text2', D.L[BINDING_NAME_DCRSHOWOPTION]
	);
	cat:AddLine(
	'text', ("%s-%s: "):format(D.L[D.LOC.CTRL],		D.L[D.LOC.HLP_LEFTCLICK]),
	'text2', D.L[BINDING_NAME_DCRPRSHOW]
	);
	cat:AddLine(
	'text', ("%s-%s: "):format(D.L[D.LOC.SHIFT],		D.L[D.LOC.HLP_LEFTCLICK]),
	'text2', D.L[BINDING_NAME_DCRSKSHOW]
	);
	cat:AddLine(
	'text', ("%s-%s: " ):format(D.L[D.LOC.SHIFT],		D.L[D.LOC.HLP_RIGHTCLICK]),
	'text2', D.L[BINDING_NAME_DCRSHOW]
	);

	if (D.profile.debugging) then
	    local HistoryIndex = 1;
	    local cat2 = D.T:AddCategory(
	    'text', "Debugging info",
	    'columns', 2,
	    'child_textR', 0.8,
	    'child_textG', 1,
	    'child_textB', 0.8,
	    'child_textR2', 0.7,
	    'child_textG2', 0.6,
	    'child_textB2', 0.5,
	    'child_justify1', 'LEFT',
	    'child_justify2', 'LEFT'
	    );

	    cat2:AddLine(
	    'text', "Afflicted units count:",
	    'text2',  D.ForLLDebuffedUnitsNum
	    );

	    cat2:AddLine(
	    'text', "Afflicted units count in range:",
	    'text2',  D.MicroUnitF.UnitsDebuffedInRange
	    );

	    cat2:AddLine(
	    'text', "Max Concurrent update events:",
	    'text2',  D.Status.MaxConcurentUpdateDebuff
	    );


	    cat2:AddLine(
	    'text', "Debuff seen history:",
	    'text2',  " "
	    );

	    while HistoryIndex < 10 do
		cat2:AddLine(
		'text', HistoryIndex,
		'text2',  (D:Debuff_History_Get (HistoryIndex, true))
		);

		HistoryIndex = HistoryIndex + 1;

	    end

	end


    end

    D.MFContainer = DcrMUFsContainer;
    D.MicroUnitF.Frame = D.MFContainer;


    D.LLContainer = DcrLiveList;
    D.LiveList.Frame = DcrLiveList;


    D.DewDrop:Register(DecursiveMainBar,
    'children', function()
	D.DewDrop:FeedAceOptionsTable( D.options )
    end
    )
    D.Waterfall:Register("Decursive","aceOptions", D.options, 'title',  L[D.LOC.STR_OPTIONS],  "colorR", 0.1, "colorG", 0.1, "colorB", 0.3);

    DC.TypeNames = {
	[DC.MAGIC]	= D.LOC.MAGIC;
	[DC.ENEMYMAGIC]	= D.LOC.MAGIC;
	[DC.CURSE]	= D.LOC.CURSE;
	[DC.POISON]	= D.LOC.POISON;
	[DC.DISEASE]	= D.LOC.DISEASE;
	[DC.CHARMED]	= D.LOC.CHARMED;
    }

    DC.NameToTypes = D:tReverse(DC.TypeNames);
    DC.NameToTypes[D.LOC.MAGIC] = DC.MAGIC;

    DC.TypeColors = {
	[DC.MAGIC]	= "2222DD";
	[DC.ENEMYMAGIC]	= "2222FF";
	[DC.CURSE]	= "DD22DD";
	[DC.POISON]	= "22DD22";
	[DC.DISEASE]	= "995533";
	[DC.CHARMED]	= "FF0000";
	[DC.NOTYPE]	= "AAAAAA";
    }

    -- /script DcrC.SpellsToUse[Dcr.DS["Dampen Magic"]] = {Types = {DcrC.MAGIC, DcrC.DISEASE, DcrC.POISON},IsBest = false}; Dcr:Configure();

    -- SPELL TABLE -- must be parsed after localisation is loaded {{{
	DC.SpellsToUse = {

	    [DS[D.LOC.SPELL_POLYMORPH]]	    = { --Mages
	    Types = {DC.CHARMED},
	    IsBest = false,
	    Pet = false,
	    Rank = 1,
	},
	-- Druids
	[DS[D.LOC.SPELL_CYCLONE]]	    = {
	    Types = {DC.CHARMED},
	    IsBest = false,
	    Pet = false,
	},
	--[[
	-- used for testing only
	[DS["Dampen Magic"] ]	    = {
	    Types = {DC.MAGIC},--, DC.DISEASE, DC.POISON},
	    IsBest = false,
	    Pet = false,
	}, --]]
	--[[
	-- used for testing only
	[DS["Amplify Magic"] ]	    = {
	    Types = {DC.DISEASE, DC.POISON},
	    IsBest = false,
	    Pet = false,
	}, --]]
	[DS[D.LOC.SPELL_ABOLISH_DISEASE]]	    = {
	    Types = {DC.DISEASE},
	    IsBest = true,
	    Pet = false,
	},
	[DS[D.LOC.SPELL_CURE_DISEASE]]	    = {
	    Types = {DC.DISEASE},
	    IsBest = false,
	    Pet = false,
	},
	-- paladins
	[DS[D.LOC.SPELL_CLEANSE]]		    = {
	    Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
	    IsBest = true,
	    Pet = false,
	},
	[DS[D.LOC.SPELL_PURIFY]]		    = {
	    Types = {DC.DISEASE, DC.POISON},
	    IsBest = false,
	    Pet = false,
	},
	-- Priests
	[DS[D.LOC.SPELL_DISPELL_MAGIC]]	    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	    Pet = false,
	},
	-- Druids
	[DS[D.LOC.SPELL_ABOLISH_POISON]]	    = {
	    Types = {DC.POISON},
	    IsBest = true,
	    Pet = false,
	},
	[DS[D.LOC.SPELL_CURE_POISON]]	    = {
	    Types = {DC.POISON},
	    IsBest = false,
	    Pet = false,
	},
	-- mages
	[DS[D.LOC.SPELL_REMOVE_LESSER_CURSE]]   = {
	    Types = {DC.CURSE},
	    IsBest = true,
	    Pet = false,
	},
	-- druids
	[DS[D.LOC.SPELL_REMOVE_CURSE]]	    = {
	    Types = {DC.CURSE},
	    IsBest = true,
	    Pet = false,
	},
	--[=[ -- disabled because of Korean locals... see below
	[DS[D.LOC.SPELL_PURGE]]		    = {
	    Types = {DC.ENEMYMAGIC},
	    IsBest = true,
	    Pet = false,
	},
	--]=]
	[DS[D.LOC.PET_FEL_CAST]]		    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	    Pet = true,
	},
	[DS[D.LOC.PET_DOOM_CAST]]		    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	    Pet = true,
	},

    };

    -- Thanks to Korean localization team of WoW we have to make an exception....
    -- They found the way to call two different spells the same (Shaman PURGE and Paladin CLEANSE... (both are called "정화") )
    if (select(2, UnitClass("player")) == "SHAMAN") then
	DC.SpellsToUse[DS[D.LOC.SPELL_PURGE]]		    = {
	    Types = {DC.ENEMYMAGIC},
	    IsBest = true,
	    Pet = false,
	};
    end

    -- Thanks to Chinese localization team of WoW we have to make anOTHER exception.... ://///
    -- They found the way to call two different spells the same (Devour Magic and Consume Magic... (both are called "&#21534;&#22124;&#39764;&#27861;" )
    if (select(2, UnitClass("player")) == "PRIEST") then
	DC.SpellsToUse[DS[D.LOC.PET_FEL_CAST]] = nil; -- so we remove PET_FEL_CAST.
    end

    -- // }}}

end -- // }}}

--Old_MacroFrame_SaveMacro = false;
local FirstEnable = true;
function D:OnEnable(first) -- called after PLAYER_LOGIN -- {{{

    if DecursiveSelfDiagnostic() == 2 then
	return false;
    end


    -- Register slashes command {{{
    if (FirstEnable) then
	SLASH_DECURSIVEDIAG1 = D.CONF.MACRO_DIAG;
	SlashCmdList["DECURSIVEDIAG"] = function(msg)
	    DecursiveSelfDiagnostic(true, true);
	end

	SLASH_DECURSIVEPRADD1 = D.CONF.MACRO_PRADD;
	SlashCmdList["DECURSIVEPRADD"] = function(msg)
	    D:AddTargetToPriorityList();
	end
	SLASH_DECURSIVEPRCLEAR1 = D.CONF.MACRO_PRCLEAR;
	SlashCmdList["DECURSIVEPRCLEAR"] = function(msg)
	    D:ClearPriorityList();
	end

	SLASH_DECURSIVEPRSHOW1 = D.CONF.MACRO_PRSHOW;
	SlashCmdList["DECURSIVEPRSHOW"] = function(msg)
	    D:ShowHidePriorityListUI();
	end

	SLASH_DECURSIVESKADD1 = D.CONF.MACRO_SKADD;
	SlashCmdList["DECURSIVESKADD"] = function(msg)
	    D:AddTargetToSkipList();
	end
	SLASH_DECURSIVESKCLEAR1 = D.CONF.MACRO_SKCLEAR;
	SlashCmdList["DECURSIVESKCLEAR"] = function(msg)
	    D:ClearSkipList();
	end

	SLASH_DECURSIVESKSHOW1 = D.CONF.MACRO_SKSHOW;
	SlashCmdList["DECURSIVESKSHOW"] = function(msg)
	    D:ShowHideSkipListUI();
	end

	SLASH_DECURSIVESHOW1 = D.CONF.MACRO_SHOW;
	SlashCmdList["DECURSIVESHOW"] = function(msg)
	    D:HideBar(0);
	end

	SLASH_DECURSIVERESET1 = D.CONF.MACRO_RESET;
	SlashCmdList["DECURSIVERESET"] = function(msg)
	    D:ResetWindow();
	end

	SLASH_DECURSIVEHIDE1 = D.CONF.MACRO_HIDE;
	SlashCmdList["DECURSIVEHIDE"] = function(msg)
	    D:HideBar(1);
	end

	SLASH_DECURSIVEOPTION1 = D.CONF.MACRO_OPTION;
	SlashCmdList["DECURSIVEOPTION"] = function(msg)
	    D.Waterfall:Open("Decursive");
	end

	SLASH_DECURSIVESHOWORDER1 = D.CONF.MACRO_SHOW_ORDER
	SlashCmdList["DECURSIVESHOWORDER"] = function(msg)
	    D:Show_Cure_Order();
	end
    end -- }}}


    if (FirstEnable) then
	-- configure the message frame for Decursive
	DecursiveTextFrame:SetFading(true);
	DecursiveTextFrame:SetFadeDuration(D.CONF.TEXT_LIFETIME / 3);
	DecursiveTextFrame:SetTimeVisible(D.CONF.TEXT_LIFETIME);


	-- add support Earth panel (need to be checked I don't even know what Earth Panel is...) {{{
	if(EarthFeature_AddButton) then
	    EarthFeature_AddButton(
	    {
		id = "Decursive";
		name = BINDING_HEADER_DECURSIVE;
		subtext = L[D.LOC.OPTION_MENU];
		tooltip = L[BINDING_NAME_DCRSHOW];
		icon = DC.IconON;
		callback = D.ShowHidePriorityListUI;
	    }
	    );
	end -- }}}

	-- hook the load macro thing {{{
	-- So Decursive will re-update its macro when the macro UI is closed
	hooksecurefunc("ShowMacroFrame", function ()
	    if (not D.MacroSaveHooked) then
		D:Debug("Hooking MacroFrame_OnHide");
		hooksecurefunc("MacroFrame_OnHide", function () D:UpdateMacro(); end);
		D.MacroSaveHooked = true;
	    end
	end); -- }}}



    end


    -- these events are automatically stopped when the addon is disabled by Ace

    -- Spell changes events
    self:RegisterEvent("LEARNED_SPELL_IN_TAB");
    self:RegisterEvent("SPELLS_CHANGED");

    -- Combat detection events
    self:RegisterEvent("PLAYER_REGEN_DISABLED","EnterCombat");
    self:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat");

    -- Cast status events
    -- self:RegisterEvent("UNIT_SPELLCAST_STOP","UNIT_SPELLCAST_STOP"); -- Unused
    self:RegisterEvent("UNIT_SPELLCAST_SENT","UNIT_SPELLCAST_SENT");
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_SUCCEEDED");

    -- Raid/Group changes events
    self:RegisterEvent("PARTY_MEMBERS_CHANGED","GroupChanged");
    self:RegisterEvent("PARTY_LEADER_CHANGED","GroupChanged");
    self:RegisterEvent("RAID_ROSTER_UPDATE","GroupChanged");
    self:RegisterEvent("PLAYER_FOCUS_CHANGED","PLAYER_FOCUS_CHANGED");

    -- Player pet detection event (used to find pet spells)
    self:RegisterEvent("UNIT_PET","UNIT_PET");

    -- used to find when a unit is not in line of sight
    self:RegisterEvent("UI_ERROR_MESSAGE","UI_ERROR_MESSAGE");


    -- Buff and Debuff Events thses trigger a debuff scan, ther arguments are not used
    self:RegisterEvent("SpecialEvents_UnitDebuffGained")
    self:RegisterEvent("SpecialEvents_UnitDebuffLost")
    self:RegisterEvent("SpecialEvents_UnitBuffGained")
    self:RegisterEvent("SpecialEvents_UnitBuffLost")


    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

    -- used for Debugging purpose
    --self:RegisterEvent("ADDON_ACTION_FORBIDDEN","ADDON_ACTION_FORBIDDEN");
    --self:RegisterEvent("ADDON_ACTION_BLOCKED","ADDON_ACTION_BLOCKED");



    self:ScheduleRepeatingEvent("SheduledTasks", self.SheduledTasks, 0.2, self);

    -- Configure specific profile dependent data
    D:OnProfileEnable();

    if (FirstEnable) then
	D:ColorPrint(0.3, 0.5, 1, L[D.LOC.IS_HERE_MSG]);
	D:ColorPrint(0.3, 0.5, 1, L[D.LOC.SHOW_MSG]);
    end

    FirstEnable = false;



end -- // }}}

function D:OnProfileEnable()

    D.DcrFullyInitialized = false;
    D:CancelScheduledEvent("LLupdate");
    D:CancelScheduledEvent("MUFupdate");

    D.Groups_datas_are_invalid = true;
    D.Status = {};
    D.Status.FoundSpells = {};
    D.Status.CuringSpells = {};
    D.Status.CuringSpellsPrio = {};
    D.Status.Blacklisted_Array = {};
    D.Status.Unit_Array_UnitToName = {};
    --D.Status.Unit_Array_UnitToIndex = {};
    D.Status.UnitNum = 0;
    D.Status.DelayedFunctionCalls = {};
    D.Status.DelayedFunctionCallsCount = 0;
    D.Status.MaxConcurentUpdateDebuff = 0;

    -- if we log in and we are already fighting...
    if (InCombatLockdown()) then
	D.Status.Combat = true;
    end

    D.profile = D.db.profile; -- D.db has a metatable for __index so to avoid the call of a function each time we access a config data we set this shortcut.
    D.classprofile = D.db.class;

    if type (D.profile.OutputWindow) == "string" then
	D.Status.OutputWindow = getglobal(D.profile.OutputWindow);
    end

    D.debugging = D.profile.debugging;
    D.debugFrame = D.Status.OutputWindow;
    D.printFrame = D.Status.OutputWindow;

    D:Debug("Loading profile datas...");

    -- this is needed to fix a typo in previous versions...
    if (D.profile.skipByClass["WARRIoR"]) then
	D.profile.skipByClass["WARRIoR"] = nil;
	D.profile.skipByClass["WARRIOR"] = {};
	D:tcopy(D.profile.skipByClass["WARRIOR"], D.defaults.skipByClass["WARRIOR"]);
    end

    D:Init();


    D.MicroUnitF.MaxUnit = D.profile.DebuffsFrameMaxCount;


    D.Groups_datas_are_invalid = true;
    D:CreateDropDownFiltersMenu();

    D:CreateDropDownMUFcolorsMenu();
    D.MicroUnitF:RegisterMUFcolors(D.profile.MF_colors);

    D.MicroUnitF:ResetAllPositions ();


    D.Status.Enabled = true;

    D.MicroUnitF:Delayed_Force_FullUpdate();
    D.MicroUnitF:Delayed_MFsDisplay_Update();
    D:AutoHideShowMUFs();

    -- set Fubar Icon
    if not D.Status.HasSpell or D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame then
	D:SetIcon(DC.IconOFF);
    else
	D:SetIcon(DC.IconON);
    end

    -- initialize the unit array to get all the variable existing
    -- even if the Live-list and the MUFs are disabled... (some people are strange)
    D:GetUnitArray();

    -- put the updater events at the end of the init so there is no chance they could be called before everything is ready
    if not D.profile.Hide_LiveList then
	self:ScheduleRepeatingEvent("LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
    end

    if D.profile.ShowDebuffsFrame then
	self:ScheduleRepeatingEvent("MUFupdate", self.DebuffsFrame_Update, self.profile.DebuffsFrameRefreshRate, self);
    end
    D.DcrFullyInitialized = true;
    D:ShowHideButtons(true);
end

function D:OnDisable() -- When the addon is disabled by ACE
    D.Status.Enabled = false;
    D.DcrFullyInitialized = false;
    
    D:SetIcon("Interface\\AddOns\\" .. D.folderName .. "\\iconOFF.tga");
    if ( D.profile.ShowDebuffsFrame) then
	D.MFContainer:Hide();
    end
end




-------------------------------------------------------------------------------
-- init functions and configuration functions {{{
-------------------------------------------------------------------------------
function D:Init() --{{{

    if (D.profile.OutputWindow == nil or not D.profile.OutputWindow) then
	D.Status.OutputWindow = DEFAULT_CHAT_FRAME;
	D.profile.OutputWindow =  "DEFAULT_CHAT_FRAME";
    end

    D:Println("%s %s by %s", D.name, D.version, D.author);

    D:Debug( "Decursive Initialization started!");


    -- SET MF FRAME AS WRITTEN IN THE CURRENT PROFILE {{{
    -- Set the scale and place the MF container correctly
    D.MFContainer:Show();
    D.MFContainer:SetScale(D.profile.DebuffsFrameElemScale);
    D.MicroUnitF:Place();

    if (D.profile.ShowDebuffsFrame) then
	D.MFContainer:Show();
    else
	D.MFContainer:Hide();
    end
    -- }}}

    -- SET THE LIVE_LIST FRAME AS WRITTEN IN THE CURRENT PROFILE {{{

	-- Set poristion and scale
    DecursiveMainBar:Show();
    DecursiveMainBar:SetScale(D.profile.LiveListScale);
    DcrLiveList:Show();
    DcrLiveList:SetScale(D.profile.LiveListScale);
    D:PlaceLL();

    if (D.profile.Hidden) then
	DecursiveMainBar:Hide();
    else
	DecursiveMainBar:Show();
    end

    -- displays frame according to the current profile
    if (D.profile.Hide_LiveList) then
	DcrLiveList:Hide();
    else
	DcrLiveList:ClearAllPoints();
	DcrLiveList:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
	DcrLiveList:Show();
    end

    -- set Alpha
    DecursiveMainBar:SetAlpha(D.profile.LiveListAlpha);
    --DcrLiveList:SetAlpha(D.profile.LiveListAlpha);
    -- }}}

    if (D.profile.MacroBind == "NONE") then
	D.profile.MacroBind = false;
    end


    D:ChangeTextFrameDirection(D.profile.CustomeFrameInsertBottom);


    -- Configure spells
    D:Configure();

end --}}}

function D:ReConfigure() --{{{

    if not D.Status.HasSpell then
	return;
    end

    D:Debug("|cFFFF0000D:ReConfigure was called!|r");

    local Spell, spellName;
    local GetSpellInfo = _G.GetSpellInfo;

    local Reconfigure = false;
    for spellName, Spell in pairs(DC.SpellsToUse) do
	-- Do we have that spell?
	if GetSpellInfo(spellName) then -- yes
	    -- is it new?
	    if not D.Status.FoundSpells[spellName] then -- yes
		Reconfigure = true;
		break;
	    end
	elseif D.Status.FoundSpells[spellName] then -- we don't have it anymore...
	    Reconfigure = true;
	    break;
	end
    end

    if Reconfigure == true then
	D:Debug("D:ReConfigure RECONFIGURATION!");
	D:Configure();
	return;
    end
    D:Debug("D:ReConfigure No reconfiguration required!");

end --}}}

function D:Configure() --{{{

    -- first empty out the old "spellbook"
     D.Status.HasSpell = false;


    local CuringSpells = D.Status.CuringSpells;

    CuringSpells[DC.MAGIC]	= false;
    CuringSpells[DC.ENEMYMAGIC]	= false;
    CuringSpells[DC.CURSE]	= false;
    CuringSpells[DC.POISON]     = false;
    CuringSpells[DC.DISEASE]    = false;
    CuringSpells[DC.CHARMED]    = false;

    local Spell, spellName, Type, _;
    local GetSpellInfo = _G.GetSpellInfo;

    D:Debug("Configuring Decursive...");

    for spellName, Spell in pairs(DC.SpellsToUse) do
	-- Do we have that spell?
	if GetSpellInfo(spellName) then -- yes
	    -- register it
	    for _, Type in pairs (DC.SpellsToUse[spellName].Types) do

		if not CuringSpells[Type] or not DC.SpellsToUse[ CuringSpells[Type] ].IsBest then  -- we did not already registered this spell or it's not the best spell for this type

		    D.Status.FoundSpells[spellName] = {DC.SpellsToUse[spellName].Pet, (select(2, GetSpellInfo(spellName)))};
		    CuringSpells[Type] = spellName;

		    D:Debug("Spell \"%s\" (%s) registered for type %d ( %s ), PetSpell: ", spellName, D.Status.FoundSpells[spellName][2], Type, DC.TypeNames[Type], D.Status.FoundSpells[spellName][1]);
		    D.Status.HasSpell = true;
		end
	    end

	end
    end



    --[[
    -- parse through the entire library...
    -- look for known cleaning spells...

    local i = 1;

    local BookType = BOOKTYPE_SPELL;
    local break_flag = false

    -- This array will be used to test if a reconfiguration is required
    D.Status.FoundSpells = {};

    while not break_flag  do
	while (true) do -- I wish there was a continue statement in LUA...
	    spellName, spellRank = GetSpellName(i, BookType);
	    if (not spellName) then
		if (BookType == BOOKTYPE_PET) then
		    break_flag = true;
		    break;
		end
		BookType = BOOKTYPE_PET; -- once done with our spells, search for our pet' spells
		i = 1;
		break;

	    end


	    if (DC.SpellsToUse[spellName]) then

		
	    end

	    i = i + 1
	end
    end
    --]]


    -- Verify the cure order list (if it was damaged)
    D:CheckCureOrder ();
    -- Set the appropriate priorities according to debuffs types
    D:SetCureOrder ();

    if (not D.Status.HasSpell) then
	return;
    end







end --}}}

function D:GetSpellsTranslations(FromDIAG)
    local GetSpellInfo = _G.GetSpellInfo;
    local Spells = {
	[D.LOC.SPELL_POLYMORPH]		= {	118,					 },
	[D.LOC.SPELL_CYCLONE]		= {	33786,					 },
	[D.LOC.SPELL_CURE_DISEASE]	= {	528, 2870,				 },
	[D.LOC.SPELL_ABOLISH_DISEASE]	= {	552,					 },
	[D.LOC.SPELL_PURIFY]		= {	1152,					 },
	[D.LOC.SPELL_CLEANSE]		= {	4987,					 },
	[D.LOC.SPELL_DISPELL_MAGIC]	= {	527, 988,				 },
	[D.LOC.SPELL_CURE_POISON]	= {	526, 8946,				 },
	[D.LOC.SPELL_ABOLISH_POISON]	= {	2893,					 },
	[D.LOC.SPELL_REMOVE_LESSER_CURSE]={	475,					 },
	[D.LOC.SPELL_REMOVE_CURSE]	= {	2782,					 },
	[D.LOC.SPELL_PURGE]		= {	370, 8012,				 },
	[D.LOC.PET_FEL_CAST]		= {	19505, 19731, 19734, 19736, 27276, 27277,},
	[D.LOC.PET_DOOM_CAST]		= {	527, 988,				 },
	[D.LOC.CURSEOFTONGUES]		= {	1714, 11719,                             },
	[D.LOC.DCR_LOC_SILENCE]		= {	15487,					 },
	[D.LOC.DCR_LOC_MINDVISION]	= {	2096, 10909,				 },
	[D.LOC.DREAMLESSSLEEP]		= {	15822,					 },
	[D.LOC.GDREAMLESSSLEEP]		= {	24360,					 },
	[D.LOC.MDREAMLESSSLEEP]		= {	28504,					 },
	[D.LOC.ANCIENTHYSTERIA]		= {	19372,					 },
	[D.LOC.IGNITE]			= {	19659,					 },
	[D.LOC.TAINTEDMIND]		= {	16567,					 },
	[D.LOC.MAGMASHAKLES]		= {	19496,					 },
	[D.LOC.CRIPLES]			= {	33787,					 },
	[D.LOC.DUSTCLOUD]		= {	26072,					 },
	[D.LOC.WIDOWSEMBRACE]		= {	28732,					 },
	[D.LOC.SONICBURST]		= {	39052,					 },
	[D.LOC.DELUSIONOFJINDO]		= {	24306,					 },
	[D.LOC.MUTATINGINJECTION]	= {	28169,					 },
	['Phase Shift']			= {	4511,					 },
	['Banish']			= {	710, 18647,				 },
	['Frost Trap Aura']		= {	13810,					 },
	['Arcane Blast']		= {	30451,					 },
	['Prowl']			= {	5215, 6783, 9913, 24450,		 },
	['Stealth']			= {	1784, 1785, 1786, 1787,			 },
	['Shadowmeld']			= {	20580,					 },
	['Invisibility']		= {	66,					 },
	['Lesser Invisibility']		= {	7870,                                    },
	['Ice Armor']			= {	7302, 7320, 10219, 10220, 27124,	 },
	['Unstable Affliction']		= {	30108, 30404, 30405,			 },
	['Dampen Magic']		= {	604,					 },
	['Amplify Magic']		= {	1008,					 },
    };


    local Sname, Sids, Sid, _, ok;
    ok = true;
    for Sname, Sids in pairs(Spells) do
	for _, Sid in ipairs(Sids) do

	    if _ == 1 then
		DS[Sname] = (GetSpellInfo(Sid));
	    elseif FromDIAG then
		if DS[Sname] ~= (GetSpellInfo(Sid)) then
		    D:errln("Spell IDs %s and %s have different translations: %s and %s", Sids[1], Sid, DS[Sname], (GetSpellInfo(Sid)) );
		    D:errln("Please report this to ARCHARODIM@teaser.fr");
		    ok = false;
		end
	    end

	end
    end

    -- get a 'Rank #' string exemple (workaround due to the way the
    -- polymorph spell variants are handled in WoW 2.3)

    DC.RANKNUMTRANS = select(2, GetSpellInfo(118));

    return ok;

end


-- Create the macro for Decursive
-- This macro will cast the first spell (priority)

-- NEW SetBindingMacro("KEY", "macroname"|macroid)
-- UPDATED name,texture,body,isLocal = GetMacroInfo(id|"name") - Now takes ID or name
-- UPDATED DeleteMacro() -- as above
-- UPDATED EditMacro() -- as above
-- UPDATED PickupMacro() -- as above
-- CreateMacro("name", icon, "body", local)


function D:UpdateMacro ()

    if (D.Status.Combat) then
	D:AddDelayedFunctionCall (
	"UpdateMacro", self.UpdateMacro,
	self);
	return false;
    end
    D:Debug("UpdateMacro called");


    local CuringSpellsPrio  = D.Status.CuringSpellsPrio;
    local ReversedCureOrder = D.Status.ReversedCureOrder;
    local CuringSpells	    = D.Status.CuringSpells;


    -- Get an ordered spell table
    local Spells = {};
    for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do
	--table.insert (Spells, Prio, Spell);
	Spells[Prio] = Spell;
    end

    --D:PrintLiteral(Spells);
    if (next (Spells)) then
	for i=1,4 do
	    if (not Spells[i]) then
		table.insert (Spells, CuringSpells[ReversedCureOrder[1] ]);
	    end
	end
    end

    --D:PrintLiteral(D.Status.CuringSpellsPrio);
    local MacroParameters = {
	D.CONF.MACRONAME,
	1,
	next(Spells) and string.format("/stopcasting\n/cast [target=mouseover,nomod,exists] %s;  [target=mouseover,exists,mod:ctrl] %s; [target=mouseover,exists,mod:shift] %s", unpack(Spells)) or "/script Dcr:Println('"..L[D.LOC.NOSPELL].."')",
	1
    };

    --D:PrintLiteral(GetMacroIndexByName(D.CONF.MACRONAME));
    if (GetMacroIndexByName(D.CONF.MACRONAME) ~= 0) then
	-- D:Debug("Macro found");
	EditMacro(D.CONF.MACRONAME, unpack(MacroParameters));
    elseif ((GetNumMacros()) < 18) then
	CreateMacro(unpack(MacroParameters));
    else
	D:errln("Too many macros exist, Decursive cannot create its macro");
	return false;
    end


    D:SetMacroKey(D.profile.MacroBind);

    return true;

end



-- }}}

function D:SetDateAndRevision (Date, Revision)
    if not D.TextVersion then
	D.TextVersion = GetAddOnMetadata("Decursive", "Version");
	D.Revision = 0;
    end

    local Rev = tonumber((string.gsub(Revision, "%$Revision: (%d+) %$", "%1")));

    if  Rev and D.Revision < Rev then
	D.Revision = Rev;
	D.date = Date:gsub("%$Date: (.-) %$", "%1");
	D.version = string.format("%s (|cFF11CCAARevision: %d|r)", D.TextVersion, Rev);
    end
end

D:SetDateAndRevision("$Date$", "$Revision$");

DcrLoadedFiles["DCR_init.lua"] = true;

-------------------------------------------------------------------------------
