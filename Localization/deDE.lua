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

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

--[=[
--			YOUR ATTENTION PLEASE
--
--	   !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--	################################################################
--	#  http://wow.curseforge.com/projects/decursive/localization/  #
--	################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

-- big ugly scary fatal error message display function {{{
if not DcrFatalError then
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
    }; -- }}}
DcrFatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then DcrFatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "deDE");

if not L then
    DcrLoadedFiles["deDE.lua"] = "@project-version@";
    return;
end;


--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="ignore")@


DcrLoadedFiles["deDE.lua"] = "@project-version@";
