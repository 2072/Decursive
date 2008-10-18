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
--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");


local L = D.L;
local BC = D.BC;
local DC = DcrC;
local DS = DC.DS;

D.DebuffUpdateRequest = 0;

local pairs	= _G.pairs;
local next	= _G.next;
local pairs	= _G.pairs;
local ipairs	= _G.ipairs;
local unpack	= _G.unpack;
local select	= _G.select;
local table		= _G.table;
local UnitCreatureFamily	= _G.UnitCreatureFamily;
local InCombatLockdown	= _G.InCombatLockdown;
local PlaySoundFile	= _G.PlaySoundFile;
local UnitExists	= _G.UnitExists;
local UnitCanAttack	= _G.UnitCanAttack;
local UnitName		= _G.UnitName;
local UnitGUID		= _G.UnitGUID;


function D:GroupChanged () -- {{{
    -- this will trigger an update of the unit array
    D.Groups_datas_are_invalid = true;
    -- Update the MUFs display in a short moment
    D.MicroUnitF:Delayed_MFsDisplay_Update ();


    -- Test if we have to hide Decursive MUF window
    if D.profile.AutoHideDebuffsFrame ~= 0 then
	D:ScheduleEvent("Dcr_CheckIfHideShow", self.AutoHideShowMUFs, 2, self);
    end

    D:Debug("Groups changed");
end -- }}}

local OncePetRetry = false;

