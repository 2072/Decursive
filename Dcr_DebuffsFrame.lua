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

if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_lists.xml"] or not DcrLoadedFiles["Dcr_lists.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (Dcr_lists.xml or Dcr_lists.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D   = Dcr;
D:SetDateAndRevision("$Date: 2008-08-12 04:50:10 +0200 (mar., 12 août 2008) $", "$Revision: 80230 $");


local L	    = D.L;
local BC    = D.BC;
local AceOO = D.AOO;
local DC    = DcrC;
local DS    = DC.DS;


-- initialize our MicroUnitF class
D.MicroUnitF = AceOO.Class();

-- create a shortcut
local MicroUnitF = D.MicroUnitF;

-- since there are tens of thousands of globals defined at all times, lets use some locals!
local BOOKTYPE_PET	= BOOKTYPE_PET;
local BOOKTYPE_SPELL	= BOOKTYPE_SPELL;

-- Init object factory defaults
MicroUnitF.ExistingPerID	    = {};
MicroUnitF.ExistingPerNum	    = {};
MicroUnitF.UnitToMUF		    = {};
MicroUnitF.Number		    = 0;
MicroUnitF.UnitShown		    = 0;
MicroUnitF.UnitsDebuffedInRange	    = 0;
D.ForLLDebuffedUnitsNum		    = 0;


-- using power 2 values just to OR them but only CHARMED_STATUS is ORed (it's a C style bitfield)
local NORMAL		    = DC.NORMAL;
local ABSENT		    = DC.ABSENT;
local FAR		    = DC.FAR;
local STEALTHED		    = DC.STEALTHED;
local BLACKLISTED	    = DC.BLACKLISTED;
local AFFLICTED		    = DC.AFFLICTED;
local AFFLICTED_NIR	    = DC.AFFLICTED_NIR;
local CHARMED_STATUS	    = DC.CHARMED_STATUS;
local AFFLICTED_AND_CHARMED = DC.AFFLICTED_AND_CHARMED;


-- Those are the different colors used for the MUFs main texture
local MF_colors = { };

local unpack		= _G.unpack;
local select		= _G.select;
local pairs		= _G.pairs;
local ipairs		= _G.ipairs;
local PlaySoundFile	= _G.PlaySoundFile;
local IsControlKeyDown	= _G.IsControlKeyDown;
local floor		= _G.math.floor;
local table		= _G.table;
local t_insert		= _G.table.insert;
local str_format	= _G.string.format;
local str_sub		= _G.string.gsub;
local table		= _G.table;
local string		= _G.string;
local UnitExists	= _G.UnitExists;
local UnitClass		= _G.UnitClass;
local fmod		= _G.math.fmod;
local UnitIsUnit	= _G.UnitIsUnit;

-- Those are lookups table to set the frame attributes
local AvailableButtons = { -- {{{
    "%s1", -- left mouse button
    "%s2", -- right mouse button
    "ctrl-%s1",
    "ctrl-%s2",
    "shift-%s1",
    "shift-%s2",
    "alt-%s1",
    "alt-%s2",
    -- 3, -- middle mouse button || RESERVED FOR TARGETING
}; -- }}}

DC.AvailableButtonsReadable = { -- {{{
    L[D.LOC.HLP_LEFTCLICK], -- left mouse button
    L[D.LOC.HLP_RIGHTCLICK], -- right mouse button
    L[D.LOC.CTRL] .. "-" .. L[D.LOC.HLP_LEFTCLICK],
    L[D.LOC.CTRL] .. "-" .. L[D.LOC.HLP_RIGHTCLICK],
    L[D.LOC.SHIFT] .. "-" .. L[D.LOC.HLP_LEFTCLICK],
    L[D.LOC.SHIFT] .. "-" .. L[D.LOC.HLP_RIGHTCLICK],
    L[D.LOC.ALT] .. "-" .. L[D.LOC.HLP_LEFTCLICK],
    L[D.LOC.ALT] .. "-" .. L[D.LOC.HLP_RIGHTCLICK],
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
}; -- }}}

-- modifier for the macro
local AvailableModifier = { -- {{{
    "shift","ctrl","alt",
} -- }}}

-- MicroUnitF STATIC methods {{{

-- Updates the color table
function MicroUnitF:RegisterMUFcolors ()
   -- MF_colors = D.profile.MF_colors; -- this should be enough but is not because D.profile can change at unexpected times....
    D:tcopy(MF_colors, D.profile.MF_colors);
end

-- defines what is printed when the object is read as a string
function MicroUnitF:ToString() -- {{{
    return "Decursive Micro Unit Frame Object";
end -- }}}

-- The Factory for MicroUnitF objects
function MicroUnitF:Create(ID, Unit) -- {{{

    if (D.Status.Combat) then
	-- if we are fighting, postpone the call
	D:AddDelayedFunctionCall (
	"Create"..ID, self.Create,
	ID, Unit);
	return false;
    end

    -- if we attempt to create a MUF that already exists, update it instead
    if (self.ExistingPerID[ID]) then
	self.ExistingPerID[ID]:UpdateAttributes(Unit);
	-- D:errln("Cannot create %s: already exists", ID);
	return self.ExistingPerID[ID];
    end

    self.Number = self.Number + 1;

    -- create a new MUF object
    self.ExistingPerID[ID] = self:new(D.MFContainer, ID, Unit, self.Number);

    -- (currently ID is the same than Number)
    self.ExistingPerNum[self.Number] = self.ExistingPerID[ID];

    return self.ExistingPerID[ID];
end -- }}}

-- return a MUF object if it exists, nil otherwise
function MicroUnitF:Exists(IdOrNum) -- {{{
    return self.ExistingPerID[IdOrNum] or self.ExistingPerNum[IdOrNum];
end -- }}}

-- return the number MUFs we can use
function MicroUnitF:MFUsableNumber () -- {{{
    return ((self.MaxUnit > D.Status.UnitNum) and D.Status.UnitNum or self.MaxUnit);
end -- }}}

-- this is used when a setting influencing MUF's position is changed
function MicroUnitF:ResetAllPositions () -- {{{
    local MicroFrame = false;

    D:Debug("Resetting all MF position");

    for i=1, self.Number do

	MicroFrame = self.ExistingPerID[i].Frame;

	MicroFrame:SetPoint(unpack(self:GiveMFAnchor(i)));

    end
end -- }}}

-- return the anchor of a given MUF depending on its creation ID
function MicroUnitF:GiveMFAnchor (ID) -- {{{
    local LineNum = floor( (ID - 1) / D.profile.DebuffsFramePerline);
    local NumOnLine = fmod( (ID - 1), D.profile.DebuffsFramePerline);

    local x = (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0) + NumOnLine * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing);
    local y = (D.profile.DebuffsFrameGrowToTop and -1 or 1) * LineNum * ((-1 * D.profile.DebuffsFrameYSpacing) - DC.MFSIZE);


    return { "TOPLEFT", x, y - 20, "TOPLEFT" };
end -- }}}


function MicroUnitF:Delayed_MFsDisplay_Update ()
    if (D.profile.ShowDebuffsFrame) then
	D:ScheduleEvent("Dcr_UpdateMUFsNUM", self.MFsDisplay_Update, 0.2, self);
    end
end

-- This update the MUFs display, show and hide MUFs as necessary
function MicroUnitF:MFsDisplay_Update () -- {{{

    if (not D.profile.ShowDebuffsFrame) then
	return false;
    end

    -- This function cannot do anything if we are fighting
    if (D.Status.Combat) then
	-- if we are fighting, postpone the call
	D:AddDelayedFunctionCall (
	"UpdateMicroUnitFrameDisplay", self.MFsDisplay_Update,
	self);
	return false;
    end

    -- Get an up to date unit array if necessary
    D:GetUnitArray();

    -- =======
    --  Begin
    -- =======
   
    -- get the number of MUFs we should display
    local NumToShow = self:MFUsableNumber();


    -- if we don't have all the MUFs needed then return, we are not ready
    if (self.Number < NumToShow) then
	return false;
    end


    local MF_f = false;
    local MF = false;

    --  D:Debug("self.Number = %d", self.Number);

    local start;
    local Old_UnitShown = self.UnitShown;

    -- if there are more MUFs than the actual unit number
    if self.UnitShown > NumToShow then
	start = NumToShow + 1;
    -- if there is not enough MUFs
    elseif self.UnitShown < NumToShow then
	start = self.UnitShown + 1;
    else
	start = NumToShow;
    end

    D:Debug("Update required: NumToShow = %d, starting at: %d", NumToShow, start);

    for i=start, self.Number do

	if self.ExistingPerID[i] then
	    MF = self.ExistingPerID[i];
	    MF_f = MF.Frame;
	else
	    -- this should not happen
	    D:Debug("%s (positionned at %d) does not has a frame yet", D.Status.Unit_Array[i], i);
	    break;
	end

	-- show/hide and update position if necessary
	if (i <= NumToShow and not MF.Shown) then

	    MF_f:SetPoint(unpack(self:GiveMFAnchor(i)));
	    MF_f:Show();
	    MF.Shown = true;
	    self.UnitShown = self.UnitShown + 1;

	    -- Schedule an update for the MUF we just shown
	    D:ScheduleEvent("Dcr_Update"..MF.CurrUnit, MF.Update, D.profile.DebuffsFrameRefreshRate * (NumToShow + 1 - i), MF, false, false, true);
	    --D:Debug("Showing %d, scheduling update in %f", i, D.profile.DebuffsFrameRefreshRate * (NumToShow + 1 - i));

	elseif (i > NumToShow and MF.Shown) then
	    --D:Debug("Hidding %d", i);

	    -- clear debuff before hiding to avoid leaving 'ghosts' behind...
	    if D.UnitDebuffed[MF.CurrUnit] then
		D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum - 1;
	    end

	    MF.Debuffs			  = false;
	    MF.IsDebuffed		  = false;
	    MF.Debuff1Prio		  = false;
	    MF.PrevDebuff1Prio		  = false;
	    D.UnitDebuffed[MF.CurrUnit]	  = false; -- used by the live-list only
	    D.Stealthed_Units["MF.CurrUnit"] = false;


	    MF.Shown = false;
	    self.UnitShown = self.UnitShown - 1;
	    D:Debug("Hiding %d, scheduling update in %f", i, D.profile.DebuffsFrameRefreshRate * (i - NumToShow));
	    D:ScheduleEvent("Dcr_Update"..MF.CurrUnit, MF.Update, D.profile.DebuffsFrameRefreshRate * (i - NumToShow), MF, false, false);
	    MF_f:Hide();
	end

    end

    if self.UnitShown > 0 and Old_UnitShown ~= self.UnitShown then

	local FirstLineNum = 0;
	local RightEdge = 0;
	local Handle_x = 0;

	if self.UnitShown >= D.profile.DebuffsFramePerline then
	    FirstLineNum = D.profile.DebuffsFramePerline;
	else
	    FirstLineNum = self.UnitShown;
	end

	if D.profile.DebuffsFrameStickToRight then
	    Handle_x = -1 * (FirstLineNum - 1) * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing) * self.Frame:GetEffectiveScale();
	end

	RightEdge = D.profile.DebuffsFrame_x + self.Frame:GetEffectiveScale() * (FirstLineNum * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing) - D.profile.DebuffsFrameXSpacing) + Handle_x;

	if (RightEdge > UIParent:GetWidth() * UIParent:GetEffectiveScale()) then
	    Handle_x = Handle_x - (RightEdge - UIParent:GetWidth() * UIParent:GetEffectiveScale());
	    D:Debug("put the MUF on the screen!!!");
	end

	-- if the handle needs to be moved
	if (Handle_x ~= 0 or D.profile.DebuffsFrameStickToRight) and self.UnitShown > 0 then
	    D.profile.DebuffsFrame_x = D.profile.DebuffsFrame_x + Handle_x;
	    MicroUnitF:Place();
	    MicroUnitF:SavePos();
	end

    end

    return true;
end -- }}}


function MicroUnitF:Delayed_Force_FullUpdate ()
    if (D.profile.ShowDebuffsFrame) then
	D:ScheduleEvent("Dcr_Force_FullUpdate", self.Force_FullUpdate, 0.2, self);
    end
end

function MicroUnitF:Force_FullUpdate () -- {{{
    if (not D.profile.ShowDebuffsFrame) then
	return false;
    end

    -- This function cannot do anything if we are fighting
    if (D.Status.Combat) then
	-- if we are fighting, postpone the call
	D:AddDelayedFunctionCall (
	"Force_FullUpdate", self.Force_FullUpdate,
	self);
	return false;
    end

    local MF;--, MF_f;

    D.Status.SpellsChanged = GetTime(); -- will force an update of all MUFs attributes

    for i=1, self.Number do
	if self.ExistingPerID[i] then
	    MF = self.ExistingPerID[i];
	    MF.UnitStatus = 0; -- reset status to force SetColor to update
	    MF.TooltipUpdate = 0; -- force help tooltip to update
	    --MF_f = MF.Frame;

	    MF.ChronoFontString:SetTextColor(unpack(MF_colors[D.LOC.COLORCHRONOS]));

	    D:ScheduleEvent("Dcr_Update"..MF.CurrUnit, MF.Update, D.profile.DebuffsFrameRefreshRate * i, MF, false, false, true);
	end
    end
end -- }}}


-- Those set the scalling of the MUF container
-- SACALING FUNCTIONS (MicroUnitF Children) {{{
-- Place the MUFs container according to its scale
function MicroUnitF:Place () -- {{{
    local UIScale	= UIParent:GetEffectiveScale()
    local FrameScale	= self.Frame:GetEffectiveScale();
    local x, y = D.profile.DebuffsFrame_x, D.profile.DebuffsFrame_y;

    -- check if the coordinates are correct
    if x and y and (x + 10 > UIParent:GetWidth() * UIScale or x < 0 or (-1 * y + 10) > UIParent:GetHeight() * UIScale or y > 0) then
	x = false; -- reset to default position
	message("MUFs position reset to default");
    end

    -- If executed for the very first time, then put it in the top right corner of the screen
    if (not x or not y) then
	x =    (UIParent:GetWidth() * UIScale) - (UIParent:GetWidth() * UIScale) / 4;
	y =  - (UIParent:GetHeight() * UIScale) / 5;

	D.profile.DebuffsFrame_x = x;
	D.profile.DebuffsFrame_y = y;
    end

    -- set to the scaled position
    self.Frame:ClearAllPoints();
    self.Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x/FrameScale , y/FrameScale);
end -- }}}

-- Save the position of the frame without its scale
function MicroUnitF:SavePos () -- {{{
    if self.Frame:IsVisible() then
	-- We save the unscalled position (no problem if the sacale is changed behind our back)
	D.profile.DebuffsFrame_x = self.Frame:GetEffectiveScale() * self.Frame:GetLeft();
	D.profile.DebuffsFrame_y = self.Frame:GetEffectiveScale() * self.Frame:GetTop() - UIParent:GetHeight() * UIParent:GetEffectiveScale();


	-- if we choosed to align the MUF to the right then we have to add the
	-- width of the first line
	if D.profile.DebuffsFrameStickToRight and self.UnitShown > 1 then
	    if self.UnitShown >= D.profile.DebuffsFramePerline then
		D.profile.DebuffsFrame_x = D.profile.DebuffsFrame_x + (D.profile.DebuffsFramePerline - 1)   * (DC.MFSIZE  + D.profile.DebuffsFrameXSpacing) * self.Frame:GetEffectiveScale();
	    else
		D.profile.DebuffsFrame_x = D.profile.DebuffsFrame_x + (self.UnitShown - 1)		    * (DC.MFSIZE  + D.profile.DebuffsFrameXSpacing) * self.Frame:GetEffectiveScale();
	    end
	end


	if D.profile.DebuffsFrame_x < 0 then
	    D.profile.DebuffsFrame_x = 0;
	end

	if D.profile.DebuffsFrame_y > 0 then
	    D.profile.DebuffsFrame_y = 0;
	end

	--	D:Debug("Frame position saved");
    end

end -- }}}

-- set the scaling of the MUFs container according to the user settings
function MicroUnitF:SetScale (NewScale) -- {{{
    
    -- save the current position without any scaling
    self:SavePos ();
    -- Setting the new scale
    self.Frame:SetScale(NewScale);
    -- Place the frame adapting its position to the news cale
    self:Place ();
    
end -- }}}
-- }}}

-- Update the MUF of a given unitid
function MicroUnitF:UpdateMUFUnit(Unitid, CheckStealth)
    if not D.profile.ShowDebuffsFrame then
	return;
    end

    if (not Unitid) then
	D:Debug("XXXXX ==> UpdateMUFUnit: Unitid was nil!");
    end

    -- Update the unit array (GetUnitArray() will do something only if necessary)
    D:GetUnitArray();

    local unit = false;

    if (D.Status.Unit_Array_UnitToName[Unitid]) then -- XXX Unit_Array_UnitToName not reliable
	unit = Unitid;
    elseif (Unitid == "focus") then
	unit = "focus";
    else
	D:Debug("Unit %s, not in raid or party!", Unitid);
	return;
    end

    -- get the MUF object
    local MF = self.UnitToMUF[unit];

    if (MF and MF.Shown) then
	-- The MUF will be updated only every DebuffsFrameRefreshRate seconds at most
	-- but we don't miss any event XXX note this can be the cause of slowdown if 25 or 40 players got debuffed at the same instant, DebuffUpdateRequest is here to prevent that since 2008-02-17
	if (not D:IsEventScheduled("Dcr_Update"..unit)) then
	    D.DebuffUpdateRequest = D.DebuffUpdateRequest + 1;
	    D:ScheduleEvent("Dcr_Update"..unit, MF.Update, D.profile.DebuffsFrameRefreshRate * (1 + floor(D.DebuffUpdateRequest / (D.profile.DebuffsFramePerUPdate / 2))), MF, false, false, CheckStealth);
	    D:Debug("Update scheduled for, ", unit, MF.ID);


	    return true; -- return value used to aknowledge that the function actually did something
	end
    else
	D:Debug("No MUF found for ", unit, Unitid);
    end
end

-- Event management functions
-- MUF EVENTS (MicroUnitF children) (OnEnter, OnLeave, OnCornerClick, OnLoad, OnPreClick) {{{
-- It's outside the function to avoid creating and discarding this table at each call
local DefaultTTAnchor = {"ANCHOR_TOPLEFT", 0, 6};
-- This function is responsible for showing the tooltip when the mouse pointer is over a MUF
function MicroUnitF:OnEnter() -- {{{
    D.Status.MouseOveringMUF = true;

    local MF = this.Object;
    local Status;

    local Unit = MF.CurrUnit; -- shortcut
    local TooltipText = "";

    --[=[
    D:ScheduleEvent("Dcr_testOnEnter", function(Unit)
	if UnitIsVisible(Unit) and not UnitIsUnit("mouseover", Unit) then
	    D:Println("|cFFFF0000ALERT:|r |cFFFFFF60Something strange is happening, mouseover is not MUF!, report this to archarodim@teaser.fr|r", (UnitName("mouseover")), (UnitName(Unit)));
	end
    end, 0, Unit );
    --]=]


    -- Compare the current unit name to the one storred when the group data were collected
    if (D:PetUnitName(  Unit, true   )) ~= D.Status.Unit_Array_UnitToName[Unit] then -- XXX Unit_Array_UnitToName not reliable
	D.Status.Unit_Array_UnitToName[Unit] = D:PetUnitName(  Unit, true    );
    end

    MF:Update(false, false, true); -- will reset the color early and set the current status of the MUF
    MF:SetClassBorder(); -- set the border if it wasn't possible at the time the unit was discovered

    if not Unit then
	return; -- If the user overs the MUF befor it's completely initialized
    end

    if (D.profile.AfflictionTooltips) then


	-- removes the CHARMED_STATUS bit from Status, we don't need it
	Status = bit.band(MF.UnitStatus,  bit.bnot(CHARMED_STATUS));



	-- First, write the name of the unit in its class color
	if (UnitExists(MF.CurrUnit)) then
	    TooltipText =
	    -- Colored unit name
	    -- D:ColorText(	    (D:PetUnitName(	  Unit, true    )) -- cannot be replaced by MF.UnitName, (UnitName is set by SetClassBorder only if class borders are displayed)
	    D:ColorText(	    (D:PetUnitName(	  Unit, true    ))
	    , "FF" .. ((UnitClass(Unit)) and DC.HexClassColor[ (select(2, UnitClass(Unit))) ] or "AAAAAA")) .. "  |cFF3F3F3F(".. Unit .. ")|r";
	end


	-- set UnitStatus text
	local StatusText = "";

	-- set the status text, just translate the bitfield to readable text
	if (Status == NORMAL) then
	    StatusText = L[D.LOC.NORMAL];

	elseif (Status == ABSENT) then
	    StatusText = str_format(L[D.LOC.ABSENT], Unit);

	elseif (Status == FAR) then
	    StatusText = L[D.LOC.TOOFAR];

	elseif (Status == STEALTHED) then
	    StatusText = L[D.LOC.STEALTHED];

	elseif (Status == BLACKLISTED) then
	    StatusText = L[D.LOC.BLACKLISTED];

	elseif (MF.Debuffs and (Status == AFFLICTED or Status == AFFLICTED_NIR)) then
	    local DebuffType = MF.Debuffs[1].Type;
	    StatusText = str_format(L[D.LOC.AFFLICTEDBY], D:ColorText( L[DC.TypeNames[DebuffType]], "FF" .. DC.TypeColors[DebuffType]) );
	end

	-- Unit Status
	TooltipText = TooltipText .. "\n" .. L[D.LOC.UNITSTATUS] .. StatusText .. "\n";

	-- list the debuff(s) names
	if (MF.Debuffs) then
	    for i, Debuff in ipairs(MF.Debuffs) do
		if (Debuff.Type) then
		    local DebuffApps = Debuff.Applications;
		    TooltipText = TooltipText .. "\n" .. str_format("%s", D:ColorText(Debuff.Name, "FF" .. DC.TypeColors[Debuff.Type])) .. (DebuffApps>0 and str_format(" (%d)", DebuffApps) or "");

		    -- Create a warning if the Unstable Affliction is detected
		    if Debuff.Name == DS["Unstable Affliction"] then
		    --if Debuff.Name == "Malédiction de Stalvan" then -- to test easily
			D:Println("|cFFFF0000 ==> %s !!|r (%s)", DS["Unstable Affliction"], D:MakePlayerName((D:PetUnitName(	  Unit, true    ))));
			PlaySoundFile("Sound\\Doodad\\G_NecropolisWound.wav");
		    end

		else
		    break;
		end
	    end
	end

	-- we use it to anchor the tooltip
	local FirstMUF = self.ExistingPerNum[1].Frame;

	-- finally display the tooltip
	D:DisplayTooltip( TooltipText , FirstMUF, DefaultTTAnchor);
    end

    -- show a help text in the Game default tooltip
    if (D.profile.DebuffsFrameShowHelp) then
	local helpText = MF.TooltipButtonsInfo;
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetText(helpText);
	GameTooltip:Show();

    end

end -- }}}

function MicroUnitF:OnLeave() -- {{{
    D.Status.MouseOveringMUF = false;
    --D:Debug("Micro unit Hidden");
    DcrDisplay_Tooltip:Hide();

    if (D.profile.DebuffsFrameShowHelp) then
	GameTooltip:Hide();
    end
end -- }}}

function MicroUnitF:OnCornerClick (arg1, CallingObject) -- {{{
    --D:Debug("clicked");

    if (not CallingObject) then
	CallingObject = "noframe";
    end

    if (arg1 == "RightButton" and not IsShiftKeyDown()) then

	if (not IsAltKeyDown()) then
	   ---[[
	   D.DewDrop:Open(CallingObject,
	    'children', function()
		D.DewDrop:FeedAceOptionsTable( D.options )
	    end
	    );
	    --]]
	else
	    D.Waterfall:Open("Decursive");
	end

    elseif (arg1 == "RightButton" and IsShiftKeyDown()) then
	D:HideBar();
    elseif (arg1 == "LeftButton" and IsControlKeyDown()) then
	D:ShowHidePriorityListUI();
    elseif (arg1 == "LeftButton" and IsShiftKeyDown()) then
	D:ShowHideSkipListUI();
    end

end -- }}}

function D.MicroUnitF:OnCornerEnter()
    if (D.profile.DebuffsFrameShowHelp) then
	D:DisplayGameTooltip(
	str_format(
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r: %s\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s",

	D.L[D.LOC.ALT],		D.L[D.LOC.HLP_LEFTCLICK],	D.L[D.LOC.HANDLEHELP],

	D.L[D.LOC.HLP_RIGHTCLICK],	D.L[D.LOC.STR_OPTIONS],
	D.L[D.LOC.ALT],		D.L[D.LOC.HLP_RIGHTCLICK],	D.L[BINDING_NAME_DCRSHOWOPTION],

	D.L[D.LOC.CTRL],		D.L[D.LOC.HLP_LEFTCLICK],	D.L[BINDING_NAME_DCRPRSHOW], 
	D.L[D.LOC.SHIFT],		D.L[D.LOC.HLP_LEFTCLICK],	D.L[BINDING_NAME_DCRSKSHOW],

	D.L[D.LOC.SHIFT],		D.L[D.LOC.HLP_RIGHTCLICK],	D.L[BINDING_NAME_DCRSHOW]
	));
    end;
end


function MicroUnitF:OnLoad() -- {{{
    this:SetScript("PreClick", self.OnPreClick);
    this:SetScript("PostClick", self.OnPostClick);
end
-- }}}

function MicroUnitF:OnPreClick(Button) -- {{{
	-- D:Debug("Micro unit Preclicked: ", Button);

	local Unit = this.Object.CurrUnit; -- shortcut

	if UnitIsVisible(Unit) and not UnitIsUnit("mouseover", Unit) then
	    D:Println("|cFFFF0000ALERT:|r |cFFFFFF60Something strange is happening, mouseover is not MUF(%s)! MOn='%s', Un='%s', UpT=%d\n report this to archarodim@teaser.fr|r",Unit, (UnitName("mouseover")), (UnitName(Unit)), (GetTime() - DC.StartTime));

	    --	     this.Object:UpdateAttributes(Unit);

	end

	if (this.Object.UnitStatus == NORMAL and (Button == "LeftButton" or Button == "RightButton")) then

	    D:Println(L[D.LOC.HLP_NOTHINGTOCURE]);

	elseif (this.Object.UnitStatus == AFFLICTED) then
	    local NeededPrio = D:GiveSpellPrioNum(this.Object.Debuffs[1].Type);
	    local RequestedPrio = false;

	    if (Button == "LeftButton") then
		if (IsControlKeyDown()) then
		    RequestedPrio = 3;
		else
		    RequestedPrio = 1;
		end
	    elseif (Button == "RightButton") then
		if (IsControlKeyDown()) then
		    RequestedPrio = 4;
		else
		    RequestedPrio = 2;
		end
	    end

	    if (RequestedPrio and NeededPrio ~= RequestedPrio) then
		D:errln(L[D.LOC.HLP_WRONGMBUTTON]);
		D:Println(L[D.LOC.HLP_USEXBUTTONTOCURE], D:ColorText(DC.AvailableButtonsReadable[NeededPrio], D:NumToHexColor(MF_colors[NeededPrio])));

	    elseif RequestedPrio and D.Status.HasSpell then
--		D:Print("XXX ClickedMF SET");
		D.Status.ClickedMF = this.Object; -- used to update the MUF on cast success and failure to know which unit is being cured
		D:Debuff_History_Add(this.Object.Debuffs[1].Name, this.Object.Debuffs[1].TypeName);
	    end
	end
end -- }}}

-- }}}

-- }}}



