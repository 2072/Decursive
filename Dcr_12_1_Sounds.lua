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
T._LoadedFiles["Dcr_12_1_Sounds.lua"] = not DC.RESTRICTED_AURAS and "@project-version@";

function D:Schedule_MN_SoundsRegistration(delay)
    if DC.RESTRICTED_AURAS then
        D:ScheduleDelayedCall("12.1RegisterSounds", D.Refresh12_1AuraSounds, delay or 1, D)
    end
end


if not DC.RESTRICTED_AURAS or not C_UnitAuras or type(C_UnitAuras.AddAuraSound) ~= "function" then
    return
end

local DoesSpellExist = C_Spell.DoesSpellExist

-- AddAuraSound requires an exact public spell ID (no API to register a sound by type...).
-- Blizzard handles the per unit detection and playback after registration.
local SPELLS_BY_TYPE = {}

if not DC.FOREVER then
    -- These are the actionable dispels in the current (~2026-10-01) 12.1 dungeon rotation and raid. 
    SPELLS_BY_TYPE = {
        [DC.MAGIC] = D:filterSeq({
            1294569, 1217633, 1228198, 1201554, 1235549, 1239860, 1259365,
            1238084, 1249238, 276031, 1294815, 372682, 373589, 1305234,
            381515, 392641, 392924, 268008, 268013, 1296052, 1286922,
            270920, 270499, 373693
        }, DoesSpellExist),
        [DC.POISON] = D:filterSeq({
            1294845, 1305368, 1307571, 474515, 1216590, 1234846, 1250937,
            1226031, 1289258, 1263971, 267273, 271564, 1298104, 1306763,
            263957, 272699, 273563, 1308100, 1308148, 267027,
            1301800, 1306906,
            11918 -- poison from an Elwyn forest spider I use for my tests...
        }, DoesSpellExist),
        [DC.DISEASE] = D:filterSeq({
            1296069, 1302867, 1245456, 267763, 269686,
        }, DoesSpellExist),
        [DC.CURSE] = D:filterSeq({
            1309980, 1310017, 1238255, 1217973, 1238801, 1252095, 269972,
            270492,
        }, DoesSpellExist),
        [DC.BLEED] = D:filterSeq({
            474740, 1216300, 1295035, 1295427, 1311136, 1238439, 1235865,
            1238076, 1241058, 1247746, 1242135, 1237267, 1267894, 1299133,
            1311778, 266191, 266231, 1297781, 1297918, 1301851, 1302945,
            1303490, 372796, 1291399,
        }, DoesSpellExist),
    }
else
    SPELLS_BY_TYPE = {
        [DC.MAGIC] = D:filterSeq({
        }, DoesSpellExist),
        [DC.POISON] = D:filterSeq({
        }, DoesSpellExist),
        [DC.DISEASE] = D:filterSeq({
        }, DoesSpellExist),
        [DC.CURSE] = D:filterSeq({ -- all Curses from Forever as of 2026-11-16 (Thanks to Vinny, the author of the Luna Unit Frames Plus add-on)
            603, 702, 704, 980, 1010, 1014, 1108, 1714, 2943, 3105, 3237, 3360, 3387, 4060,
            4974, 5137, 5271, 5884, 6205, 6217, 6909, 6922, 6946, 7038, 7039, 7040, 7041, 7042,
            7043, 7044, 7045, 7046, 7047, 7048, 7049, 7050, 7051, 7053, 7054, 7057, 7068, 7098,
            7099, 7124, 7289, 7621, 7646, 7658, 7659, 7713, 8066, 8267, 8268, 8277, 8282, 9035,
            10096, 10651, 10653, 11707, 11708, 11711, 11712, 11713, 11717, 11719, 11892, 11960, 11961, 11963,
            11980, 12020, 12255, 12279, 12480, 12493, 12741, 12889, 13338, 13524, 13583, 13619, 14538, 14868,
            14875, 15042, 15470, 15730, 15731, 15802, 16071, 16098, 16231, 16247, 16336, 16429, 16499, 16567,
            16867, 16871, 17105, 17213, 17227, 17484, 17639, 17692, 17738, 17771, 17820, 17831, 18159, 18223,
            18266, 18267, 18502, 18671, 18702, 18948, 19249, 19251, 19252, 19253, 19254, 19281, 19282, 19283,
            19284, 19285, 19372, 19703, 19713, 19716, 19727, 19755, 21007, 21048, 21056, 21058, 21151, 21153,
            21330, 22371, 22687, 23154, 23224, 24054, 24306, 24673, 24674, 25195, 25816, 26977, 28342, 28350,
            28440, 28542, 29213, 402791, 402792, 402794, 411956, 427143, 434841, 437868, 440892, 443964, 443975, 444046,
            446362, 449432, 457326, 460755, 460932, 461232, 461343, 461682, 462178, 462250, 1214956, 1220926, 1221577, 1225228,
            1230206, 1231509, 1231592, 1233077, 1235328, 1244967, 1272973, 1283087, 1283361, 1288462, 1288558, 1289435, 1290950, 1292602,
            1294617, 1294626, 1302039, 1304473, 1305819, 1306983, 1308704, 1308705, 1308707, 1310285, 1311676, 1311677, 1311680, 1316709,
            1325756, 1325757, 1325758,
        }, DoesSpellExist),
        [DC.BLEED] = D:filterSeq({
        }, DoesSpellExist),
    }
end


local allSpells = {}

for k, s in pairs(SPELLS_BY_TYPE) do
    for _, id in ipairs(s) do
        allSpells[id] = k
    end
