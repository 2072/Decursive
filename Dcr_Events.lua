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
    Dcr.Groups_datas_are_invalid = true;
    Dcr:Debug("Groups changed");
end -- }}}

Dcr.Status.CheckingPET = nil;

function Dcr:UNIT_PET (Unit) -- {{{

    if (UnitInRaid(Unit) or UnitInParty(Unit)) then
	Dcr.Groups_datas_are_invalid = true;
    end

    if ( Unit == "player" and not Dcr.Status.CheckingPET) then
	Dcr.Status.CheckingPET = self:ScheduleEvent(Dcr.UpdatePlayerPet, 2);
	Dcr:Debug ("PLAYER pet detected! Poll in 2 seconds");
    end
end -- }}}

local curr_petType = nil;
local last_petType = nil;

function Dcr:UpdatePlayerPet () -- {{{
    curr_petType = UnitCreatureFamily("pet");

    if (curr_petType) then Dcr:Debug ("Pet Type: " .. curr_petType);  end;

    if (last_petType ~= curr_petType) then
	if (curr_petType) then Dcr:Debug ("Pet name changed: " .. curr_petType); else  Dcr:Debug ("No more pet!"); end;

	last_petType = curr_petType;
	Dcr:Configure();
	Dcr.Status.CheckingPET = nil;
    end
end -- }}}

function Dcr:UI_ERROR_MESSAGE (Error) -- {{{
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
    Dcr.Status.CastingSpellOn = nil;
    Dcr.Status.CastingSpellOnName = nil;
end --}}}

function Dcr:UNIT_SPELLCAST_FAILED(unit)
    Dcr:Debug("Spell cast failed");
end

function Dcr:UNIT_SPELLCAST_SENT( player, spell, rank, target )
    if (Dcr:tcheckforval(Dcr.Status.CuringSpells, spell)) then
	Dcr.Status.CastingSpellOn = Dcr:NameToUnit(target); -- XXX
	Dcr.Status.CastingSpellOnName = target;
    end
end
function Dcr:UNIT_SPELLCAST_SUCCEEDED( player, spell, rank )
    if (Dcr:tcheckforval(Dcr.Status.CuringSpells, spell)) then


	Dcr:Println(L[Dcr.LOC.SUCCESSCAST], spell, Dcr:MakePlayerName((Dcr.Status.CastingSpellOnName)));

	if (Dcr.Status.ClickedMF) then
	    Dcr:Debug("Updating color of clicked frame");
	    Dcr.Status.ClickedMF:SetColor();
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
	Dcr:Debug("Focus removed");
    else
	Dcr:Debug("Focus changed");
    end
end

function Dcr:OnDebugEnable ()
    Dcr.db.profile.debugging = true;
end

function Dcr:OnDebugDisable ()
    Dcr.db.profile.debugging = false;
end

-- This function update Decursive states :
--   - clear the black list
--   - Restor Self AutoCast
function Dcr:SheduledTasks() -- {{{

    --Dcr:Debug("Schedul called");
    -- clean up the blacklist
    for unit in pairs(Dcr.Status.Blacklisted_Array) do
	Dcr.Status.Blacklisted_Array[unit] = Dcr.Status.Blacklisted_Array[unit] - 0.1;
	if (Dcr.Status.Blacklisted_Array[unit] < 0) then
	    Dcr.Status.Blacklisted_Array[unit] = nil;
	end
    end

    if (RestorSelfAutoCast) then
	RestorSelfAutoCastTimeOut = RestorSelfAutoCastTimeOut - 0.1;
	if (RestorSelfAutoCastTimeOut < 0) then
	    RestorSelfAutoCast = false;
	    SetCVar("autoSelfCast", "1");

	    Dcr:Debug("autoSelfCast restored!");
	end
    end

    if (not Dcr.Status.Combat and Dcr.Status.DelayedFunctionCallsCount > 0) then
	for Id, FuncAndArgs in pairs (Dcr.Status.DelayedFunctionCalls) do
	    Dcr:Debug("Running post combat command %s", Id);
	    local DidSmth = FuncAndArgs.func(unpack(FuncAndArgs.args));
	    Dcr.Status.DelayedFunctionCalls[Id] = nil;
	    Dcr.Status.DelayedFunctionCallsCount = Dcr.Status.DelayedFunctionCallsCount - 1;
	    if (DidSmth) then
		break;
	    end
	end
    end

    if (Dcr.Status.Combat and not InCombatLockdown()) then
	Dcr.Status.Combat = false;
    end

end --}}}

-- the combat saver functions and events. These keep us in combat mode // {{{
-------------------------------------------------------------------------------
function Dcr:EnterCombat() --{{{
    Dcr:Debug("Entering combat");
    Dcr.Status.Combat = true;
end --}}}

function Dcr:LeaveCombat() --{{{
    Dcr:Debug("Leaving combat");
    Dcr.Status.Combat = false;
end --}}}
-- }}}


