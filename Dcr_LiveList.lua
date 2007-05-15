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

local L	    = Dcr.L;
local BC    = Dcr.BC;
local BS    = Dcr.BS;
local AceOO = Dcr.AOO;

Dcr.LiveList = AceOO.Class();

local LiveList = Dcr.LiveList;

LiveList.ExistingPerID	= {};
LiveList.Number		= 0;
LiveList.NumberShown	= 0;
Dcr.ForLLDebuffedUnitsNum = 0;

-- temporary variables often used in function
local Debuff, Debuffs, IsCharmed, MF, i, Index, RangeStatus;

-- defines what is printed when the object is read as a string
function LiveList:ToString() -- {{{
    return "Decursive Live-List object";
end -- }}}

-- The Factory for LiveList objects
function LiveList:Create() -- {{{

    if self.Number + 1 > Dcr.profile.Amount_Of_Afflicted then
	return false;
    end

    self.Number = self.Number + 1;

    LiveList.ExistingPerID[self.Number] = LiveList:new(DcrLiveList, self.Number);


    return LiveList.ExistingPerID[self.Number];

end -- }}}

function LiveList:DisplayItem (ID, UnitID, Debuff) -- {{{

    --Dcr:Debug("(LiveList) Displaying LVItem %d for UnitID %s", ID, UnitID);
    local LVItem = false;

    if ID > LiveList.Number + 1 then
	return error(("LiveList:DisplayItem: bad argument #1 'ID (= %d)' must be < LiveList.Number + 1 (LiveList.Number = %d)"):format(ID, LiveList.Number),2);
    end

    if not self.ExistingPerID[ID] then
	LVItem=self:Create();
    else
	LVItem = self.ExistingPerID[ID];
    end

    if not LVItem then
	return false;
    end

    if not Debuff then
	Debuff = Dcr.ManagedDebuffUnitCache[UnitID][1];
    end

    LVItem:SetDebuff(UnitID, Debuff, nil);
    --Dcr:Debug("XXXX => Updating ll item %d for %s", ID, UnitID);

    if not LVItem.IsShown then
	LVItem.Frame:Show();
	LiveList.NumberShown = LiveList.NumberShown + 1;
	LVItem.IsShown = true;
    end

end -- }}}

function LiveList:RestAllPosition () -- {{{
    for _, LVitem in ipairs(LiveList.ExistingPerID) do
	LVitem.Frame:ClearAllPoints();
	LVitem.Frame:SetPoint(LVitem:GiveAnchor());
    end
end -- }}}

function LiveList.prototype:GiveAnchor() -- {{{

    local ItemHeight = self.Frame:GetHeight();

    if Dcr.profile.ReverseLiveDisplay then
    end

    if self.ID == 1 then
	if Dcr.profile.ReverseLiveDisplay then
	    return "BOTTOMLEFT", DecursiveMainBar, "BOTTOMLEFT", 5, -1 * (ItemHeight + 1) * Dcr.profile.Amount_Of_Afflicted;
	else
	    return "TOPLEFT", DecursiveMainBar, "BOTTOMLEFT", 5, 0;
	end
    else
	if Dcr.profile.ReverseLiveDisplay then
	    return "BOTTOMLEFT", LiveList.ExistingPerID[self.ID - 1].Frame, "TOPLEFT", 0, 1;
	else
	    return "TOPLEFT", LiveList.ExistingPerID[self.ID - 1].Frame, "BOTTOMLEFT", 0, -1;
	end
    end

end -- }}}