-- MicroUnitF NON STATIC METHODS {{{
-- init a new micro frame (Call internally by :new() only)
function MicroUnitF.prototype:init(Container,ID, Unit, FrameNum) -- {{{
	MicroUnitF.super.prototype.init(self); -- needed

	D:Debug("Initializing MicroUnit object '%s' with FrameNum=%d", ID, FrameNum);


	-- set object default variables
	self.Parent		= Container;
	self.ID			= ID;
	self.FrameNum		= FrameNum;
	self.Debuffs		= false;
	self.Debuff1Prio	= false;
	self.PrevDebuff1Prio	= false;
	self.IsDebuffed		= false;
	self.CurrUnit		= "";
	self.UnitName		= false;
	self.UnitClass		= false;
	self.UnitStatus		= 0;
	self.FirstDebuffType	= 0;
	self.NormalAlpha	= false;
	self.BorderAlpha	= false;
	self.Color		= {};
	self.IsCharmed		= false;
	self.UpdateCountDown	= 3;
	self.LastAttribUpdate	= 0;
	self.LitTime		= false;
	self.Chrono		= false;
	self.PrevChrono		= false;

	-- create the frame
	self.Frame  = CreateFrame ("Button", "DcrMicroUnit"..ID, self.Parent, "DcrMicroUnitTemplateSecure");

	-- outer texture (the class border)
	-- Bottom side
	self.OuterTexture1 = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Bottom", "BORDER");
	self.OuterTexture1:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 0);
	self.OuterTexture1:SetPoint("TOPRIGHT", self.Frame, "BOTTOMRIGHT",  0, 2);

	-- left side
	self.OuterTexture2 = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Left", "BORDER");
	self.OuterTexture2:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, -2);
	self.OuterTexture2:SetPoint("BOTTOMRIGHT", self.Frame, "BOTTOMLEFT", 2, 2);

	-- top side
	self.OuterTexture3 = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Top", "BORDER");
	self.OuterTexture3:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, 0);
	self.OuterTexture3:SetPoint("BOTTOMRIGHT", self.Frame, "TOPRIGHT", 0, -2);

	-- right side
	self.OuterTexture4 = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Right", "BORDER");
	self.OuterTexture4:SetPoint("TOPRIGHT", self.Frame, "TOPRIGHT", 0, -2);
	self.OuterTexture4:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMRIGHT", -2, 2);


	-- global texture
	self.Texture = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Back", "ARTWORK");
	self.Texture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.Texture:SetHeight(16);
	self.Texture:SetWidth(16);

	-- inner Texture (Charmed special texture)
	self.InnerTexture = self.Frame:CreateTexture("DcrMicroUnit"..ID.."Charmed", "OVERLAY");
	self.InnerTexture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.InnerTexture:SetHeight(7);
	self.InnerTexture:SetWidth(7);
	self.InnerTexture:SetTexture(unpack(MF_colors[CHARMED_STATUS]));

	-- Chrono Font string
	self.ChronoFontString = self.Frame:CreateFontString("DcrMicroUnit"..ID.."Chrono", "OVERLAY", "DcrMicroUnitChronoFont");
	self.ChronoFontString:SetTextColor(unpack(MF_colors[D.LOC.COLORCHRONOS]));

	-- a reference to this object
	self.Frame.Object = self;

	-- register events
	self.Frame:RegisterForClicks("AnyUp");
	self.Frame:SetFrameStrata("MEDIUM");

	-- set the frame attributes
	self:UpdateAttributes(Unit);

	-- once the MF frame is set up, schedule an event to show and place it
	MicroUnitF:Delayed_MFsDisplay_Update();
end -- }}}


