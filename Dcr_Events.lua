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

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_opt.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_opt.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end
local D = Dcr;
D:SetDateAndRevision("$Date$", "$Revision$");


local L = D.L;
local BC = D.BC;
local DC = DcrC;
local DS = DC.DS;

D.DebuffUpdateRequest = 0;

local _G	= _G;
local pairs	= _G.pairs;
local next	= _G.next;
local pairs	= _G.pairs;
local ipairs	= _G.ipairs;
local unpack	= _G.unpack;
local table		= _G.table;
local UnitCreatureFamily	= _G.UnitCreatureFamily;
local InCombatLockdown	= _G.InCombatLockdown;
local UnitExists	= _G.UnitExists;
local UnitIsFriend	= _G.UnitIsFriend;
local UnitName		= _G.UnitName;
local UnitGUID		= _G.UnitGUID;


function D:GroupChanged () -- {{{
    -- this will trigger an update of the unit array
    D.Groups_datas_are_invalid = true;
    -- Update the MUFs display in a short moment
    D.MicroUnitF:Delayed_MFsDisplay_Update ();


    -- Test if we have to hide Decursive MUF window
    if D.profile.AutoHideDebuffsFrame ~= 0 then
	D:ScheduleEvent("CheckIfHideShow", self.AutoHideShowMUFs, 2, self);
    end

    D:Debug("Groups changed");
end -- }}}

local OncePetRetry = false;

function D:UNIT_PET (Unit) -- {{{

    -- when a pet changes somwhere, we update the unit array.

    D:Debug("Pet changed for: ", Unit);
    if (D.Status.Unit_Array_UnitToName[Unit]) then
	D.Groups_datas_are_invalid = true;
    end

    self.MicroUnitF:Delayed_MFsDisplay_Update();

    -- If the player's pet changed then we should check it for interesting spells
    if ( Unit == "player" ) then
	self:ScheduleEvent("CheckPet", self.UpdatePlayerPet, 2, self);
	OncePetRetry = false;
	D:Debug ("PLAYER pet detected! Poll in 2 seconds...");
    end
end -- }}}

local curr_petType = false;
local last_petType = false;

function D:UpdatePlayerPet () -- {{{
    curr_petType = UnitCreatureFamily("pet");
    D:Debug("|cFF0000FFCurrent Pet type is %s|r", curr_petType);

    -- if we had a pet and lost it, retry once later...
    if (last_petType and not curr_petType and not OncePetRetry) then
	OncePetRetry = true;

	D:Debug("|cFF9900FFPet lost, retry in 10 seconds|r");
	D:ScheduleEvent("ReCheckPetOnce", D.UpdatePlayerPet, 10, self);
	return;
    end

    -- if we've changed of pet
    if (last_petType ~= curr_petType) then
	if (curr_petType) then D:Debug ("|cFF0066FFPet name changed: %s|r", curr_petType); else D:Debug ("|cFF0066FFNo more pet!|r"); end; -- debug info only

	last_petType = curr_petType;
	D:Configure();
    else
	D:Debug ("|cFFAA66FFNo change in Pet Type (%s)|r", curr_petType);
    end
end -- }}}



