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

DcrCorrupted	 = false;

DcrLoadedFiles = {
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
do
    DcrDiagStatus = false;

    local FatalError = function (TheError) StaticPopup_Show ("Decursive_Error_Frame", TheError); end

    local PrintMessage = function (message, ...) if DcrDiagStatus ~= 2 then Dcr:Print("|cFFFFAA55Self diagnostic:|r ", format(message, ...)); end end;

    -- the beautiful error popup : {{{ -
    StaticPopupDialogs["Decursive_Error_Frame"] = {
	text = "|cFFFF0000Decursive Error:|r\n%s",
	button1 = "OK",
	OnAccept = function()
	    return false;
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
    }; -- }}}

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
	    ["AceDB-2.0"]		= 90000 + 1091,
	    ["AceConsole-2.0"]		= 90000 + 1091,
	    ["AceLocale-2.2"]		= 90000 + 1091,
	    ["AceAddon-2.0"]	        = 90000 + 1091,
	    ["Dewdrop-2.0"]		= 90000 + 320,
	    ["Waterfall-1.0"]		= 90000 + 125,
	    ["Tablet-2.0"]		= 90000 + 216,
	}; -- }}}

	--LibStub:GetLibrary
	local UseLibStub = {
	    ["LibBabble-Class-3.0"] = 90000 + 45,
	    ["LibDataBroker-1.1"] = 3,
	    ["LibDBIcon-1.0"] = 3,
	    ["CallbackHandler-1.0"] = 3,
	};

	local GenericErrorMessage1 = "Decursive could not initialize properly because one or several of the required shared libraries (at least |cFF00FF00AceLibrary or LibStub|r) could not be found.\n";
	local GenericErrorMessage2 = "Try to re-install Decursive from its original archive or use the |cFF00FF00Curse client|r (Curse.com) to update |cFFFF0000ALL|r your Ace add-ons properly.";

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
	if not FatalOccured then
	    for k,v in pairs (DcrLoadedFiles) do
		if not v then
		    table.insert(Errors, ("The Decursive file |cFF00FF00%s|r could not be loaded!!!\n"):format(k));
		    FatalOccured = true;
		end
	    end
	end

	if #Errors > 0 then
	    local ErrorString = ("|cFFFF0000%d error(s)|r found while loading Decursive:\n\n"):format(#Errors);

	    for k, v in pairs (Errors) do
		ErrorString = ErrorString .. v;
	    end

	    ErrorString = ErrorString .. "\n\n" .. GenericErrorMessage2;

	    FatalError(ErrorString);
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
		    PrintMessage("|cFFFF0000Event lib management error: argument could not be read!|r");
		    argtestdone = true;
		end

		if OneTimeEvent == ConfirmOneTimeEventMessage and CustomEventCaught == ConfirmCustomEventMessage then
		    Dcr:CancelScheduledEvent("DcrDiagRepeat");
		    Dcr:UnregisterEvent(CustomEvent);
		    PrintMessage("|cFF00FF00Event library functionning properly!|r");
		    PrintMessage("|cFF00FF00Everything seems to be OK.|r");
		    return;
		end

		-- cast the custom event
		Dcr:TriggerEvent(CustomEvent, ConfirmCustomEventMessage);

		if ReapeatingEventCount == 4 then
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


DcrLoadedFiles["Dcr_DIAG.lua"] = "@file-abbreviated-hash@";
