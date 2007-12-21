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
D.BC	    = AceLibrary("Babble-Class-2.2");
D.BS	    = AceLibrary("Babble-Spell-2.2");
D.DewDrop   = AceLibrary("Dewdrop-2.0");
D.A	    = AceLibrary("SpecialEvents-Aura-2.0");
D.Waterfall = AceLibrary("Waterfall-1.0");
D.T	    = AceLibrary("Tablet-2.0");

local L = D.L;
local BC = D.BC;
local BS = D.BS;

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

DC.IconON = "Interface\\AddOns\\" .. D.folderName .. "\\iconON.tga";
DC.IconOFF = "Interface\\AddOns\\" .. D.folderName .. "\\iconOFF.tga";

DC.ENEMYMAGIC = 2;
DC.MAGIC	= 1;
DC.CURSE	= 4;
DC.POISON	= 8;
DC.DISEASE	= 16;
DC.CHARMED	= 32;


DC.NORMAL		    = 8;
DC.ABSENT		    = 16;
DC.FAR			    = 32;
DC.STEALTHED		    = 64;
DC.BLACKLISTED		    = 128;
DC.AFFLICTED		    = 256;
DC.AFFLICTED_NIR	    = 512;
DC.CHARMED		    = 1024;
DC.AFFLICTED_AND_CHARMED = bit.bor(DC.AFFLICTED, DC.CHARMED);

DC.MFSIZE = 20;

-- This value is returned by UnitName when the name of a unit is not available yet
DC.UNKNOWN = UNKNOWNOBJECT;

-- Get the translation for "pet"
DC.PET = SPELL_TARGET_TYPE8_DESC;

-- Holder for 'Rank #' translation
DC.RANKNUMTRANS = false;

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
    }

    -- /script DC.SpellsToUse[D.BS["Dampen Magic"]] = {Types = {DC.MAGIC, DC.DISEASE, DC.POISON},IsBest = false}; D:Configure();

    -- SPELL TABLE -- must be parsed after localisation is loaded {{{
	DC.SpellsToUse = {

	    [BS[D.LOC.SPELL_POLYMORPH]]	    = { --Mages
	    Types = {DC.CHARMED},
	    IsBest = false,
	    Rank = 1,
	},
	-- Druids
	[BS[D.LOC.SPELL_CYCLONE]]	    = {
	    Types = {DC.CHARMED},
	    IsBest = false,
	},
	--[[
	-- used for testing only
	[BS["Dampen Magic"] ]	    = {
	    Types = {DC.MAGIC},--, DC.DISEASE, DC.POISON},
	    IsBest = false,
	}, --]]
	--[[
	-- used for testing only
	[BS["Amplify Magic"] ]	    = {
	    Types = {DC.DISEASE, DC.POISON},
	    IsBest = false,
	}, --]]
	[BS[D.LOC.SPELL_CURE_DISEASE]]	    = {
	    Types = {DC.DISEASE},
	    IsBest = false,
	},
	[BS[D.LOC.SPELL_ABOLISH_DISEASE]]	    = {
	    Types = {DC.DISEASE},
	    IsBest = true,
	},
	[BS[D.LOC.SPELL_PURIFY]]		    = {
	    Types = {DC.DISEASE, DC.POISON},
	    IsBest = false,
	},
	-- paladins
	[BS[D.LOC.SPELL_CLEANSE]]		    = {
	    Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
	    IsBest = true,
	},
	[BS[D.LOC.SPELL_DISPELL_MAGIC]]	    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	},
	[BS[D.LOC.SPELL_CURE_POISON]]	    = {
	    Types = {DC.POISON},
	    IsBest = false,
	},
	[BS[D.LOC.SPELL_ABOLISH_POISON]]	    = {
	    Types = {DC.POISON},
	    IsBest = true,
	},
	-- mages
	[BS[D.LOC.SPELL_REMOVE_LESSER_CURSE]]   = {
	    Types = {DC.CURSE},
	    IsBest = true,
	},
	-- druids
	[BS[D.LOC.SPELL_REMOVE_CURSE]]	    = {
	    Types = {DC.CURSE},
	    IsBest = true,
	},
	--[=[ -- disabled because of Korean locals... see below
	[BS[D.LOC.SPELL_PURGE]]		    = {
	    Types = {DC.ENEMYMAGIC},
	    IsBest = true,
	},
	--]=]
	[BS[D.LOC.PET_FEL_CAST]]		    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	},
	[BS[D.LOC.PET_DOOM_CAST]]		    = {
	    Types = {DC.MAGIC, DC.ENEMYMAGIC},
	    IsBest = true,
	},

    };

    -- Thanks to Korean localization team of WoW we have to make an exception....
    -- They found the way to call two different spells the same (Shaman PURGE and Paladin CLEANSE... (both are called "정화") )
    if (select(2, UnitClass("player")) == "SHAMAN") then
	DC.SpellsToUse[BS[D.LOC.SPELL_PURGE]]		    = {
	    Types = {DC.ENEMYMAGIC},
	    IsBest = true,
	};
    end

    -- // }}}

