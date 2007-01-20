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


local L			    = Dcr.L;
local BC		    = Dcr.BC;
local BS		    = Dcr.BS;

local RaidRosterCache	    = { };
local SortingTable	    = { };
Dcr.Status.Unit_ArrayByName = { };

Dcr.Status.InternalPrioList = { };
Dcr.Status.InternalSkipList = { };
Dcr.Status.Unit_Array	    = { };

-------------------------------------------------------------------------------
-- GROUP STATUS UPDATE, these functions update the UNIT table to scan {{{
-------------------------------------------------------------------------------


local function AddToSort (unit, index) -- // {{{
    if (Dcr.db.profile.Random_Order and (not Dcr.Status.InternalPrioList[(UnitName(unit))]) and not UnitIsUnit(unit,"player")) then
	index = random (1, 3000);
    end
    SortingTable[unit] = index;
    --Dcr:Debug("Adding to sort: ", unit, index);
end --}}}

-- Raid/Party Name Check Function (a terrible function, need optimising)
-- this returns the UnitID that the Name points to
-- this does not check "target" or "mouseover"
local function NameToUnit( Name) --{{{
    if (not Name) then
	return false;
    elseif (Name == (UnitName("player"))) then
	return "player";
    elseif (Name == (UnitName("pet"))) then
	return "pet";
    elseif (Name == (UnitName("party1"))) then
	return "party1";
    elseif (Name == (UnitName("party2"))) then
	return "party2";
    elseif (Name == (UnitName("party3"))) then
	return "party3";
    elseif (Name == (UnitName("party4"))) then
	return "party4";
    elseif (Name == (UnitName("partypet1"))) then
	return "partypet1";
    elseif (Name == (UnitName("partypet2"))) then
	return "partypet2";
    elseif (Name == (UnitName("partypet3"))) then
	return "partypet3";
    elseif (Name == (UnitName("partypet4"))) then
	return "partypet4";
    else
	local numRaidMembers = GetNumRaidMembers();
	if (numRaidMembers > 0) then
	    -- we are in a raid
	    local i;
	    local RaidName;
	    for i=1, numRaidMembers do
		RaidName = GetRaidRosterInfo(i);
		if ( Name == RaidName) then
		    return "raid"..i;
		end
		if ( Name == (UnitName("raidpet"..i))) then
		    return "raidpet"..i;
		end
	    end
	end
    end
    return false;
end --}}}
-- }}}