function MicroUnitF.prototype:Update(SkipSetColor, SkipDebuffs, CheckStealth)

    local MF = self;
    -- get the unit this MUF should show
    local Unit = D.Status.Unit_Array[MF.ID]; -- get the unit the MUF _should_ be attached to.
    local ActionsDone = 0;

    if not Unit then -- This unit no longer exists (number of MUF higher than number of units)
	--D:Debug("No Unit for MUF #", MF.ID);
	if MF.CurrUnit ~= "" then -- There is a unit attached to this MUF
	    Unit = MF.CurrUnit; -- we will update the MUF according to its current unit.
	    --D:Debug(" Using previous unit: ", MF.CurrUnit);
	else
	    return 0 -- This MUF has no purpose at all then...
	end
    end

    -- The unit is the same but the name isn't... (check for class change)
    if MF.CurrUnit == Unit and D.Status.Unit_Array_UnitToName[self.CurrUnit] ~= self.UnitName then -- XXX us the event UNIT_NAME, more reliable...
	if MF:SetClassBorder() then
	    ActionsDone = ActionsDone + 1; -- count expensive things done
	end
    end

    -- Update the frame attributes if necessary (Spells priority or unit id changes)
    if (D.Status.SpellsChanged ~= MF.LastAttribUpdate or MF.CurrUnit ~= Unit) then
	--D:Debug("Attributes update required: ", MF.ID);
	if (MF:UpdateAttributes(Unit, true)) then
	    ActionsDone = ActionsDone + 1; -- count expensive things done
	    SkipSetColor = false; SkipDebuffs = false; -- if some attributes were updated then update the rest
	end
    end

    if (not SkipSetColor) then
	if (not SkipDebuffs) then
	    -- get the manageable debuffs of this unit
	    MF:SetDebuffs();
	    --D:Debug("Debuff set for ", MF.ID);
	    if CheckStealth then
		D.Stealthed_Units[Unit] = D:CheckUnitStealth(Unit); -- update stealth status
