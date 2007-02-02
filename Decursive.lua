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

-- print out a fuckload of info
Dcr_Print_DEBUG = false;
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- The UI functions {{{
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- The printing functions {{{
-------------------------------------------------------------------------------

function Dcr:Show_Cure_Order() --{{{
    Dcr:Println("printing cure order:");
    for index, unit in ipairs(Dcr.Status.Unit_Array) do
	Dcr:Println( unit, " - ", Dcr:MakePlayerName((UnitName(unit))) , " Index: ", index);
    end
end --}}}

-- }}}
-------------------------------------------------------------------------------

-- Show Hide FUNCTIONS -- {{{

function Dcr:ShowHideLiveList(hide) --{{{
    -- if hide is requested or if hide is not set and the live-list is shown
    if (hide==1 or (not hide and DecursiveAfflictedListFrame:IsVisible())) then
	Dcr.db.profile.Hide_LiveList = true;
	DecursiveAfflictedListFrame:Hide();
	if Dcr.Status.ScanShedule then
	    Dcr:CancelScheduledEvent(Dcr.Status.ScanShedule);
	    Dcr.Status.ScanShedule = false;
	end
    else
	Dcr.db.profile.Hide_LiveList = false;
	DecursiveAfflictedListFrame:ClearAllPoints();
	DecursiveAfflictedListFrame:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
	DecursiveAfflictedListFrame:Show();

	if not Dcr.Status.ScanShedule then
	    Dcr.Status.ScanShedule = Dcr:ScheduleRepeatingEvent(Dcr.RaidScanner_SC, Dcr.db.profile.ScanTime);
	end
    end

end --}}}

function Dcr:Hide(hide) --{{{

    if (hide==1 or (not hide and DecursiveMainBar:IsVisible())) then
	if (Dcr.db.profile.LiveListTied) then
	    Dcr:ShowHideLiveList(1);
	end
	Dcr.db.profile.Hidden = true;
	DecursiveMainBar:Hide();
    else
	if (Dcr.db.profile.LiveListTied) then
	    Dcr:ShowHideLiveList(0);
	end
	Dcr.db.profile.Hidden = false;
	DecursiveMainBar:Show();
    end

    if DecursiveMainBar:IsVisible() and DecursiveAfflictedListFrame:IsVisible() then
	DecursiveAfflictedListFrame:ClearAllPoints();
	DecursiveAfflictedListFrame:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
    else
	Dcr:ColorPrint(0.3, 0.5, 1, L[Dcr.LOC.SHOW_MSG]);
    end
end --}}}

function Dcr:ShowHidePriorityListUI() --{{{
    if (DecursivePriorityListFrame:IsVisible()) then
	DecursivePriorityListFrame:Hide();
    else
	DecursivePriorityListFrame:Show();
    end
end --}}}

function Dcr:ShowHideSkipListUI() --{{{
    if (DecursiveSkipListFrame:IsVisible()) then
	DecursiveSkipListFrame:Hide();
    else
	DecursiveSkipListFrame:Show();
    end
end --}}}

function Dcr:ShowHideButtons(UseCurrentValue) --{{{

    local DecrFrame = "DecursiveMainBar";
    local buttons = {
	DecrFrame .. "Priority",
	DecrFrame .. "Skip",
	DecrFrame .. "Hide",
    }

    DCRframeObject = getglobal(DecrFrame);

    if (not UseCurrentValue) then
	Dcr.db.profile.HideButtons = (not Dcr.db.profile.HideButtons);
    end

    for _, ButtonName in pairs(buttons) do
	Button = getglobal(ButtonName);

	if (Dcr.db.profile.HideButtons) then
	    Button:Hide();
	    DCRframeObject.isLocked = 1;
	else
	    Button:Show();
	    DCRframeObject.isLocked = 0;
	end

    end

end --}}}

-- }}}


-- this resets the location of the windows
function Dcr:ResetWindow() --{{{


    DecursiveMainBar:ClearAllPoints();
    DecursiveMainBar:SetPoint("CENTER", UIParent);
    DecursiveMainBar:Show();

    DecursiveAfflictedListFrame:ClearAllPoints();
    DecursiveAfflictedListFrame:SetPoint("TOPLEFT", DecursiveMainBar, "BOTTOMLEFT");
    DecursiveAfflictedListFrame:Show();

    DecursivePriorityListFrame:ClearAllPoints();
    DecursivePriorityListFrame:SetPoint("CENTER", UIParent);

    DecursiveSkipListFrame:ClearAllPoints();
    DecursiveSkipListFrame:SetPoint("CENTER", UIParent);

    DecursivePopulateListFrame:ClearAllPoints();
    DecursivePopulateListFrame:SetPoint("CENTER", UIParent);


    Dcr.MFContainer:ClearAllPoints();
    Dcr.MFContainer:SetPoint("CENTER", UIParent, "CENTER", 200, 250);

end --}}}


-- this displays the tooltips of the live-list
function Dcr:DebuffTemplate_OnEnter() --{{{
    if (Dcr.db.profile.AfflictionTooltips) then
	DcrDisplay_Tooltip:SetOwner(this, "ANCHOR_CURSOR");
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetUnitDebuff(this.unit,this.debuff); -- OK
	DcrDisplay_Tooltip:Show();
    end
end --}}}

function Dcr:PlaySound () --{{{
    if (Dcr.db.profile.PlaySound and not Dcr.Status.SoundPlayed) then
	-- good sounds: Sound\\Doodad\\BellTollTribal.wav
	--		Sound\\interface\\AuctionWindowOpen.wav
	PlaySoundFile("Sound\\Doodad\\BellTollTribal.wav");
	Dcr.Status.SoundPlayed = true;
    end
end --}}}

-- LIVE-LIST DISPLAY functions {{{

function Dcr:ScanUnit( Unit, Index) --{{{
    Debuff = Dcr:UnitCurableDebuffs(Unit, true);
   
    if (Debuff and Debuff[1] and Debuff[1].Type) then

	if (Dcr.db.profile.LV_OnlyInRange) then
	    local RangeStatus = IsSpellInRange(Dcr.Status.CuringSpells[Debuff[1].Type], Unit);

	    if (not RangeStatus or RangeStatus == 0) then
		return false;
	    end
	end

	Dcr:UpdateLiveDisplay(Index, Unit, Debuff[1]);
	return true;
    end
    return false;
end --}}}

function Dcr:UpdateLiveDisplay( Index, Unit, Debuff) --{{{

    if (Dcr.db.profile.ReverseLiveDisplay) then
	Index = Dcr.db.profile.Amount_Of_Afflicted + -1 * (Index - 1);
    end

    local baseFrame = "DecursiveAfflictedListFrameListItem";

    local item = getglobal(baseFrame..Index);
    if (item.debuff == Debuff.index and item.Name == Debuff.Name and item.unit == Unit and item.DebuffApps == Debuff.Applications) then
	-- it's already displayed...
	return
    end
    Dcr:Debug("Updating: "..baseFrame.. Index);

    item.unit = Unit;
    item.Name = Debuff.Name;
    item.debuff = Debuff.index;
    item.DebuffApps = Debuff.Applications;

    getglobal(baseFrame..Index.."DebuffIcon"):SetTexture(Debuff.Texture);

    if (Debuff.Applications > 0) then
	getglobal(baseFrame..Index.."DebuffCount"):SetText(Debuff.Applications);
    else
	getglobal(baseFrame..Index.."DebuffCount"):SetText("");
    end

    getglobal(baseFrame..Index.."Name"):SetText(Dcr:MakePlayerName((UnitName(Unit))));

    getglobal(baseFrame..Index.."Type"):SetText(Dcr:MakeAfflictionName(Debuff.TypeName));

    getglobal(baseFrame..Index.."Affliction"):SetText(Debuff.Name);
    
    item:Show();

    item = getglobal(baseFrame..Index.."Debuff");
    item.unit = Unit;
    item.debuff = Debuff.index;

    item = getglobal(baseFrame..Index.."ClickMe");
    item.unit = Unit;
    item.debuff = Debuff.index;
end --}}}

-- }}}

-- // }}}
-------------------------------------------------------------------------------


-- Scanning functionalties {{{
-------------------------------------------------------------------------------

-- This finction only returns interesting values of UnitDebuff()
function Dcr:GetUnitDebuff  (Unit, i) --{{{
    local Name, rank, Texture, Applications, TypeName  = UnitDebuff(Unit, i);
    if (Name) then
	return Name, TypeName, Applications, Texture;
    else
	return false, false, false, false;
    end
end --}}}

do
    -- there is a known maximum number of unit and a known maximum debuffs per unit so lets allocate the memory needed only once. Memory will be allocated when needed and re-used...
    local DebuffUnitCache = {};

    -- Variables are declared outside so that Lua doesn't initialize them at each call
    local Texture, Applications, TypeName, Name, Type, i, StoredDebuffIndex, CharmFound, IsCharmed;


    -- This is the core debuff scanning function of Decursive
    -- This function does more than just reporting Debuffs. it also detects charmed units

    function Dcr:GetUnitDebuffAll (Unit) --{{{

	-- create a Debuff table for this unit if there is not already one
	if (not DebuffUnitCache[Unit]) then
	    DebuffUnitCache[Unit] = {};
	end

	-- This is just a shortcut for easier readability
	local ThisUnitDebuffs = DebuffUnitCache[Unit];

	i = 1;			-- => to index all debuffs
	StoredDebuffIndex = 1;	-- => this index only debuffs with a type
	CharmFound = false;	-- => avoid to find that the unit is charmed again and again...


	-- test if the unit is mind controlled once
	if (UnitIsCharmed(Unit) and UnitCanAttack(Unit, "player")) then
	    IsCharmed = true;
	else
	    IsCharmed = false;
	end

	-- iterate all available debuffs
	while (true) do
	    Name, TypeName, Applications, Texture = Dcr:GetUnitDebuff(Unit, i);

	    if (not Name) then
		break;
	    end

	    -- test for a type (Magic Curse Disease or Poison)
	    if (TypeName and TypeName ~= "") then
		Type = DcrC.NameToTypes[TypeName];
	    else
		Type = false;
	    end

	    -- if the unit is charmed and we didn't took care of this information yet
	    if (not CharmFound and IsCharmed) then

		-- If the unit has a magical debuff and we can cure it
		-- (note that the target is not friendly in that case)
		if (Type == DcrC.MAGIC and Dcr.Status.CuringSpells[DcrC.ENEMYMAGIC]) then
		    Type = DcrC.ENEMYMAGIC;

		    -- NOTE: if a unit is charmed and has another magical debuff
		    -- this block will be executed...

		else -- the unit doesn't have a magical debuff or we can't remove magical debuffs
		    Type = DcrC.CHARMED;
		    TypeName = DcrC.TypeNames[DcrC.CHARMED];
		end
		CharmFound = true;
	    end


	    -- If we found a type, register the Debuff
	    if (Type) then


		-- Create a Debuff index entry if necessary
		if (not ThisUnitDebuffs[StoredDebuffIndex]) then
		    ThisUnitDebuffs[StoredDebuffIndex] = {};
		end
		ThisUnitDebuffs[StoredDebuffIndex].Texture	= Texture;
		ThisUnitDebuffs[StoredDebuffIndex].Applications	= Applications;
		ThisUnitDebuffs[StoredDebuffIndex].TypeName	= TypeName;
		ThisUnitDebuffs[StoredDebuffIndex].Type		= Type;
		ThisUnitDebuffs[StoredDebuffIndex].Name		= Name;
		ThisUnitDebuffs[StoredDebuffIndex].index	= i;

		-- we can't use i, else we wouldn't have contiguous indexes in the table
		StoredDebuffIndex = StoredDebuffIndex + 1;
	    end

	    i = i + 1;
	end

	-- erase remaining unused entries without freeing the memory (less garbage)
	while (ThisUnitDebuffs[StoredDebuffIndex]) do
	    ThisUnitDebuffs[StoredDebuffIndex].Type = false;
	    StoredDebuffIndex = StoredDebuffIndex + 1;
	end


	return ThisUnitDebuffs, IsCharmed;
    end --}}}
end


do
    -- see the comemnt about DebuffUnitCache
    local ManagedDebuffUnitCache = {};


    local sorting = function (a, b)
	cura = a.Type and Dcr.db.profile.CureOrder[a.Type] or 1024;
	curb = b.Type and Dcr.db.profile.CureOrder[b.Type] or 1024;

	return cura < curb;
    end

    -- This function will return a table containing only the Debuffs we can cure excepts the one we have to ignore
    -- in different conditions.
    function Dcr:UnitCurableDebuffs (Unit, JustOne) -- {{{

	if not Unit then
	    return false;
	end

	if (not ManagedDebuffUnitCache[Unit]) then
	    ManagedDebuffUnitCache[Unit] = {};
	end

	local AllUnitDebuffs, IsCharmed = Dcr:GetUnitDebuffAll(Unit); -- always return a table, may be empty though

	if not (AllUnitDebuffs[1] and AllUnitDebuffs[1].Type ) then -- if there is no debuff
	    return false, IsCharmed;
	end

	local Spells	= Dcr.Status.CuringSpells; -- shortcut to available spell by debuff type


	local ManagedDebuffs = ManagedDebuffUnitCache[Unit]; -- shortcut for readability

	--Dcr:Debug("Debuffs were found");

	local DebuffNum = 1; -- number of found debuff (used for indexing)

	local continue; -- if we have to ignore a debuff, this will become false



	for _, Debuff in ipairs(AllUnitDebuffs) do

	    if (not Debuff.Type) then
		break;
	    end
	    continue = true;

	    -- test if we have to ignore this debuf  {{{ --
	    if (Dcr.db.profile.DebuffsToIgnore[Debuff.Name]) then
		-- these are the BAD ones... the ones that make the target immune... abort this unit
		break; -- exit here
	    end

	    if (Dcr.db.profile.BuffDebuff[Debuff.Name]) then
		-- these are just ones you don't care about
		continue = false;
	    end

	    if (Dcr.Status.Combat) then
		local _, EnUClass = UnitClass(Unit);
		if (Dcr.db.profile.skipByClass[EnUClass]) then
		    if (Dcr.db.profile.skipByClass[EnUClass][Debuff.Name]) then
			-- these are just ones you don't care about by class while in combat
			continue = false;
		    end
		end
	    end

	    -- }}}

	    
	    if continue then
		--	Dcr:Debug("Debuffs matters");
		-- If we are still here it means that this Debuff is something not to be ignored...


		-- We have a match for this type and we decided (checked) to cure it
		-- NOTE: Dcr.db.profile.CureOrder[DEBUFF_TYPE] is set to FALSE when the type is unchecked
		-- and to -1 when there is no spell available for the type
		-- (-1 is not a reliable value to test for spell avaibility)
		if (Dcr.db.profile.CureOrder[Debuff.Type] and Dcr.db.profile.CureOrder[Debuff.Type] ~= -1) then


		    -- Dcr:Debug("we can cure it");

		    -- if we do have a spell to cure
		    if (Spells[Debuff.Type]) then
			-- The user doesn't want to cure a unit afllicted by poison or disease if the unit
			-- is beeing cured by an abolish spell

			if (Dcr.db.profile.Check_For_Abolish and (Debuff.Type == DcrC.POISON and Dcr:CheckUnitForBuffs(Unit, BS[Dcr.LOC.SPELL_ABOLISH_POISON]) or Debuff.Type == DcrC.DISEASE and Dcr:CheckUnitForBuffs(Unit, BS[Dcr.LOC.SPELL_ABOLISH_DISEASE]))) then
			    Dcr:Debug("Abolish buff found, skipping");
			else
			    -- Dcr:Debug("It's managed");

			    -- create an entry for this debuff index if necessary
			    if (not ManagedDebuffs[DebuffNum]) then
				ManagedDebuffs[DebuffNum] = {};
			    end

			    -- copy the debuff information to this table.
			    Dcr:tcopy(ManagedDebuffs[DebuffNum], Debuff);

			    DebuffNum = DebuffNum + 1;

			    -- the live-list only reports the first debuf found and set JustOne to true
			    if (JustOne) then
				break;
			    end
			end
		    end
		end
	    end
	end -- for END

	-- erase ubused entries without freeing the memory (less garbage)
	while (ManagedDebuffs[DebuffNum]) do
	    ManagedDebuffs[DebuffNum].Type = false;
	    DebuffNum = DebuffNum + 1;
	end

	-- sort the table only if it's not 'empty' and only if there is at least two debuffs
	if (ManagedDebuffs[1] and ManagedDebuffs[1].Type) then

	    -- order Debuffs according to type priority order
	    if (not JustOne and ManagedDebuffs[2] and ManagedDebuffs[2].Type) then
		table.sort(ManagedDebuffs, sorting); -- uses memory..
	    end
	    return ManagedDebuffs, IsCharmed;
	else
	    return false, IsCharmed;
	end

    end -- // }}}

end

local UnitBuffsCache	= {};
-- this function returns true if one of the debuff(s) passed to it is found on the specified unit
function Dcr:CheckUnitForBuffs(Unit, BuffNamesToCheck) --{{{

    if (not UnitBuffsCache[Unit]) then
	UnitBuffsCache[Unit] = {};
    end

    local UnitBuffs	= UnitBuffsCache[Unit];
    local i		= 1;

    -- Gett all the unit's buffs
    while (true) do
	local buff_name = UnitBuff(Unit, i);
	if (buff_name) then
	    UnitBuffs[i] = buff_name;
	else
	    break;
	end

	i = i + 1;
    end

    while UnitBuffs[i] do -- clean the rest of the cache
	UnitBuffs[i] = false;
	i = i + 1;
    end

    if type(BuffNamesToCheck) ~= "table" then
	if Dcr:tcheckforval(UnitBuffs, BuffNamesToCheck) then
	    return true;
	else
	    return false;
	end
    else
	local Buff;
	for _, Buff in pairs(BuffNamesToCheck) do

	    if Dcr:tcheckforval(UnitBuffs, Buff) then
		return true;
	    end

	end
    end

    return false;

end --}}}

local Stealthed = {BS["Prowl"], BS["Stealth"], BS["Shadowmeld"],}; -- BS["Ice Armor"],};

function Dcr:CheckUnitStealth(Unit) --{{{
    if (Dcr.db.profile.Ingore_Stealthed) then
	if Dcr:CheckUnitForBuffs(Unit, Stealthed) then
--	    Dcr:Debug("Sealth found !");
	    return true;
	end
    end
    return false;
end --}}}
-- }}}