function LiveList.prototype:init(Container,ID) -- {{{
    LiveList.super.prototype.init(self); -- needed
    Dcr:Debug("(LiveList) Initializing LiveList object '%s'", ID);

    --ObjectRelated
    self.ID		    = ID;
    self.IsShown	    = false;
    self.Parent		    = Container;

    --Debuff info
    self.UnitID		    = false;
    self.UnitName	    = false;
    self.PrevUnitName	    = false;
    self.UnitClass	    = false;
    
    self.Debuff			= {};

    self.PrevDebuffIndex	= false;
    self.PrevDebuffName		= false;
    self.PrevDebuffTypeName	= false;
    self.PrevDebuffApplicaton	= false;
    self.PrevDebuffTexture	= false;

    self.IsCharmed	    = false;
    self.PrevIsCharmed	    = false;

    self.Alpha		    = false;

    -- Create the frame
    self.Frame = CreateFrame ("Button", "DcrLiveListItem"..ID, self.Parent, "DcrLVItemTemplate");

    -- Set some basic properties
    self.Frame:SetFrameStrata("LOW");
    self.Frame:RegisterForClicks("AnyDown");

    -- Set the anchor of this item
    self.Frame:SetPoint(self:GiveAnchor());

    -- create the background
    self.BackGroundTexture = self.Frame:CreateTexture(nil, "BACKGROUND", "DcrLVBackgroundTemplate");

    -- Create the Icon Texture
    self.IconTexture = self.Frame:CreateTexture(nil, "ARTWORK", "DcrLVIconTemplate");

    -- Create the Debuff application count font string
    self.DebuffAppsFontString = self.Frame:CreateFontString(nil, "OVERLAY", "DcrLLAfflictionCountFont");

    -- Create the character name Fontstring
    self.UnitNameFontString = self.Frame:CreateFontString(nil, "OVERLAY", "DcrLLUnitNameFont");

    -- Create the debuff type fontstring
    self.DebuffTypeFontString = self.Frame:CreateFontString(nil, "OVERLAY", "DcrLLDebuffTypeFont");

    -- Create the debuff name fontstring
    self.DebuffNameFontString = self.Frame:CreateFontString(nil, "OVERLAY", "DcrLLDebuffNameFont");


    -- a reference to this object
    self.Frame.Object = self;

    self.Frame:Show();

end -- }}}

function LiveList.prototype:SetDebuff(UnitID, Debuff, IsCharmed) -- {{{
    self.UnitID		    = UnitID;
    self.UnitName	    = UnitName(UnitID);
    self.Debuff		    = Debuff;
    self.IsCharmed	    = IsCharmed;

    if Dcr.profile.LiveListAlpha ~= self.Alpha then
	self.Frame:SetAlpha(Dcr.profile.LiveListAlpha);
	self.Alpha = Dcr.profile.LiveListAlpha;
    end

    -- Set the graphical elements to the right values
    -- Icon
    if self.PrevDebuffTexture ~= Debuff.Texture then
	self.IconTexture:SetTexture(Debuff.Texture);
	self.PrevDebuffTexture =  Debuff.Texture;
    end

    -- Applications count
    if self.PrevDebuffApplicaton ~= Debuff.Applications then
	if (Debuff.Applications > 0) then
	    self.DebuffAppsFontString:SetText(Debuff.Applications);
	else
	    self.DebuffAppsFontString:SetText(" ");
	end
	self.PrevDebuffApplicaton = Debuff.Applications;
    end

    -- Unit Name
    if self.PrevUnitName ~= self.UnitName then
	self.UnitClass = select(2, UnitClass(UnitID));
	self.UnitNameFontString:SetText(self.UnitName);
	if self.UnitClass then
	    self.UnitNameFontString:SetTextColor(BC:GetColor(self.UnitClass));
	end
	self.PrevUnitName =  self.UnitName;
    end

    -- Debuff Type Name
    if self.PrevDebuffTypeName ~= Debuff.TypeName then
	if Debuff.Type then
	    self.DebuffTypeFontString:SetText(Dcr:ColorText(L[Debuff.TypeName], "FF" .. DcrC.TypeColors[Debuff.Type] ));
	    --self.DebuffTypeFontString:SetTextColor(DcrC.TypeColors[Debuff.Type]);
	else
	    self.DebuffTypeFontString:SetText("Unknown");
	end
	self.PrevDebuffTypeName = Debuff.TypeName;
    end

    -- Debuff Name
    if self.PrevDebuffName ~= Debuff.Name then
	self.DebuffNameFontString:SetText(Debuff.Name);
	self.PrevDebuffName = Debuff.Name;
    end

end -- }}}