--		D:Debug("MF:Update(): Stealth status checked as requested.");
	    end
	end

	if (MF:SetColor()) then
	    ActionsDone = ActionsDone + 1; -- count expensive things done
	end
    end

    return ActionsDone;
end

-- UPDATE attributes (Spells and Unit) {{{



do
    -- used to tell if we changed something to improve performances.
    -- Each attribute change trigger an event...
    local ReturnValue = false;
    -- this updates the sttributes of the MUF's frame object
    function MicroUnitF.prototype:UpdateAttributes(Unit, DoNotDelay)

	-- Delay the call if we are fighting
	if (D.Status.Combat) then
	    if not DoNotDelay then
		D:AddDelayedFunctionCall (
		"MicroUnit_" .. self.ID, self.UpdateAttributes,
		self, Unit);
	    end
	    return false;
	end

	--D:Debug("UpdateAttributes called for %s", Unit);

	ReturnValue = false;

	-- if the unit changed
	if (self.CurrUnit ~= Unit) then 
	    --self.Frame:SetAttribute("unit", "player"); -- XXX test if the unit really changes without this line
	    self.Frame:SetAttribute("unit", Unit);

	    -- UnitToMUF[] can only be set when out of fight so it remains
	    -- coherent with what is displayed when groups are changed during a
	    -- fight
	    MicroUnitF.UnitToMUF[Unit] = self;

	    self.CurrUnit = Unit;

	    self:SetClassBorder();

	    -- set the return value because we did something expensive
	    ReturnValue = self;
	end

	-- if the spell settings (the priority order or available spells) did not changed
	if (D.Status.SpellsChanged == self.LastAttribUpdate) then
	    return ReturnValue;
	end

--	D:Debug("UpdateAttributes() executed");
	-- set the mouse middle-button action
	self.Frame:SetAttribute("type3", "target"); --never changes

	-- set the mouse ctrl-middle-button action
	self.Frame:SetAttribute("ctrl-type3", "focus"); -- never changes

	-- set the mouse left-button action
	--self.Frame:SetAttribute("type1", "target"); -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("type1", "macro");

	-- set the mouse ctrl-left-button action
	--self.Frame:SetAttribute("ctrl-type1", "target");  -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("ctrl-type1", "macro");

	-- set the mouse right-button action
	--self.Frame:SetAttribute("type2", "target"); -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("type2", "macro");

	-- set the mouse ctrl-right-button action
	--self.Frame:SetAttribute("ctrl-type2", "target"); -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("ctrl-type2", "macro");

	-- We need:
	--
	--  - a table telling the priority of each spell
	--		D.Status.CuringSpellsPrio [ __SPELL_NAME__ ] = __PRIO_NUM__

	-- if necessary we will update the help tooltip text
	if (D.Status.SpellsChanged ~= self.TooltipUpdate) then
	    self.TooltipButtonsInfo = {};
	end

	-- set the spells attributes using the lookup tables above
	for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do

	    --self.Frame:SetAttribute(str_format(AvailableButtons[Prio], "spell"), Spell);
	    self.Frame:SetAttribute(str_format(AvailableButtons[Prio], "macrotext"), str_format("%s/cast [target=mouseover] %s%s",
	    ((not D.Status.FoundSpells[Spell][1]) and "/stopcasting\n" or ""),
	    Spell,
	    (DC.SpellsToUse[Spell].Rank and "(" .. (str_sub(DC.RANKNUMTRANS, '%d+', DC.SpellsToUse[Spell].Rank)) .. ")" or "")  ));

	    
	    --[[
	    D:Debug("XX-> macro: ",str_format(AvailableButtons[Prio], "macrotext"), str_format("%s/cast [target=mouseover] %s%s",
	    ((not D.Status.FoundSpells[Spell][1]) and "/stopcasting\n" or ""),
	    Spell,
	    (DC.SpellsToUse[Spell].Rank and "(" .. (str_sub(DC.RANKNUMTRANS, '%d+', DC.SpellsToUse[Spell].Rank)) .. ")" or "")  ));
	    --]]

	    -- set the tooltip text for the current prio if necessary
	    if (D.Status.SpellsChanged ~= self.TooltipUpdate) then
		self.TooltipButtonsInfo[Prio] =
		str_format("%s: %s", D:ColorText(DC.AvailableButtonsReadable[Prio], D:NumToHexColor(MF_colors[Prio])), Spell);
	    end
	end

	-- concatenate the tooltip text if necessary
	if (D.Status.SpellsChanged ~= self.TooltipUpdate) then
	    t_insert(self.TooltipButtonsInfo, str_format("%s: %s", L[D.LOC.HLP_MIDDLECLICK], L[D.LOC.TARGETUNIT]));
	    t_insert(self.TooltipButtonsInfo, str_format("%s: %s", L[D.LOC.CTRL] .. "-" .. L[D.LOC.HLP_MIDDLECLICK], L[D.LOC.FOCUSUNIT]));
	    self.TooltipButtonsInfo = table.concat(self.TooltipButtonsInfo, "\n");
	    self.TooltipUpdate = D.Status.SpellsChanged;
	end

	self.Debuff1Prio = false;

	-- the update timestamp
	self.LastAttribUpdate = D.Status.SpellsChanged;
	return self;
    end
end -- }}}

