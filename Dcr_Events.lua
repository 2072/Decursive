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
local BC = Dcr.BC;
local BS = Dcr.BS;

function Dcr:GroupChanged () -- {{{
    -- this will trigger an update of the unit array
    Dcr.Groups_datas_are_invalid = true;
    -- Update the MUFs display in a short moment
    Dcr.MicroUnitF:Delayed_MFsDisplay_Update ();
    Dcr:Debug("Groups changed");
end -- }}}

local OncePetRetry = false;

function Dcr:UNIT_PET (Unit) -- {{{

    -- when a pet changes somwhere, we update the unit array.

    Dcr:Debug("Pet changed for: ", Unit);
    if (UnitInRaid(Unit) or UnitInParty(Unit)) then
	Dcr.Groups_datas_are_invalid = true;
    end

    -- If the player's pet changed then we should check it for interesting spells
    if ( Unit == "player" ) then
	self:ScheduleEvent("CheckPet", self.UpdatePlayerPet, 2, self);
	OncePetRetry = false;
	Dcr:Debug ("PLAYER pet detected! Poll in 2 seconds");
    end
end -- }}}

local curr_petType = false;
local last_petType = false;

function Dcr:UpdatePlayerPet () -- {{{
    curr_petType = UnitCreatureFamily("pet");

    if (curr_petType) then Dcr:Debug ("Pet Type: " .. curr_petType);  end; -- debug info only

    -- if we had a pet and lost it, retry once later...
    if (last_petType and not curr_petType and not OncePetRetry) then
	OncePetRetry = true;
	Dcr:Debug("Pet lost, retry in 10 seconds");
	Dcr:ScheduleEvent("ReCheckPetOnce", Dcr.UpdatePlayerPet, 10, self);
	return;
    end

    -- if we've changed of pet
    if (last_petType ~= curr_petType) then
	if (curr_petType) then Dcr:Debug ("Pet name changed: " .. curr_petType); else  Dcr:Debug ("No more pet!"); end; -- debug info only

	last_petType = curr_petType;
	Dcr:Configure();
    end
end -- }}}

function Dcr:UI_ERROR_MESSAGE (Error) -- {{{
    -- this is the only way to detect out of line of sight casting failures
    if (Error == SPELL_FAILED_LINE_OF_SIGHT or Error == SPELL_FAILED_BAD_TARGETS) then
	Dcr:SpellCastFailed();

	--[[ Throw an error if WE were casting something
	if (Dcr.Status.CastingSpellOn and Error == SPELL_FAILED_LINE_OF_SIGHT) then
	    Dcr:errln("Out of sight!");
	end
	--]]

    end
end -- }}}

function Dcr:UNIT_SPELLCAST_STOP() --{{{
    --Dcr:Debug("Spell cast stopped");
    Dcr.Status.CastingSpellOn = false;
    Dcr.Status.CastingSpellOnName = false;
end --}}}

function Dcr:UNIT_SPELLCAST_FAILED(unit)
    Dcr:Debug("Spell cast failed for unit: ", unit);
end

function Dcr:UNIT_SPELLCAST_SENT( player, spell, rank, target )
    if (Dcr.Status.CuringSpellsPrio[spell]) then
	Dcr.Status.CastingSpellOn = Dcr:NameToUnit(target); -- XXX
	Dcr.Status.CastingSpellOnName = target;
    end
end
function Dcr:UNIT_SPELLCAST_SUCCEEDED( player, spell, rank )
    if (Dcr.Status.CuringSpellsPrio[spell]) then
	Dcr:Println(L[Dcr.LOC.SUCCESSCAST], spell, Dcr:MakePlayerName((Dcr.Status.CastingSpellOnName)));

	if (Dcr.Status.ClickedMF) then
	    Dcr:Debug("|cFFFF0000XXXXX|r |cFF11FF11Updating color of clicked frame|r");
	    --Dcr.Status.ClickedMF:Update();
	    Dcr:ScheduleEvent("UpdatePC"..Dcr.Status.ClickedMF.CurrUnit, Dcr.Status.ClickedMF.Update, 1, Dcr.Status.ClickedMF, false, false);
	    Dcr.Status.ClickedMF = false;
	end
    end
