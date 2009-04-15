--[[
    This file is part of Decursive.
    
    Decursive (v @project-version@) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <http://www.gnu.org/licenses/>.
--]]
-------------------------------------------------------------------------------

if not DcrLoadedFiles or not DcrLoadedFiles["DCR_init.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (DCR_init.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-09-16 00:48:59 +0200 (mar., 16 sept. 2008) $", "$Revision: 81756 $");

local L = D.L;
local BC = D.BC;
local DC = DcrC;
local DS = DC.DS;

local pairs		= _G.pairs;
local ipairs		= _G.ipairs;
local type		= _G.type;
local unpack		= _G.unpack;
local select		= _G.select;
local str_sub		= _G.string.sub;
local str_upper		= _G.string.upper;
local str_lower		= _G.string.lower;
local str_format	= _G.string.format;
local table		= _G.table;
local t_remove		= _G.table.remove;
local t_insert		= _G.table.insert;
local UnitName		= _G.UnitName;
local UnitIsPlayer	= _G.UnitIsPlayer;
local string		= _G.string;
local tonumber		= _G.tonumber;
local UnitGUID		= _G.UnitGUID;
local band		= _G.bit.band;


function D:ColorText (text, color) --{{{
    return "|c".. color .. text .. "|r";
end --}}}

function D:RemoveColor (text)
    return str_sub(text, 11, -3);
end

function D:MakePlayerName (name) --{{{
    if not name then name = "NONAME" end
    return "|cFFFFAA22|Hplayer:" .. name .. "|h" .. str_upper(name) .. "|h|r";
end --}}}

function D:UnitIsPet (Unit)
    local GUID = UnitGUID(Unit);

    if not GUID then return end

    if band(tonumber(GUID:sub(0,5), 16), 0x00f)==0x004 then
	return true;
    end
    return false;

end

function D:PetUnitName (Unit, Check) -- {{{
    local Name = (self:UnitName(Unit));

    if not Name or Name == DC.UNKNOWN  then
	Name = DC.UNKNOWN .. "-" .. Unit;
	D:Debug("PetUnitName(): Name of %s is unknown", Unit);
    end

    if not Check or (self:UnitIsPet(Unit)) then
	Name =  ("%s-%s"):format (DC.PET,Name);
    end
    
    return Name;

end -- }}}

function D:UnitName(Unit)
    local name, server = UnitName(Unit);
	if ( server and server ~= "" ) then
	    return name.."-"..server;
	else
	    return name;
	end 
end

--[=[
function D:MakeAfflictionName (name) --{{{
    if (name) then
	return "|cFFFF6622" .. L[name] .. "|r";
    else
	return "";
    end
end --}}}
--]=]

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
	    t_remove(tab, k);
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
	t_insert(Keys, k);
    end

    -- sort the table
    table.sort(Keys);

    -- we now have a sorted table containing the keys
    for pos, k in pairs(Keys) do
	-- insert the values in a new table using the position of each key
	t_insert(SortedTable, pos, tab[k]);
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
    local newname = str_sub(Name,1,1) .. str_lower(str_sub(Name, 2));
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
	return str_format("%02x%02x%02x%02x", ColorTable[4] * 255, ColorTable[1] * 255, ColorTable[2] * 255, ColorTable[3] * 255)
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
	EnglishClass = str_upper(EnglishClass);
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
	    DC.HexClassColor[EnglishClass] = str_format("%02x%02x%02x", r * 255, g * 255, b * 255);
	    DC.HexClassColor[BC[D:MakeProperEnglishClassName(EnglishClass)]] = DC.HexClassColor[EnglishClass];

	end

	return DC.HexClassColor[EnglishClass];
    end


    function D:CreateClassColorTables ()
	if RAID_CLASS_COLORS then
	    local class, colors;
	    for class in pairs(RAID_CLASS_COLORS) do
		if not class:find(" ") then -- thank to a wonderful add-on that adds the wrong translation "Death Knight" to the global RAID_CLASS_COLORS....
		    D:GetClassHexColor(class);
		    D:GetClassColor(class);
		else
		    RAID_CLASS_COLORS[class] = nil; -- Eat that!
		end
	    end
	else
	    D:Error("global RAID_CLASS_COLORS does not exist...");
	end
    end

end

DcrLoadedFiles["Dcr_utils.lua"] = "@project-version@";
