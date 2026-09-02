--[[
    This file is part of Decursive.

    Decursive add-on for World of Warcraft UI
    Copyright (C) 2006-2026 John Wellesz

    WoW 12.1 current-season dispel spell classifications are based on the
    GPLv3 DispelDB from Zhaohu's Decursive, Copyright (C) 2026 Randy Lorfing.

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
--]]

local addonName, T = ...
local D = T.Dcr
local DC = T._C

-- big ugly scary fatal error message display function {{{
if not T._FatalError then
    -- the beautiful error popup : {{{ -
    StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
        text = "|cFFFF0000Decursive Error:|r\n%s",
        button1 = "OK",
        OnAccept = function()
            return false;
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1,
        showAlert = 1,
        preferredIndex = 3,
    }; -- }}}
    T._FatalError = function (TheError) T._StaticPopupDialogsWasShown = true; StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}

if not T._LoadedFiles or not T._LoadedFiles["Dcr_DebuffsFrame.xml"] or not T._LoadedFiles["Dcr_DebuffsFrame.lua"] then -- XML are loaded even if LUA syntax errors exixts
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (Dcr_DebuffsFrame.xml or Dcr_DebuffsFrame.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["Dcr_12_1_Sounds.lua"] = not DC.MN and "@project-version@";


if not DC.TWELVE_ONE or not C_UnitAuras or type(C_UnitAuras.AddAuraSound) ~= "function" then
    return
end

-- AddAuraSound requires an exact public spell ID. These are the friendly,
-- actionable dispels in the current 12.1 dungeon rotation and raid. Blizzard
-- owns detection and playback after registration; addon Lua never reads the
-- protected aura or its AuraButton state.
local SPELLS_BY_TYPE = {
    [DC.MAGIC] = {
        1294569, 1217633, 1228198, 1201554, 1235549, 1239860, 1259365,
        1238084, 1249238, 276031, 1294815, 372682, 373589, 1305234,
        381515, 392641, 392924, 268008, 268013, 1296052, 1286922,
        270920, 270499,
    },
    [DC.POISON] = {
        1294845, 1305368, 1307571, 474515, 1216590, 1234846, 1250937,
        1226031, 1289258, 1263971, 267273, 271564, 1298104, 1306763,
        263957, 272699, 273563, 1308100, 1308148, 267027, 1303486,
        1308546, 1301800, 1306906,
    },
    [DC.DISEASE] = {
        1296069, 1302867, 1245456, 267763, 269686,
    },
    [DC.CURSE] = {
        1309980, 1310017, 1238255, 1217973, 1238801, 1252095, 269972,
        270492,
    },
    [DC.BLEED] = {
        474740, 1216300, 1295035, 1295427, 1311136, 1238439, 1235865,
        1238076, 1241058, 1247746, 1242135, 1237267, 1267894, 1299133,
        1311778, 266191, 266231, 1297781, 1297918, 1301851, 1302945,
        1303490, 372796, 1291399,
    },
}

local handles = {}
local refreshPending = false
local refreshScheduled = false

local function registrationBlocked()
    return InCombatLockdown() or (GetCVarBool and GetCVarBool("secretAurasForced"))
end

local function getUnitTokens()
    local units = { "player" }

    if IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            units[#units + 1] = "raid" .. i
        end
    else
        -- Pre-arm stable party tokens even while solo. A dungeon can enable
        -- aura restrictions before a later roster refresh is allowed to add
        -- registrations.
        for i = 1, 4 do
            units[#units + 1] = "party" .. i
        end
    end

    return units
end

local function buildDesiredRegistrations()
    local desired = {}

    if not D.profile or not D.profile.PlaySound or not D.Status or not D.Status.CuringSpells then
        return desired
    end

    local soundFile = D.profile.SoundFile or DC.AfflictionSound
    for _, unit in ipairs(getUnitTokens()) do
        for debuffType, spellIDs in pairs(SPELLS_BY_TYPE) do
            if D.Status.CuringSpells[debuffType] then
                for _, spellID in ipairs(spellIDs) do
                    local key = unit .. ":" .. spellID .. ":" .. soundFile
                    desired[key] = {
                        unitToken = unit,
                        spellID = spellID,
                        soundFileName = soundFile,
                        outputChannel = "Master",
                    }
                end
            end
        end
    end

    return desired
end

function D:Refresh12_1AuraSounds()
    if registrationBlocked() then
        refreshPending = true
        return false
    end

    refreshPending = false
    local desired = buildDesiredRegistrations()
    local trigger = Enum.UnitAuraSoundTrigger and Enum.UnitAuraSoundTrigger.Added or 0

    -- Add replacements first so a failed refresh never removes the last
    -- working registration.
    for key, soundInfo in pairs(desired) do
        if not handles[key] then
            local ok, handle = pcall(C_UnitAuras.AddAuraSound, trigger, soundInfo)
            if ok and handle then
                handles[key] = handle
            end
        end
    end

    for key, handle in pairs(handles) do
        if not desired[key] then
            local ok = pcall(C_UnitAuras.RemoveAuraSound, handle)
            if ok then
                handles[key] = nil
            end
        end
    end

    local handleCount = 0
    for _ in pairs(handles) do
        handleCount = handleCount + 1
    end
    D:Debug("12.1 aura sounds registered:", handleCount)
    return true
end

local function scheduleRefresh(delay)
    if refreshScheduled then
        refreshPending = true
        return
    end

    refreshScheduled = true
    C_Timer.After(delay or 0, function()
        refreshScheduled = false
        if not D.DcrFullyInitialized then
            scheduleRefresh(1)
            return
        end
        D:Refresh12_1AuraSounds()
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
eventFrame:RegisterEvent("SPELLS_CHANGED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_ENABLED" and not refreshPending then
        return
    end

    scheduleRefresh(event == "PLAYER_ENTERING_WORLD" and 1 or 0)
end)

T._LoadedFiles["Dcr_12_1_Sounds.lua"] = "@project-version@";
