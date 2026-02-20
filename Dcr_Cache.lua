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
local ByUnitToken = {}; -- WoW 12.0.0: Fallback index for secret GUID support
local CACHE_TTL_SECONDS = 60; -- Reduced from 300 for combat responsiveness (P1-2)

local function ValidateData(data)
    if type(data) ~= "table" then return false end
    if type(data.spell_ids) ~= "table" then return false end
    if not data.name or type(data.name) ~= "string" then return false end
    if not data.class or type(data.class) ~= "string" then return false end
    return true;
end

function DCR_Cache:Init()
    ByGUID = {};
end

function DCR_Cache:Store(unit, data)
    if not unit or not data then return false end
    
    local guid = UnitGUID(unit);
    if not guid then return false end
    
    if not ValidateData(data) then return false end
    
    local now = time();
    
    -- Store in GUID index (only for non-secret GUIDs)
    if not guid:match("^secret") then
        ByGUID[guid] = {
            guid = guid,
            unit = unit,
            name = data.name,
            class = data.class,
            role = data.role,
            timestamp = now,
            spell_ids = data.spell_ids,
        };
    end
    
    -- WoW 12.0.0: Always store in unitToken index as fallback for secret GUIDs
    ByUnitToken[unit] = {
        guid = guid,
        unit = unit,
        name = data.name,
        class = data.class,
        role = data.role,
        timestamp = now,
        spell_ids = data.spell_ids,
    };
    
    return true;
end

function DCR_Cache:Get(guid, unitToken)
    if not guid then return nil end
    
    local cached;
    
    -- First try GUID lookup (for non-secret GUIDs)
    if not guid:match("^secret") then
        cached = ByGUID[guid];
    end
    
    -- WoW 12.0.0: Fallback to unitToken lookup if GUID secret or not found
    if not cached and unitToken then
        cached = ByUnitToken[unitToken];
    end
    
    if not cached then return nil end
    
    if not ValidateData(cached) then
        -- Cleanup both indexes
        if cached.guid and not cached.guid:match("^secret") then
            ByGUID[cached.guid] = nil;
        end
        if cached.unit and ByUnitToken[cached.unit] and ByUnitToken[cached.unit] == cached then
            ByUnitToken[cached.unit] = nil;
        end
        return nil;
    end
    
    local now = time();
    if now - (cached.timestamp or 0) > CACHE_TTL_SECONDS then
        -- Expired: cleanup both indexes
        if cached.guid and not cached.guid:match("^secret") then
            ByGUID[cached.guid] = nil;
        end
        if cached.unit and ByUnitToken[cached.unit] and ByUnitToken[cached.unit] == cached then
            ByUnitToken[cached.unit] = nil;
        end
        return nil;
    end
    
    return cached;
end

function DCR_Cache:Clear()
    for guid in pairs(ByGUID) do
        ByGUID[guid] = nil;
    end
    ByGUID = {};
    
    -- WoW 12.0.0: Clear unitToken index
    for token in pairs(ByUnitToken) do
        ByUnitToken[token] = nil;
    end
    ByUnitToken = {};
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
                if ValidateData(ByGUID[guid]) then
                    ByGUID[guid].unit = unit;
                    ByGUID[guid].timestamp = now;
                    refreshed = refreshed + 1;
                else
                    ByGUID[guid] = nil;
                end
            end
        end
    end
    return refreshed;
end

D.DcrCache = DCR_Cache;
T._LoadedFiles["Dcr_Cache.lua"] = true;