function LiveList:GetDebuff(UnitID) -- {{{
    --  (note that this function is only called for the mouseover and target if the MUFs are active)

    if  UnitID == "target" and not UnitIsFriend(UnitID, "player") then
	if Dcr.ManagedDebuffUnitCache[UnitID] and Dcr.ManagedDebuffUnitCache[UnitID][1] and Dcr.ManagedDebuffUnitCache[UnitID][1].Type then
	    Dcr.ManagedDebuffUnitCache[UnitID][1].Type = false; -- clear target debuff
	end
	return;
    end

    Dcr:Debug("(LiveList) Getting Debuff for ", UnitID);
    -- decrease the total debuff number if the MUFs system isn't already doing it or if it's the mouseover or target unit
    if (not Dcr.profile.ShowDebuffsFrame or UnitID == "mouseover" or UnitID == "target") and Dcr.UnitDebuffed[UnitID]  then
	Dcr.ForLLDebuffedUnitsNum = Dcr.ForLLDebuffedUnitsNum - 1;
    end

    -- Get the unit Debuffs
    if (not Dcr.profile.ShowDebuffsFrame or UnitID == "mouseover" or UnitID == "target") then
	Debuffs, IsCharmed = Dcr:UnitCurableDebuffs(UnitID, true);
    else -- The MUFs are active and Unit is not mouseover and is not target
	MF = Dcr.MicroUnitF.ExistingPerNum[Dcr.Status.Unit_Array_UnitToIndex[unit]];
	Debuffs = MF.Debuffs;
    end

    if (Debuffs and Debuffs[1] and Debuffs[1].Type) then -- there is a Debuff

	Dcr.UnitDebuffed[UnitID] = true; -- register that this unit is debuffed

	-- increase the total debuff number
	if not Dcr.profile.ShowDebuffsFrame or UnitID == "mouseover" or UnitID == "target" then

	    Dcr.ForLLDebuffedUnitsNum = Dcr.ForLLDebuffedUnitsNum + 1;

	end
    else
	Dcr.UnitDebuffed[UnitID] = false; -- unregister this unit
    end
end -- }}}

function LiveList:DelayedGetDebuff(UnitID) -- {{{
    if not Dcr:IsEventScheduled("GetDebuff"..UnitID) then
	Dcr:ScheduleEvent("GetDebuff"..UnitID, LiveList.GetDebuff, Dcr.profile.ScanTime / 2, LiveList, UnitID);
    end
end -- }}}


