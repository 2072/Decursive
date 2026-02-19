--[[
    This file is part of Decursive.

    Decursive (v @project-version@) add-on for World of Warcraft UI
    Copyright (C) 2006-2025 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY.

    This file was last updated on @file-date-iso@
--]]

local addonName, T = ...;
if not T._LoadedFiles or not T._LoadedFiles["DCR_init.lua"] then
    if not DecursiveInstallCorrupted then error("Decursive installation is corrupted! (DCR_init.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["Dcr_Cache.lua"] = false;

local D = T.Dcr;
local _G = _G;
local pairs = _G.pairs;
local UnitExists = _G.UnitExists;
local UnitGUID = _G.UnitGUID;
local time = _G.time;

DCR_Cache = {};
local ByGUID = {};

function DCR_Cache:Init()
    ByGUID = {};
end

function DCR_Cache:Store(unit, data)
    if not unit or not data then return end
    local guid = UnitGUID(unit);
    if guid and not guid:match("^secret") then
        local now = time();
        ByGUID[guid] = {
            guid = guid,
            unit = unit,
            name = data.name,
            class = data.class,
            role = data.role,
            timestamp = now,
            spell_ids = data.spell_ids or {},
        };
    end
end

function DCR_Cache:Get(guid)
    return ByGUID[guid];
end

function DCR_Cache:Clear()
    for guid in pairs(ByGUID) do
        ByGUID[guid] = nil;
    end
end

function DCR_Cache:InvalidateAll()
    self:Clear();
end

function DCR_Cache:RefreshFromUnitArray()
    local unit_array = D.Status.Unit_Array;
    if not unit_array then return 0 end
    local refreshed = 0;
    local now = time();
    for i = 1, #unit_array do
        local unit = unit_array[i];
        if UnitExists(unit) then
            local guid = UnitGUID(unit);
            if guid and ByGUID[guid] then
                ByGUID[guid].unit = unit;
                ByGUID[guid].timestamp = now;
                refreshed = refreshed + 1;
            end
        end
    end
    return refreshed;
end

D.DcrCache = DCR_Cache;
T._LoadedFiles["Dcr_Cache.lua"] = true;
