--[[
    This file is part of Decursive.
    
    Decursive (v @project-version@) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009-2010-2011 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/to/decursive.php )

    Starting from 2009-10-31 and until said otherwise by its author, Decursive
    is no longer free software, all rights are reserved to its author (John Wellesz).

    The only official and allowed distribution means are www.2072productions.com, www.wowace.com and curse.com.
    To distribute Decursive through other means a special authorization is required.
    

    Decursive is inspired from the original "Decursive v1.9.4" by Quu.
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY.

    This file was last updated on @file-date-iso@
--]]
-------------------------------------------------------------------------------

local addonName, T = ...;
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
    T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

T.Dcr         = LibStub("AceAddon-3.0"):NewAddon("Decursive", "AceConsole-3.0", "AceEvent-3.0", "LibShefkiTimer-1.0", "AceHook-3.0");
--@debug@
--Dcr = T.Dcr; -- needed until we get rid of the xml based UI.
--@end-debug@

local D = T.Dcr;

D.name = "Decursive";
D.version = "@project-version@";
D.author = "John Wellesz";

D.L         = LibStub("AceLocale-3.0"):GetLocale("Decursive", true);

D.LC        = _G.LOCALIZED_CLASS_NAMES_MALE;

if not D.LC then
    T._AddDebugText("DCR_init.lua: Couldn't get LOCALIZED_CLASS_NAMES_MALE!");
    D.LC = {};
end

D.DcrFullyInitialized = false;

local L = D.L;
local LC = D.LC;

local BOOKTYPE_PET      = BOOKTYPE_PET;
local BOOKTYPE_SPELL    = BOOKTYPE_SPELL;




local select            = _G.select;
local pairs             = _G.pairs;
local ipairs            = _G.ipairs;
local next              = _G.next;
local InCombatLockdown  = _G.InCombatLockdown;
local GetTalentInfo     = _G.GetTalentInfo;
local UnitClass         = _G.UnitClass;