function MicroUnitF.prototype:SetDebuffs() -- {{{
    self.Debuffs, self.IsCharmed = D:UnitCurableDebuffs(self.CurrUnit);

    if D.UnitDebuffed[self.CurrUnit] then
	D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum - 1;
    end

    if (self.Debuffs and self.Debuffs[1] and self.Debuffs[1].Type) then
	--D:Debug("A debuff was found"); -- XXX
	self.IsDebuffed = true;
	self.Debuff1Prio = D:GiveSpellPrioNum( self.Debuffs[1].Type );

	D.UnitDebuffed[self.CurrUnit] = true;
	D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum + 1;

    else
	--D:Debug("No debuff found"); -- XXX
	self.IsDebuffed			= false;
	self.Debuff1Prio		= false;
	self.PrevDebuff1Prio		= false;
	D.UnitDebuffed[self.CurrUnit] = false; -- used by the live-list only
    end
end -- }}}

do
    --[=[
    --	    This function is responsible for setting all the textures of a MUF object:
    --		- The main color
    --		- Showing/Hiding the charmed alert square
    --		- The Alpha of the center and borders
    --	    This function also set the Status of the MUF that will be used in the tooltip
    --]=]
    local DebuffType, Unit, PreviousStatus, BorderAlpha, Class, ClassColor, ReturnValue, RangeStatus, Alpha, PrioChanged, PrevChrono, Time;
    local profile = {};

    -- global access optimization
    local IsSpellInRange    = _G.IsSpellInRange;
    local UnitClass	    = _G.UnitClass;
    local UnitExists	    = _G.UnitExists;
    local UnitIsVisible	    = _G.UnitIsVisible;
    local UnitLevel	    = _G.UnitLevel;
    local unpack	    = _G.unpack;
    local select	    = _G.select;
    local GetTime	    = _G.GetTime;
    local floor		    = _G.math.floor;
    local fmod		    = _G.math.fmod;

    function MicroUnitF.prototype:SetColor() -- {{{

	profile = D.profile;

	-- register default alpha of the border
	BorderAlpha =  profile.DebuffsFrameElemBorderAlpha;

	-- register local variables
	DebuffType = false;
	ReturnValue = false;
	Unit = self.CurrUnit;
	PreviousStatus = self.UnitStatus;



	-- if unit not available, if a unit cease to exist (this happen often for pets)
	if not UnitExists(Unit) then
	    if PreviousStatus ~= ABSENT then
		self.Color = MF_colors[ABSENT];
		self.UnitStatus = ABSENT;
		if self.LitTime then
		    self.LitTime = false;
		    self.ChronoFontString:SetText(" ");

		end
	    end

	    -- UnitIsVisible() behavior is not 100% reliable so we also use UnitLevel() that will return -1 when the Unit is too far...
	elseif not UnitIsVisible(Unit) or UnitLevel(Unit) < 1 then
	    if PreviousStatus ~= FAR then
		self.Color = MF_colors[FAR];
		self.UnitStatus = FAR;
		if self.LitTime then
		    self.LitTime = false;
		    self.ChronoFontString:SetText(" ");

		end
	    end

	else
	    -- If the Unit is invisible
	    if D.profile.Ingore_Stealthed and D.Stealthed_Units[Unit] then
		if PreviousStatus ~= STEALTHED then
		    self.Color = MF_colors[STEALTHED];
		    self.UnitStatus = STEALTHED;
		    if self.LitTime then
			self.LitTime = false;
			self.ChronoFontString:SetText(" ");

		    end
		end

		-- if unit is blacklisted
	    elseif D.Status.Blacklisted_Array[Unit] then
		if PreviousStatus ~= BLACKLISTED then
		    self.Color = MF_colors[BLACKLISTED];
		    self.UnitStatus = BLACKLISTED;
		    if self.LitTime then
			self.LitTime = false;
			self.ChronoFontString:SetText(" ");

		    end
		end

		-- if the unit has some debuffs we can handle
	    elseif (self.IsDebuffed) then
		DebuffType = self.Debuffs[1].Type;

		if self.PrevDebuff1Prio ~= self.Debuff1Prio then
		    self.Color = MF_colors[self.Debuff1Prio];
		    self.PrevDebuff1Prio = self.Debuff1Prio;
		    PrioChanged = true;
		end

		-- Test if the spell we are going to use is in range
		-- Some time can elapsed between the instant the debuff is detected and the instant it is shown.
		-- Between those instants, a reconfiguration can happen (pet dies or some spells become unavailable)
		-- So we test before calling this api that we can still cure this debuff type
		if D.Status.CuringSpells[DebuffType] then
		    RangeStatus = IsSpellInRange(D.Status.CuringSpells[DebuffType], Unit);
		else
		    RangeStatus = false;
		end

		-- update the chrono
		if profile.DebuffsFrameChrono then
		    if self.LitTime then
			Time = GetTime();
			PrevChrono = self.Chrono;

			self.Chrono = floor(Time - self.LitTime + 0.5);

			if self.Chrono ~= PrevChrono then
			    self.ChronoFontString:SetText( ((self.Chrono < 60) and self.Chrono or (floor(self.Chrono / 60) .. "\'") ));
			end
		    else
			self.LitTime = GetTime();
			
		    end
		end


		-- set the status according to RangeStatus
		if (not RangeStatus or RangeStatus == 0) then
		    Alpha = 0.40;
		    self.UnitStatus = AFFLICTED_NIR;

		    --  if profile.LV_OnlyInRange then
		    --	D.UnitDebuffed[self.CurrUnit] = false;
		    --  end
		else
		    Alpha = 1;
		    self.UnitStatus = AFFLICTED;
		    BorderAlpha = 1;

		    MicroUnitF.UnitsDebuffedInRange = MicroUnitF.UnitsDebuffedInRange + 1;

		    if (not D.Status.SoundPlayed) then
			D:PlaySound (self.CurrUnit, "SetColor()" );
		    end
		end
	    elseif PreviousStatus ~= NORMAL then
		-- the unit has nothing special, set the status to normal
		self.Color = MF_colors[NORMAL];
		self.UnitStatus = NORMAL;
		if self.LitTime then
		    self.LitTime = false;
		    self.ChronoFontString:SetText(" ");
		end

		-- if the previous status was FAR, trigger a full rescan of the unit XXX
		if PreviousStatus == FAR then
		    D.MicroUnitF:UpdateMUFUnit(self.CurrUnit, true); -- this is able to deal when a lot of update queries
		end
		

	    end
	end

	if PreviousStatus == AFFLICTED or PreviousStatus == AFFLICTED_AND_CHARMED  then
	    MicroUnitF.UnitsDebuffedInRange = MicroUnitF.UnitsDebuffedInRange - 1;

	    --if (MicroUnitF.UnitsDebuffedInRange == 0 and profile.LV_OnlyInRange) then
	    if (MicroUnitF.UnitsDebuffedInRange == 0 and profile.Hide_LiveList) then
		Dcr:Debug("SetColor(): No more unit, sound re-enabled");
		D.Status.SoundPlayed = false;
	    end
	end

	if (not profile.DebuffsFrameElemBorderShow) then
	    BorderAlpha = 0;
	end


	-- set the class border color when needed (the class is unknown and the unit exists or the unit name changed)
	--self:SetClassBorder();
	
	-- set the alpha of the border if necessary
	if (self.BorderAlpha ~= BorderAlpha) then
	    self.OuterTexture1:SetAlpha(BorderAlpha);
	    self.OuterTexture2:SetAlpha(BorderAlpha);
	    self.OuterTexture3:SetAlpha(BorderAlpha);
	    self.OuterTexture4:SetAlpha(BorderAlpha);

	    self.BorderAlpha = BorderAlpha;

	    -- set this to true because we just did something expensive...
	    ReturnValue = true;
	    --D:Debug("border alpha set");
	end


	-- Add the charm status to the bitfield (note that it's treated separatly because it's shown even if the unit is not afflicetd by anything we can cure)
	if (self.IsCharmed) then
	    self.UnitStatus = bit.bor( self.UnitStatus, CHARMED_STATUS);
	end

	-- if the unit is not afflicted or too far set the color to a lower alpha
	if (not DebuffType) then -- if DebuffType was not set, it means that the unit is too far
	    Alpha = self.Color[4] * profile.DebuffsFrameElemAlpha;
	    self.PrevDebuff1Prio = false;
	end


	-- Apply the colors and alphas only if necessary
	--	The MUF status changed
	--	The user changed the defaultAlpha
	--	The priority (and thus the color) of the first affliction changed
	if (self.UnitStatus ~= PreviousStatus or self.NormalAlpha ~= profile.DebuffsFrameElemAlpha or PrioChanged) then-- or self.FirstDebuffType ~= DebuffType) then

	    if PrioChanged then PrioChanged = false; end

	    -- Set the main texture
	    self.Texture:SetTexture(self.Color[1], self.Color[2], self.Color[3], Alpha);
	    --self.Texture:SetAlpha(Alpha);

	    -- Show the charmed alert square
	    if (self.IsCharmed) then
		self.InnerTexture:Show();
	    else
		self.InnerTexture:Hide();
	    end

	    --D:Debug("Color Applied, MUF Status:", self.UnitStatus);


	    -- save the current global status
	    self.NormalAlpha = profile.DebuffsFrameElemAlpha;
	    self.FirstDebuffType = DebuffType;

	    -- set this to true because we just did something expensive...
	    ReturnValue = true;
	end

	return ReturnValue;

    end -- }}}

    function MicroUnitF.prototype:SetClassBorder()
	ReturnValue = false;
