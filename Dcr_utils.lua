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

if not DcrLoadedFiles or not DcrLoadedFiles["DCR_init.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (DCR_init.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D = Dcr;
D:SetDateAndRevision("$Date$", "$Revision$");

local L = D.L;
local BS = D.BS;
local BC = D.BC;
local DC = DcrC;

function D:ColorText (text, color) --{{{
    return "|c".. color .. text .. "|r";
end --}}}

function D:RemoveColor (text)
    return string.sub(text, 11, -3);
end

function D:MakePlayerName (name) --{{{
    if not name then name = "NONAME" end
    return "|cFFFFAA22|Hplayer:" .. name .. "|h" .. string.upper(name) .. "|h|r";
end --}}}

function D:PetUnitName (Unit, Check) -- {{{
    local Name = (UnitName(Unit));

    if not Name or Name == DC.UNKNOWN  then
	Name = DC.UNKNOWN .. "_" .. Unit;
	Dcr:Debug("Name of %s is unknown", Unit);
    end

    if not Check or (not UnitIsPlayer(Unit) and Unit ~= "focus") then
	Name =  DC.PET .. " - " .. Name;
    end
    
    return Name;

end -- }}}

function D:MakeAfflictionName (name) --{{{
    if (name) then
	return "|cFFFF6622" .. L[name] .. "|r";
    else
	return "";
    end
end --}}}

function D:Println( ... ) --{{{

    if (D.profile.Print_ChatFrame) then
	D:CustomPrint (1,1,1, D.Status.OutputWindow, D.CONF.TEXT_LIFETIME, " ", ... );
    end
    if (D.profile.Print_CustomFrame) then
	D:CustomPrint (1,1,1, DecursiveTextFrame, D.CONF.TEXT_LIFETIME, " ", ... );
    end
end --}}}

function D:ColorPrint (r,g,b, ... )
    if (D.profile.Print_ChatFrame) then
	D:CustomPrint (r,g,b,D.Status.OutputWindow, D.CONF.TEXT_LIFETIME, " ", ... );
    end
    if (D.profile.Print_CustomFrame) then
	D:CustomPrint (r,g,b, DecursiveTextFrame, D.CONF.TEXT_LIFETIME, " ", ... );
    end
end


function D:tremovebyval(tab, val) -- {{{
    local k;
    local v;
    for k,v in pairs(tab) do
	if(v==val) then
	    table.remove(tab, k);
	    return true;
	end
    end
    return false;
end -- }}}

function D:tcheckforval(tab, val) -- {{{
    local k;
    local v;
    if (tab) then
	for k,v in pairs(tab) do
	    if(v==val) then
		return true;
	    end
	end
    end
    return false;
end -- }}}

-- tcopy: recursively copy contents of one table to another
function D:tcopy(to, from)   -- "to" must be a table (possibly empty)
    if (type(from) ~= "table") then 
	return error(("D:tcopy: bad argument #2 'from' must be a table, got '%s' instead"):format(type(from)),2);
    end

    if (type(to) ~= "table") then 
	return error(("D:tcopy: bad argument #1 'to' must be a table, got '%s' instead"):format(type(to)),2);
    end
    for k,v in pairs(from) do
	if(type(v)=="table") then
	    to[k] = {}; -- this generate garbage
	    D:tcopy(to[k], v);
	else
	    to[k] = v;
	end
    end
end


function D:tGiveValueIndex(tab, val)
    local k;
    local v;
    for k,v in pairs(tab) do
	if(v==val) then
	    return k;
	end
    end
    return false;
end

function D:tSortUsingKeys(tab)
    local SortedTable = {};
    local Keys = {};

    -- store all the keys in a table
    for k,v in pairs(tab) do
	table.insert(Keys, k);
    end

    -- sort the table
    table.sort(Keys);

    -- we now have a sorted table containing the keys
    for pos, k in pairs(Keys) do
	-- insert the values in a new table using the position of each key
	table.insert(SortedTable, pos, tab[k]);
    end

    -- we return a new sorted table with new keys but with the same values
    return SortedTable;
end

function D:tReverse(tab)
    local ReversedTable = {};

    for k,v in pairs(tab) do
	ReversedTable[v] = k;
    end

    return ReversedTable;
end

function D:Pack(...)
    local args = {};
    for i=1,select("#",...), 1 do
	args[i]=select(i, ...);
    end
    return args;
end

function D:MakeProperEnglishClassName (Name)
    local newname = strsub(Name,1,1) .. string.lower(strsub(Name, 2));
    return newname;
end

function D:ThisSetText(text) --{{{
    getglobal(this:GetName().."Text"):SetText(text);
end --}}}

function D:ThisSetParentText(text) --{{{
    getglobal(this:GetParent():GetName().."Text"):SetText(text);
end --}}}

do
local DefaultAnchorTab = {"ANCHOR_LEFT"};
    function D:DisplayTooltip(Message, RelativeTo, AnchorTab) --{{{
	if (not AnchorTab) then
	    AnchorTab = DefaultAnchorTab;
	end
	DcrDisplay_Tooltip:SetOwner(RelativeTo, unpack(AnchorTab));
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetText(Message);
	DcrDisplay_Tooltip:Show();
    end --}}}
end

function D:DisplayGameTooltip(Message) --{{{
    GameTooltip_SetDefaultAnchor(GameTooltip, this);
    GameTooltip:SetText(Message);
    GameTooltip:Show();
end --}}}

function D:errln( ... ) --{{{
    if (D.profile.Print_Error) then
	if (D.profile.Print_ChatFrame) then
	    D:CustomPrint ( 1, 0.1, 0.1,D.Status.OutputWindow, D.CONF.TEXT_LIFETIME, " ", ... );
	end
	if (D.profile.Print_CustomFrame) then
	    D:CustomPrint (1,0.1,0.1, DecursiveTextFrame, D.CONF.TEXT_LIFETIME, " ", ... );
	    -- DecursiveTextFrame:AddMessage(Message, 1, 0.1, 0.1, 0.9);
	end
    end
end --}}}


function D:NumToHexColor(ColorTable)
	return string.format("%02x%02x%02x%02x", ColorTable[4] * 255, ColorTable[1] * 255, ColorTable[2] * 255, ColorTable[3] * 255)
end

-- function taken from http://www.wowwiki.com/SetTexCoord_Transformations
function D:SetCoords(t, A, B, C, D, E, F)
	local det = A*E - B*D;
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
	
	ULx, ULy = ( B*F - C*E ) / det, ( -(A*F) + C*D ) / det;
	LLx, LLy = ( -B + B*F - C*E ) / det, ( A - A*F + C*D ) / det;
	URx, URy = ( E + B*F - C*E ) / det, ( -D - A*F + C*D ) / det;
	LRx, LRy = ( E - B + B*F - C*E ) / det, ( -D + A -(A*F) + C*D ) / det;
	
	t:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

do

    DC.ClassesColors = { };

    function D:GetClassColor (EnglishClass)
	EnglishClass = string.upper(EnglishClass);
	if not DC.ClassesColors[EnglishClass] then
	    if RAID_CLASS_COLORS and RAID_CLASS_COLORS[EnglishClass] then
		DC.ClassesColors[EnglishClass] = { RAID_CLASS_COLORS[EnglishClass].r, RAID_CLASS_COLORS[EnglishClass].g, RAID_CLASS_COLORS[EnglishClass].b };
	    else
		DC.ClassesColors[EnglishClass] = { 0.63, 0.63, 0.63 };
	    end
	    DC.ClassesColors[BC[D:MakeProperEnglishClassName(EnglishClass)]] = DC.ClassesColors[EnglishClass];
	end
	return unpack(DC.ClassesColors[EnglishClass]);
    end

    DC.HexClassColor = { };

    function D:GetClassHexColor(EnglishClass)
	if not DC.HexClassColor[EnglishClass] then
	    local r, g, b = self:GetClassColor(EnglishClass)
	    DC.HexClassColor[EnglishClass] = string.format("%02x%02x%02x", r * 255, g * 255, b * 255);
	    DC.HexClassColor[BC[D:MakeProperEnglishClassName(EnglishClass)]] = DC.HexClassColor[EnglishClass];

	end

	return DC.HexClassColor[EnglishClass];
    end


    function D:CreateClassColorTables ()
    if RAID_CLASS_COLORS then
	local class, colors;
	for class in pairs(RAID_CLASS_COLORS) do
	    D:GetClassHexColor(class);
	    D:GetClassColor(class);
	end
    else
	Dcr:Error("global RAID_CLASS_COLORS does not exist...");
    end
    end

end

DcrLoadedFiles["Dcr_utils.lua"] = true;
