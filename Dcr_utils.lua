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
local BS = Dcr.BS;

function Dcr:ColorText (text, color) --{{{
    return "|c".. color .. text .. "|r";
end --}}}

function Dcr:MakePlayerName (name) --{{{
    if not name then name = "NONAME" end
    return "|cFFFFAA22|Hplayer:" .. name .. "|h" .. string.upper(name) .. "|h|r";
end --}}}

function Dcr:MakeAfflictionName (name) --{{{
    if (name) then
	return "|cFFFF6622" .. L[name] .. "|r";
    else
	return "";
    end
end --}}}

function Dcr:Println( ... ) --{{{

    if (Dcr.db.profile.Print_ChatFrame) then
	Dcr:CustomPrint (1,1,1, Dcr.Status.OutputWindow, Dcr.CONF.TEXT_LIFETIME, " ", ... );
    end
    if (Dcr.db.profile.Print_CustomFrame) then
	Dcr:CustomPrint (1,1,1, DecursiveTextFrame, Dcr.CONF.TEXT_LIFETIME, " ", ... );
    end
end --}}}

function Dcr:ColorPrint (r,g,b, ... )
    if (Dcr.db.profile.Print_ChatFrame) then
	Dcr:CustomPrint (r,g,b,Dcr.Status.OutputWindow, Dcr.CONF.TEXT_LIFETIME, " ", ... );
    end
    if (Dcr.db.profile.Print_CustomFrame) then
	Dcr:CustomPrint (r,g,b, DecursiveTextFrame, Dcr.CONF.TEXT_LIFETIME, " ", ... );
    end
end


function Dcr:tremovebyval(tab, val) -- {{{
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

function Dcr:tcheckforval(tab, val) -- {{{
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
function Dcr:tcopy(to, from)   -- "to" must be a table (possibly empty)
    if (type(from) ~= "table") then 
	return error(("Dcr:tcopy: bad argument #2 'from' must be a table, got '%s' instead"):format(type(from)),2);
    end

    if (type(to) ~= "table") then 
	return error(("Dcr:tcopy: bad argument #1 'to' must be a table, got '%s' instead"):format(type(to)),2);
    end

    for k,v in pairs(from) do
	if(type(v)=="table") then
	    to[k] = {}
	    Dcr:tcopy(to[k], v);
	else
	    to[k] = v;
	end
    end
end


function Dcr:tGiveValueIndex(tab, val)
    local k;
    local v;
    for k,v in pairs(tab) do
	if(v==val) then
	    return k;
	end
    end
    return false;
end

function Dcr:tSortUsingKeys(tab)
    local SortedTable = {};
    local Keys = {};

    for k,v in pairs(tab) do
	table.insert(Keys, k);
    end

    table.sort(Keys);

    for pos, k in pairs(Keys) do
	table.insert(SortedTable, pos, tab[k]);
    end

    return SortedTable;
end

function Dcr:tReverse(tab)
    local ReversedTable = {};

    for k,v in pairs(tab) do
	ReversedTable[v] = k;
    end

    return ReversedTable;
end

function Dcr:Pack(...)
    local args = {};
    for i=1,select("#",...), 1 do
	args[i]=select(i, ...);
    end
    return args;
end

function Dcr:MakeProperEnglishClassName (Name)
    local newname = strsub(Name,1,1) .. string.lower(strsub(Name, 2));
    return newname;
end

function Dcr:ThisSetText(text) --{{{
    getglobal(this:GetName().."Text"):SetText(text);
end --}}}

function Dcr:ThisSetParentText(text) --{{{
    getglobal(this:GetParent():GetName().."Text"):SetText(text);
end --}}}

do
local DefaultAnchorTab = {"ANCHOR_LEFT"};
    function Dcr:DisplayTooltip(Message, RelativeTo, AnchorTab) --{{{
	if (not AnchorTab) then
	    AnchorTab = DefaultAnchorTab;
	end
	DcrDisplay_Tooltip:SetOwner(RelativeTo, unpack(AnchorTab));
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetText(Message);
	DcrDisplay_Tooltip:Show();
    end --}}}
end

function Dcr:DisplayGameTooltip(Message) --{{{
    GameTooltip_SetDefaultAnchor(GameTooltip, this);
    GameTooltip:SetText(Message);
    GameTooltip:Show();
end --}}}

function Dcr:errln( ... ) --{{{
    if (Dcr.db.profile.Print_Error) then
	if (Dcr.db.profile.Print_ChatFrame) then
	    Dcr:CustomPrint ( 1, 0.1, 0.1,Dcr.Status.OutputWindow, Dcr.CONF.TEXT_LIFETIME, " ", ... );
	end
	if (Dcr.db.profile.Print_CustomFrame) then
	    Dcr:CustomPrint (1,0.1,0.1, DecursiveTextFrame, Dcr.CONF.TEXT_LIFETIME, " ", ... );
	    -- DecursiveTextFrame:AddMessage(Message, 1, 0.1, 0.1, 0.9);
	end
    end
end --}}}


function Dcr:NumToHexColor(ColorTable)
	return string.format("%02x%02x%02x%02x", ColorTable[4] * 255, ColorTable[1] * 255, ColorTable[2] * 255, ColorTable[3] * 255)
end