local last_focus_GUID = false;
function D:PLAYER_FOCUS_CHANGED ()
    self.Status.Unit_Array_UnitToName["focus"] = (self:PetUnitName("focus", true));

    if (self.Status.Unit_Array[#self.Status.Unit_Array] == "focus" and not UnitExists("focus")) then

	table.remove(self.Status.Unit_Array, #self.Status.Unit_Array);
	self.Status.UnitNum = #self.Status.Unit_Array;
	
	self.Status.Unit_Array_GUIDToUnit[last_focus_GUID] = nil;

	self.MicroUnitF:Delayed_MFsDisplay_Update();

	self:Debug("Focus removed");
	return;

    elseif self.Status.Unit_Array[#self.Status.Unit_Array] ~= "focus" and UnitExists("focus") and UnitIsFriend("focus", "player")
	and not self:NameToUnit((self:UnitName("focus"))) then

	table.insert(self.Status.Unit_Array, "focus");
	self.Status.UnitNum = #self.Status.Unit_Array;

	self.Status.Unit_Array_UnitToName["focus"] = (D:PetUnitName("focus", true));

	self.Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] = "focus";



	self.MicroUnitF:Delayed_MFsDisplay_Update();
	self:Debug("Focus Added");
    elseif UnitExists("focus") then
	self.MicroUnitF:UpdateMUFUnit("focus", true);

	self.Status.Unit_Array_GUIDToUnit[last_focus_GUID] = nil;
	self.Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] = "focus";

	self:Debug("Focus changed");
    end

    last_focus_GUID = UnitGUID("focus");

end

function D:OnDebugEnable ()
    self.profile.debugging = true;
end

function D:OnDebugDisable ()
    self.profile.debugging = false;
end

-- This function update Decursive states :
--   - Clear the black list
--   - Execute things we couldn't do when in combat
D.Status.MaxConcurentUpdateDebuff = 0;
function D:SheduledTasks() -- {{{

    --D:Debug("Schedul called");
    -- clean up the blacklist
    for unit in pairs(self.Status.Blacklisted_Array) do
	self.Status.Blacklisted_Array[unit] = self.Status.Blacklisted_Array[unit] - 0.1;
	if (self.Status.Blacklisted_Array[unit] < 0) then
	    self.Status.Blacklisted_Array[unit] = nil; -- remove it from the BL
	end
    end

    if (not self.Status.Combat and self.Status.DelayedFunctionCallsCount > 0) then
	for Id, FuncAndArgs in pairs (self.Status.DelayedFunctionCalls) do
	    D:Debug("Running post combat command %s", Id);
	    local DidSmth = FuncAndArgs.func(unpack(FuncAndArgs.args));
	    self.Status.DelayedFunctionCalls[Id] = nil; -- remove it from the list
	    self.Status.DelayedFunctionCallsCount = self.Status.DelayedFunctionCallsCount - 1;
	    if (DidSmth) then
		break;
	    end
	end
    end

    if (self.Status.Combat and not InCombatLockdown()) then -- just in case...
	D:LeaveCombat();
    end

    if D.DebuffUpdateRequest > D.Status.MaxConcurentUpdateDebuff then
	D.Status.MaxConcurentUpdateDebuff = D.DebuffUpdateRequest;
    end

    D.DebuffUpdateRequest = 0;

end --}}}

-- the combat functions and events. // {{{
-------------------------------------------------------------------------------
function D:EnterCombat() -- called on PLAYER_REGEN_DISABLED {{{
    --D:Debug("Entering combat");
    self.Status.Combat = true;
end --}}}

function D:LeaveCombat() --{{{
    --D:Debug("Leaving combat");
    self.Status.Combat = false;
end --}}}
-- }}}

-- This let us park command we can't execute while in combat to execute them later {{{
    -- the called function must return a non false value when it does something to prevent UI lagging
function D:AddDelayedFunctionCall(CallID,functionLink, ...)
    if (not self.Status.DelayedFunctionCalls[CallID]) then 
	self.Status.DelayedFunctionCalls[CallID] =  {["func"] = functionLink, ["args"] =  {...}};
	self.Status.DelayedFunctionCallsCount = self.Status.DelayedFunctionCallsCount + 1;
    end
end -- }}}



function D:UPDATE_MOUSEOVER_UNIT ()
    if not self.profile.Hide_LiveList and not self.Status.MouseOveringMUF and UnitIsFriend("mouseover", "player") then
	--	D:Debug("will check MouseOver");
	self.LiveList:DelayedGetDebuff("mouseover");
    end
end



function D:PLAYER_TARGET_CHANGED()

    if UnitExists("target") and UnitIsFriend("player", "target") then

	D.Status.TargetExists = true;

	self.LiveList:DelayedGetDebuff("target");
	

	if self:CheckUnitStealth("target") then
	    self.Stealthed_Units["target"] = true;
	end

    else
	D.Status.TargetExists = false;
	self.Stealthed_Units["target"] = false;
    end
end

