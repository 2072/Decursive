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

DcrCorrupted	 = false;

DcrC = {};
local DC = DcrC;

DC.StartTime = GetTime();
DC.MyClass = "unkknown";

DcrLoadedFiles = {
    ["Dcr_DIAG.xml"]		= false,
    ["Dcr_DIAG.lua"]		= false,
    ["DCR_init.lua"]		= false,
    ["Dcr_LDB.lua"]		= false,
    ["Dcr_utils.lua"]		= false,

    ["enUS.lua"]	= false,
    ["frFR.lua"]	= false,
    ["deDE.lua"]	= false,
    ["zhTW.lua"]	= false,
    ["esES.lua"]	= false,
    ["koKR.lua"]	= false,
    ["zhCN.lua"]	= false,
    ["ruRU.lua"]	= false,
    
    ["Dcr_opt.lua"]		= false,
    ["Dcr_Events.lua"]		= false,
    ["Dcr_Raid.lua"]		= false,
    ["Decursive.lua"]		= false,
    ["Dcr_lists.lua"]		= false,
    ["Dcr_DebuffsFrame.lua"]	= false,
    ["Dcr_LiveList.lua"]	= false,

    ["Dcr_DebuffsFrame.xml"]	= false,
    ["Dcr_lists.xml"]		= false,
    ["Dcr_LiveList.xml"]	= false,
    ["Decursive.xml"]		= false,
    
};

-- This self diagnostic functionality is here to give clear instructions to the
-- user when something goes wrong with the Ace shared libraries or when a
-- Decursive file could not be loaded.
    
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
	return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = false,
    showAlert = 1,
    }; -- }}}
DcrFatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end

-- Decursive LUA error manager and debug reporting functions {{{

local function NiceTime()
    return tonumber(("%.4f"):format(GetTime() - DC.StartTime));
end

local function print(t)
    if DEFAULT_CHAT_FRAME then
	DEFAULT_CHAT_FRAME:AddMessage(t);
    end
end

-- taken from AceConsole-2.0
local function tostring_args(a1, ...)
	if select('#', ...) < 1 then
		return tostring(a1)
	end
	return tostring(a1), tostring_args(...)
end

Dcr_DebugText = "";
-- taken from BugSack
function Dcr_DebugFrameOnTextChanged()
    if this:GetText() ~= Dcr_DebugText then
	this:SetText(Dcr_DebugText)
    end
    this:GetParent():UpdateScrollChildRect()
    local _, m = DecursiveDebuggingFrameScrollScrollBar:GetMinMaxValues()
    if m > 0 and this.max ~= m then
	this.max = m
	DecursiveDebuggingFrameScrollScrollBar:SetValue(0)
    end
end

Dcr_DebugTextTable = {};
local DebugTextTable = Dcr_DebugTextTable;
local Reported = {};
local GetFramerate = _G.GetFramerate;
local GetNetStats = _G.GetNetStats;
function Dcr_AddDebugText(a1, ...)

    Dcr:Debug("Error processed");
    local text = "";

    if select('#', ...) > 0 then
	text = strjoin(", ", tostring_args(a1, ...))
    else
	text = tostring(a1);
    end

    if not Reported[text] then
	table.insert (DebugTextTable,  ("\n------\n%.4f (%d-%d): %s -|count: "):format(NiceTime(), select(3, GetNetStats()), GetFramerate(), text) );
	table.insert (DebugTextTable, 1);
	Reported[text] = #DebugTextTable;
    else
	DebugTextTable[Reported[text]] = DebugTextTable[Reported[text]] + 1;
    end
end

local AddDebugText = Dcr_AddDebugText;

-- The error handler
local ProperErrorHandler = false;
local IsReporting = false;

_G.original_debuglocals = _G.debuglocals;
---[=[
_G.debuglocals = function (level)
    local ADDLEVEL = 2; -- 2 is for this function and DecursiveErrorHandler

    -- test for other add-on that hooks the error handler and increment ADDLEVEL
    if QuestHelper_Errors then
	ADDLEVEL = ADDLEVEL + 1;
    end

    if Swatter and Swatter.OnError then
	ADDLEVEL = ADDLEVEL + 1;
    end

    return original_debuglocals(level + ADDLEVEL) or "Sometimes debuglocals() returns nothing, it's one of those times... (FYI: This message is a HotFix from Decursive to prevent a C stack overflow)";
end; 
--]=]

function DecursiveErrorHandler(err, ...)

    -- second blizzard bug HotFix
    ---[=[
    if ScriptErrorsFrameScrollFrameText then
	if not ScriptErrorsFrameScrollFrameText.cursorOffset then
	    ScriptErrorsFrameScrollFrameText.cursorOffset = 0;
	    print("|cFF00FF00Decursive HotFix to Blizzard_DebugTools:|r |cFFFF0000ScriptErrorsFrameScrollFrameText.cursorOffset was nil|r");
	end
    end
    --]=]

    --Add a check to see if the error is happening inside the Blizzard debug tool himself...
    if (err:lower()):find("blizzard_debugtools") then
	if ( GetCVarBool("scriptErrors") ) then
	    print (("|cFFFF0000%s|r"):format(err));
	end
	return;
    end

    if (err:lower()):find("decursive") and not (err:lower()):find("\\libs\\") and not IsReporting then
	IsReporting = true;
	AddDebugText(err, debugstack(2), ...);
	if Dcr then
	    Dcr:Debug("Error recorded", ...);
	end
	IsReporting = false;
    end

    if ProperErrorHandler then
	return ProperErrorHandler( err, ... ); -- returning this way prevents this function from appearing in the stack
    end
end

function DcrHookErrorHandler()
    if not ProperErrorHandler then
	ProperErrorHandler = geterrorhandler();
	seterrorhandler(DecursiveErrorHandler);
    end
end

--}}}