-- this gets an array of units for us to check
function Dcr:GetUnitArray() --{{{

    -- if the groups composition did not changed
    if (not Dcr.Groups_datas_are_invalid) then
	return;
    end

    Dcr:Debug ("|cFFFF44FF-->|r Updating Units Array");

    local pname;
    local raidnum = GetNumRaidMembers();
    local MyName = (UnitName( "player"));

    local SortIndex = 1;

    -- clear all the arrays
    Dcr.Status.InternalPrioList	    = {}
    Dcr.Status.InternalSkipList	    = {}
    SortingTable	    = {}
    Dcr.Status.Unit_ArrayByName    = {}
    local RaidRosterCache = {}

    local unit;
    -- First sort the prioritylist (remove missing units) and add its content to the main list
    for _, pname in pairs(Dcr.db.profile.PriorityList) do
	unit = NameToUnit( pname );
	if (unit) then
	    Dcr.Status.InternalPrioList[pname] = unit;
	    -- use this loop to add prio characters to the main list
	    Dcr.Status.Unit_ArrayByName[pname] = unit;
	    AddToSort(unit, SortIndex); SortIndex = SortIndex + 1;
	end
    end

    -- The same with the skip list
    for _, pname in pairs(Dcr.db.profile.SkipList) do
	unit = NameToUnit( pname );
	if (unit) then
	    Dcr.Status.InternalSkipList[pname] = unit;
	end
    end

    -- Add the player to the main list if needed
    if (not Dcr:IsInSkipOrPriorList(MyName)) then
	Dcr.Status.Unit_ArrayByName[MyName] = "player";
	AddToSort( "player", SortIndex); SortIndex = SortIndex + 1;
    end

    -- add the party members... if they exist
    for i = 1, 4 do
	if (UnitExists("party"..i)) then
	    pname = (UnitName("party"..i));
	    if (not pname) then -- at logon sometimes pname is nil...
		pname = "party"..i;
	    end
	    -- check the name to see if we skip
	    if (not Dcr:IsInSkipOrPriorList(pname)) then
		-- we don't skip him
		Dcr.Status.Unit_ArrayByName[pname] = "party"..i;
		AddToSort("party"..i, SortIndex); SortIndex = SortIndex + 1;
	    end
	end
    end


    if ( raidnum > 0 ) then -- if we are in a raid
	local currentGroup = 0;
	local rName, rGroup;
	local CaheID = 1; -- make an ordered table

	-- Cache the raid roster info eliminating useless info and already listed members
	for i = 1, raidnum do
	    rName, _, rGroup = GetRaidRosterInfo(i);

	    -- find our group (a whole iteration is required, raid info are not ordered)
	    if ( currentGroup==0 and rName == MyName) then
		currentGroup = rGroup;
	    end

	    -- add all except: our own group and member to skip ... and units that are not there (Blizzard?)
	    if (currentGroup ~= rGroup and not Dcr:IsInSkipOrPriorList(rName) ) then --and UnitExists( "raid"..i)) then

		if (not RaidRosterCache[CaheID]) then
		    RaidRosterCache[CaheID] = {};
		end

		if (not rName) then -- at logon sometimes rName is nil...
		    rName = rGroup.."unknown"..i;
		end
		RaidRosterCache[CaheID].rName    = rName;
		RaidRosterCache[CaheID].rGroup   = rGroup;
		RaidRosterCache[CaheID].rIndex   = i; -- I can't trust lua, the manual is not clear at all about table behavior...
		CaheID = CaheID + 1;
	    end

	end

	for _, raidMember in ipairs(RaidRosterCache) do

	    if (raidMember.rGroup) then
		if (raidMember.rGroup > currentGroup) then
		    Dcr.Status.Unit_ArrayByName[raidMember.rName] = "raid" .. raidMember.rIndex;
		    -- add first the groups that are after ours
		    AddToSort("raid" .. raidMember.rIndex, raidMember.rGroup * 100 + SortIndex); SortIndex =  SortIndex + 1;
		end

		if (raidMember.rGroup < currentGroup) then
		    Dcr.Status.Unit_ArrayByName[raidMember.rName] = "raid" .. raidMember.rIndex;
		    -- add then the groups that are before ours
		    AddToSort("raid" .. raidMember.rIndex, raidMember.rGroup * 100 + 1000 + SortIndex); SortIndex = SortIndex + 1;
		end

	    end

	end

	SortIndex = SortIndex + 8 * 100 + 1000 + 1;

    end -- END if we are in a raid

    -- Exit if we don't have to scan pets...
    if ( Dcr.db.profile.Scan_Pets) then

	-- add our own pet
	if (UnitExists("pet")) then
	    Dcr.Status.Unit_ArrayByName[(UnitName("pet"))] = "pet";
	    AddToSort("pet", SortIndex); SortIndex = SortIndex + 1;
	end

	-- the parties pets if they have them
	for i = 1, 4 do
	    if (UnitExists("partypet"..i)) then
		pname = (UnitName("partypet"..i));
		if (not pname) then -- at logon sometimes pname is nil...
		    pname = "partypet"..i;
		end
		Dcr.Status.Unit_ArrayByName[pname] = "partypet"..i;
		AddToSort("partypet"..i, SortIndex); SortIndex = SortIndex + 1;
	    end
	end

	-- and then the raid pets if they are out
	if (raidnum > 0) then
	    for i = 1, raidnum do
		if (UnitExists("raidpet"..i)) then
		    pname = (UnitName("raidpet"..i));
		    if (not pname) then -- at logon sometimes pname is nil...
			pname = "raidpet"..i;
		    end
		    -- add it only of not already in
		    if (not Dcr.Status.Unit_ArrayByName[pname]) then
			Dcr.Status.Unit_ArrayByName[pname] = "raidpet"..i;
			AddToSort("raidpet"..i, SortIndex); SortIndex = SortIndex + 1;
		    end
		end
	    end
	end
    end

    -- we use a hash-key style table for Dcr.Status.Unit_ArrayByName because it allows us
    -- to not care if we add a same unit several times (speed optimization)
    -- but we cannot use sort unless indexes are integer so:
    Dcr.Status.Unit_Array = {}
    for _, value in pairs(Dcr.Status.Unit_ArrayByName) do -- /!\ PAIRS not iPAIRS
	table.insert(Dcr.Status.Unit_Array, value);
    end

    table.sort(Dcr.Status.Unit_Array, function (a,b) return SortingTable[a] < SortingTable[b] end);

    Dcr.Groups_datas_are_invalid = false;
    Dcr.MFContainer.UpdateYourself = true;
    return;
end --}}}

-------------------------------------------------------------------------------