-------------------------------------------------------------------------------
-- variables {{{
-------------------------------------------------------------------------------
D.Groups_datas_are_invalid = true;
-------------------------------------------------------------------------------
-- Internal HARD settings for Decursive
D.CONF = {};
D.CONF.TEXT_LIFETIME = 4.0;
D.CONF.MAX_LIVE_SLOTS = 10;
D.CONF.MACRONAME = "Decursive";
D.CONF.MACROCOMMAND = string.format("MACRO %s", D.CONF.MACRONAME);

BINDING_HEADER_DECURSIVE = "Decursive";


-- CONSTANTS

local DC = T._C;

DC.DS = {};

local DS = DC.DS;

DC.AfflictionSound = "Interface\\AddOns\\Decursive\\Sounds\\AfflictionAlert.ogg";
DC.FailedSound = "Interface\\AddOns\\Decursive\\Sounds\\FailedSpell.ogg";
--DC.AfflictionSound = "Sound\\Doodad\\BellTollTribal.wav"

DC.IconON = "Interface\\AddOns\\Decursive\\iconON.tga";
DC.IconOFF = "Interface\\AddOns\\Decursive\\iconOFF.tga";

DC.CLASS_DRUID       = 'DRUID';
DC.CLASS_HUNTER      = 'HUNTER';
DC.CLASS_MAGE        = 'MAGE';
DC.CLASS_PALADIN     = 'PALADIN';
DC.CLASS_PRIEST      = 'PRIEST';
DC.CLASS_ROGUE       = 'ROGUE';
DC.CLASS_SHAMAN      = 'SHAMAN';
DC.CLASS_WARLOCK     = 'WARLOCK';
DC.CLASS_WARRIOR     = 'WARRIOR';
DC.CLASS_DEATHKNIGHT = 'DEATHKNIGHT';
DC.CLASS_MONK        = 'MONK';

DC.MyClass = "NOCLASS";
DC.MyName = "NONAME";
DC.MyGUID = "NONE";

DC.MAGIC        = 1;
DC.ENEMYMAGIC   = 2;
DC.CURSE        = 4;
DC.POISON       = 8;
DC.DISEASE      = 16;
DC.CHARMED      = 32;
DC.NOTYPE       = 64;


DC.NORMAL                   = 8;
DC.ABSENT                   = 16;
DC.FAR                      = 32;
DC.STEALTHED                = 64;
DC.BLACKLISTED              = 128;
DC.AFFLICTED                = 256;
DC.AFFLICTED_NIR            = 512;
DC.CHARMED_STATUS           = 1024;
DC.AFFLICTED_AND_CHARMED = bit.bor(DC.AFFLICTED, DC.CHARMED_STATUS);

DC.MFSIZE = 20;

-- This value is returned by UnitName when the name of a unit is not available yet
DC.UNKNOWN = UNKNOWNOBJECT;

-- Get the translation for "pet"
DC.PET = SPELL_TARGET_TYPE8_DESC;

DC.DebuffHistoryLength = 40; -- we use a rather high value to avoid garbage creation

DC.DevVersionExpired = false;

-- Create MUFs number fontinstance
DC.NumberFontFileName = _G.NumberFont_Shadow_Small:GetFont();

DC.RAID_ICON_LIST = _G.ICON_LIST;
if not DC.RAID_ICON_LIST then
    T._AddDebugText("DCR_init.lua: Couldn't get Raid Target Icon List!");
    DC.RAID_ICON_LIST = {};
end

DC.RAID_ICON_TEXTURE_LIST = {};

for i,v in ipairs(DC.RAID_ICON_LIST) do
    DC.RAID_ICON_TEXTURE_LIST[i] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. i;
end



D.DebuffHistory = {};

D.MFContainer = false;
D.LLContainer = false;

D.profile = {};
D.classprofile = {};

D.Status = {};

D.Status.CuringSpells = {};
D.Status.CuringSpellsPrio = {};
D.Status.DelayedFunctionCalls = {};
D.Status.DelayedFunctionCallsCount = 0;

D.Status.Blacklisted_Array = {};
D.Status.UnitNum = 0;

D.Status.PrioChanged = true;

D.Status.last_focus_GUID = false;
D.Status.UpdateCooldown = 0;

D.Status.GroupUpdatedOn = 0;
D.Status.GroupUpdateEvent = 0;

D.Status.TestLayout = false;
D.Status.TestLayoutUNum = 25;

-- An acces the debuff table
D.ManagedDebuffUnitCache = {};
-- A table UnitID=>IsDebuffed (boolean)
D.UnitDebuffed = {};

-- // }}}
-------------------------------------------------------------------------------


-- D.Initialized = false;
-------------------------------------------------------------------------------

-- add support for FuBar
D.independentProfile    = true; -- for Fubar
D.hasIcon               = DC.IconOFF;
D.hasNoColor            = true;
D.overrideMenu          = true;
D.defaultMinimapPosition = 250;
D.hideWithoutStandby    = true;
D.defaultPosition       = "LEFT";
D.hideMenuTitle         = true;

function D:AddDebugText(a1, ...)
    T._AddDebugText(a1, ...);
end

function D:VersionWarnings()

    local alpha = false;
    local fromCheckOut = false;
    --@alpha@
    alpha = true;
    --@end-alpha@

    if (("@project-version@"):lower()):find("beta") or ("@project-version@"):find("RC") or ("@project-version@"):find("Candidate") or alpha then

        D.RunningADevVersion = true;

        -- check for expiration of this dev version
        if D.VersionTimeStamp ~= 0 then

            local VersionLifeTime  = 3600 * 24 * 30; -- 30 days

            if time() > D.VersionTimeStamp + VersionLifeTime then
                DC.DevVersionExpired = true;
                -- Display the expiration notice only once evry 48 hours
                if time() - self.db.global.LastExpirationAlert > 48 * 3600  then
                    StaticPopup_Show ("Decursive_Notice_Frame", "|cff00ff00Decursive version: @project-version@|r\n\n" .. "|cFFFFAA66" .. L["DEV_VERSION_EXPIRED"] .. "|r");

                    self.db.global.LastExpirationAlert = time();
                end

                return;
            end

        end

        if self.db.global.NonRealease ~= "@project-version@" then
            self.db.global.NonRealease = "@project-version@";
            StaticPopup_Show ("Decursive_Notice_Frame", "|cff00ff00Decursive version: @project-version@|r\n\n" .. "|cFFFFAA66" .. L["DEV_VERSION_ALERT"] .. "|r");
        end
    end

    --@debug@
    fromCheckOut = true;
    if time() - self.db.global.LastChekOutAlert > 24 * 3600  then
        StaticPopup_Show ("Decursive_Notice_Frame", "|cff00ff00Decursive version: @project-version@|r\n\n" .. "|cFFFFAA66" .. 
        [[
        |cFFFF0000You're using an unpackaged version of Decursive.|r
        Decursive is not meant to be used this way.
        Annoying and invasive debugging messages will be displayed.
        More resources (memory and CPU) will be used due to debug routines and sanity test code being executed.
        Localisation is not working and English text may be wrong.

        Using Decursive in this state will bring you nothing but troubles.

        |cFF00FF00Alpha versions of Decursive are automatically packaged. You should use those instead.|r

        ]]
        .. "|r");

        self.db.global.LastChekOutAlert = time();
    end
    --@end-debug@

    -- re-enable new version pop-up alerts when a newer version is installed
    if D.db.global.NewVersionsBugMeNot and D.db.global.NewVersionsBugMeNot < D.VersionTimeStamp then
        D.db.global.NewVersionsBugMeNot = false;
    end


    -- Prevent time travelers from blocking the system
    if D.db.global.NewerVersionDetected > time() then
        D.db.global.NewerVersionDetected = D.VersionTimeStamp;
        D.db.global.NewerVersionName = false;
        D.db.global.NewerVersionAlert = 0;
        D:Debug("|cFFFF0000TIME TRAVELER DETECTED!|r");
    end

    -- if not fromCheckOut then -- this version is properly packaged
    if D.db.global.NewerVersionName then -- a new version was detected some time ago
        if D.db.global.NewerVersionDetected > D.VersionTimeStamp and D.db.global.NewerVersionName ~= D.version then -- it's still newer than this one
            if time() - D.db.global.NewerVersionAlert > 3600 * 24 * 4 then -- it's been more than 4 days since the new version alert was shown
                if not D.db.global.NewVersionsBugMeNot then -- the user did not disable new version alerts
                    StaticPopup_Show ("Decursive_Notice_Frame", "|cff55ff55Decursive version: @project-version@|r\n\n" .. "|cFF55FFFF" .. (L["NEW_VERSION_ALERT"]):format(D.db.global.NewerVersionName or "none", date("%Y-%m-%d", D.db.global.NewerVersionDetected)) .. "|r");
                    D.db.global.NewerVersionAlert = time();
                end
            end
        else
            D.db.global.NewerVersionDetected = D.VersionTimeStamp;
            D.db.global.NewerVersionName = false;
        end
    end
--    end

end


function D:OnInitialize() -- Called on ADDON_LOADED -- {{{

    if T._SelfDiagnostic() == 2 then
        return false;
    end

    T._HookErrorHandler();
    T._CatchAllErrors = true; -- During init we catch all the errors else, if a library fails we won't know it.

    D:LocalizeBindings ();
    D.defaults = D:GetDefaultsSettings();

    self.db = LibStub("AceDB-3.0"):New("DecursiveDB", D.defaults, true);

    self.db.RegisterCallback(self, "OnProfileChanged", "SetConfiguration")
    self.db.RegisterCallback(self, "OnProfileCopied", "SetConfiguration")
    self.db.RegisterCallback(self, "OnProfileReset", "SetConfiguration")

    
    -- Register slashes command {{{
    self:RegisterChatCommand("dcrdiag"      ,function() T._SelfDiagnostic(true, true)               end         );
    self:RegisterChatCommand("decursive"    ,function() LibStub("AceConfigDialog-3.0"):Open(D.name) end         );
    self:RegisterChatCommand("dcrpradd"     ,function() D:AddTargetToPriorityList()                 end, false  );
    self:RegisterChatCommand("dcrprclear"   ,function() D:ClearPriorityList()                       end, false  );
    self:RegisterChatCommand("dcrprshow"    ,function() D:ShowHidePriorityListUI()                  end, false  );
    self:RegisterChatCommand("dcrskadd"     ,function() D:AddTargetToSkipList()                     end, false  );
    self:RegisterChatCommand("dcrskclear"   ,function() D:ClearSkipList()                           end, false  );
    self:RegisterChatCommand("dcrskshow"    ,function() D:ShowHideSkipListUI()                      end, false  );
    self:RegisterChatCommand("dcrreset"     ,function() D:ResetWindow()                             end, false  );
    self:RegisterChatCommand("dcrshow"      ,function() D:HideBar(0)                                end, false  );
    self:RegisterChatCommand("dcrhide"      ,function() D:HideBar(1)                                end, false  );
    self:RegisterChatCommand("dcrshoworder" ,function() D:Show_Cure_Order()                         end, false  );
    self:RegisterChatCommand("dcrreport"    ,function() D:ShowDebugReport()                         end, false  );
    -- }}}

    -- Create some useful cache tables
    D:CreateClassColorTables();


    D.MFContainer = DcrMUFsContainer;
    D.MFContainerHandle = DcrMUFsContainerDragButton;
    D.MicroUnitF.Frame = D.MFContainer;


    D.LLContainer = DcrLiveList;
    D.LiveList.Frame = DcrLiveList;


    DC.TypeNames = {
        [DC.MAGIC]      = "Magic",
        [DC.ENEMYMAGIC] = "Magic",
        [DC.CURSE]      = "Curse",
        [DC.POISON]     = "Poison",
        [DC.DISEASE]    = "Disease",
        [DC.CHARMED]    = "Charm",
    }

    DC.NameToTypes = D:tReverse(DC.TypeNames);
    DC.NameToTypes["Magic"] = DC.MAGIC; -- make sure 'Magic' is set to DC.MAGIC and not to DC.ENEMYMAGIC

    DC.TypeColors = {
        [DC.MAGIC]      = "2222DD",
        [DC.ENEMYMAGIC] = "2222FF",
        [DC.CURSE]      = "DD22DD",
        [DC.POISON]     = "22DD22",
        [DC.DISEASE]    = "995533",
        [DC.CHARMED]    = "FF0000",
        [DC.NOTYPE]     = "AAAAAA",
    }

    DC.TypeToLocalizableTypeNames = {
        [DC.MAGIC]      = "MAGIC",
        [DC.ENEMYMAGIC] = "MAGICCHARMED",
        [DC.CURSE]      = "CURSE",
        [DC.POISON]     = "POISON",
        [DC.DISEASE]    = "DISEASE",
        [DC.CHARMED]    = "CHARM",
    }
    DC.LocalizableTypeNamesToTypes = D:tReverse(DC.TypeToLocalizableTypeNames);

    -- /script DcrC.SpellsToUse[DcrC.DS["Dampen Magic"]] = {Types = {DcrC.MAGIC, DcrC.DISEASE, DcrC.POISON},Better = false}; DecursiveRootTable.Dcr:Configure();
    -- /script DcrC.SpellsToUse[DcrC.DS["SPELL_POLYMORPH"]] = {  Types = {DcrC.CHARMED}, Better = false, Pet = false, Rank = "1 : Pig"}; DecursiveRootTable.Dcr:Configure();

    -- SPELL TABLE -- must be parsed after localisation is loaded {{{
    DC.SpellsToUse = {
        -- Priests
        [DS["SPELL_CURE_DISEASE"]]          = {
            Types = {DC.DISEASE},
            Better = 0,
            Pet = false,
        },
        -- Priests
        [DS["SPELL_DISPELL_MAGIC"]]         = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            Better = 1,
            Pet = false,
        },
        -- Paladins
        [DS["SPELL_CLEANSE"]]               = {
            Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
            Better = 2,
            Pet = false,
        },
        -- Druids
        [DS["SPELL_CYCLONE"]]       = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        },
        -- Mages and Druids
        [DS["SPELL_REMOVE_CURSE"]]   = {
            Types = {DC.CURSE},
            Better = 0,
            Pet = false,

            --[===[ for testing purpose only {{{
            EnhancedBy = DS["TALENT_ARCANE_POWER"], 
            EnhancedByCheck = function ()
                return (select(5, GetTalentInfo(1,1))) > 0;
            end,
            Enhancements = {
                Types = {DC.CURSE, DC.MAGIC},
                OnPlayerOnly = {
                    [DC.CURSE] = false,
                    [DC.MAGIC]  = true,
                },
            }
            --}}} ]===]
        },
        -- Mages
        [DS["SPELL_POLYMORPH"]]      = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        },
        
        -- Shaman resto
        [DS["CLEANSE_SPIRIT"]]              = {
            Types = {DC.CURSE, DC.DISEASE, DC.POISON},
            Better = 3,
            Pet = false,
        },
        -- Shamans http://www.wowhead.com/?spell=51514
        [DS["SPELL_HEX"]]    = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        },
        --[=[ -- disabled because of Korean locals... see below
        -- Shamans
        [DS["SPELL_PURGE"]]                 = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = false,
        }, --]=]
        -- Hunters http://www.wowhead.com/?spell=19801
        [DS["SPELL_TRANQUILIZING_SHOT"]]    = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = false,
        },
        -- Warlock
        [DS["SPELL_FEAR"]]    = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        },
        -- Warlock
        [DS["PET_FEL_CAST"]]                = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            Better = 1,
            Pet = true,
        },
        -- Warlock
        [DS["PET_DOOM_CAST"]]               = { -- WARNING this will be overwritten by priests' dispel magic
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            Better = 1,
            Pet = true,
        },
    }; -- }}}



    if T._tocversion >= 50000 then

        -- Monks
        DC.SpellsToUse[DS["SPELL_DETOX"]]               = {
            Types = {DC.DISEASE, DC.POISON},
            Better = 2,
            Pet = false,

            EnhancedBy = DS["PASSIVE_INTERNAL_MEDICINE"],
            EnhancedByCheck = function ()
                return (GetSpellBookItemInfo(DS["PASSIVE_INTERNAL_MEDICINE"])) and true or false;
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
            }
        };

        -- Monks
        DC.SpellsToUse[DS["SPELL_DIFFUSEMAGIC"]]               = {
            Types = {DC.MAGIC},
            Better = 0,
            Pet = false,
            OnPlayerOnly = {
                [DC.MAGIC]  = true,
            },
        };

        -- Paladins
        DC.SpellsToUse[DS["SPELL_CLEANSE"]]               = {
            Types = {DC.DISEASE, DC.POISON},
            Better = 2,
            Pet = false,

            EnhancedBy = DS["PASSIVE_SACRED_CLEANSING"], -- http://www.wowhead.com/talent#srrrdkdz
            EnhancedByCheck = function ()
                return (GetSpellBookItemInfo(DS["PASSIVE_SACRED_CLEANSING"])) and true or false;
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
            }
            
        };
        -- Shaman
        DC.SpellsToUse[DS["CLEANSE_SPIRIT"]]              = {
            Types = {DC.CURSE},
            Better = 3,
            Pet = false,
        };

        -- Shaman resto
        DC.SpellsToUse[DS["PURIFY_SPIRIT"]]              = {
            -- BUG in MOP BETA (2012-07-08): /spew GetSpellBookItemInfo('Purify Spirit') == nil while /spew (GetSpellInfo('Cleanse Spirit')) == 'Purify Spirit'
            Types = {DC.CURSE, DC.MAGIC},
            Better = 4,
            Pet = false,
        };

        -- Warlocks (Imp)
        DC.SpellsToUse[DS["SPELL_SINGE_MAGIC"]]         = {
            Types = {DC.MAGIC},
            Better = 0,
            Pet = true,
        };

        -- Warlocks (Imp singe magic ability when used with Grimoire of Sacrifice)
        DC.SpellsToUse[DS["SPELL_COMMAND_DEMON"]]         = {
            Types = {}, -- does nothing by default
            Better = 1, -- the Imp takes time to disappear when sacrificed, during that interlude, Singe Magic is still there
            Pet = false,

            EnhancedBy = true,
            EnhancedByCheck = function ()
                return (GetSpellInfo(DS["SPELL_COMMAND_DEMON"]) == DS["SPELL_SINGE_MAGIC"]);
            end,
            Enhancements = {
                Types = {DC.MAGIC},
            }
        };

        -- Warlock
        DC.SpellsToUse[DS["SPELL_FEAR"]]    = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        };
        -- Warlocks
        DC.SpellsToUse[DS["PET_FEL_CAST"]]              = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = true,
        };
        -- Mages
        DC.SpellsToUse[DS["SPELL_POLYMORPH"]]      = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        };

        -- Druids (Balance Feral Guardian)
        DC.SpellsToUse[DS["SPELL_REMOVE_CORRUPTION"]]      = {
            Types = {DC.POISON, DC.CURSE},
            Better = 0,
            Pet = false,

        };

        -- Druids (Restoration)
        DC.SpellsToUse[DS["SPELL_NATURES_CURE"]]      = {
            Types = {DC.MAGIC, DC.POISON, DC.CURSE},
            Better = 1,
            Pet = false,
        };

        -- Priests (global)
        DC.SpellsToUse[DS["SPELL_DISPELL_MAGIC"]]         = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = false,
        };

        -- Priests (Discipline, Holy)
        DC.SpellsToUse[DS["SPELL_PURIFY"]]         = {
            Types = {DC.MAGIC, DC.DISEASE},
            Better = 0,
            Pet = false,
        };

    -- WoW 4.0 changes {{{
        --https://docs.google.com/document/pub?id=13GLsRWUA4pMQ0EAV2FWkmJvDNQTeIcivO8XtP0iZ-tA
    elseif T._tocversion >= 40000  then
        -- Paladins
        DC.SpellsToUse[DS["SPELL_CLEANSE"]]               = {
            Types = {DC.DISEASE, DC.POISON},
            Better = 2,
            Pet = false,

            EnhancedBy = DS["TALENT_SACRED_CLEANSING"], -- http://www.wowhead.com/talent#srrrdkdz
            EnhancedByCheck = function ()
                return (select(1, GetTalentInfo(1,14))) == DS["TALENT_SACRED_CLEANSING"] and (select(5, GetTalentInfo(1,14))) > 0;
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
            }
        };
        -- Shaman resto
        DC.SpellsToUse[DS["CLEANSE_SPIRIT"]]              = {
            Types = {DC.CURSE},
            Better = 3,
            Pet = false,

            EnhancedBy = DS["TALENT_IMPROVED_CLEANSE_SPIRIT"], -- http://www.wowhead.com/talent#hZZfGdzsk
            EnhancedByCheck = function ()
                return (select(1, GetTalentInfo(3,12))) == DS["TALENT_IMPROVED_CLEANSE_SPIRIT"] and (select(5, GetTalentInfo(3,12))) > 0;
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.CURSE},
            }
        };
        -- Warlocks
        DC.SpellsToUse[DS["PET_FEL_CAST"]]              = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = true,
        };
        -- Warlocks
        DC.SpellsToUse[DS["SPELL_SINGE_MAGIC"]]         = {
            Types = {DC.MAGIC},
            Better = 0,
            Pet = true,
        };
        -- Warlock
        DC.SpellsToUse[DS["SPELL_FEAR"]]    = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        };
        -- Mages
        DC.SpellsToUse[DS["SPELL_POLYMORPH"]]      = {
            Types = {DC.CHARMED},
            Better = 0,
            Pet = false,
        };
        -- Druids
        DC.SpellsToUse[DS["SPELL_REMOVE_CORRUPTION"]]      = {
            Types = {DC.POISON, DC.CURSE},
            Better = 0,
            Pet = false,

            EnhancedBy = DS["TALENT_NATURES_CURE"], -- http://www.wowhead.com/talent#0ZZrfuIdfr0o
            EnhancedByCheck = function ()
                return (select(1, GetTalentInfo(3,17))) == DS["TALENT_NATURES_CURE"] and (select(5, GetTalentInfo(3,17))) > 0;
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.POISON, DC.CURSE},
            }
        };
        -- Priests
        DC.SpellsToUse[DS["SPELL_CURE_DISEASE"]]       = {
            Types = {DC.DISEASE},
            Better = 0,
            Pet = false,

            EnhancedBy = DS["TALENT_BODY_AND_SOUL"], -- http://www.wowhead.com/talent#bZfurrRoM
            EnhancedByCheck = function ()
                return (select(1, GetTalentInfo(2,14))) == DS["TALENT_BODY_AND_SOUL"] and (select(5, GetTalentInfo(2,14))) > 0;
            end,
            Enhancements = {
                Types = {DC.DISEASE, DC.POISON},
                OnPlayerOnly = {
                    [DC.DISEASE] = false,
                    [DC.POISON]  = true,
                },
            }
        };
        -- Priests
        DC.SpellsToUse[DS["SPELL_DISPELL_MAGIC"]]         = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            Better = 1,
            Pet = false,

            EnhancedBy = DS["SPEC_ABSOLUTION"], -- it's a downgrading actually XXX need to make OnPlayerOnly part of the defaults and add it to the custom spell UI...
            EnhancedByCheck = function ()
                return (not GetPrimaryTalentTree() or GetPrimaryTalentTree() == 3);
            end,
            Enhancements = {
                Types = {DC.MAGIC, DC.ENEMYMAGIC},
                OnPlayerOnly = {
                    [DC.MAGIC] = true,
                    [DC.ENEMYMAGIC] = false,
                },
            }
        };

        -- old WoW 3.5 for compatibilty with China {{{
    elseif T._tocversion < 40000 then
         -- Priests -- XXX to be removed
        DC.SpellsToUse[DS["SPELL_ABOLISH_DISEASE"]]       = {
            Types = {DC.DISEASE},
            Better = 1,
            Pet = false,

            EnhancedBy = DS["TALENT_BODY_AND_SOUL"],
            EnhancedByCheck = function ()
                return (select(5, GetTalentInfo(2,20))) > 0;
            end,
            Enhancements = {
                Types = {DC.DISEASE, DC.POISON},
                OnPlayerOnly = {
                    [DC.DISEASE] = false,
                    [DC.POISON]  = true,
                },
            }
        };

        -- Druids
        DC.SpellsToUse[DS["SPELL_ABOLISH_POISON"]]        = {
            Types = {DC.POISON},
            Better = 1,
            Pet = false,
        };

        -- Shamans
        DC.SpellsToUse[DS["SPELL_CURE_TOXINS"]]           = {
            Types = {DC.POISON, DC.DISEASE},
            Better = 1,
            Pet = false,
        };

        -- Druids
        DC.SpellsToUse[DS["SPELL_CURE_POISON"]]           = {
            Types = {DC.POISON},
            Better = 0,
            Pet = false,
        };
        -- Paladins
        DC.SpellsToUse[DS["SPELL_PURIFY"]]                = {
            Types = {DC.DISEASE, DC.POISON},
            Better = 1,
            Pet = false,
        };

    end -- }}}
    
    -- }}}


    -- Thanks to Korean localization team of WoW we have to make an exception....
    -- They found the way to call two different spells the same (Shaman PURGE and Paladin CLEANSE... (both are called "정화") )
    if ((select(2, UnitClass("player"))) == "SHAMAN") then
        -- Shamans
        DC.SpellsToUse[DS["SPELL_PURGE"]]                   = {
            Types = {DC.ENEMYMAGIC},
            Better = 0,
            Pet = false,
        };
    end

    --[=[ this exception is no longer required since Consume magic no longer exists: http://www.wowwiki.com/Consume_Magic
    -- Thanks to Chinese localization team of WoW we have to make anOTHER exception.... ://///
    -- They found the way to call two different spells the same (Devour Magic and Consume Magic... (both are called "&#21534;&#22124;&#39764;&#27861;" )
    if ((select(2, UnitClass("player"))) == "PRIEST") then
        DC.SpellsToUse[DS["PET_FEL_CAST"]] = nil; -- so we remove PET_FEL_CAST.
    end
    --]=]


    -- New Comm Part used for version checking
    -- only if AceComm is here
    if LibStub:GetLibrary("AceComm-3.0", true) then
        DC.COMMAVAILABLE = true;
        LibStub("AceComm-3.0"):RegisterComm("DecursiveVersion", D.OnCommReceived);
    end

    T._CatchAllErrors = false;

end -- // }}}

local FirstEnable = true;
function D:OnEnable() -- called after PLAYER_LOGIN -- {{{

    if T._SelfDiagnostic() == 2 then
        return false;
    end
    T._CatchAllErrors = true; -- During init we catch all the errors else, if a library fails we won't know it.
    D.debug = D.db.global.debug;


    if (FirstEnable) then
        D:ExportOptions ();
        -- configure the message frame for Decursive
        DecursiveTextFrame:SetFading(true);
        DecursiveTextFrame:SetFadeDuration(D.CONF.TEXT_LIFETIME / 3);
        DecursiveTextFrame:SetTimeVisible(D.CONF.TEXT_LIFETIME);

    end

    -- hook the load macro thing {{{
    -- So Decursive will re-update its macro when the macro UI is closed
    D:SecureHook("ShowMacroFrame", function ()
        if not D:IsHooked(MacroPopupFrame, "Hide") then
            D:Debug("Hooking MacroPopupFrame:Hide()");
            D:SecureHook(MacroPopupFrame, "Hide", function () D:UpdateMacro(); end);
        end
    end); -- }}}

    D:SecureHook("CastSpellByName", "HOOK_CastSpellByName");

    -- these events are automatically stopped when the addon is disabled by Ace

    -- Spell changes events
    self:RegisterEvent("LEARNED_SPELL_IN_TAB");
    self:RegisterEvent("SPELLS_CHANGED");
    self:RegisterEvent("PLAYER_TALENT_UPDATE");
    self:RegisterEvent("PLAYER_ALIVE"); -- talents SHOULD be available
    self:RegisterEvent("PLAYER_ENTERING_WORLD");

    -- Combat detection events
    self:RegisterEvent("PLAYER_REGEN_DISABLED","EnterCombat");
    self:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat");

    -- Raid/Group changes events
    self:RegisterEvent("PARTY_LEADER_CHANGED", D.GroupChanged, D);

    if DC.MOP then
        self:RegisterEvent("GROUP_ROSTER_UPDATE", D.GroupChanged, D);
    else
        self:RegisterEvent("PARTY_MEMBERS_CHANGED", D.GroupChanged, D);
        self:RegisterEvent("RAID_ROSTER_UPDATE", D.GroupChanged, D);
    end

    self:RegisterEvent("PLAYER_FOCUS_CHANGED");

    -- Player pet detection event (used to find pet spells)
    self:RegisterEvent("UNIT_PET");

    self:RegisterEvent("UNIT_AURA");

    self:RegisterEvent("PLAYER_TARGET_CHANGED");
    
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN");

    self:RegisterMessage("DECURSIVE_TALENTS_AVAILABLE");

    D:ScheduleRepeatedCall("ScheduledTasks", D.ScheduledTasks, 0.3, D);

    -- Configure specific profile dependent data
    D:SetConfiguration();

    if FirstEnable and not D.db.global.NoStartMessages then
        D:ColorPrint(0.3, 0.5, 1, L["IS_HERE_MSG"]);
        D:ColorPrint(0.3, 0.5, 1, L["SHOW_MSG"]);
    end

    FirstEnable = false;

    D:StartTalentAvaibilityPolling();

    T._CatchAllErrors = false;

end -- // }}}

function D:SetConfiguration()

    if T._SelfDiagnostic() == 2 then
        return false;
    end
    T._CatchAllErrors = true; -- During init we catch all the errors else, if a library fails we won't know it.

    D.DcrFullyInitialized = false;
    D:CancelDelayedCall("Dcr_LLupdate");
    D:CancelDelayedCall("Dcr_MUFupdate");
    D:CancelDelayedCall("Dcr_ScanEverybody");

    D.Groups_datas_are_invalid = true;
    D.Status = {};
    D.Status.FoundSpells = {};
    D.Status.PlayerOnlyTypes = {};
    D.Status.CuringSpells = {};
    D.Status.CuringSpellsPrio = {};
    D.Status.Blacklisted_Array = {};
    D.Status.UnitNum = 0;
    D.Status.DelayedFunctionCalls = {};
    D.Status.DelayedFunctionCallsCount = 0;
    D.Status.MaxConcurentUpdateDebuff = 0;
    D.Status.PrioChanged = true;
    D.Status.last_focus_GUID = false;
    D.Status.GroupUpdatedOn = 0;
    D.Status.GroupUpdateEvent = 0;
    D.Status.UpdateCooldown = 0;
    D.Status.MouseOveringMUF = false;
    D.Status.TestLayout = false;
    D.Status.TestLayoutUNum = 25;
    D.Status.Unit_Array_GUIDToUnit = {};
    D.Status.Unit_Array_UnitToGUID = {};
    D.Status.Unit_Array = {};
    D.Status.InternalPrioList = {};
    D.Status.InternalSkipList = {};
    

    -- if we log in and we are already fighting...
    if InCombatLockdown() then
        D.Status.Combat = true;
    end

    D.profile = D.db.profile; -- shortcut
    D.classprofile = D.db.class; -- shortcut

    if type (D.profile.OutputWindow) == "string" then
        D.Status.OutputWindow = _G[D.profile.OutputWindow];
    end

    --D.debugFrame = D.Status.OutputWindow;
    --D.printFrame = D.Status.OutputWindow;

    D:Debug("Loading profile datas...");

    D:Init(); -- initialize Dcr core (set frames display, scans available cleansing spells)

    D.MicroUnitF.MaxUnit = D.profile.DebuffsFrameMaxCount;

    if D.profile.MF_colors['Chronometers'] then
        D.profile.MF_colors[ "COLORCHRONOS"] = D.profile.MF_colors['Chronometers'];
        D.profile.MF_colors['Chronometers'] = nil;
    end

    D.MicroUnitF:RegisterMUFcolors(D.profile.MF_colors); -- set the colors as set in the profile

    D.Status.Enabled = true;

    -- set Icon
    if not D.Status.HasSpell or D.profile.HideLiveList and not D.profile.ShowDebuffsFrame then
        D:SetIcon(DC.IconOFF);
    else
        D:SetIcon(DC.IconON);
    end

    -- put the updater events at the end of the init so there is no chance they could be called before everything is ready (even if LUA is not multi-threaded... just to stay logical )
    if not D.profile.HideLiveList then
        self:ScheduleRepeatedCall("Dcr_LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
    end

    if D.profile.ShowDebuffsFrame then
        self:ScheduleRepeatedCall("Dcr_MUFupdate", self.DebuffsFrame_Update, self.profile.DebuffsFrameRefreshRate, self);
        self:ScheduleRepeatedCall("Dcr_ScanEverybody", self.ScanEveryBody, 1, self);
    end

    D.DcrFullyInitialized = true; -- everything should be OK
    D:ShowHideButtons(true);
    D:AutoHideShowMUFs();


    D.MicroUnitF:Delayed_Force_FullUpdate(); -- schedule all attributes of exixting MUF to update

    D:SetMinimapIcon();

    -- code for backward compatibility
    if     ((not next(D.profile.PrioGUIDtoNAME)) and #D.profile.PriorityList ~= 0)
        or ((not next(D.profile.SkipGUIDtoNAME)) and #D.profile.SkipList ~= 0) then
        D:ClearPriorityList();
        D:ClearSkipList();
    end
    

    T._CatchAllErrors = false; -- During init we catch all the errors else, if a library fails we won't know it.
    D:VersionWarnings();
end

function D:OnDisable() -- When the addon is disabled by Ace
    D.Status.Enabled = false;
    D.DcrFullyInitialized = false;
    
    D:SetIcon("Interface\\AddOns\\Decursive\\iconOFF.tga");

    if ( D.profile.ShowDebuffsFrame) then
        D.MFContainer:Hide();
    end

    D:CancelAllTimedCalls();
    D:Debug(D:GetTimersNumber());

    -- the disable warning popup : {{{ -
    StaticPopupDialogs["Decursive_OnDisableWarning"] = {
        text = L["DISABLEWARNING"],
        button1 = "OK",
        OnAccept = function()
            return false;
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = false,
        showAlert = 1,
        preferredIndex = 3,
    }; -- }}}

    LibStub("AceConfigRegistry-3.0"):NotifyChange(D.name);
    StaticPopup_Show("Decursive_OnDisableWarning");
end

-- A list of some people I personally have problems with. Decursive will not function for them.
-- I don't want this kind of people benefiting from my hard work.
-- Those [Insert appropriate word here] are players you really don't want to meet. Ignorance is just not enough for them...
-- This list will only be used to disable Decursive for them, nothing else will ever happen.
local BADPLAYERS = {
    {"|A|r|a|d|o|s", "|C|o|n|s|e|i|l| |d|e|s| |O|m|b|r|e|s|", "|P|A|L|A|D|I|N|"}, -- This one gave me the most horrible experience I ever had in a pickup-group (At the Oculus). He is a terrible leader ; the kind of incompetent person who will accuse you of his own failures. All of this in a perverse and insidious way so he can turn others against you.


    --{"|A|r|c|h|a|r|o|d|i|m|", "|L|e|s| |S|e|n|t|i|n|e|l|l|e|s|", "|M|A|G|E|"}, -- so I can test if it works.
};
local BADPLAYERS_READABLE = false;
local GetRealmName = _G.GetRealmName;
function D:CheckPlayer()

    if not BADPLAYERS_READABLE then
        BADPLAYERS_READABLE = {};
        D:tcopycallback(BADPLAYERS_READABLE, BADPLAYERS, function (data) return (data:gsub("|", "")) end);
        BADPLAYERS = nil;
    end

    for i=1, #BADPLAYERS_READABLE do
        --D:Debug("TEST 1");
        if BADPLAYERS_READABLE[i][1] == (self:UnitName("player")) then
            --D:Debug("TEST 2 name ");
            if BADPLAYERS_READABLE[i][2] == GetRealmName() then
                --D:Debug("TEST 3 realmname");
                if BADPLAYERS_READABLE[i][3] == (select(2, UnitClass("player"))) then
                    --D:Debug("TEST 4 unitclass");
                    D:Disable();
                    break;
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- init functions and configuration functions {{{
-------------------------------------------------------------------------------
function D:Init() --{{{

    if (D.profile.OutputWindow == nil or not D.profile.OutputWindow) then
        D.Status.OutputWindow = DEFAULT_CHAT_FRAME;
        D.profile.OutputWindow =  "DEFAULT_CHAT_FRAME";
    end

    if not D.db.global.NoStartMessages then
        D:Println("%s %s by %s", D.name, D.version, D.author);
    end

    D:Debug( "Decursive Initialization started!");


    -- SET MF FRAME AS WRITTEN IN THE CURRENT PROFILE {{{
    -- Set the scale and place the MF container correctly
    if D.profile.ShowDebuffsFrame then
        D.MicroUnitF:Show();
    else
        D.MFContainer:Hide();
    end
    D.MFContainerHandle:EnableMouse(not D.profile.HideMUFsHandle);

    -- }}}


    -- SET THE LIVE_LIST FRAME AS WRITTEN IN THE CURRENT PROFILE {{{

    -- Set poristion and scale
    DecursiveMainBar:SetScale(D.profile.LiveListScale);
    DecursiveMainBar:Show();
    DcrLiveList:SetScale(D.profile.LiveListScale);
    DcrLiveList:Show();
    D:PlaceLL();

    if D.profile.BarHidden then
        DecursiveMainBar:Hide();
    else
        DecursiveMainBar:Show();
    end

    -- displays frame according to the current profile
    if (D.profile.HideLiveList) then
        DcrLiveList:Hide();
    else
        DcrLiveList:ClearAllPoints();
        DcrLiveList:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
        DcrLiveList:Show();
    end

    -- set Alpha
    DecursiveMainBar:SetAlpha(D.profile.LiveListAlpha);
    -- }}}

    if (D.db.global.MacroBind == "NONE") then
        D.db.global.MacroBind = false;
    end


    D:ChangeTextFrameDirection(D.profile.CustomeFrameInsertBottom);


    -- Configure spells
    D:Configure();

end --}}}

local function SpellIterator()
    local currentSpellTable = DC.SpellsToUse;
    local currentKey = nil;
    local iter

    iter = function()
        local ST

        currentKey, ST = next(currentSpellTable, currentKey);

        -- we reached the end of a table
        if currentKey == nil and currentSpellTable == DC.SpellsToUse then
            -- it was the base table now use the user defined one
            currentSpellTable = D.classprofile.UserSpells;
            --@debug@
            D:Debug("|cFF00FF00Shifting to user spells|r");
            --@end-debug@
            return iter(); -- continue with the other table
        end

        -- if it's already defined in the base table (but not editable) or if it's hidden, skip it
        if ST and (currentSpellTable ~= DC.SpellsToUse and (DC.SpellsToUse[currentKey] and not currentSpellTable[currentKey].MacroText or currentSpellTable[currentKey].Hidden)) then
            --@debug@
            D:Debug("Skipping", currentKey);
            if currentSpellTable ~= DC.SpellsToUse and DC.SpellsToUse[currentKey] then
                D:Print("|cFFFF0000Cheating for|r", currentKey);
            end
            --@end-debug@

            return iter(); -- aka 'continue'
        end

        return currentKey, ST;
    end;

    return iter;
end

function D:ReConfigure() --{{{

    D:Debug("|cFFFF0000D:ReConfigure was called!|r");
    if not D.DcrFullyInitialized then
        D:Debug("|cFFFF0000D:ReConfigure aborted, init uncomplete!|r");
        return;
    end

    local GetSpellBookItemInfo = _G.GetSpellBookItemInfo;
    local GetSpellInfo = _G.GetSpellInfo;

    local Reconfigure = false;
    for spellName, spell in SpellIterator() do
        -- Do we have that spell?
        if (not spell.Pet and GetSpellInfo(spellName)) or (spell.Pet and GetSpellBookItemInfo(spellName)) then -- yes
            -- We had it but it's been disabled
            if spell.Disabled and D.Status.FoundSpells[spellName] then
                D:Debug("D:ReConfigure:", spellName, 'has been disabled');
                Reconfigure = true;
                break;
                -- is it new?
            elseif not spell.Disabled and not D.Status.FoundSpells[spellName] then -- yes
                D:Debug("D:ReConfigure:", spellName, 'is new');
                Reconfigure = true;
                break;
            elseif spell.EnhancedBy then -- it's not new but there is an enhancement available...

                -- Workaround to the fact that function are not serialized upon storage to the DB
                if not spell.EnhancedByCheck and D.classprofile.UserSpells[spellName] then
                    spell.EnhancedByCheck = DC.SpellsToUse[spellName].EnhancedByCheck;
                    D.classprofile.UserSpells[spellName].EnhancedByCheck = spell.EnhancedByCheck;
                end

                if spell.EnhancedByCheck() then -- we have it now
                    if not D.Status.FoundSpells[spellName][3] then -- but not then :)
                        D:Debug("D:ReConfigure:", spellName, 'has an enhancement that was not available b4');
                        Reconfigure = true;
                        break;
                    end
                else -- we do no not
                    if D.Status.FoundSpells[spellName][3] then -- but we used to :'(
                        D:Debug("D:ReConfigure:", spellName, 'had an enhancement that is no longer available');
                        Reconfigure = true;
                        break;
                    end
                end
            end

        elseif D.Status.FoundSpells[spellName] then -- we don't have it anymore...
            D:Debug("D:ReConfigure:", spellName, 'is no longer available');
            Reconfigure = true;
            break;
        end
    end

    if Reconfigure == true then
        D:Debug("D:ReConfigure RECONFIGURATION!");
        D:Configure();
        return;
    end
    D:Debug("D:ReConfigure No reconfiguration required!");

end --}}}



function D:Configure() --{{{

    -- first empty out the old "spellbook"
    self.Status.HasSpell = false;
    self.Status.FoundSpells = {};


    local CuringSpells = self.Status.CuringSpells;

    CuringSpells[DC.MAGIC]      = false;
    CuringSpells[DC.ENEMYMAGIC] = false;
    CuringSpells[DC.CURSE]      = false;
    CuringSpells[DC.POISON]     = false;
    CuringSpells[DC.DISEASE]    = false;
    CuringSpells[DC.CHARMED]    = false;

    local Type, _;
    local GetSpellBookItemInfo = _G.GetSpellBookItemInfo;
    local GetSpellInfo = _G.GetSpellInfo;
    local Types = {};
    local OnPlayerOnly = false;
    local IsEnhanced = false;

    self:Debug("Configuring Decursive...");

    for spellName, spell in SpellIterator() do
        if not spell.Disabled then
            -- self:Debug("trying spell", spellName);
            -- Do we have that spell?
            if (not spell.Pet and GetSpellInfo(spellName)) or (spell.Pet and GetSpellBookItemInfo(spellName)) then -- yes (both API because of MOP bug with Purify Spirit)
                Types = spell.Types;
                OnPlayerOnly = false;
                IsEnhanced = false;

                -- Could it be enhanced by something (a talent for example)?
                if spell.EnhancedBy then
                    --@alpha@
                    self:Debug("Enhancement for ", spellName);
                    --@end-alpha@

                    -- Workaround to the fact that function are not serialized upon storage to the DB
                    if not spell.EnhancedByCheck and D.classprofile.UserSpells[spellName] then
                        spell.EnhancedByCheck = DC.SpellsToUse[spellName].EnhancedByCheck;
                        D.classprofile.UserSpells[spellName].EnhancedByCheck = spell.EnhancedByCheck;
                    end

                    if spell.EnhancedByCheck() then -- we have the enhancement
                        IsEnhanced = true;

                        Types = spell.Enhancements.Types; -- set the type to scan to the new ones

                        if spell.Enhancements.OnPlayerOnly then -- On the 'player' unit only?
                            --@alpha@
                            self:Debug("Enhancement for %s is for player only", spellName);
                            --@end-alpha@
                            OnPlayerOnly = spell.Enhancements.OnPlayerOnly;
                        end
                    end
                end

                if spell.OnPlayerOnly then
                    OnPlayerOnly = spell.OnPlayerOnly;
                end

                -- register it
                self.Status.FoundSpells[spellName] = {spell.Pet, "", IsEnhanced, spell.Better, spell.MacroText};
                for _, Type in pairs (Types) do

                    if not CuringSpells[Type] or spell.Better > self.Status.FoundSpells[CuringSpells[Type]][4] then  -- we did not already registered this spell or it's not the best spell for this type

                        CuringSpells[Type] = spellName;

                        if OnPlayerOnly and OnPlayerOnly[Type] then
                            --@alpha@
                            self:Debug("Enhancement for player only for type added",Type);
                            --@end-alpha@
                            self.Status.PlayerOnlyTypes[Type] = true;
                        else
                            self.Status.PlayerOnlyTypes[Type] = false;
                        end

                        self:Debug("Spell \"%s\" (%s) registered for type %d ( %s ), PetSpell: ", spellName, D.Status.FoundSpells[spellName][2], Type, DC.TypeNames[Type], D.Status.FoundSpells[spellName][1]);
                        self.Status.HasSpell = true;
                    end
                end

            end
        end
    end

    -- Verify the cure order list (if it was damaged)
    self:CheckCureOrder ();
    -- Set the appropriate priorities according to debuffs types
    self:SetCureOrder ();

    LibStub("AceConfigRegistry-3.0"):NotifyChange(D.name);

    if (not self.Status.HasSpell) then
        return;
    end

end --}}}

function D:GetSpellsTranslations(FromDIAG)
    local GetSpellInfo = _G.GetSpellInfo;

    local Spells = {};

    -- /spew DecursiveRootTable._C.DS

    Spells = {
        ["SPELL_POLYMORPH"]             = {     118,                                     },
        ["SPELL_COUNTERSPELL"]          = {     2139,                                    },
        ["SPELL_CYCLONE"]               = {     33786,                                   },
        ["SPELL_CURE_DISEASE"]          = {     528,                                     },
        ["SPELL_ABOLISH_DISEASE"]       = {     552,                                     },
        ["SPELL_PURIFY"]                = {     1152,                                    }, -- paladins
        ["SPELL_CLEANSE"]               = {     4987,                                    },
        ["SPELL_DISPELL_MAGIC"]         = {     527,                                     },
        ["SPELL_CURE_TOXINS"]           = {     526,                                     }, -- shamans
        ["SPELL_CURE_POISON"]           = {     8946,                                    },
        ["SPELL_ABOLISH_POISON"]        = {     2893,                                    }, -- removed in WoW 4.0
        ["SPELL_REMOVE_CURSE"]          = {     2782,                                    }, -- Druids/Mages
        ['SPELL_TRANQUILIZING_SHOT']    = {     19801,                                   },
        ['SPELL_HEX']                   = {     51514,                                   }, -- shamans
        ['SPEC_ABSOLUTION']             = {     33167,                                   }, -- Priests
        ["CLEANSE_SPIRIT"]              = {     51886,                                   },
        ["SPELL_PURGE"]                 = {     370,                                     },
        ["PET_FEL_CAST"]                = {     19505,                                   },
        ["SPELL_FEAR"]                  = {     5782                                     },
        ["PET_DOOM_CAST"]               = {     527,                                     },
        ["CURSEOFTONGUES"]              = {     1714,                                    },
        ["DCR_LOC_SILENCE"]             = {     15487,                                   },
        ["DCR_LOC_MINDVISION"]          = {     2096,                                    },
        ["DREAMLESSSLEEP"]              = {     15822,                                   },
        ["GDREAMLESSSLEEP"]             = {     24360,                                   },
        ["MDREAMLESSSLEEP"]             = {     28504,                                   },
        ["ANCIENTHYSTERIA"]             = {     19372,                                   },
        ["IGNITE"]                      = {     19659,                                   },
        ["TAINTEDMIND"]                 = {     16567,                                   },
        ["MAGMASHAKLES"]                = {     19496,                                   },
        ["CRIPLES"]                     = {     33787,                                   },
        ["DUSTCLOUD"]                   = {     26072,                                   },
        ["WIDOWSEMBRACE"]               = {     28732,                                   },
        ["SONICBURST"]                  = {     39052,                                   },
        ["DELUSIONOFJINDO"]             = {     24306,                                   },
        ["MUTATINGINJECTION"]           = {     28169,                                   },
        ['Phase Shift']                 = {     4511,                                    },
        ['Banish']                      = {     710,                                     },
        ['Frost Trap Aura']             = {     13810,                                   },
        ['Arcane Blast']                = {     30451,                                   },
        ['Prowl']                       = {     5215,   24450,                           },
        ['Stealth']                     = {     1784,                                    },
        ['Camouflage']                  = {     51755,                                   },
        ['Shadowmeld']                  = {     58984,                                   },
        ['Invisibility']                = {     66,                                      },
        ['Lesser Invisibility']         = {     7870,                                    },
        ['Ice Armor']                   = {     7302,                                    },
        ['Unstable Affliction']         = {     30108,                                   },
        ['Vampiric Touch']              = {     34914,                                   },
        ['Flame Shock']                 = {     8050,                                    },
        ['Dampen Magic']                = {     604,                                     },
        ['Amplify Magic']               = {     1008,                                    },
        ['TALENT_BODY_AND_SOUL']        = {     64129, 65081,                            },
        ['TALENT_ARCANE_POWER']         = {     12042,                                   }, --temp to test
        ['DARK_MATTER']                 = {     59868,                                   }, --temp to test
        --['YOGGG_DOMINATE_MIND']       = {     63042,                                   }, --temp to test
        --['STALVAN_CURSE']             = {     3105,                                    }, --temp to test
    };

    -- WoW 4.0 compatibility fixes
    if T._tocversion >= 40000 then
        Spells["SPELL_REMOVE_CURSE"]         = {     475,                                   }; -- Druids/Mages
        Spells["SPELL_REMOVE_CORRUPTION"]    = {     2782,                                  };
        Spells["SPELL_SINGE_MAGIC"]          = {     89808,                                 }; -- Warlock imp
        Spells["TALENT_IMPROVED_CLEANSE_SPIRIT"] = {  77130,                                }; -- resto shaman
        Spells["TALENT_NATURES_CURE"]        = {  88423,                                    }; -- resto druids
        Spells["TALENT_SACRED_CLEANSING"]    = {  53551,                                    }; -- holy palladins


        ---[=[
        Spells["Dampen Magic"]    = nil;
        Spells["Amplify Magic"]    = nil;
        Spells["SPELL_ABOLISH_DISEASE"]    = nil;
        Spells["SPELL_ABOLISH_POISON"]    = nil;
        Spells["SPELL_CURE_TOXINS"]    = nil;
        Spells["SPELL_CURE_POISON"]    = nil;
        Spells["SPELL_PURIFY"]    = nil;
        Spells["Phase Shift"]    = nil;
        --]=]
        
    end

    if T._tocversion >= 50000 then
        Spells["SPEC_ABSOLUTION"]       = nil;
        Spells["CURSEOFTONGUES"]        = nil;
        Spells["SPELL_PURIFY"]          = {527}; -- = Spells["SPELL_DISPELL_MAGIC"];
        Spells["SPELL_DISPELL_MAGIC"]   = {528}; -- = Spells["SPELL_CURE_DISEASE"];
        Spells["SPELL_CURE_DISEASE"]    = nil;
        Spells["PET_DOOM_CAST"]         = nil; -- disappeared a long time ago
        Spells["PURIFY_SPIRIT"]         = {77130}; -- resto shaman
        Spells["TALENT_IMPROVED_CLEANSE_SPIRIT"] = nil; -- resto shaman
        Spells["TALENT_SACRED_CLEANSING"]    = nil;
        Spells["PASSIVE_SACRED_CLEANSING"]    = {53551};
        Spells["PASSIVE_INTERNAL_MEDICINE"]    = {115451};
        Spells["TALENT_NATURES_CURE"]    = nil;
        Spells["SPELL_NATURES_CURE"]    = {88423};
        Spells["SHROUD_OF_CONCEALMENT"]    = {115834}; -- rogue
        Spells["SPELL_DETOX"]    = {115450}; -- monk
        Spells["SPELL_DIFFUSEMAGIC"]    = {122783}; -- monk

        Spells["SPELL_COMMAND_DEMON"]    = {119898}; -- warlock
        Spells['Greater Invisibility']         = {110959};

        DS["SPELL_CURE_DISEASE"]        = '_LOST SPELL_';
        DS["PET_DOOM_CAST"]             = '_LOST SPELL_';
    end    

    -- Note to self: The truth is not unique, there can be several truths. The world is not binary. (self revelation on 2011-02-25)

    --@debug@
    local dubs = {};
    --@end-debug@
    local alpha = false;
    --@alpha@
    alpha = true;
    --@end-alpha@
    local Sname, Sids, Sid, _, ok;
    ok = true;
    for Sname, Sids in pairs(Spells) do
        for _, Sid in ipairs(Sids) do

            if _ == 1 then
                DS[Sname] = (GetSpellInfo(Sid));
                --@debug@
                if FromDIAG and DS[Sname] then
                    if not dubs[DS[Sname]] then
                        dubs[DS[Sname]] = {Sname};
                    else
                        dubs[DS[Sname]][#dubs[DS[Sname]] + 1] = Sname;
                    end
                end
                --@end-debug@
                if not DS[Sname] then
                    if random (1, 15000) == 2323 or FromDIAG then
                        D:AddDebugText("SpellID:|cffff0000", Sid, "no longer exists.|r This was supposed to represent the spell", Sname);
                        D:errln("SpellID:", Sid, "no longer exists. This was supposed to represent the spell", Sname);
                    end
                    DS[Sname] = "_LOST SPELL_";
                end
            elseif FromDIAG then
                if (GetSpellInfo(Sid)) and DS[Sname] ~= (GetSpellInfo(Sid)) then

                    D:AddDebugText("|cffff0000Spell IDs", Sids[1] , "and", Sid, "have different translations:|r", DS[Sname], "and", (GetSpellInfo(Sid)) );

                    D:errln("Spell IDs", Sids[1] , "and", Sid, "have different translations:", DS[Sname], "and", (GetSpellInfo(Sid)) );

                    D:errln("Please report this to ARCHARODIM+DcrReport@teaser.fr");

                    ok = false;
                elseif not (GetSpellInfo(Sid)) then

                    D:AddDebugText("SpellID:|cffff0000", Sid, "no longer exist.|r This was supposed to represent the spell", Sname);

                    D:errln("SpellID:", Sid, "no longer exists. This was supposed to represent the spell", Sname);
                end
            end

        end
    end

    --@debug@
    if FromDIAG then
        for spell, ids in pairs(dubs) do
            if #ids > 1 then
                local dub = "";

                for _, id in ipairs(ids) do
                    dub = dub .. ", " .. id;
                end
                D:AddDebugText("|cffffAA22dubs found for", spell, ':|r ', dub);
            end
        end
    end
    --@end-debug@

    return ok;

end


-- Create the macro for Decursive
-- This macro will cast the first spell (priority)

-- NEW SetBindingMacro("KEY", "macroname"|macroid)
-- UPDATED name,texture,body,isLocal = GetMacroInfo(id|"name") - Now takes ID or name
-- UPDATED DeleteMacro() -- as above
-- UPDATED EditMacro() -- as above
-- UPDATED PickupMacro() -- as above
-- CreateMacro("name", icon, "body", local)


function D:UpdateMacro ()


    if D.profile.DisableMacroCreation then
        return false;
    end

    if InCombatLockdown() then
        D:AddDelayedFunctionCall (
        "UpdateMacro", self.UpdateMacro,
        self);
        return false;
    end
    D:Debug("UpdateMacro called");


    local CuringSpellsPrio  = D.Status.CuringSpellsPrio;
    local ReversedCureOrder = D.Status.ReversedCureOrder;
    local CuringSpells      = D.Status.CuringSpells;


    -- Get an ordered spell table
    local Spells = {};
    for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do -- XXX MACROUPDATE
        Spells[Prio] = Spell;
    end

    if (next (Spells)) then
        for i=1,4 do
            if (not Spells[i]) then
                table.insert (Spells, CuringSpells[ReversedCureOrder[1] ]);
            end
        end
    end

    local MacroParameters = {
        D.CONF.MACRONAME,
        1, -- icon index
        next(Spells) and string.format("/stopcasting\n/cast [@mouseover,nomod,exists] %s;  [@mouseover,exists,mod:ctrl] %s; [@mouseover,exists,mod:shift] %s", unpack(Spells)) or "/script DecursiveRootTable.Dcr:Println('"..L["NOSPELL"].."')",
        0, -- per account
    };

    --D:PrintLiteral(GetMacroIndexByName(D.CONF.MACRONAME));
    if GetMacroIndexByName(D.CONF.MACRONAME) ~= 0 then
	if not D.profile.AllowMacroEdit then
	    EditMacro(D.CONF.MACRONAME, unpack(MacroParameters));
	    D:Debug("Macro updated");
	else
	    D:Debug("Macro not updated due to AllowMacroEdit");
	end
    elseif (GetNumMacros()) < 36 then
        CreateMacro(unpack(MacroParameters));
    else
        D:errln("Too many macros exist, Decursive cannot create its macro");
        return false;
    end


    D:SetMacroKey(D.db.global.MacroBind);

    return true;

end



-- }}}

function D:SetDateAndRevision (Date, Revision)
    if not D.TextVersion then
        D.TextVersion = GetAddOnMetadata("Decursive", "Version");
        D.Revision = 0;
    end

    local Rev = tonumber((string.gsub(Revision, "%$Revision: (%d+) %$", "%1")));

    if  Rev and D.Revision < Rev then
        D.Revision = Rev;
        D.date = Date:gsub("%$Date: (.-) %$", "%1");
        D.version = string.format("%s (|cFF11CCAARevision: %d|r)", D.TextVersion, Rev);
    end
end

--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");

function D:LocalizeBindings ()

    BINDING_NAME_DCRSHOW    = L["BINDING_NAME_DCRSHOW"];
    BINDING_NAME_DCRMUFSHOWHIDE = L["BINDING_NAME_DCRMUFSHOWHIDE"];
    BINDING_NAME_DCRPRADD     = L["BINDING_NAME_DCRPRADD"];
    BINDING_NAME_DCRPRCLEAR   = L["BINDING_NAME_DCRPRCLEAR"];
    BINDING_NAME_DCRPRLIST    = L["BINDING_NAME_DCRPRLIST"];
    BINDING_NAME_DCRPRSHOW    = L["BINDING_NAME_DCRPRSHOW"];
    BINDING_NAME_DCRSKADD   = L["BINDING_NAME_DCRSKADD"];
    BINDING_NAME_DCRSKCLEAR = L["BINDING_NAME_DCRSKCLEAR"];
    BINDING_NAME_DCRSKLIST  = L["BINDING_NAME_DCRSKLIST"];
    BINDING_NAME_DCRSKSHOW  = L["BINDING_NAME_DCRSKSHOW"];
    BINDING_NAME_DCRSHOWOPTION = L["BINDING_NAME_DCRSHOWOPTION"];

end

D.Revision = "@project-abbreviated-hash@";
D.date = "@project-date-iso@";
D.version = "@project-version@";
do

    if D.date ~= "@project".."-date-iso@" then

        -- get a fucking table of D.date so we can get a fucking timestamp with time() because @project-timestamp@ doesn't fucking work :/ FUCK!!

        --local example =  "2008-05-01T12:34:56Z";

        local year, month, day, hour, min, sec = string.match( D.date, "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)");
        local projectDate = {["year"] = year, ["month"] = month, ["day"] = day, ["hour"] = hour, ["min"] = min, ["sec"] = sec, ["isdst"] = false };

        D.VersionTimeStamp = time(projectDate);
    else
        D.VersionTimeStamp = 0;
    end

end

T._LoadedFiles["DCR_init.lua"] = "@project-version@";

-------------------------------------------------------------------------------

--[======[
TEST to see what keyword substitutions are actually working.... DAMN!!!!

Simple replacements

@file-revision@
    Turns into the current revision of the file in integer form. e.g. 1234
    Note: does not work for git
@project-revision@
    Turns into the highest revision of the entire project in integer form. e.g. 1234
    Note: does not work for git
@file-hash@
    Turns into the hash of the file in hex form. e.g. 106c634df4b3dd4691bf24e148a23e9af35165ea
    Note: does not work for svn
@project-hash@
    Turns into the hash of the entire project in hex form. e.g. 106c634df4b3dd4691bf24e148a23e9af35165ea
    Note: does not work for svn
@file-abbreviated-hash@
    Turns into the abbreviated hash of the file in hex form. e.g. 106c63 Note: does not work for svn
@project-abbreviated-hash@
    Turns into the abbreviated hash of the entire project in hex form. e.g. 106c63
    Note: does not work for svn
@file-author@
    Turns into the last author of the file. e.g. ckknight
@project-author@
    Turns into the last author of the entire project. e.g. ckknight
@file-date-iso@
    Turns into the last changed date (by UTC) of the file in ISO 8601. e.g. 2008-05-01T12:34:56Z
@project-date-iso@
    Turns into the last changed date (by UTC) of the entire project in ISO 8601. e.g. 2008-05-01T12:34:56Z
@file-date-integer@
    Turns into the last changed date (by UTC) of the file in a readable integer fashion. e.g. 20080501123456
@project-date-integer@
    Turns into the last changed date (by UTC) of the entire project in a readable integer fashion. e.g. 2008050123456
@file-timestamp@
    Turns into the last changed date (by UTC) of the file in POSIX timestamp. e.g. 1209663296
@project-timestamp@
    Turns into the last changed date (by UTC) of the entire project in POSIX timestamp. e.g. 1209663296
@project-version@
    Turns into an approximate version of the project. The tag name if on a tag, otherwise it's up to the repo.
    :SVN returns something like "r1234"
    :Git returns something like "v0.1-873fc1"
    :Mercurial returns something like "r1234". 

--]======]