end


local expectedCount = (
        #SPELLS_BY_TYPE[DC.MAGIC]
        + #SPELLS_BY_TYPE[DC.POISON]
        + #SPELLS_BY_TYPE[DC.DISEASE]
        + #SPELLS_BY_TYPE[DC.CURSE]
        + #SPELLS_BY_TYPE[DC.BLEED]
        )

local actualCount = D:tCount(allSpells)

assert(
    actualCount == expectedCount,
    ("Bad SPELLS_BY_TYPE table (non unique or duplicated ids): expected: %d, found: %d"):format(expectedCount, actualCount)
)

DC.KNOWN_SIDS_to_TYPES = allSpells
DC.KNOWN_SIDS_by_TYPES = SPELLS_BY_TYPE

function D:AddKnownSpellIDToSoundReg(spellID, spellType)
    if not DoesSpellExist(spellID) then
        return
    end

    if spellType == DC.ENEMYMAGIC then
        spellType = DC.MAGIC
    end

    if not SPELLS_BY_TYPE[spellType] then
        D:Debug("AddKnownSpellIDToSoundReg bad usage: unknown type:", spellType)
        return
    end

    if allSpells[spellID] then return end

    allSpells[spellID] = spellType
    SPELLS_BY_TYPE[spellType][#SPELLS_BY_TYPE[spellType] + 1] = spellID

    D:Schedule_MN_SoundsRegistration()
end

function D:RemoveKnownSpellIDFromSoundReg(spellID)
    if not allSpells[spellID] then return end

    local spellType = allSpells[spellID]

    allSpells[spellID] = nil

    for i = #SPELLS_BY_TYPE[spellType], 1, -1 do
        if SPELLS_BY_TYPE[spellType][i] == spellID then
            table.remove(SPELLS_BY_TYPE[spellType], i)
            break
        end
    end

    D:Schedule_MN_SoundsRegistration()
end

local handles = {}

local soundRegCache = setmetatable({}, {
    __mode = "kv",
})

local cacheMissCount = 0

-- sound file id caching mechanism to shorten the registration keys
local nextSoundId = 1
local soundIds = setmetatable({}, {
    __index = function(t, key)
        local id = nextSoundId
        nextSoundId = nextSoundId + 1
        rawset(t, key, id)
        return id
    end
})

local function buildDesiredRegistrations()
    local desired = {}
    cacheMissCount = 0

    if not D.profile or not D.profile.PlaySound or not D.Status or not D.Status.CuringSpells then
        return desired
    end

    D:Debug("|cFF00FF0012.1 aura sounds registered:|r Building registration map...")
    local curingSpells = D.Status.CuringSpells
    local cureOrder = D:GetCureOrderTable() -- key are types, values are positive number when type is enabled, false when not
    local soundFile = D.profile.SoundFile or DC.AfflictionSound

    local soundId = soundIds[soundFile]

    for _, unit in ipairs(D.Status.Unit_Array) do
        for debuffType, spellIDs in pairs(SPELLS_BY_TYPE) do
            local typePrioEnabledWithSpell = cureOrder[debuffType] and curingSpells[debuffType]

            if typePrioEnabledWithSpell then
                for _, spellID in ipairs(spellIDs) do
                    local key = unit .. ":" .. spellID .. ":" .. soundId
                    if not soundRegCache[key] then
                        soundRegCache[key] = {
                            unitToken = unit,
                            spellID = spellID,
                            soundFileName = soundFile,
                            outputChannel = "Master",
                        }
                        cacheMissCount = cacheMissCount + 1
                    end
                    desired[key] = soundRegCache[key]
                end
            end
        end
    end
    D:Debug("|cFF00FF0012.1 aura sounds registered:|r Done building registration map.")

    return desired
end

function D:Refresh12_1AuraSounds()
    if D:AurasRestricted() then
        D:Debug("|cFFFF0000Sound registration not possible while auras are restricted... rescheduling in 5s|r")
        D:Schedule_MN_SoundsRegistration(5)
        return false
    end

    local desired = buildDesiredRegistrations()
    local trigger = Enum.UnitAuraSoundTrigger and Enum.UnitAuraSoundTrigger.Added or 0
    local addedCount = 0
    local removedCount = 0
    local errorCount = 0


    D:Debug("|cFF00FF0012.1 aura sounds registered:|r Updating registrations...")

    -- Add replacements first so a failed refresh never removes the last
    -- working registration.
    for key, soundInfo in pairs(desired) do
        if not handles[key] then
            local ok, handle = pcall(C_UnitAuras.AddAuraSound, trigger, soundInfo)
            if ok and handle then
                handles[key] = handle
                addedCount = addedCount + 1
            else
                errorCount = errorCount + 1
            end
        end
    end

    for key, handle in pairs(handles) do
        if not desired[key] then
            local ok = pcall(C_UnitAuras.RemoveAuraSound, handle)
            if ok then
                handles[key] = nil
                removedCount = removedCount + 1
            else
                errorCount = errorCount + 1
            end
        end
    end

    local handleCount = 0
    for _ in pairs(handles) do
        handleCount = handleCount + 1
    end
    D:Debug("|cFF00FF0012.1 aura sounds registered:|r", handleCount, ", Added:", addedCount, ", Removed:", removedCount, ", CacheMiss:", cacheMissCount, ", Errors:", errorCount)
    return true
end


T._LoadedFiles["Dcr_12_1_Sounds.lua"] = "@project-version@";
