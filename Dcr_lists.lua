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


-- Dcr_ListFrameTemplate specific internal functions {{{
function Dcr:ListFrameTemplate_OnLoad()
    this.ScrollFrame = getglobal(this:GetName().."ScrollFrame");
    this.ScrollBar = getglobal(this.ScrollFrame:GetName().."ScrollBar");
    this.ScrollFrame.offset = 0;
end

function Dcr:ListFrameScrollFrameTemplate_OnMouseWheel(value)
    local scrollBar = getglobal(this:GetName().."ScrollBar");
    local min, max = scrollBar:GetMinMaxValues();
    if ( value > 0 ) then
	if (IsShiftKeyDown() ) then
	    scrollBar:SetValue(min);
	else
	    scrollBar:SetValue(scrollBar:GetValue() - scrollBar:GetValueStep());
	end
    else
	if (IsShiftKeyDown() ) then
	    scrollBar:SetValue(max);
	else
	    scrollBar:SetValue(scrollBar:GetValue() + scrollBar:GetValueStep());
	end
    end
end

-- }}}

-- Dcr_ListFrameTemplate specific handlers {{{

function Dcr:PrioSkipListFrame_OnUpdate() --{{{
    if (this.UpdateYourself) then
	this.UpdateYourself = false;
	local baseName = this:GetName();
	local size;

	if (this.Priority) then
	    size = table.getn(Dcr.db.profile.PriorityList);
	else
	    size = table.getn(Dcr.db.profile.SkipList);
	end

	if (size < 11 ) then
	    this.ScrollFrame.offset = 0;
	else
	    if (this.ScrollFrame.offset <= 0) then
		this.ScrollFrame.offset = 0;
	    elseif (this.ScrollFrame.offset >= (size - 10)) then
		this.ScrollFrame.offset = (size - 10);
	    end
	end

	local i;
	for i = 1, 10 do
	    local id = ""..i;
	    if (i < 10) then
		id = "0"..i;
	    end
	    local btn = getglobal(baseName.."Index"..id);

	    btn:SetID( i + this.ScrollFrame.offset);
	    Dcr:PrioSkipListEntry_Update(btn);

	    if (i <= size) then
		btn:Show();
	    else
		btn:Hide();
	    end
	end
	this:ScrollUpdateFunc(getglobal(baseName.."ScrollFrame"));
	-- Dcr.Groups_datas_are_invalid = true;
    end

end --}}}

function Dcr:PrioSkipListEntryTemplate_OnClick() --{{{
--    Dcr:PrintLiteral(arg1);

    if (this:GetParent().Priority) then
	list = Dcr.db.profile.PriorityList;
	UnitNum = getn(Dcr.db.profile.PriorityList);
    else
	list = Dcr.db.profile.SkipList;
	UnitNum = getn(Dcr.db.profile.SkipList);
    end


    local id = this:GetID();
    if (id) then
	if (IsControlKeyDown()) then
	    if (this:GetParent().Priority) then
		Dcr:RemoveIDFromPriorityList(id);
	    else
		Dcr:RemoveIDFromSkipList(id);
	    end
	elseif (UnitNum > 1) then
	    local previousUnit_ID, previousUnit, nextUnit_ID, nextUnit, currentUnit;

	    --if (id == 0) then
		-- previousUnit_ID	= UnitNum;  else 
		previousUnit_ID  = id - 1;
	    --end
	    --if (id == UnitNum - 1) then
		--nextUnit_ID	=           0;	else
		nextUnit_ID      = id + 1;
	    --end

	    previousUnit = list[previousUnit_ID];
	    nextUnit	 = list[nextUnit_ID    ];
	    currentUnit	 = list[id];


	    if (arg1=="RightButton" and IsShiftKeyDown()) then -- move at the bottom
		table.remove(list, id);
		table.insert(list, UnitNum, currentUnit);

	    elseif (arg1=="LeftButton" and IsShiftKeyDown()) then -- move at the top
		table.remove(list, id);
		table.insert(list, 1, currentUnit);
	    elseif (arg1=="LeftButton" and id ~= 1) then -- unit gets higher
		Dcr:Debug("upping %s of id %d", list[id], id);
		list[previousUnit_ID]	= list[id];
		list[id]		= previousUnit;
	    elseif (arg1=="RightButton" and id ~= UnitNum) then -- unit gets lower
		Dcr:Debug("downing %s of id %d", list[id], id);
		list[nextUnit_ID]	= list[id];
		list[id]		= nextUnit;
	    elseif (arg1=="MiddleButton") then
	    
	    end
	    this:GetParent().UpdateYourself = true;
	end
	Dcr.Groups_datas_are_invalid = true;
    else
	    Dcr:Debug("No ID");
    end

end --}}}

function Dcr:PrioSkipListEntry_Update(Entry) --{{{
	local id = Entry:GetID();
	if (id) then
	    local name, classname;
	    if (Entry:GetParent().Priority) then
		name = Dcr.db.profile.PriorityList[id];
		classname = Dcr.db.profile.PriorityListClass[name];
	    else
		name = Dcr.db.profile.SkipList[id];
		classname = Dcr.db.profile.SkipListClass[name];
	    end
	    if not classname then
		classname = "WARRIOR";
	    end
	    if (name) then
		if (type(name) == "number") then
		    if (name < 10) then
			name = string.format("[ %s %s ]", L[Dcr.LOC.STR_GROUP], name);
		    else
			name = string.format("[ %s ]", DcrC.ClassNumToName[name]);
		    end
		end
		Entry:SetText(id.." - "..Dcr:ColorText(name, "FF"..BC:GetHexColor(classname)));
	    else
		Entry:SetText("Error - NO name!");
	    end
	else
	    Entry:SetText("Error - No ID!");
	end
end --}}}

function Dcr:PrioSkipList_ScrollFrame_Update (ScrollFrame) -- {{{
    local maxentry;
    local UpdateListOnceDone = true;
    local DirectCall = false;

    --Dcr:Debug("ScrollFrame is a %s", type(ScrollFrame));
    if (not ScrollFrame) then
	ScrollFrame = this; -- Called from the scrollbar frame handler
    else
	UpdateListOnceDone = false; -- The function was called from the list update function
	DirectCall = true;
    end

    if (not ScrollFrame.UpdateYourself) then
	ScrollFrame.UpdateYourself = true;
	return;
    end

    if (ScrollFrame:GetParent().Priority) then
	maxentry = table.getn(Dcr.db.profile.PriorityList);
    else
	maxentry = table.getn(Dcr.db.profile.SkipList);
    end

    FauxScrollFrame_Update(ScrollFrame,maxentry,10,16);


    if (UpdateListOnceDone) then
	ScrollFrame.UpdateYourself = false; -- prevent this function to re-execute unecessarily
	ScrollFrame:GetParent().UpdateYourself = true;
    end
    --Dcr:Debug("PrioSkipList_ScrollFrame_Update executed for %s", ScrollFrame:GetName());
end -- }}}


-- }}}