-- XXX Unit_Array_UnitToName not reliable
	if (D.profile.DebuffsFrameElemBorderShow and (D.Status.Unit_Array_UnitToName[self.CurrUnit] ~= self.UnitName or (not self.UnitClass and UnitExists(self.CurrUnit)))) then

	    -- Get the name of this unit
	    self.UnitName = D.Status.Unit_Array_UnitToName[self.CurrUnit];

	    if self.UnitName then -- can be nil because of focus...
		-- Get its class
		Class = (select(2, UnitClass(self.CurrUnit)));
	    else
		Class = false;
	    end

	    -- if the class changed
	    if (Class and Class ~= self.UnitClass) then
		ClassColor = DC.ClassesColors[Class];
		-- update the border color (the four borders)
		self.OuterTexture1:SetTexture(  unpack(ClassColor) );
		self.OuterTexture2:SetTexture(  unpack(ClassColor) );
		self.OuterTexture3:SetTexture(  unpack(ClassColor) );
		self.OuterTexture4:SetTexture(  unpack(ClassColor) );

		-- save the class for futur reference
		self.UnitClass = Class;

		-- set this to true because we just did something expensive...
		ReturnValue = true;

		--D:Debug("Class '%s' set for '%s'", Class, self.CurrUnit);
	    elseif not Class and self.UnitClass then
		-- if the class is not available, set it to false so this test will be done again and again until a class is found
		self.UnitClass = false;
		BorderAlpha = 0;
		self.OuterTexture1:SetAlpha(BorderAlpha);
		self.OuterTexture2:SetAlpha(BorderAlpha);
		self.OuterTexture3:SetAlpha(BorderAlpha);
		self.OuterTexture4:SetAlpha(BorderAlpha);

		self.BorderAlpha = BorderAlpha;

		ReturnValue = true;
		--D:Debug("Class of unit %s is Nil", self.CurrUnit);
	    end
	end
	return ReturnValue;

    end

