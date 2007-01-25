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
function Dcr_debug( Message) --{{{
    if (Dcr_Print_DEBUG) then
	Dcr.Status.OutputWindow:AddMessage(Message, 0.1, 0.1, 1);
    end
    return true;
end --}}}



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

-- skip list stuff
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


-- LIVE DISPLAY functions {{{

    

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
    --Dcr:Debug("Previous: ", item.debuff,  item.Name, item.unit, item.DebuffApps);
    --Dcr:Debug("new     : ", Debuff.index,  Debuff.Name, Unit, Debuff.Applications);

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
    --
    --
    -- item.UpdateMe = true;
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
function Dcr:GetUnitDebuff  (Unit, i) --{{{
    local Name, rank, Texture, Applications, TypeName  = UnitDebuff(Unit, i);
    if (Name) then
	return Name, TypeName, Applications, Texture;
    else
	return false, false, false, false;
    end
end --}}}

do
    -- there is a known maximum number of unit and a known maximum debuffs per unit so lets allocate the memory needed only once.
    local DebuffUnitCache = {};
    local Texture, Applications, TypeName, Name, Type, i, StoredDebuffIndex, CharmFound;

    function Dcr:GetUnitDebuffAll (Unit) --{{{

	if (not DebuffUnitCache[Unit]) then
	    DebuffUnitCache[Unit] = {};
	end

	local ThisUnitDebuffs = DebuffUnitCache[Unit];

	i = 1;
	StoredDebuffIndex = 1;
	CharmFound = false;
	while (true) do
	    Name, TypeName, Applications, Texture = Dcr:GetUnitDebuff(Unit, i);

	    if (not Name) then
		break;
	    end

	    if (TypeName and TypeName ~= "") then
		Type = DcrC.NameToTypes[TypeName];
	    else
		Type = false;
	    end

	    if (not CharmFound and UnitIsCharmed(Unit) and UnitCanAttack(Unit, "player")) then

		if (Type == DcrC.MAGIC and Dcr.Status.CuringSpells[DcrC.MAGIC]) then
		    Type = DcrC.ENEMYMAGIC;
		else
		    Type = DcrC.CHARMED;
		    TypeName = DcrC.TypeNames[DcrC.CHARMED];
		end
		CharmFound = true;

	    end

	    if (Type) then


		-- memory leak here
		if (not ThisUnitDebuffs[StoredDebuffIndex]) then
		    ThisUnitDebuffs[StoredDebuffIndex] = {};
		end
		--if not (Type == ThisUnitDebuffs[StoredDebuffIndex].Type and Name == ThisUnitDebuffs[StoredDebuffIndex].Name and Applications ~= ThisUnitDebuffs[StoredDebuffIndex].Applications) then
		ThisUnitDebuffs[StoredDebuffIndex].Texture	= Texture;
		ThisUnitDebuffs[StoredDebuffIndex].Applications	= Applications;
		ThisUnitDebuffs[StoredDebuffIndex].TypeName	= TypeName;
		ThisUnitDebuffs[StoredDebuffIndex].Type		= Type;
		ThisUnitDebuffs[StoredDebuffIndex].Name		= Name;
		ThisUnitDebuffs[StoredDebuffIndex].index	= i;
		--end


		StoredDebuffIndex = StoredDebuffIndex + 1;
	    end

	    i = i + 1;
	end

	-- erase remaining unused entries without freeing the memory (less garbage)
	while (ThisUnitDebuffs[StoredDebuffIndex]) do
	    ThisUnitDebuffs[StoredDebuffIndex].Type = false;
	    StoredDebuffIndex = StoredDebuffIndex + 1;
	end

	--    TODO:
	--    Add an 'unfriendly' type so that any controlled unit is shown

	return ThisUnitDebuffs;
    end --}}}
end


do
    local ManagedDebuffUnitCache = {};


    local sorting = function (a, b)
	cura = a.Type and Dcr.db.profile.CureOrder[a.Type] or 1024;
	curb = b.Type and Dcr.db.profile.CureOrder[b.Type] or 1024;

	return cura < curb;
    end

    function Dcr:UnitCurableDebuffs (Unit, JustOne)

	if not Unit then
	    return false;
	end

	if (not ManagedDebuffUnitCache[Unit]) then
	    ManagedDebuffUnitCache[Unit] = {};
	end

	local AllUnitDebuffs = Dcr:GetUnitDebuffAll(Unit); -- always return a table, may be empty though

	if not (AllUnitDebuffs[1] and AllUnitDebuffs[1].Type ) then
	    return false;
	end

	local Spells	= Dcr.Status.CuringSpells;


	local ManagedDebuffs = ManagedDebuffUnitCache[Unit];

	--Dcr:Debug("Debuffs were found");

	local DebuffNum = 1;

	local continue;



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
		-- Dcr:Debug("Debuffs matters");
		-- if we are still here it means that this Debuff is something not to be ignored...

		local DebuffType = Debuff.Type;

		-- We have a match for this type and we decided (checked) to cure it
		if (Dcr.db.profile.CureOrder[DebuffType] and Dcr.db.profile.CureOrder[DebuffType] ~= -1) then


		    -- Dcr:Debug("we can cure it");

		    if (Spells[DebuffType]) then
			if (Dcr.db.profile.Check_For_Abolish and (DebuffType == DcrC.POISON and Dcr:CheckUnitForBuffs(Unit, BS[Dcr.LOC.SPELL_ABOLISH_POISON]) or DebuffType == DcrC.DISEASE and Dcr:CheckUnitForBuffs(Unit, BS[Dcr.LOC.SPELL_ABOLISH_DISEASE]))) then
			    Dcr:Debug("Abolish buff found, skipping");
			else
			   -- Dcr:Debug("It's managed");

			    if (not ManagedDebuffs[DebuffNum]) then
				ManagedDebuffs[DebuffNum] = {};
			    end

			    Dcr:tcopy(ManagedDebuffs[DebuffNum], Debuff);

			    DebuffNum = DebuffNum + 1;
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

	-- sort the table only of it's not 'empty' and only if there is at least two debuffs
	if (ManagedDebuffs[1] and ManagedDebuffs[1].Type) then

	    -- order Debuffs according to type priority order
	    if (not JustOne and ManagedDebuffs[2] and ManagedDebuffs[2].Type) then
		table.sort(ManagedDebuffs, sorting); -- uses memory..
	    end
	    return ManagedDebuffs;
	else
	    return false;
	end

    end

end

local UnitBuffsCache	= {};
function Dcr:CheckUnitForBuffs(Unit, BuffNamesToCheck) --{{{

    if (not UnitBuffsCache[Unit]) then
	UnitBuffsCache[Unit] = {};
    end

    local UnitBuffs	= UnitBuffsCache[Unit];
    -- local FoundBuffs	= {};
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
		-- FoundBuffs[Buff] = true;
	    end

	end

	--[[
	if (next(FoundBuffs)) then
	    return FoundBuffs;
	else
	    return false;
	end
	--]]

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

--[[
function Dcr_UnitInRange(Unit) --{{{
    -- ==> XXX use result = IsSpellInRange(spell, [unit]) - is nil for no valid target, 0 for out of range, 1 for in range
    -- and usable, noMana = IsUsableSpell(spell)
    -- XXX will use them when mouseovering unit farmes
    if (CheckInteractDistance(Unit, 4)) then
	return true;
    end
    return false;
end --}}}
-- }}}
--]]