function D:LEARNED_SPELL_IN_TAB()
    --D:Debug("|cFFFF0000A new spell was learned, scheduling a reconfiguration|r");
    self:ScheduleEvent("NewSpellLearned", self.Configure, 5, self);
end

function D:SPELLS_CHANGED()
    --D:Debug("|cFFFF0000Spells were changed, scheduling a reconfiguration check|r");
    self:ScheduleEvent("SpellsChanged", self.ReConfigure, 15, self);
end

do
    local bit = _G.bit;
    local band = bit.band;
    local bor = bit.bor;

    -- AURA bitfields {{{
    -- a friendly player character controled directly by the player that is not an outsider
    local PLAYER	= bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER   , COMBATLOG_OBJECT_TYPE_PLAYER  , COMBATLOG_OBJECT_REACTION_FRIENDLY  );
    local PLAYER_MASK	= bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- a hostile player character contoled as a pet and that is not an outsider
    local MIND_CONTROLED_PLAYER		= bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER , COMBATLOG_OBJECT_TYPE_PET	 , COMBATLOG_OBJECT_REACTION_HOSTILE  );
    local MIND_CONTROLED_PLAYER_MASK	= bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- a pet controled by a friendly player that is not an outsider
    local PET	    = bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER	, COMBATLOG_OBJECT_TYPE_PET	, COMBATLOG_OBJECT_REACTION_FRIENDLY  );
    local PET_MASK  = bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- An outsider friendly focused unit
    local FOCUSED_FRIEND       = bit.bor (COMBATLOG_OBJECT_REACTION_FRIENDLY   , COMBATLOG_OBJECT_FOCUS	    , COMBATLOG_OBJECT_AFFILIATION_OUTSIDER); -- XXX should be also applied on the MUFS (No need to include an insider...)

    -- An friendly targeted unit
    local TARGETED_FRIEND       = bit.bor (COMBATLOG_OBJECT_REACTION_FRIENDLY   , COMBATLOG_OBJECT_TARGET);

    -- local DEST_GLOBAL =  bit.bor (PLAYER, MIND_CONTROLED_PLAYER, PET, FOCUSED_FRIEND, TARGETED_FRIEND); -- unused

    -- local EXCLUDED = bit.bor (COMBATLOG_OBJECT_TYPE_OBJECT, COMBATLOG_OBJECT_TYPE_GUARDIAN); -- unused

    -- }}}

    local OUTSIDER		= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER;
    local HOSTILE_OUTSIDER	= bit.bor (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, COMBATLOG_OBJECT_REACTION_HOSTILE);
    local FOCUS_OR_TARGET	= bit.bor (COMBATLOG_OBJECT_FOCUS, COMBATLOG_OBJECT_TARGET);
    local ME			= COMBATLOG_OBJECT_AFFILIATION_MINE;

    -- {{{
    local function match (value, mask, Verify_exclude) 

	if band(value, mask) == mask then
	    if not Verify_exclude or value == band(value, Verify_exclude) then
		return true;
	    end
	end

	return false;

    end --}}}

    local substr = _G.string.sub;
    local AuraEvents = {
	["SPELL_AURA_APPLIED"]	    = 1,
	["SPELL_AURA_REMOVED"]	    = 0,
	["SPELL_AURA_APPLIED_DOSE"] = 1,
	["SPELL_AURA_REMOVED_DOSE"] = 0,
	["UNIT_DIED"] = 0,
	--["SPELL_AURA_DISPELLED"] = 0,
    };

    local SpellEvents = {
	["SPELL_MISSED"]	= true,
	["SPELL_CAST_START"]	= true,
	["SPELL_CAST_FAILED"]	= true,
	["SPELL_CAST_SUCCESS"]	= true,
	["DISPEL_FAILED"]	= true,
    };

    local UnitID;

    function D:DummyDebuff (UnitID, DebuffName)
	D:COMBAT_LOG_EVENT_UNFILTERED(0, "SPELL_AURA_APPLIED", nil, nil, COMBATLOG_OBJECT_NONE, UnitGUID(UnitID), self.Status.Unit_Array_UnitToName[UnitID], PLAYER, 0, DebuffName, 0x32, "DEBUFF");
    end

    function D:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)


	if destName and AuraEvents[event] then

	    if band (destFlags, HOSTILE_OUTSIDER) == HOSTILE_OUTSIDER or (band (destFlags, OUTSIDER) ~= 0 and band(destFlags, FOCUS_OR_TARGET) == 0) then
		return; -- This won't work for neutral units currently hostile...
	    end

	    --D:Print("? (source=%s) (dest=|cFF00AA00%s|r -- %X): |cffff0000%s|r", sourceName, destName, destFlags, event);

	    if	match(destFlags, PLAYER, PLAYER_MASK)
		or match(destFlags, MIND_CONTROLED_PLAYER, MIND_CONTROLED_PLAYER_MASK)
		or band (destFlags, FOCUSED_FRIEND) == FOCUSED_FRIEND
		or (self.profile.Scan_Pets and (match(destFlags, PET, PET_MASK))) then -- Players ans pets

		-- D:Print("A managed unit got something (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cffff0000%s|r, |cFF00AAAA%s|r, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg12);

		UnitID = self.Status.Unit_Array_GUIDToUnit[destGUID];


		if arg12 == "BUFF" and self.profile.Ingore_Stealthed then
		    if DC.IsStealthBuff[arg10] then
			if AuraEvents[event] == 1 then
			    self.Stealthed_Units[UnitID] = true;
			else
			    D:Debug("STEALTH LOST: ", UnitID, buffName);
			    self.Stealthed_Units[UnitID] = false;
			end
			self.MicroUnitF:UpdateMUFUnit(UnitID);
		    end
		else
		    D:Debug("Debuff, UnitId: ", UnitID, arg10, event);
		    if self.profile.ShowDebuffsFrame then
			self.MicroUnitF:UpdateMUFUnit(UnitID);
		    elseif not self.profile.Hide_LiveList then
			D:Debug("(LiveList) Registering delayed GetDebuff for ", destName);
			self.LiveList:DelayedGetDebuff(UnitID);
		    end

		    if event == "UNIT_DIED" then
			self.Stealthed_Units[UnitID] = false;
		    end

		end
	    end


	    -- unused specific tests {{{
	    --elseif	(match(destFlags, PET, PET_MASK)) and self.profile.Scan_Pets then -- PET
	    --	D:Print("A pet got something (source=%s) (dest=|cFF00AA00%s|r -- %x): %s", sourceName, destName, destFlags, event);
	    --	D:Print(destName, arg10, arg12);


	    --   elseif	(match(destFlags, MIND_CONTROLED_PLAYER, MIND_CONTROLED_PLAYER_MASK)) then -- MIND CONTROLLED
	    --	D:Print("Mind controled player got something (source=%s) (dest=|cFF00AA00%s|r -- %x): %s", sourceName, destName, destFlags, event);
	    --	D:Print("%s ", destName, arg10, arg12);
	    --  end

	    -- if		band (destFlags, FOCUSED_FRIEND) == FOCUSED_FRIEND  then -- FOCUSED FRIEND
	    --	D:Print("focused NPC got something (source=%s) (dest=|cFF00AA00%s|r -- %x): %s", sourceName, destName, destFlags, event);
	    --	D:Print(destName, arg10, arg12);
	    --  end
	    --  }}}

	    if self.Status.TargetExists then -- TARGET

		if	band (destFlags, TARGETED_FRIEND) == TARGETED_FRIEND  then

		    D:Debug("A Target got something (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cffff0000%s|r, |cFF00AAAA%s|r, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg12);

		    self.LiveList:DelayedGetDebuff("target");

		    if arg12 == "BUFF" and self.profile.Ingore_Stealthed then
			if DC.IsStealthBuff[arg10] then
			    if AuraEvents[event] == 1 then
				self.Stealthed_Units[UnitID] = true;
			    else
				D:Debug("TARGET STEALTH LOST: ", UnitID, buffName);
				self.Stealthed_Units[UnitID] = false;
			    end
			end
		    end
		    -- TODO: 
		    -- fix target and mouseover updating in live-list (maybe schedule a repeating event that is disable when the target or mouseover stop to exists

		end
	    end

	    -- SPELL EVENTS {{{
	elseif SpellEvents[event] and self.Status.CuringSpellsPrio[arg10] and self.Status.ClickedMF and band(sourceFlags, ME) ~= 0 then -- SPELL_MISSED  SPELL_CAST_START  SPELL_CAST_FAILED  SPELL_CAST_SUCCESS  DISPEL_FAILED

	    if event == "SPELL_CAST_START" then -- useless

		self:Print("|cFFFF0000Starting SPELL: ", arg10, "|r");
		self:ScheduleEvent("UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1 + ((select(7, GetSpellInfo(arg9))) / 1000), self.Status.ClickedMF, false, false);
	    end

	    if event == "SPELL_CAST_SUCCESS" then
		D:Println(L[self.LOC.SUCCESSCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName));

		--self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of clicked frame|r");
		self:ScheduleEvent("UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1, self.Status.ClickedMF, false, false);

	    end

	    if event == "SPELL_CAST_FAILED" then
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);

		--self:Println("|cFFFF0000Failed SPELL: ", arg12, destName, arg10, (select(2, GetSpellInfo(arg9))), "|r"); -- write it well
		--PlaySoundFile(DC.FailedSound);

		if (arg12 == SPELL_FAILED_LINE_OF_SIGHT or arg12 == SPELL_FAILED_BAD_TARGETS) then

		    if not self.profile.DoNot_Blacklist_Prio_List or not self:IsInPriorList(destName) then
			self.Status.Blacklisted_Array[self.Status.ClickedMF.CurrUnit] = self.profile.CureBlacklist;

			self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of blacklist frame|r");
			self:ScheduleEvent("Update"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, self.profile.DebuffsFrameRefreshRate, self.Status.ClickedMF, false, true);
		    end

		    PlaySoundFile(DC.FailedSound);
		end

	    elseif event == "SPELL_MISSED" or event == "DISPEL_FAILED" then -- XXX to test
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);
		PlaySoundFile(DC.FailedSound);
	    end

	    self.Status.ClickedMF = false;

	    --D:Print("SPELL EVENT: (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cFFBB0000%s|r for spell |cFF00FF00%s|r", sourceName, sourceFlags, destName, destFlags, event, arg10);
	    ----  }}}
--	elseif 	band (destFlags, TARGETED_FRIEND) == TARGETED_FRIEND then
--	   D:Print("UNKNOWN EVENT: (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cFFBB0000%s|r for spell |cFF00FF00%s|r, %s, %s, %s, %s, %s, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	    --  }}}
	end


    end



end


-- unused deprecated event handlers {{{
--[=[

function D:SpellCastFailed() -- the blacklisting function {{{
    D:Debug("Not in line of sight or bad target!");
    if (
	D.Status.CastingSpellOn	    -- a cast failed and we were casting on someone
	and not (
	D.Status.CastingSpellOn == "player"   -- we do not blacklist ourself
	or
	(
	-- we do not blacklist people in the priority list
	D.profile.DoNot_Blacklist_Prio_List and D:IsInPriorList(D.Status.CastingSpellOnName) 
	)
	)
	) then
	D.Status.Blacklisted_Array[D.Status.CastingSpellOn] = D.profile.CureBlacklist;
	D:Debug("%s is blacklisted for %d seconds", D.Status.CastingSpellOnName, D.profile.CureBlacklist);
	D.Status.CastingSpellOn = false;
	D.Status.CastingSpellOnName = false;
    end
end --}}}

function D:_SpecialEvents_UnitBuffGained(UnitID, buffName, index, applications, texture, rank)
    --D:Debug("Buff gained, UnitId: ", UnitID, buffName);

    if DC.IsStealthBuff[buffName] then
	D:Debug("STEALTH GAINED: ", UnitID, buffName);

	self.Stealthed_Units[UnitID] = true;

	self.MicroUnitF:UpdateMUFUnit(UnitID);
    end
end

function D:_SpecialEvents_UnitBuffLost(UnitID, buffName, applications, texture, rank)
    --D:Debug("Buff LOST, UnitId: ", UnitID, buffName);

    if DC.IsStealthBuff[buffName] then
	D:Debug("STEALTH LOST: ", UnitID, buffName);

	self.Stealthed_Units[UnitID] = false;

	self.MicroUnitF:UpdateMUFUnit(UnitID);
    end
end

function D:_SpecialEvents_UnitDebuffGained (UnitID, debuffName, applications, debuffType, texture, rank, index)
    D:Debug("Debuff gained, UnitId: ", UnitID, debuffName);

    if self.profile.ShowDebuffsFrame and UnitID ~= "target" then

	if UnitID ~= "focus" then -- focus can be an enemy and get a lot of debuff...
	    D:Debuff_History_Add( debuffName, debuffType );
	end

	self.MicroUnitF:UpdateMUFUnit(UnitID);
    elseif not self.profile.Hide_LiveList then -- (not MUFs or unit is target) and LiveList
	D:Debug("(LiveList) Registering delayed GetDebuff for ", UnitID);
	self.LiveList:DelayedGetDebuff(UnitID);
    end
end

function D:_SpecialEvents_UnitDebuffLost (UnitID, debuffName, applications, debuffType, texture, rank)
    D:Debug("Debuff LOST, UnitId: ", UnitID, debuffName);
    if self.profile.ShowDebuffsFrame and UnitID ~= "target" then
	self.MicroUnitF:UpdateMUFUnit(UnitID);
    elseif not self.profile.Hide_LiveList then -- (not MUFs or unit is target) and LiveList
	D:Debug("(LiveList) Registering delayed GetDebuff for ", UnitID);
	self.LiveList:DelayedGetDebuff(UnitID);
    end
end


function D:UI_ERROR_MESSAGE (Error) -- {{{
    -- this is the only way to detect out of line of sight casting failures
    if (Error == SPELL_FAILED_LINE_OF_SIGHT or Error == SPELL_FAILED_BAD_TARGETS) then
	D:ScheduleEvent("CastFailed", D.SpellCastFailed, 0.8, self);

	--[[ Throw an error if WE were casting something
	if (D.Status.CastingSpellOn and Error == SPELL_FAILED_LINE_OF_SIGHT) then
	    D:errln("Out of sight!");
	end
	--]]

    end
end -- }}}

function D:UNIT_SPELLCAST_STOP(UnitID) -- unused {{{
    D:Debug("Spell cast stopped", UnitID);
    D.Status.CastingSpellOn = false;
    D.Status.CastingSpellOnName = false;
end --}}}

function D:UNIT_SPELLCAST_FAILED(unit) -- unused
    D:Debug("Spell cast failed for unit: ", unit);
end

function D:UNIT_SPELLCAST_SENT( player, spell, rank, target) -- XXX
    D:Debug("|cFFFF0000Sending SPELL: ", player, spell, rank, target, "|r");
    if (self.Status.CuringSpellsPrio[spell]) then
	self.Status.CastingSpellOn = D:NameToUnit(target);
	self.Status.CastingSpellOnName = target;
    end
end

function D:UNIT_SPELLCAST_SUCCEEDED( player, spell, rank )
    if (self.Status.CuringSpellsPrio[spell]) then
	D:Println(L[self.LOC.SUCCESSCAST], spell, rank, D:MakePlayerName((D.Status.CastingSpellOnName)));

	if (self.Status.ClickedMF) then
	    D:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of clicked frame|r");
	    D:ScheduleEvent("UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1, self.Status.ClickedMF, false, false);
	    self.Status.ClickedMF = false;
	end
    end
end

function D:ADDON_ACTION_BLOCKED (Addon, protectedfunction)
   D:errln("The add-on %s tried to use the protected function: %s", Addon, protectedfunction); 
end

function D:ADDON_ACTION_FORBIDDEN (Addon, protectedfunction)
   D:errln("The add-on %s tried to use the forbidden function: %s", Addon, protectedfunction); 
end

--]=]
-- }}}

DcrLoadedFiles["Dcr_Events.lua"] = true;