-- Dev version usage warning {{{
-- the beautiful beta notice popup : {{{ -
StaticPopupDialogs["Decursive_Notice_Frame"] = {
    text = "|cFFFF0000Decursive Notice:|r\n%s",
    button1 = "OK",
    OnAccept = function()
	return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = false,
    showAlert = 1,
}; -- }}}



-- }}}

do
    DcrDiagStatus = false;

    local PrintMessage = function (message, ...) if DcrDiagStatus ~= 2 then Dcr:Print("|cFFFFAA55Self diagnostic:|r ", format(message, ...)); end end;


    function DecursiveSelfDiagnostic (force, FromCommand) -- {{{

	-- will not executes several times unless forced
	if not force and DcrDiagStatus then
	    return DcrDiagStatus;
	end

	DcrDiagStatus = 0; -- will be set to 1 if the diagnostic fails

	-- Table with all the required libraries with their current revision at Decursive release time.
	local LibrariesToCheck = { -- {{{
	    ["AceLibrary"]		= 90000 + 1091,
	    ["AceOO-2.0"]		= 90000 + 1091,
	    ["AceDebug-2.0"]		= 90000 + 1091,
	    ["AceEvent-2.0"]		= 90000 + 1091,
	    ["AceDB-2.0"]		= 90000 + 1094,
	    ["AceConsole-2.0"]		= 90000 + 1094,
	    ["AceAddon-2.0"]	        = 90000 + 1096,
	    ["Dewdrop-2.0"]		= 90000 + 320, -- (alpha)
	    ["Waterfall-1.0"]		= 90000 + 125,
	    ["Tablet-2.0"]		= 90000 + 216,
	}; -- }}}

	--LibStub:GetLibrary
	local UseLibStub = {
	    ["AceLocale-3.0"] = 2,
	    ["LibDataBroker-1.1"] = 3,
	    ["LibDBIcon-1.0"] = 8,
	    ["CallbackHandler-1.0"] = 3,
	    ["LibOOP-1.0"] = 0,
	};

	local GenericErrorMessage1 = "Decursive could not initialize properly because one or several of the required shared libraries (at least |cFF00FF00AceLibrary or LibStub|r) could not be found.\n";
	local GenericErrorMessage2 = "Try to re-install Decursive from its original archive or use the |cFF00FF00Curse client|r (Curse.com) to update |cFFFF0000ALL|r your add-ons properly.";

	local ErrorFound = false;
	local Errors = {};
	FatalOccured = false;

	-- Check each version of the required libraries that use LibStub
	if LibStub then
	    for k,v in pairs(UseLibStub) do
		if LibStub:GetLibrary(k, true) then
		    if (select(2, LibStub:GetLibrary(k))) < v then
			table.insert(Errors, ("The shared library |cFF00FF00%s|r is out-dated, revision |cFF0077FF%s|r at least is required.\n"):format(k, tostring(v)));
		    end
		else
		    table.insert(Errors, ("The shared library |cFF00FF00%s|r could not be found!!!\n"):format(k));
		    FatalOccured = true;
		end
	    end
	else
	    table.insert(Errors, GenericErrorMessage1);
	    FatalOccured = true;
	end


	-- Check each version of the required libraries that use AceLibrary
	if AceLibrary and AceLibrary:HasInstance("AceLibrary") then

	    for k,v in pairs(LibrariesToCheck) do
		if AceLibrary:HasInstance(k) then
		    if AceLibrary:IsNewVersion(k,v) then
			table.insert(Errors, ("The shared library |cFF00FF00%s|r is out-dated, revision |cFF0077FF%s|r at least is required.\n"):format(k, tostring(v)));
		    end
		else
		    table.insert(Errors, ("The shared library |cFF00FF00%s|r could not be found!!!\n"):format(k));
		    FatalOccured = true;
		end
	    end
	else
	    table.insert(Errors, GenericErrorMessage1);
	    FatalOccured = true;
	end

	-- check if all Decursive files are loaded
	local mixedFileVersionsdetection = {};
	local MixedVersionsCount = 0;
	if not FatalOccured then
	    for k,v in pairs (DcrLoadedFiles) do
		if v and v ~= "@pro" .. "ject-version@" and not mixedFileVersionsdetection[v] then
		    mixedFileVersionsdetection[v] = k;
		    MixedVersionsCount = MixedVersionsCount + 1;
		end

		if not v then
		    table.insert(Errors, ("The Decursive file |cFF00FF00%s|r could not be loaded!\n"):format(k));
		    FatalOccured = true;
		end
	    end
	end

	if MixedVersionsCount > 1 then
	    -- some mixed files were detected
	    local MixedDetails = "|cFFFF5599The versions of these files differ|r:\n\n";
	    for k,v in pairs (mixedFileVersionsdetection) do
		MixedDetails = ("%s%s --> %s\n"):format(MixedDetails, v, k);
	    end

	    table.insert(Errors, ("Decursive installation is corrupted, mixed versions detected!\n\n%s\n"):format(MixedDetails));
	    FatalOccured = true;
	end

	if #Errors > 0 then
	    local ErrorString = ("|cFFFF0000%d error(s)|r found while loading Decursive:\n\n"):format(#Errors);

	    for k, v in pairs (Errors) do
		ErrorString = ErrorString .. v;
	    end

	    ErrorString = ErrorString .. "\n\n" .. GenericErrorMessage2;

	    DcrFatalError(ErrorString);
	    DcrDiagStatus = FatalOccured and 2 or 1;
	end

	-- if no fatal error let this file update the date and revision of Decursive
	--if DcrDiagStatus ~= 2 then
	  --  Dcr:SetDateAndRevision("@file-date-iso@", "$Revision: 79890 $");
	--end

	-- if the diagnostic was requested by the user, we also test AceEvent functionalities {{{ -
	if force and FromCommand and DcrDiagStatus == 0 then

	    PrintMessage("|cFF00FF00No problem found in shared libraries or Decursive files!|r");

	    PrintMessage("Now checking spell translations...");
	    if Dcr:GetSpellsTranslations(true) then
		PrintMessage("|cFF00FF00No error found in spell translations!|r");
	    end

	    AddDebugText("Now checking the event management library...");
	    PrintMessage("Now checking the event management library...");
	    PrintMessage("If, in about 2 seconds, the message \"|cFF00FF00Event library functionning properly|r\" does not appear then there is a problem");

	    local OneTimeEvent = "not set"; local ReapeatingEventRate = 1; local ReapeatingEventCount = 0; local CustomEvent = "DCR_TEST_DIAG_EVENT"; local CustomEventCaught = "not set";
	    local ConfirmOneTimeEventMessage = "That was a good time!";
	    local ConfirmCustomEventMessage = "I was really caught!";

	    -- Register a curstom event
	    Dcr:RegisterEvent(CustomEvent, function(DiagTestArg1) CustomEventCaught = DiagTestArg1; end);

	    -- Schedule a function call in 0.5s
	    Dcr:ScheduleEvent("DcrDiagOneTimeEvent", function(DiagTestArg2) OneTimeEvent = DiagTestArg2 end, ReapeatingEventRate / 2, ConfirmOneTimeEventMessage);

	    -- Set a repeating function call that will check for other test event completion
	    Dcr:ScheduleRepeatingEvent("DcrDiagRepeat",
	    function (argTest)
		local argtestdone = false;
		if not argtestdone and argTest ~= "test" then
		    AddDebugText("Event lib management error: argument could not be read!");
		    PrintMessage("|cFFFF0000Event lib management error: argument could not be read!|r");
		    argtestdone = true;
		end

		if OneTimeEvent == ConfirmOneTimeEventMessage and CustomEventCaught == ConfirmCustomEventMessage then
		    Dcr:CancelScheduledEvent("DcrDiagRepeat");
		    Dcr:UnregisterEvent(CustomEvent);
		    PrintMessage("|cFF00FF00Event library functionning properly!|r");
		    PrintMessage("|cFF00FF00Everything seems to be OK.|r");
		    AddDebugText("Event library functionning properly, Everything seems to be OK");
		    return;
		end

		-- cast the custom event
		Dcr:TriggerEvent(CustomEvent, ConfirmCustomEventMessage);

		if ReapeatingEventCount == 4 then
		    AddDebugText("A problem occured, OneTimeEvent:", OneTimeEvent, "CustomEventCaught:", CustomEventCaught);
		    PrintMessage("|cFFFF0000A problem occured, OneTimeEvent='%s', CustomEventCaught='%s'|r", OneTimeEvent, CustomEventCaught);
		    Dcr:CancelScheduledEvent("DcrDiagRepeat");
		    Dcr:UnregisterEvent(CustomEvent);
		    return;
		end

		ReapeatingEventCount = ReapeatingEventCount + 1;

	    end,
	    ReapeatingEventRate, "test");

	end -- }}}

	return DcrDiagStatus;


    end -- }}}
end


DcrLoadedFiles["Dcr_DIAG.lua"] = "@project-version@";