-- list specific management functions {{{
-------------------------------------------------------------------------------

function Dcr:AddTargetToPriorityList() --{{{
    Dcr:Debug( "Adding the target to the priority list");
    return Dcr:AddUnitToPriorityList("target", true);
end --}}}

function Dcr:AddUnitToPriorityList( unit, check ) --{{{

    if (#Dcr.db.profile.PriorityList > 99) then
	return false;
    end

    if (not check or UnitExists(unit)) then
	if (type(unit) == "number" or UnitIsPlayer(unit)) then
	    Dcr:Debug("adding %s", unit);

	    local name = "";

	    if type(unit) == "number" then
		name = unit;
	    else
		name = (UnitName( unit));
	    end

	    for _, pname in pairs(Dcr.db.profile.PriorityList) do
		if (name == pname) then
		    return false;
		end
	    end

	    table.insert(Dcr.db.profile.PriorityList,name);

	    if (type(unit) == "string") then
		_, Dcr.db.profile.PriorityListClass[name] = UnitClass(unit);
	    elseif unit > 10 then
		Dcr.db.profile.PriorityListClass[unit] = string.upper(BC:GetReverseTranslation(DcrC.ClassNumToName[unit]));
	    end

	    DecursivePriorityListFrame.UpdateYourself = true;
	    Dcr:Debug("Unit %s added to the prio list", name);
	    Dcr.Groups_datas_are_invalid = true;
	    return true;
	else
	    Dcr:Debug("Unit is not a player");
	end
    else
	    Dcr:Debug("Unit does not exist");
    end
    return false;
end --}}}

function Dcr:RemoveIDFromPriorityList(id) --{{{

    Dcr.db.profile.PriorityListClass[ Dcr.db.profile.PriorityList[id] ] = nil;

    table.remove( Dcr.db.profile.PriorityList, id );

    Dcr.Groups_datas_are_invalid = true;
    DecursivePriorityListFrame.UpdateYourself = true;
end --}}}

function Dcr:ClearPriorityList() --{{{
    Dcr.db.profile.PriorityList = {};
    Dcr.db.profile.PriorityListClass = {};
    
    Dcr.Groups_datas_are_invalid = true;
    DecursivePriorityListFrame.UpdateYourself = true;
end --}}}

function Dcr:AddTargetToSkipList() --{{{
    Dcr:Debug( "Adding the target to the Skip list");
    return Dcr:AddUnitToSkipList("target");
end --}}}

function Dcr:AddUnitToSkipList( unit) --{{{

    if (#Dcr.db.profile.SkipList > 99) then
	return false;
    end

    if (not check or UnitExists(unit)) then
	if (type(unit) == "number" or UnitIsPlayer(unit)) then
	    Dcr:Debug("adding %s", unit);

	    local name = "";
	    
	    if type(unit) == "number" then
		name = unit;
	    else
		name = (UnitName( unit));
	    end

	    for _, pname in pairs(Dcr.db.profile.SkipList) do
		if (name == pname) then
		    return false;
		end
	    end

	    table.insert(Dcr.db.profile.SkipList,name);

	    if (type(unit) == "string") then
		_, Dcr.db.profile.SkipListClass[name] = UnitClass(unit);
	    elseif unit > 10 then
		Dcr.db.profile.SkipListClass[unit] = string.upper(BC:GetReverseTranslation(DcrC.ClassNumToName[unit]));
	    end

	    Dcr:Debug("Unit %s added to the skip list", name);
	    DecursiveSkipListFrame.UpdateYourself = true;
	    Dcr.Groups_datas_are_invalid = true;
	    return true;
	else
	    Dcr:Debug("Unit is not a player");
	end
    else
	    Dcr:Debug("Unit does not exist");
    end
    return false;
end --}}}

function Dcr:RemoveIDFromSkipList(id) --{{{

    Dcr.db.profile.SkipListClass[ Dcr.db.profile.SkipList[id] ] = nil;

    table.remove( Dcr.db.profile.SkipList, id );

    Dcr.Groups_datas_are_invalid = true;
    DecursiveSkipListFrame.UpdateYourself = true;
end --}}}

function Dcr:ClearSkipList() --{{{
    local i;

    Dcr.db.profile.SkipList = {};
    Dcr.db.profile.SkipListClass = {};
    
    Dcr.Groups_datas_are_invalid = true;
    DecursiveSkipListFrame.UpdateYourself = true;
end --}}}


function Dcr:IsInPriorList (name) --{{{
    for _, PriorName in pairs(Dcr.db.profile.PriorityList) do
	if (PriorName == name) then
	    return true;
	end
    end
    return false;
end --}}}

function Dcr:IsInSkipList (name) --{{{
    for _, SkipName in pairs(Dcr.db.profile.SkipList) do
	if (SkipName == name) then
	    return true;
	end
    end
    return false
end --}}}


-- }}}



function Dcr:PopulateButtonPress() --{{{
    local PopulateFrame = this:GetParent();
    local UppedClass = "";

    if (IsShiftKeyDown() and this.ClassType) then

	-- UnitClass returns uppercased class...
	UppedClass = string.upper(this.ClassType);

	Dcr:Debug("Populate called for %s", this.ClassType);
	-- for the class type stuff... we do party

	local _, pclass = UnitClass("player");
	if (pclass == UppedClass) then
	    PopulateFrame:addFunction("player");
	end

	_, pclass = UnitClass("party1");
	if (pclass == UppedClass) then
	    PopulateFrame:addFunction("party1");
	end
	_, pclass = UnitClass("party2");
	if (pclass == UppedClass) then
	    PopulateFrame:addFunction("party2");
	end
	_, pclass = UnitClass("party3");
	if (pclass == UppedClass) then
	    PopulateFrame:addFunction("party3");
	end
	_, pclass = UnitClass("party4");
	if (pclass == UppedClass) then
	    PopulateFrame:addFunction("party4");
	end
    end

    local i, pgroup, pclass;


    if (IsShiftKeyDown() and this.ClassType) then
	Dcr:Debug("Finding raid units with a macthing class");
	for index, unit in ipairs(Dcr.Status.Unit_Array) do
	    _, pclass = UnitClass(unit);

	    if (pclass == UppedClass) then
		Dcr:Debug("found %s", pclass);
		PopulateFrame:addFunction(unit);
	    end

	end
    elseif (this.ClassType) then
	PopulateFrame:addFunction(DcrC.ClassNameToNum[BC[this.ClassType]]);
    end


    local max = GetNumRaidMembers();

    if (IsShiftKeyDown() and this.GroupNumber and max > 0) then
	Dcr:Debug("Finding raid units with a macthing group number");
	for i = 1, max do
	    _, _, pgroup, _, _, pclass = GetRaidRosterInfo(i);

	    if (pgroup == this.GroupNumber) then
		Dcr:Debug("found %s in group %d", pclass, max);
		PopulateFrame:addFunction("raid"..i);
	    end
	end
    elseif (not IsShiftKeyDown()) then
	PopulateFrame:addFunction(this.GroupNumber);
    end

end --}}}