end

function Dcr:ADDON_ACTION_BLOCKED (Addon, protectedfunction)
   Dcr:errln("The add-on %s tried to use the protected function: %s", Addon, protectedfunction); 
end

function Dcr:ADDON_ACTION_FORBIDDEN (Addon, protectedfunction)
   Dcr:errln("The add-on %s tried to use the forbidden function: %s", Addon, protectedfunction); 
end

function Dcr:PLAYER_FOCUS_CHANGED ()
    Dcr.Status.Unit_Array_UnitToName["focus"] = (UnitName("focus"));

    if (Dcr.Status.Unit_Array[#Dcr.Status.Unit_Array] == "focus" and not UnitExists("focus")) then
	table.remove(Dcr.Status.Unit_Array, #Dcr.Status.Unit_Array);
	Dcr.Status.UnitNum = #Dcr.Status.Unit_Array;
	Dcr.MicroUnitF:Delayed_MFsDisplay_Update();
	Dcr:Debug("Focus removed");

    elseif Dcr.Status.Unit_Array[#Dcr.Status.Unit_Array] ~= "focus" and UnitExists("focus") and UnitIsFriend("focus", "player") then
	table.insert(Dcr.Status.Unit_Array, "focus");
	Dcr.Status.UnitNum = #Dcr.Status.Unit_Array;
	Dcr.Status.Unit_Array_UnitToName["focus"] = (UnitName("focus"));
	--Dcr.Status.Unit_Array_UnitToIndex["focus"] = Dcr.MicroUnitF:MFUsableNumber();


	Dcr.MicroUnitF:Delayed_MFsDisplay_Update();
	Dcr:Debug("Focus Added");
    else
	Dcr.MicroUnitF:UpdateMUFUnit("focus");
	Dcr:Debug("Focus changed");
    end
end

function Dcr:OnDebugEnable ()
    Dcr.profile.debugging = true;
end

function Dcr:OnDebugDisable ()
    Dcr.profile.debugging = false;
end

-- This function update Decursive states :
--   - Clear the black list
--   - Execute things we couldn't do when in combat
function Dcr:SheduledTasks() -- {{{

    --Dcr:Debug("Schedul called");
    -- clean up the blacklist
    for unit in pairs(Dcr.Status.Blacklisted_Array) do
	Dcr.Status.Blacklisted_Array[unit] = Dcr.Status.Blacklisted_Array[unit] - 0.1;
	if (Dcr.Status.Blacklisted_Array[unit] < 0) then
	    Dcr.Status.Blacklisted_Array[unit] = nil; -- remove it from the BL
	end
    end

    if (not Dcr.Status.Combat and Dcr.Status.DelayedFunctionCallsCount > 0) then
	for Id, FuncAndArgs in pairs (Dcr.Status.DelayedFunctionCalls) do
	    Dcr:Debug("Running post combat command %s", Id);
	    local DidSmth = FuncAndArgs.func(unpack(FuncAndArgs.args));
	    Dcr.Status.DelayedFunctionCalls[Id] = nil; -- remove it from the list
	    Dcr.Status.DelayedFunctionCallsCount = Dcr.Status.DelayedFunctionCallsCount - 1;
	    if (DidSmth) then
		break;
	    end
	end
    end

    if (Dcr.Status.Combat and not InCombatLockdown()) then
	Dcr:LeaveCombat();
    end

end --}}}

-- the combat functions and events. // {{{
-------------------------------------------------------------------------------
function Dcr:EnterCombat() -- called on PLAYER_REGEN_DISABLED {{{
    Dcr:Debug("Entering combat");
    Dcr.Status.Combat = true;
end --}}}

function Dcr:LeaveCombat() --{{{
    Dcr:Debug("Leaving combat");
    Dcr.Status.Combat = false;
end --}}}
-- }}}

-- This let us park command we can't execute while in combat to execute them later {{{
function Dcr:AddDelayedFunctionCall(CallID,functionLink, ...)
    if (not Dcr.Status.DelayedFunctionCalls[CallID]) then 
	Dcr.Status.DelayedFunctionCalls[CallID] =  {["func"] = functionLink, ["args"] =  {...}};
	Dcr.Status.DelayedFunctionCallsCount = Dcr.Status.DelayedFunctionCallsCount + 1;
    end
end -- }}}

