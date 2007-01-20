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

Dcr	    = AceLibrary("AceAddon-2.0"):new    ("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0");
Dcr.AOO	    = AceLibrary("AceOO-2.0");
Dcr.L	    = AceLibrary("AceLocale-2.2"):new   ("Dcr");
Dcr.BC	    = AceLibrary("Babble-Class-2.2");
Dcr.BS	    = AceLibrary("Babble-Spell-2.2");
Dcr.DewDrop = AceLibrary("Dewdrop-2.0");

local L = Dcr.L;
local BC = Dcr.BC;
local BS = Dcr.BS;


-------------------------------------------------------------------------------
-- variables {{{
-------------------------------------------------------------------------------
Dcr.Groups_datas_are_invalid = false;
-------------------------------------------------------------------------------
-- Internal HARD settings for decursive
Dcr.CONF = {};
Dcr.CONF.TEXT_LIFETIME = 4.0;
Dcr.CONF.MAX_LIVE_SLOTS = 15;
Dcr.CONF.MACRONAME = "Decursive";

BINDING_HEADER_DECURSIVE = "Decursive";

Dcr.CONF.MACRO_COMMAND  = "/decursive";
Dcr.CONF.MACRO_SHOW     = "/dcrshow";
Dcr.CONF.MACRO_HIDE     = "/dcrhide";
Dcr.CONF.MACRO_OPTION   = "/dcroption";
Dcr.CONF.MACRO_RESET    = "/dcrreset";

Dcr.CONF.MACRO_PRADD    = "/dcrpradd";
Dcr.CONF.MACRO_PRCLEAR  = "/dcrprclear";
Dcr.CONF.MACRO_PRLIST   = "/dcrprlist";
Dcr.CONF.MACRO_PRSHOW   = "/dcrprshow";

Dcr.CONF.MACRO_SKADD    = "/dcrskadd";
Dcr.CONF.MACRO_SKCLEAR  = "/dcrskclear";
Dcr.CONF.MACRO_SKLIST   = "/dcrsklist";
Dcr.CONF.MACRO_SKSHOW   = "/dcrskshow";
Dcr.CONF.MACRO_DEBUG	   = "/dcrdebug";
Dcr.CONF.MACRO_SHOW_ORDER   = "/dcrshoworder";

-- CONSTANTS
DcrC = {};

DcrC.MAGIC	= 1;
DcrC.ENEMYMAGIC = 2;
DcrC.CURSE	= 4;
DcrC.POISON	= 8;
DcrC.DISEASE	= 16;
DcrC.BLACKTEXTURE = "Interface\\AddOns\\Decursive\\Textures\\BackDrop";
DcrC.TRANSTEXTURE = "Interface\\AddOns\\Decursive\\Textures\\BackDrop-transparent-white";

Dcr.MFContainer = false;

Dcr.Status = {};

Dcr.Status.CuringSpells = {};
Dcr.Status.CuringSpellsPrio = {};
Dcr.Status.DelayedFunctionCalls = {};
Dcr.Status.DelayedFunctionCallsCount = 0;

Dcr.Status.Blacklisted_Array = {};


-- // }}}
-------------------------------------------------------------------------------


-- Dcr.Initialized = false;
-------------------------------------------------------------------------------

function Dcr:OnInitialize() -- Called on ADDON_LOADED -- {{{
	self:RegisterDB("DcrDB", "DcrCharDB");
	self:RegisterDefaults('profile', Dcr.defaults )
	-- self:RegisterDefaults('profile', defaults );
	self:RegisterChatCommand({'/dcr', '/decursive'}, Dcr.options )


	Dcr.MFContainer = DcrMUFsContainer;
	Dcr.MicroUnitF.Frame = Dcr.MFContainer;

	Dcr.DewDrop:Register(DecursiveMainBar,
	'children', function()
	    Dcr.DewDrop:FeedAceOptionsTable( Dcr.options )
	end
	)

	DcrC.TypeNames = {
	    [DcrC.MAGIC]	= Dcr.LOC.MAGIC;
	    [DcrC.ENEMYMAGIC]	= Dcr.LOC.MAGIC;
	    [DcrC.CURSE]	= Dcr.LOC.CURSE;
	    [DcrC.POISON]	= Dcr.LOC.POISON;
	    [DcrC.DISEASE]	= Dcr.LOC.DISEASE;
	}

	DcrC.NameToTypes = Dcr:tReverse(DcrC.TypeNames);
	DcrC.NameToTypes[Dcr.LOC.MAGIC] = DcrC.MAGIC;

	DcrC.TypeColors = {
	    [DcrC.MAGIC]	= "2222DD";
	    [DcrC.ENEMYMAGIC]	= "2222FF";
	    [DcrC.CURSE]	= "DD22DD";
	    [DcrC.POISON]	= "22DD22";
	    [DcrC.DISEASE]	= "995533";
	}

	-- SPELL TABLE -- must be parsed after localisation is loaded {{{
	DcrC.SpellsToUse = {

	    [BS[Dcr.LOC.SPELL_POLYMORPH]]	    = {
		Types = {DcrC.ENEMYMAGIC},
		IsBest = false,
	    },
	    --[[
	    [BS["Dampen Magic"] ]	    = {
		Types = {DcrC.MAGIC, DcrC.DISEASE, DcrC.POISON},
		IsBest = false,
	    }, --]]
	    [BS[Dcr.LOC.SPELL_CURE_DISEASE]]	    = {
		Types = {DcrC.DISEASE},
		IsBest = false,
	    },
	    [BS[Dcr.LOC.SPELL_ABOLISH_DISEASE]]	    = {
		Types = {DcrC.DISEASE},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_PURIFY]]		    = {
		Types = {DcrC.DISEASE, DcrC.POISON},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_CLEANSE]]		    = {
		Types = {DcrC.MAGIC, DcrC.DISEASE, DcrC.POISON},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_DISPELL_MAGIC]]	    = {
		Types = {DcrC.MAGIC, DcrC.ENEMYMAGIC},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_CURE_POISON]]	    = {
		Types = {DcrC.POISON},
		IsBest = false,
	    },
	    [BS[Dcr.LOC.SPELL_ABOLISH_POISON]]	    = {
		Types = {DcrC.POISON},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_REMOVE_LESSER_CURSE]] = {
		Types = {DcrC.CURSE},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_REMOVE_CURSE]]	    = {
		Types = {DcrC.CURSE},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.SPELL_PURGE]]		    = {
		Types = {DcrC.ENEMYMAGIC},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.PET_FEL_CAST]]		    = {
		Types = {DcrC.MAGIC, DcrC.ENEMYMAGIC},
		IsBest = true,
	    },
	    [BS[Dcr.LOC.PET_DOOM_CAST]]		    = {
		Types = {DcrC.MAGIC, DcrC.ENEMYMAGIC},
		IsBest = true,
	    },

	}; -- // }}}

end -- // }}}

--Old_MacroFrame_SaveMacro = false;

function Dcr:OnEnable(first) -- called after PLAYER_LOGIN -- {{{
    
    -- Register slashes command {{{
    if (first) then
	SLASH_DECURSIVEPRADD1 = Dcr.CONF.MACRO_PRADD;
	SlashCmdList["DECURSIVEPRADD"] = function(msg)
	    Dcr:AddTargetToPriorityList();
	end
	SLASH_DECURSIVEPRCLEAR1 = Dcr.CONF.MACRO_PRCLEAR;
	SlashCmdList["DECURSIVEPRCLEAR"] = function(msg)
	    Dcr:ClearPriorityList();
	end

	SLASH_DECURSIVEPRSHOW1 = Dcr.CONF.MACRO_PRSHOW;
	SlashCmdList["DECURSIVEPRSHOW"] = function(msg)
	    Dcr:ShowHidePriorityListUI();
	end

	SLASH_DECURSIVESKADD1 = Dcr.CONF.MACRO_SKADD;
	SlashCmdList["DECURSIVESKADD"] = function(msg)
	    Dcr:AddTargetToSkipList();
	end
	SLASH_DECURSIVESKCLEAR1 = Dcr.CONF.MACRO_SKCLEAR;
	SlashCmdList["DECURSIVESKCLEAR"] = function(msg)
	    Dcr:ClearSkipList();
	end

	SLASH_DECURSIVESKSHOW1 = Dcr.CONF.MACRO_SKSHOW;
	SlashCmdList["DECURSIVESKSHOW"] = function(msg)
	    Dcr:ShowHideSkipListUI();
	end

	SLASH_DECURSIVESHOW1 = Dcr.CONF.MACRO_SHOW;
	SlashCmdList["DECURSIVESHOW"] = function(msg)
	    Dcr:Hide(0);
	end

	SLASH_DECURSIVERESET1 = Dcr.CONF.MACRO_RESET;
	SlashCmdList["DECURSIVERESET"] = function(msg)
	    Dcr:ResetWindow();
	end

	SLASH_DECURSIVEHIDE1 = Dcr.CONF.MACRO_HIDE;
	SlashCmdList["DECURSIVEHIDE"] = function(msg)
	    Dcr:Hide(1);
	end

	SLASH_DECURSIVESHOWORDER1 = Dcr.CONF.MACRO_SHOW_ORDER
	SlashCmdList["DECURSIVESHOWORDER"] = function(msg)
	    Dcr:Show_Cure_Order();
	end
    end -- }}}


    if (first) then
	-- configure the message frame for Decursive
	DecursiveTextFrame:SetFading(true);
	DecursiveTextFrame:SetFadeDuration(Dcr.CONF.TEXT_LIFETIME / 3);
	DecursiveTextFrame:SetTimeVisible(Dcr.CONF.TEXT_LIFETIME);


	-- add support Earth panel
	if(EarthFeature_AddButton) then
	    EarthFeature_AddButton(
	    {
		id = "Decursive";
		name = BINDING_HEADER_DECURSIVE;
		subtext = L[Dcr.LOC.OPTION_MENU];
		tooltip = L[BINDING_NAME_DCRSHOW];
		icon = "Interface\\Icons\\Spell_Nature_RemoveCurse";
		callback = Dcr.ShowHidePriorityListUI;
	    }
	    );
	end

	--hook the load macro thing
	hooksecurefunc("ShowMacroFrame", function ()
	    if (not Dcr.MacroSaveHooked) then
		Dcr:Debug("Hooking MacroFrame_OnHide");
		hooksecurefunc("MacroFrame_OnHide", function () Dcr:UpdateMacro(); end);
		Dcr.MacroSaveHooked = true;
	    end
	end);

    end


    -- these events are automatically stopped when the addon is disabled by ACE
    self:RegisterEvent("LEARNED_SPELL_IN_TAB","Configure",1);
    self:RegisterEvent("SPELLS_CHANGED","ReConfigure", 1);
    self:RegisterEvent("PLAYER_REGEN_DISABLED","EnterCombat");
    self:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat");
    self:RegisterEvent("UNIT_SPELLCAST_STOP","UNIT_SPELLCAST_STOP");
   -- self:RegisterEvent("UNIT_SPELLCAST_FAILED","UNIT_SPELLCAST_FAILED");
    self:RegisterEvent("UNIT_SPELLCAST_SENT","UNIT_SPELLCAST_SENT");
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_SUCCEEDED");

    self:RegisterEvent("PARTY_MEMBERS_CHANGED","GroupChanged");
    self:RegisterEvent("PARTY_LEADER_CHANGED","GroupChanged");
    self:RegisterEvent("RAID_ROSTER_UPDATE","GroupChanged");
    self:RegisterEvent("UNIT_PET","UNIT_PET");
    self:RegisterEvent("UI_ERROR_MESSAGE","UI_ERROR_MESSAGE");
    self:RegisterEvent("ADDON_ACTION_FORBIDDEN","ADDON_ACTION_FORBIDDEN");
    --	self:RegisterEvent("ADDON_ACTION_BLOCKED","ADDON_ACTION_BLOCKED");



    self:ScheduleRepeatingEvent(Dcr.SheduledTasks, 0.12);
    
    -- Configure specific profile dependent data
    Dcr:OnProfileEnable();

    if (first) then
	Dcr:ColorPrint(0.3, 0.5, 1, L[Dcr.LOC.IS_HERE_MSG]);
	Dcr:ColorPrint(0.3, 0.5, 1, L[Dcr.LOC.SHOW_MSG]);
    end



end -- // }}}

function Dcr:OnProfileEnable()


    if (Dcr.Status.ScanShedule) then
	Dcr:CancelScheduledEvent(Dcr.Status.ScanShedule);
    end
    if (Dcr.Status.MicroFrameUpdateSchedule) then
	Dcr:CancelScheduledEvent(Dcr.Status.MicroFrameUpdateSchedule);
    end


    Dcr.Groups_datas_are_invalid = true;
    Dcr.Status = {};
    Dcr.Status.FoundSpells = {};
    Dcr.Status.CuringSpells = {};
    Dcr.Status.CuringSpellsPrio = {};
    Dcr.Status.Blacklisted_Array = {};
    Dcr.Status.DelayedFunctionCalls = {};
    Dcr.Status.DelayedFunctionCallsCount = 0;

    if type (Dcr.db.profile.OutputWindow) == "string" then
	Dcr.Status.OutputWindow = getglobal(Dcr.db.profile.OutputWindow);
    end

    Dcr.debugging = Dcr.db.profile.debugging;
    Dcr.debugFrame = Dcr.Status.OutputWindow;
    Dcr.printFrame = Dcr.Status.OutputWindow;

    Dcr:Debug("Loading profile datas...");
    Dcr:Init();

    if not Dcr.db.profile.Hide_LiveList then
	Dcr.Status.ScanShedule =
	self:ScheduleRepeatingEvent(Dcr.RaidScanner_SC, Dcr.db.profile.ScanTime);
    else
	Dcr.Status.ScanShedule = false;
    end

    if Dcr.db.profile.ShowDebuffsFrame then
	Dcr.Status.MicroFrameUpdateSchedule =
	self:ScheduleRepeatingEvent(Dcr.DebuffsFrame_Update, 0.06);
    else
	Dcr.Status.MicroFrameUpdateSchedule = false;
    end

    Dcr.Groups_datas_are_invalid = true;
    Dcr:CreateDropDownFiltersMenu();

  

    Dcr.Status.Enabled = true;


end

function Dcr:OnDisable() -- When the addon is disabled by ACE
    Dcr.Status.Enabled = false;
    if ( Dcr.db.profile.ShowDebuffsFrame) then
	Dcr.MFContainer:Hide();
    end
end




-------------------------------------------------------------------------------
-- init functions and configuration functions {{{
-------------------------------------------------------------------------------
function Dcr:Init() --{{{

    if (Dcr.db.profile.OutputWindow == nil or not Dcr.db.profile.OutputWindow) then
	Dcr.Status.OutputWindow = DEFAULT_CHAT_FRAME;
	Dcr.db.profile.OutputWindow =  "DEFAULT_CHAT_FRAME";
    end

    Dcr:Println("%s %s by %s", Dcr.name, Dcr.version, Dcr.author);

    Dcr:Debug( "Decursive Initialization started!");



    -- displays frame according to the current profile
    if (Dcr.db.profile.Hide_LiveList) then
	DecursiveAfflictedListFrame:Hide();
    else
	DecursiveAfflictedListFrame:ClearAllPoints();
	DecursiveAfflictedListFrame:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
	DecursiveAfflictedListFrame:Show();
    end

    if (Dcr.db.profile.ShowDebuffsFrame) then
	Dcr.MFContainer:Show();
	Dcr.MFContainer:SetScale(Dcr.db.profile.DebuffsFrameElemScale);
	Dcr.MicroUnitF:Place();
    else
	Dcr.MFContainer:Hide();
    end
    if (Dcr.db.profile.Hidden) then
	DecursiveMainBar:Hide();
    else
	DecursiveMainBar:Show();
    end

    Dcr:ShowHideButtons(true);

    Dcr:ChangeTextFrameDirection(Dcr.db.profile.CustomeFrameInsertBottom);


    -- Configure spells
    Dcr:Configure();

end --}}}

function Dcr:ReConfigure() --{{{

    if not Dcr.Status.HasSpell then
	return;
    end

    Dcr:Debug("Dcr:ReConfigure was called!");

    local DoNotReconfigure = true;

    for Spell, id_booktype in pairs(Dcr.Status.FoundSpells) do

	if ( GetSpellName(id_booktype[1], id_booktype[2]) ~= Spell) then
	    DoNotReconfigure = false;
	    break;
	end

    end

    if DoNotReconfigure == false then
	Dcr:Debug("Dcr:ReConfigure RECONFIGURATION!");
	Dcr:Configure();
	return;
    end
    Dcr:Debug("Dcr:ReConfigure No reconfiguration required!");

end --}}}

function Dcr:Configure() --{{{

    -- first empty out the old "spellbook"
     Dcr.Status.HasSpell = false;


    -- TODO
    -- ==> In the futur, Users will be able to choose keystrokes and clicks associated to their spells

    local CuringSpells = Dcr.Status.CuringSpells;

    CuringSpells[DcrC.MAGIC]	  = false;
    CuringSpells[DcrC.ENEMYMAGIC] = false;
    CuringSpells[DcrC.CURSE]	  = false;
    CuringSpells[DcrC.POISON]     = false;
    CuringSpells[DcrC.DISEASE]    = false;



    Dcr:Debug("Configuring Decursive...");
    -- parse through the entire library...
    -- look for known cleaning spells...

    local i = 1;

    local BookType = BOOKTYPE_SPELL;
    local break_flag = false
    local spellName, spellRank;

    local CheckedSpells = Dcr.db.profile.CureOrder 

    -- This array will be used to test if a reconfiguration is required
    Dcr.Status.FoundSpells = {};

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

	    if (DcrC.SpellsToUse[spellName]) then

		for _, Type in pairs (DcrC.SpellsToUse[spellName].Types) do

		    if	    (CuringSpells[Type] and DcrC.SpellsToUse[ CuringSpells[Type] ].IsBest)  -- we already registered the best
			or  (CuringSpells[Type] and CuringSpells[Type] == spellName) then	    -- this spell is already registered
			break;
		    end

		    Dcr.Status.FoundSpells[spellName] = {i, BookType}; -- save the id of the spell to be able to check for changes later
		    CuringSpells[Type] = spellName;

		    -- if this spell was not available before, activate it
		    if (CheckedSpells[Type] == -1) then
			CheckedSpells[Type] = false;
			Dcr:SetCureOrder(Type);
		    end

		    Dcr:Debug("Spell \"%s\" registered for type %d ( %s )", spellName, Type, DcrC.TypeNames[Type]);
		end


		 Dcr.Status.HasSpell = true;

		-- any of them will work for the cooldown... we store the last
		--DCR_SPELL_COOLDOWN_CHECK[1] = i; DCR_SPELL_COOLDOWN_CHECK[2] = BookType;


		-- Dcr:Debug( L[Dcr.LOC.SPELL_FOUND], spellName);

	    end

	    i = i + 1
	end
    end


    -- Verify the cure order list (if it was damaged)
    Dcr:CheckCureOrder ();
    -- Set the appropriate priorities according to debuffs types
    Dcr:SetCureOrder ();

    if (not Dcr.Status.HasSpell) then
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


function Dcr:UpdateMacro ()

    if (Dcr.Status.Combat) then
	Dcr:AddDelayedFunctionCall (
	"UpdateMacro", self.UpdateMacro,
	self);
	return false;
    end
    Dcr:Debug("UpdateMacro called");


    local CuringSpellsPrio  = Dcr.Status.CuringSpellsPrio;
    local ReversedCureOrder = Dcr.Status.ReversedCureOrder;
    local CuringSpells	    = Dcr.Status.CuringSpells;


    -- Get an ordered spell table
    local Spells = {};
    for Spell, Prio in pairs(Dcr.Status.CuringSpellsPrio) do
	table.insert (Spells, Prio, Spell);
    end

    if (next (Spells)) then
	for i=1,3 do
	    if (not Spells[i]) then
		table.insert (Spells, CuringSpells[ReversedCureOrder[1] ]);
	    end
	end
    end

    local MacroParameters = {
	Dcr.CONF.MACRONAME,
	1,
	next(Spells) and string.format("/stopcasting\n/cast [target=mouseover,nomodifier,exists] %s;  [target=mouseover,exists,modifier:ctrl] %s; [target=mouseover,exists,modifier:shift] %s", unpack(Spells)) or "/script Dcr:Println('No spell available')",
	1
    };

    --Dcr:PrintLiteral(GetMacroIndexByName(Dcr.CONF.MACRONAME));
    if (GetMacroIndexByName(Dcr.CONF.MACRONAME) ~= 0) then
	-- Dcr:Debug("Macro found");
	EditMacro(Dcr.CONF.MACRONAME, unpack(MacroParameters));
    elseif ((GetNumMacros()) < 18) then
	CreateMacro(unpack(MacroParameters));
    else
	Dcr:errln("Too many macros exist, Decursive cannot create its macro");
	return false;
    end


    if (GetBindingAction(Dcr.db.profile.MacroBind) ~= string.format("MACRO %s",Dcr.CONF.MACRONAME)) then
	Dcr.db.profile.PreviousMacroKeyAction = GetBindingAction(Dcr.db.profile.MacroBind);
    end

    SetBindingMacro(Dcr.db.profile.MacroBind, Dcr.CONF.MACRONAME);

    return true;

end

-- }}}
-------------------------------------------------------------------------------