function Dcr:AddDelayedFunctionCall(CallID,functionLink, ...)
    if (not Dcr.Status.DelayedFunctionCalls[CallID]) then 
	Dcr.Status.DelayedFunctionCalls[CallID] =  {["func"] = functionLink, ["args"] =  Dcr:Pack(...)};
	Dcr.Status.DelayedFunctionCallsCount = Dcr.Status.DelayedFunctionCallsCount + 1;
    end
end

function Dcr:SpellCastFailed() --{{{
    Dcr:Debug("Not in line of sight!");
    if (
	Dcr.Status.CastingSpellOn	    -- a cast failed and we were casting on someone
	and not (
	Dcr.Status.CastingSpellOn == "player"   -- we do not blacklist ourself
	or
	(
	-- we do not blacklist people in the priority list
	Dcr.db.profile.DoNot_Blacklist_Prio_List and Dcr:IsInPriorList(Dcr.Status.CastingSpellOnName) 
	)
	)
	) then
	Dcr:Println("%s is blaclisted for %d seconds", Dcr.Status.CastingSpellOnName, Dcr.db.profile.CureBlacklist);

	Dcr.Status.Blacklisted_Array[Dcr.Status.CastingSpellOn] = Dcr.db.profile.CureBlacklist;
	Dcr.Status.CastingSpellOn = nil;
	Dcr.Status.CastingSpellOnName = nil;
    end
end --}}}


function Dcr:RaidScanner_SC () --{{{

    if Dcr.db.profile.Amount_Of_Afflicted < 1 then
	Dcr.db.profile.Amount_Of_Afflicted = 1;
    elseif Dcr.db.profile.Amount_Of_Afflicted > Dcr.CONF.MAX_LIVE_SLOTS then
	Dcr.db.profile.Amount_Of_Afflicted = Dcr.CONF.MAX_LIVE_SLOTS;
    end


    --Dcr:Debug("Dcr:RaidScanner_SC () called");

    local index = 1;
    local targetexists = false;
    Dcr:GetUnitArray();

    -- First scan the current target
    if (UnitExists("target") and UnitIsFriend("target", "player") and not UnitIsUnit("target", "player")) then
	if (UnitIsVisible("target") and not Dcr:CheckUnitStealth("target")) then
	    targetexists = true;
	    if (Dcr:ScanUnit("target", index)) then
		if (index == 1) then
		    Dcr:PlaySound ();
		end
		index = index + 1;
	    end
	end
    end

    -- Then the mouse-overed target
    if (not Dcr.Status.MouseOveringMUF and UnitExists("mouseover") and UnitIsFriend("mouseover", "player")) then
	if (UnitIsVisible("mouseover") and not Dcr:CheckUnitStealth("mouseover")) then
	    targetexists = true;
	    if (Dcr:ScanUnit("mouseover", index)) then
		if (index == 1) then
		    Dcr:PlaySound ();
		end
		index = index + 1;
	    end
	end
    end

    -- Charmed units are always displayed first what ever is the priority
    if (Dcr.Status.CuringSpells[DcrC.ENEMYMAGIC] or Dcr.Status.CuringSpells[DcrC.CHARMED]) then
	for _, unit in ipairs(Dcr.Status.Unit_Array) do
	    if (index > Dcr.db.profile.Amount_Of_Afflicted) then
		break;
	    end
	    if (UnitIsVisible(unit) and not (targetexists and UnitIsUnit(unit, "target"))) then
		-- if the unit is even close by
		if (UnitIsCharmed(unit)) then
		    -- if the unit is mind controlled
		    if (Dcr:ScanUnit(unit, index)) then
			if (index == 1) then
			    Dcr:PlaySound ();
			end
			index = index + 1;
		    end
		end
	    end
	end
    end

    -- Dcr_debug(" normal loop");
    for _, unit in ipairs(Dcr.Status.Unit_Array) do
	if (index > Dcr.db.profile.Amount_Of_Afflicted) then
	    break;
	end
	if (UnitIsVisible(unit) and not (targetexists and UnitIsUnit(unit, "target"))) then
	    if (not UnitIsCharmed(unit) and not Dcr:CheckUnitStealth(unit)) then
		-- if the unit is even close by
		if (Dcr:ScanUnit(unit, index)) then
		    if (index == 1) then
			Dcr:PlaySound ();
		    end
		    index = index + 1;
		end
	    end
	end
    end

    -- clear livelist
    local i;
    local Index;
    local item;

    for i = index, Dcr.CONF.MAX_LIVE_SLOTS do
	if i == 1 then
	    Dcr.Status.SoundPlayed = false;
	end
	Index = i;
	if (Dcr.db.profile.ReverseLiveDisplay and not (i > Dcr.db.profile.Amount_Of_Afflicted)) then
	    Index = Dcr.db.profile.Amount_Of_Afflicted + -1 * (Index - 1);
	end
	item = getglobal("DecursiveAfflictedListFrameListItem"..Index);
	item.unit = "player";
	item.debuff = 0;
	item:Hide();
    end

    -- for testing only		
    -- Dcr_UpdateLiveDisplay( 1, "player", 1)

end --}}}


