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
-- Traditional Chinese localization
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

if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "zhTW");

if not L then
    DcrLoadedFiles["zhTW.lua"] = "@project-version@";
    return;
end;

--@localization(locale="zhTW", format="lua_additive_table")@


DcrLoadedFiles["zhTW.lua"] = "@project-version@";