end 
-- }}}

do
    local MicroFrameUpdateIndex = 1; -- MUFs are not updated all together
    local NumToShow, ActionsDone, Unit, MF, pass;
    -- updates the micro frames if needed (called regularly by ACE event, changed in the option menu)
    function D:DebuffsFrame_Update() -- {{{

	-- Update the unit array (GetUnitArray() will do something only if necessary)
	if (self.Groups_datas_are_invalid) then
	    self:GetUnitArray();
	end

	NumToShow = ((MicroUnitF.MaxUnit > self.Status.UnitNum) and self.Status.UnitNum or MicroUnitF.MaxUnit);
	--NumToShow = MicroUnitF:MFUsableNumber();

	ActionsDone = 0; -- used to limit the maximum number of consecutive UI actions


	-- we don't check all the MUF at each call, only some of them (changed in the options)
	for pass = 1, self.profile.DebuffsFramePerUPdate do

	    -- When all frames have been updated, go back to the first
	    if (MicroFrameUpdateIndex > NumToShow) then
		MicroFrameUpdateIndex = 1;
		-- self:Debug("last micro frame updated,,:: %d", #self.Status.Unit_Array);
	    end

	    -- get a unit
	    Unit = self.Status.Unit_Array[MicroFrameUpdateIndex];

	    -- should never fire unless the player choosed to ignore everything or something is wrong somewhere in the code
	    if not Unit then
		--self:Debug("Unit is nil :/");
		return false;
	    end

	    -- get its MUF
	    MF = MicroUnitF.ExistingPerID[MicroFrameUpdateIndex];
	    --MF = MicroUnitF:Exists(MicroFrameUpdateIndex);

	    -- if no MUF then create it (All MUFs are created here)
	    if (not MF) then
		if (not self.Status.Combat) then
		    MF = MicroUnitF:Create(MicroFrameUpdateIndex, Unit);
		    ActionsDone = ActionsDone + 1;
		end
	    end

	    -- update the MUF attributes and its colors XXX -- this is done by an event handler now (buff/debuff received...)
	    --ActionsDone = ActionsDone + MF:Update(not MF.IsDebuffed and true or false, true);
	    if MF then
		if not MF.IsDebuffed and MF.UpdateCountDown ~= 0 then
		    MF.UpdateCountDown = MF.UpdateCountDown - 1;
		else -- if MF.IsDebuffed or MF.UpdateCountDown == 0
		    ActionsDone = ActionsDone + MF:Update(false, not (MF.IsDebuffed and MF.UnitStatus ~= AFFLICTED)); -- we rescan debuffs if the unit is not in spell range
		    MF.UpdateCountDown = 3;
		end
	    end

	    -- we are done for this frame, go to te next
	    MicroFrameUpdateIndex = MicroFrameUpdateIndex + 1;

	    -- don't update more than 5 MUF in a row
	    -- don't loop when reaching the end, wait for the next call (useful when less MUFs than PerUpdate)
	    if (ActionsDone > 5 or pass == NumToShow) then
		--self:Debug("Max actions count reached");
		break;
	    end

	end
	--    end
    end -- }}}
end

-- This little function returns the priority of the spell corresponding to an affliction type (one spell can be used for several types)
function D:GiveSpellPrioNum (Type) -- {{{
    return D.Status.CuringSpellsPrio[D.Status.CuringSpells[Type]];
end -- }}}








-- old unused variables and functions
-- UNUSED STUFF {{{
-- Micro Frame Events, useless for now

function MicroUnitF:OnPostClick()
--	D:Debug("Micro unit PostClicked");
end

function MicroUnitF:OnAttributeChanged(self, name, value)
	D:Debug("Micro unit '%s' AttributeChanged to '%s'", name, value);
end


local MUF_Status = { -- unused
    [1] = "normal";
    [2] = "absent";
    [3] = "far";
    [4] = "stealthed";
    [5] = "blacklist";
    [6] = "afflicted";
    [7] = "afflicted-far";
    [8] = "afflicted-charmed";
    [9] = "afflicted-charmed-far";
}


local MF_Textures = { -- unused
    "Interface/AddOns/Decursive/Textures/BackDrop-red", -- red
    "Interface/AddOns/Decursive/Textures/BackDrop-blue", -- blue
    "Interface/AddOns/Decursive/Textures/BackDrop-orange", -- orange
    ["grey"] = "Interface\\AddOns\\Decursive\\Textures\\BackDrop-grey-medium",
    ["black"] = "Interface/AddOns/Decursive/Textures/BackDrop",
};


-- }}}

DcrLoadedFiles["Dcr_DebuffsFrame.lua"] = "$Revision: 80230 $";