function D:UNIT_PET (Unit) -- {{{

    -- when a pet changes somwhere, we update the unit array.

    if not D.profile.Scan_Pets then
	return;
    end

    D:Debug("Pet changed for: ", Unit);
    if (Unit ~= "focus" and self.Status.Unit_Array_UnitToGUID[Unit]) then
	D.Groups_datas_are_invalid = true;
    end

    self.MicroUnitF:Delayed_MFsDisplay_Update();

    -- If the player's pet changed then we should check it for interesting spells
    if ( Unit == "player" ) then
	self:ScheduleEvent("Dcr_CheckPet", self.UpdatePlayerPet, 2, self);
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
	D:ScheduleEvent("Dcr_ReCheckPetOnce", D.UpdatePlayerPet, 10, self);
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



function D:PLAYER_FOCUS_CHANGED () -- {{{

    local Status = self.Status;

    Status.Unit_Array_UnitToGUID["focus"] = UnitGUID("focus");

    if Status.Unit_Array[#Status.Unit_Array] == "focus" -- focus has an entry in our unit array
	and (not UnitExists("focus") -- but it doesn't exist anymore
	or UnitCanAttack("focus", "player") -- or it has become nasty (focus was changed to an enemy target)
	or Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] ~= "focus" ) then -- or it is already in our group under a different unit name...


	table.remove(Status.Unit_Array, #Status.Unit_Array);
	Status.UnitNum = #Status.Unit_Array;
	
	Status.Unit_Array_GUIDToUnit[Status.last_focus_GUID] = nil;

	self.MicroUnitF:Delayed_MFsDisplay_Update();

	self:Debug("Focus removed");
	return;

    elseif Status.Unit_Array[#Status.Unit_Array] ~= "focus" -- focus is not in our unit array
	and UnitExists("focus") and not UnitCanAttack("focus", "player") -- it exists and she is nice
	and not Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] then -- and it's not part of our unit array already

	table.insert(Status.Unit_Array, "focus");
	Status.UnitNum = #Status.Unit_Array;

	Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] = "focus";


	Status.last_focus_GUID = UnitGUID("focus");

	self.MicroUnitF:Delayed_MFsDisplay_Update();
	self:Debug("Focus Added");
    elseif UnitExists("focus") and not Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] then -- the focus was changed but not to a unit in our unit array

	Status.Unit_Array_GUIDToUnit[Status.last_focus_GUID] = nil;
	Status.Unit_Array_GUIDToUnit[UnitGUID("focus")] = "focus";

	self.MicroUnitF:UpdateMUFUnit("focus", true);

	Status.last_focus_GUID = UnitGUID("focus");
	self:Debug("Focus changed");
    end


end -- }}}

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
    if not self.profile.Hide_LiveList and not self.Status.MouseOveringMUF and not UnitCanAttack("mouseover", "player") then
	--	D:Debug("will check MouseOver");
	self.LiveList:DelayedGetDebuff("mouseover");
    end
end



function D:PLAYER_TARGET_CHANGED()

    if UnitExists("target") and not UnitCanAttack("player", "target") then

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
    self:ScheduleEvent("Dcr_NewSpellLearned", self.Configure, 5, self);
end

function D:SPELLS_CHANGED()
    --D:Debug("|cFFFF0000Spells were changed, scheduling a reconfiguration check|r");
    self:ScheduleEvent("Dcr_SpellsChanged", self.ReConfigure, 15, self);
end

do
    local bit = _G.bit;
    local band = bit.band;
    local bor = bit.bor;

    -- AURA bitfields -- now useless {{{
    -- a friendly player character controled directly by the player that is not an outsider
    local PLAYER	= bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER   , COMBATLOG_OBJECT_TYPE_PLAYER  , COMBATLOG_OBJECT_REACTION_FRIENDLY  ); -- still used
    local PLAYER_MASK	= bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- a hostile player character contoled as a pet and that is not an outsider
    local REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE;

    -- a pet controled by a friendly player that is not an outsider
    local PET	    = bit.bor (COMBATLOG_OBJECT_CONTROL_PLAYER	, COMBATLOG_OBJECT_TYPE_PET	, COMBATLOG_OBJECT_REACTION_FRIENDLY  );
    local PET_MASK  = bit.bnot (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);

    -- An outsider friendly focused unit
    local FOCUSED_FRIEND       = bit.bor (COMBATLOG_OBJECT_REACTION_FRIENDLY   , COMBATLOG_OBJECT_FOCUS	    , COMBATLOG_OBJECT_AFFILIATION_OUTSIDER);
    -- }}}

    local OUTSIDER		= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER;
    local HOSTILE_OUTSIDER	= bit.bor (COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, COMBATLOG_OBJECT_REACTION_HOSTILE);
    local FRIENDLY_TARGET	= bit.bor (COMBATLOG_OBJECT_TARGET, COMBATLOG_OBJECT_REACTION_FRIENDLY);
    local ME			= COMBATLOG_OBJECT_AFFILIATION_MINE;


    local AuraEvents = {
	["SPELL_AURA_APPLIED"]	    = 1,
	["SPELL_AURA_APPLIED_DOSE"] = 1,
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
	["SPELL_DISPEL_FAILED"]	= true,
    };

    local UnitID;

    function D:DummyDebuff (UnitID, DebuffName)
	D:COMBAT_LOG_EVENT_UNFILTERED(0, "SPELL_AURA_APPLIED", nil, nil, COMBATLOG_OBJECT_NONE, UnitGUID(UnitID), (UnitName(UnitID)), PLAYER, 0, DebuffName, 0x32, "DEBUFF");
    end

    function D:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)

	if destName and AuraEvents[event] then

	    if (self.Groups_datas_are_invalid) then
		self:GetUnitArray();
	    end

	    UnitID = self.Status.Unit_Array_GUIDToUnit[destGUID]; -- get the grouped unit associated to the destGUID if there is none then the unit is not in our group or is filtered out

	    --D:Print("? (source=%s) (dest=|cFF00AA00%s|r -- %X): |cffff0000%s|r", sourceName, destName, destFlags, event);

	    if UnitID then -- this test is enough, if the unit is groupped we definetely need to scan it, whatever is its status...

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

	    if self.Status.TargetExists and band (destFlags, FRIENDLY_TARGET) == FRIENDLY_TARGET then -- TARGET

		D:Debug("A Target got something (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cffff0000%s|r, |cFF00AAAA%s|r, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg12);

		self.LiveList:DelayedGetDebuff("target");

		if arg12 == "BUFF" and self.profile.Ingore_Stealthed then
		    if DC.IsStealthBuff[arg10] then
			if AuraEvents[event] == 1 then
			    self.Stealthed_Units["target"] = true;
			else
			    D:Debug("TARGET STEALTH LOST: ", "target", buffName);
			    self.Stealthed_Units["target"] = false;
			end
		    end
		end
	    end

	    -- SPELL EVENTS {{{
	elseif self.Status.ClickedMF and SpellEvents[event] and self.Status.CuringSpellsPrio[arg10] and band(sourceFlags, ME) ~= 0 then -- SPELL_MISSED  SPELL_CAST_START  SPELL_CAST_FAILED  SPELL_CAST_SUCCESS  DISPEL_FAILED

	    if event == "SPELL_CAST_START" then -- useless

		self:Print("|cFFFF0000Starting SPELL: ", arg10, "|r");
		self:ScheduleEvent("Dcr_UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1 + ((select(7, GetSpellInfo(arg9))) / 1000), self.Status.ClickedMF, false, false);
	    end

	    if event == "SPELL_CAST_SUCCESS" then
		--D:Println(L[self.LOC.SUCCESSCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName));
		self:Debug(L[self.LOC.SUCCESSCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName));

		--self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of clicked frame|r");
		self:ScheduleEvent("Dcr_UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1, self.Status.ClickedMF, false, false);
		self:ScheduleEvent("Dcr_clickedMFreset", function() D.Status.ClickedMF = false; D:Debug("ClickedMF to false (sched)"); end, 0.1 );

	    end

	    if event == "SPELL_CAST_FAILED" then
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);

		if (arg12 == SPELL_FAILED_LINE_OF_SIGHT or arg12 == SPELL_FAILED_BAD_TARGETS) then

		    if not self.profile.DoNot_Blacklist_Prio_List or not self:IsInPriorList(self.Status.Unit_Array_UnitToGUID[self.Status.ClickedMF.CurrUnit]) then
			self.Status.Blacklisted_Array[self.Status.ClickedMF.CurrUnit] = self.profile.CureBlacklist;

			self:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of blacklist frame|r");
			self:ScheduleEvent("Dcr_Update"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, self.profile.DebuffsFrameRefreshRate, self.Status.ClickedMF, false, true);
		    end

		    PlaySoundFile(DC.FailedSound);
		end
		self.Status.ClickedMF = false;

	    elseif event == "SPELL_MISSED" or event == "SPELL_DISPEL_FAILED" then -- XXX to test
		destName = self:PetUnitName( self.Status.ClickedMF.CurrUnit, true);

		D:Println(L[self.LOC.FAILEDCAST], arg10, (select(2, GetSpellInfo(arg9))), D:MakePlayerName(destName), arg12);
		PlaySoundFile(DC.FailedSound);
		self.Status.ClickedMF = false;
	    end


	    ----  }}}
	--else
	   --D:Print("UNKNOWN EVENT: (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cFFBB0000%s|r for spell |cFF00FF00%s|r, %s, %s, %s, %s, %s, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	    --  }}}
	end


    end



end


-- unused deprecated event handlers {{{
--[=[
    -- match (value, mask, Verify_exclude)  {{{
    local function match (value, mask, Verify_exclude) 

	if band(value, mask) == mask then
	    if not Verify_exclude or value == band(value, Verify_exclude) then
		return true;
	    end
	end

	return false;

    end --}}}

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

	    
	    --[[if	match(destFlags, PLAYER, PLAYER_MASK)
		-- or match(destFlags, MIND_CONTROLED_PLAYER, MIND_CONTROLED_PLAYER_MASK)
		or (UnitID and band (destFlags, REACTION_HOSTILE) == REACTION_HOSTILE) -- an hostile unit in our group is a mind controlled unit
		or band (destFlags, FOCUSED_FRIEND) == FOCUSED_FRIEND
		or (self.profile.Scan_Pets and (match(destFlags, PET, PET_MASK))) then -- Players and pets XXX to test
		--]]
		-- D:Print("A managed unit got something (source=%s -- %X) (dest=|cFF00AA00%s|r -- %x): |cffff0000%s|r, |cFF00AAAA%s|r, %s", sourceName, sourceFlags, destName, destFlags, event, arg10, arg12);


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
	D:ScheduleEvent("Dcr_CastFailed", D.SpellCastFailed, 0.8, self);

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
	    D:ScheduleEvent("Dcr_UpdatePC"..self.Status.ClickedMF.CurrUnit, self.Status.ClickedMF.Update, 1, self.Status.ClickedMF, false, false);
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

DcrLoadedFiles["Dcr_Events.lua"] = "@file-abbreviated-hash@";