end -- // }}}

--Old_MacroFrame_SaveMacro = false;

function D:OnEnable(first) -- called after PLAYER_LOGIN -- {{{
    
    if DecursiveSelfDiagnostic() == 2 then
	return false;
    end

    -- Register slashes command {{{
    if (first) then
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


    if (first) then
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


    -- these events are automatically stopped when the addon is disabled by ACE

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

    if (first) then
	D:ColorPrint(0.3, 0.5, 1, L[D.LOC.IS_HERE_MSG]);
	D:ColorPrint(0.3, 0.5, 1, L[D.LOC.SHOW_MSG]);
    end



end -- // }}}

function D:OnProfileEnable()


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

    if not D.profile.Hide_LiveList then
	self:ScheduleRepeatingEvent("LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
    end

    D.MicroUnitF.MaxUnit = D.profile.DebuffsFrameMaxCount;

    if D.profile.ShowDebuffsFrame then
	self:ScheduleRepeatingEvent("MUFupdate", self.DebuffsFrame_Update, self.profile.DebuffsFrameRefreshRate, self);
    end

    D.Groups_datas_are_invalid = true;
    D:CreateDropDownFiltersMenu();

    D.MicroUnitF:ResetAllPositions ();
  

    D.Status.Enabled = true;

    D.MicroUnitF:Delayed_MFsDisplay_Update();

    -- set Fubar Icon
    if not D.Status.HasSpell or D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame then
	D:SetIcon(DC.IconOFF);
    else
	D:SetIcon(DC.IconON);
    end

    -- initialize the unit array to get all the variable existing
    -- even if the Live-list and the MUFs are disabled... (some people are strange)
    D:GetUnitArray();

end

function D:OnDisable() -- When the addon is disabled by ACE
    D.Status.Enabled = false;
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

    D:ShowHideButtons(true);

    D:ChangeTextFrameDirection(D.profile.CustomeFrameInsertBottom);


    -- Configure spells
    D:Configure();

end --}}}

function D:ReConfigure() --{{{

    if not D.Status.HasSpell then
	return;
    end

    D:Debug("|cFFFF0000D:ReConfigure was called!|r");

    local DoNotReconfigure = true;

    for Spell, id_booktype in pairs(D.Status.FoundSpells) do

	if ( GetSpellName(id_booktype[1], id_booktype[2]) ~= Spell) then
	    DoNotReconfigure = false;
	    break;
	end

    end

    if DoNotReconfigure == false then
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

    CuringSpells[DC.MAGIC]	  = false;
    CuringSpells[DC.ENEMYMAGIC] = false;
    CuringSpells[DC.CURSE]	  = false;
    CuringSpells[DC.POISON]     = false;
    CuringSpells[DC.DISEASE]    = false;
    CuringSpells[DC.CHARMED]    = false;



    D:Debug("Configuring Decursive...");
    -- parse through the entire library...
    -- look for known cleaning spells...

    local i = 1;

    local BookType = BOOKTYPE_SPELL;
    local break_flag = false
    local spellName, spellRank;

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

	    -- get a 'Rank #' string exemple (workaround due to the way the
	    -- polymorph spell variants are handled in WoW 2.3)
	    -- it will be used to select the rank of the spell found.
	    -- We only test when we have found at least one spell else we would
	    -- detect things that are not ranks such as 'Master' for Cooking...

	    if not DC.RANKNUMTRANS and D.Status.HasSpell and spellName ~= BS[D.LOC.SPELL_POLYMORPH] and spellRank ~= "" then
		DC.RANKNUMTRANS = spellRank;
	    end


	    if (DC.SpellsToUse[spellName]) then

		for _, Type in pairs (DC.SpellsToUse[spellName].Types) do

		    if	    (CuringSpells[Type] and DC.SpellsToUse[ CuringSpells[Type] ].IsBest)  -- we already registered the best
			or  (CuringSpells[Type] and CuringSpells[Type] == spellName) then	    -- this spell is already registered
			break;
		    end

		    D.Status.FoundSpells[spellName] = {i, BookType, spellRank}; -- save the id of the spell to be able to check for changes later
		    CuringSpells[Type] = spellName;

		    D:Debug("Spell \"%s\" registered for type %d ( %s )", spellName, Type, DC.TypeNames[Type]);
		end

		 D.Status.HasSpell = true;
	    end

	    i = i + 1
	end
    end


    -- Verify the cure order list (if it was damaged)
    D:CheckCureOrder ();
    -- Set the appropriate priorities according to debuffs types
    D:SetCureOrder ();

    if (not D.Status.HasSpell) then
	return;
    end

    

    



end --}}}

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

    --Dcr:PrintLiteral(Spells);
    if (next (Spells)) then
	for i=1,4 do
	    if (not Spells[i]) then
		table.insert (Spells, CuringSpells[ReversedCureOrder[1] ]);
	    end
	end
    end

    --Dcr:PrintLiteral(D.Status.CuringSpellsPrio);
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
