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
    ["Dcr_utils.lua"]		= false,

    ["localization.lua"]	= false,
    ["localization.fr.lua"]	= false,
    ["localization.de.lua"]	= false,
    ["localization.tw.lua"]	= false,
    ["localization.es.lua"]	= false,
    ["localization.kr.lua"]	= false,
    ["localization.cn.lua"]	= false,
    
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

    -- the beatiful error popup : {{{
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

    function DecursiveSelfDiagnostic (force) -- {{{

	-- will not executes several times unless forced
	if not force and DcrDiagStatus then
	    return DcrDiagStatus;
	end

	DcrDiagStatus = 0; -- will be set to 1 if the diagnostic fails

	-- Table with all the required libraries with their current revision at Decursive release time.
	local LibrariesToCheck = { -- {{{
	    ["AceLibrary"]		= 49421,
	    ["AceOO-2.0"]		= 38641,
	    ["AceDebug-2.0"]		= 34168,
	    ["AceEvent-2.0"]		= 56171,
	    ["AceDB-2.0"]		= 46764,
	    ["AceConsole-2.0"]		= 48940,
	    ["AceLocale-2.2"]		= 40629,
	    ["AceAddon-2.0"]	        = 46764,
	    ["SpecialEvents-Aura-2.0"]  = 54669,
	    ["Babble-Class-2.2"]	= 54287 * 100000 + 40629, -- 40629 is AceLocale revision
	    ["Babble-Spell-2.2"]	= 55718 * 100000 + 40629, -- 40629 is AceLocale revision
	    ["Dewdrop-2.0"]		= 48630,
	    ["Waterfall-1.0"]		= 54094,
	    ["Tablet-2.0"]		= 55567,
	    ["FuBarPlugin-2.0"]		= 52843,
	}; -- }}}

	local GenericErrorMessage1 = "Decursive could not initialize properly because one or several of the required shared libraries (at least |cFF00FF00AceLibrary|r) could not be found.\n";
	local GenericErrorMessage2 = "Try to re-install Decursive from its original archive or use |cFF00FF00JWoWUpdater|r (Google it) to update |cFFFF0000ALL|r your Ace add-ons properly.";

	local ErrorFound = false;
	local Errors = {};
	FatalOccured = false;

	-- Check each version of the required libraries
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

	if force and DcrDiagStatus == 0 then
	    Dcr:Print("Decursive self diagnostic complete, no problem found!");
	end

	return DcrDiagStatus;


    end -- }}}
end


DcrLoadedFiles["Dcr_DIAG.lua"] = true;