function Dcr:SpellCastFailed() -- the blacklisting function {{{
    Dcr:Debug("Not in line of sight or bad target!");
    if (
	Dcr.Status.CastingSpellOn	    -- a cast failed and we were casting on someone
	and not (
	Dcr.Status.CastingSpellOn == "player"   -- we do not blacklist ourself
	or
	(
	-- we do not blacklist people in the priority list
	Dcr.profile.DoNot_Blacklist_Prio_List and Dcr:IsInPriorList(Dcr.Status.CastingSpellOnName) 
	)
	)
	) then
	Dcr.Status.Blacklisted_Array[Dcr.Status.CastingSpellOn] = Dcr.profile.CureBlacklist;
	Dcr:Println("%s is blaclisted for %d seconds", Dcr.Status.CastingSpellOnName, Dcr.profile.CureBlacklist);
	Dcr.Status.CastingSpellOn = false;
	Dcr.Status.CastingSpellOnName = false;
    end
end --}}}


function Dcr:UPDATE_MOUSEOVER_UNIT ()
    if not Dcr.profile.Hide_LiveList and not Dcr.Status.MouseOveringMUF and UnitIsFriend("mouseover", "player") then
	Dcr:Debug("will check MouseOver");
	Dcr.LiveList:DelayedGetDebuff("mouseover");
    end
end

function Dcr:SpecialEvents_UnitDebuffGained (UnitID, debuffName, applications, debuffType, texture, rank, index)
    Dcr:Debug("Debuff gained, UnitId: ", UnitID, debuffName);
    if Dcr.profile.ShowDebuffsFrame and UnitID ~= "target" then
	Dcr.MicroUnitF:UpdateMUFUnit(UnitID);
    elseif not Dcr.profile.Hide_LiveList then -- (not MUFs or unit is target) and LiveList
	Dcr:Debug("(LiveList) Registering delayed GetDebuff for ", UnitID);
	Dcr.LiveList:DelayedGetDebuff(UnitID);
    end
end

function Dcr:SpecialEvents_UnitDebuffLost (UnitID, debuffName, applications, debuffType, texture, rank)
    Dcr:Debug("Debuff LOST, UnitId: ", UnitID, debuffName);
    if Dcr.profile.ShowDebuffsFrame and UnitID ~= "target" then
	Dcr.MicroUnitF:UpdateMUFUnit(UnitID);
    elseif not Dcr.profile.Hide_LiveList then -- (not MUFs or unit is target) and LiveList
	Dcr:Debug("(LiveList) Registering delayed GetDebuff for ", UnitID);
	Dcr.LiveList:DelayedGetDebuff(UnitID);
    end
end


function Dcr:SpecialEvents_UnitBuffGained(UnitID, buffName, index, applications, texture, rank)
    --Dcr:Debug("Buff gained, UnitId: ", UnitID, buffName);

    if DcrC.IsStealthBuff[buffName] then
	Dcr:Debug("STEALTH GAINED: ", UnitID, buffName);

	Dcr.Stealthed_Units[UnitID] = true;

	Dcr.MicroUnitF:UpdateMUFUnit(UnitID);
    end
end

function Dcr:SpecialEvents_UnitBuffLost(UnitID, buffName, applications, texture, rank)
    --Dcr:Debug("Buff LOST, UnitId: ", UnitID, buffName);

    if DcrC.IsStealthBuff[buffName] then
	Dcr:Debug("STEALTH LOST: ", UnitID, buffName);

	Dcr.Stealthed_Units[UnitID] = false;

	Dcr.MicroUnitF:UpdateMUFUnit(UnitID);
    end
end