function LiveList:Update_Display() -- {{{

    -- Update the unit array
    if (Dcr.Groups_datas_are_invalid) then
	Dcr:GetUnitArray();
    end

    Index = 0;

    -- Check the units in order of importance:

    -- First the Target
    if Dcr.UnitDebuffed["target"] and UnitExists("target") then
	Index = Index + 1;
	self:DisplayItem(Index, "target");
	if not Dcr.Status.SoundPlayed then
	    Dcr:PlaySound ("target");
	end
    end

    -- Then the MouseOver
    if not Dcr.Status.MouseOveringMUF and Dcr.UnitDebuffed["mouseover"] and UnitExists("mouseover") then
	Index = Index + 1;
	self:DisplayItem(Index, "mouseover");
	if not Dcr.Status.SoundPlayed then
	    Dcr:PlaySound ("mouseover");
	end
    end

    -- Then continue with all the remaining units if at least one of them is debuffed
    -- We need this loop because:
    --	    1, we have to show an ordered list (always true)
    --	    2, we want to test if the unit is in spell range (only if the option is active and the MUFs hidden)
    --	    There is no event to do the last and a not simple table.sort() would be needed for the first...
    if Dcr.ForLLDebuffedUnitsNum - Index > 0 and Index < Dcr.profile.Amount_Of_Afflicted then
	for _, UnitID in ipairs(Dcr.Status.Unit_Array) do
	    -- if the unit is debuffedm still exists and is not stealthedm check this only if the MUFs engine is not there, redudent tests otherwise...
	    if Dcr.UnitDebuffed[UnitID] and UnitExists(UnitID) and not (not Dcr.profile.ShowDebuffsFrame and Dcr.profile.Ingore_Stealthed and Dcr.Stealthed_Units[UnitID]) then

		-- The MUFs are shown or we don't care about range
		if Dcr.profile.ShowDebuffsFrame or not Dcr.profile.LV_OnlyInRange then
		    Index = Index + 1;
		    self:DisplayItem(Index, UnitID);
		-- play the sound if not already done
		if not Dcr.Status.SoundPlayed then
		    Dcr:PlaySound (UnitID);
		end
		else -- The MUFS are hidden and we care about range
		    RangeStatus = IsSpellInRange(Dcr.Status.CuringSpells[Dcr.ManagedDebuffUnitCache[UnitID][1].Type], UnitID);

		    if (RangeStatus and RangeStatus ~= 0) then

			Index = Index + 1;
			self:DisplayItem(Index, UnitID);
		-- play the sound if not already done
		if not Dcr.Status.SoundPlayed then
		    Dcr:PlaySound (UnitID);
		end
		    end
		end
	    end

	    -- don't loop if we reach the max displayed unit num or if all debuffed units have been displayed
	    if Index == Dcr.profile.Amount_Of_Afflicted or Index == Dcr.ForLLDebuffedUnitsNum then
		break;
	    end
	end
    end

    -- reset the sound if no units were displayed
    if Index == 0 then
	Dcr.Status.SoundPlayed = false; -- re-enable the sound if no more debuff
    end

    -- Hide unneeded Items
    if self.NumberShown > Index then -- if there are more unit shown than the actual number of debuffed units
	for i = Index + 1, self.NumberShown do
	    if self.ExistingPerID[i] and self.ExistingPerID[i].IsShown then
		Dcr:Debug("(LiveList) Hidding LVItem %d", i);
		self.ExistingPerID[i].Frame:Hide();
		self.ExistingPerID[i].IsShown = false;
		self.NumberShown = self.NumberShown - 1;
	    else
		break;
	    end
	end
    end


end -- }}}



function LiveList:DisplayTestItem() -- {{{
    if not LiveList.TestItemDisplayed then
	LiveList.TestItemDisplayed = true;
	Dcr:SpecialEvents_UnitDebuffLost(Dcr:NameToUnit(UnitName("player")), "Test item");
    end
end -- }}}

function LiveList:HideTestItem() -- {{{
     LiveList.TestItemDisplayed = false;
     local i = 1;

     for UnitID, Debuffed in pairs(Dcr.UnitDebuffed) do
	 if Debuffed then
	     Dcr:ScheduleEvent("rmt"..i, Dcr.SpecialEvents_UnitDebuffLost, i * (Dcr.profile.ScanTime / 2), Dcr, UnitID, "Test item");
	     i = i + 1;
	 end
     end

end -- }}}


-- this displays the tooltips of the live-list
function LiveList:DebuffTemplate_OnEnter() --{{{
    if (Dcr.profile.AfflictionTooltips and this.Object.UnitID) then
	DcrDisplay_Tooltip:SetOwner(this, "ANCHOR_CURSOR");
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetUnitDebuff(this.Object.UnitID,this.Object.Debuff.index); -- OK
	DcrDisplay_Tooltip:Show();
    end
end --}}}

function LiveList:Onclick() -- {{{
    Dcr:Println(L[Dcr.LOC.HLP_LL_ONCLICK_TEXT]);
end -- }}}
