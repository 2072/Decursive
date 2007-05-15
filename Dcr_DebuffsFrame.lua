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
Dcr:SetDateAndRevision("$Date$", "$Revision$");


local L	    = Dcr.L;
local BC    = Dcr.BC;
local BS    = Dcr.BS;
local AceOO = Dcr.AOO;

-- initialize our MicroUnitF class
Dcr.MicroUnitF = AceOO.Class();

-- create a shortcut
local MicroUnitF = Dcr.MicroUnitF;

-- Init object factory defaults
MicroUnitF.ExistingPerID = {};
MicroUnitF.ExistingPerNum = {};
MicroUnitF.Number   = 0;
MicroUnitF.UnitShown   = 0;
Dcr.DebuffedUnitsNum = 0; -- XXX does not belong here


-- using power 2 values just to OR them but only CHARMED is ORed (it's a C style bitfield)
local NORMAL		    = 8;
local ABSENT		    = 16;
local FAR		    = 32;
local STEALTHED		    = 64;
local BLACKLISTED	    = 128;
local AFFLICTED		    = 256;
local AFFLICTED_NIR	    = 512;
local CHARMED		    = 1024;
local AFFLICTED_AND_CHARMED = bit.bor(AFFLICTED, CHARMED);


-- Those are the different colors used for the MUFs main texture
local MF_colors = {
			  {  .8 , 0   , 0    ,  1	}, -- red
			  { 0   , 0   , 0.8  ,  1	}, -- blue
			  { 1   ,  .5 ,  .25 ,  1	}, -- orange
			  { 1   , 1   , 1    ,  1	}, -- white for undefined
			  { 1   , 1   , 1    ,  1	}, -- white for undefined
    [NORMAL]		= {  .0 ,  .3 ,  .1  ,   .9	}, -- dark green
    [BLACKLISTED]	= { 0   , 0   , 0    ,  1	}, -- black
    [ABSENT]		= {  .4 ,  .4 ,  .4  ,   .9	}, -- transparent grey
    [FAR]		= {  .4 ,  .1 ,  .4  ,   .85	}, -- transparent purple
    [STEALTHED]		= {  .4 ,  .6 ,  .4  ,  1	}, -- pale green
    ["InnerCharmed"]	= {  0  , 1   , 0    ,  1	}, -- full green
};
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
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
}; -- }}}

local AvailableButtonsReadable = { -- {{{
    L[Dcr.LOC.HLP_LEFTCLICK], -- left mouse button
    L[Dcr.LOC.HLP_RIGHTCLICK], -- right mouse button
    L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    L[Dcr.LOC.SHIFT] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.SHIFT] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    L[Dcr.LOC.ALT] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.ALT] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
}; -- }}}

-- modifier for the macro
local AvailableModifier = { -- {{{
    "shift","ctrl","alt",
} -- }}}

-- MicroUnitF STATIC methods {{{

-- defines what is printed when the object is read as a string
function MicroUnitF:ToString() -- {{{
    return "Decursive Micro Unit Frame Object";
end -- }}}

-- The Factory for MicroUnitF objects
function MicroUnitF:Create(ID, Unit) -- {{{

    if (Dcr.Status.Combat) then
	-- if we are fighting, postpone the call
	Dcr:AddDelayedFunctionCall (
	"Create"..ID, self.Create,
	ID, Unit);
	return false;
    end

    -- if we attempt to create a MUF that already exists, update it instead
    if (MicroUnitF.ExistingPerID[ID]) then
	MicroUnitF.ExistingPerID[ID]:UpdateAttributes(Unit);
	-- Dcr:errln("Cannot create %s: already exists", ID);
	return MicroUnitF.ExistingPerID[ID];
    end

    MicroUnitF.Number = MicroUnitF.Number + 1;

    -- create a new MUF object
    MicroUnitF.ExistingPerID[ID] = MicroUnitF:new(Dcr.MFContainer, ID, Unit, MicroUnitF.Number);

    -- (currently ID is the same than Number)
    MicroUnitF.ExistingPerNum[MicroUnitF.Number] = MicroUnitF.ExistingPerID[ID];

    return MicroUnitF.ExistingPerID[ID];
end -- }}}

-- return a MUF object if it exists, nil otherwise
function MicroUnitF:Exists(IdOrNum) -- {{{
    return MicroUnitF.ExistingPerID[IdOrNum] or MicroUnitF.ExistingPerNum[IdOrNum];
end -- }}}

-- return the number MUFs we can use
function MicroUnitF:MFUsableNumber () -- {{{
    return ((MicroUnitF.MaxUnit > Dcr.Status.UnitNum) and Dcr.Status.UnitNum or MicroUnitF.MaxUnit);
end -- }}}

-- this is used when a setting influencing MUF's position is changed
function MicroUnitF:ResetAllPositions () -- {{{
    local MicroFrame = false;

    Dcr:Debug("Resetting all MF position");

    for i=1, MicroUnitF.Number do

	MicroFrame = MicroUnitF.ExistingPerID[i].Frame;

	MicroFrame:SetPoint(unpack(MicroUnitF:GiveMFAnchor(i)));

    end
end -- }}}

-- return the anchor of a given MUF depending on its creation ID
function MicroUnitF:GiveMFAnchor (ID) -- {{{
    local LineNum = math.floor( (ID - 1) / Dcr.profile.DebuffsFramePerline);
    local NumOnLine = math.fmod( (ID - 1), Dcr.profile.DebuffsFramePerline);

    local x = (Dcr.profile.DebuffsFrameGrowToTop and DcrC.MFSIZE or 0) + NumOnLine * (DcrC.MFSIZE + Dcr.profile.DebuffsFrameXSpacing);
    local y = (Dcr.profile.DebuffsFrameGrowToTop and -1 or 1) * LineNum * ((-1 * Dcr.profile.DebuffsFrameYSpacing) - DcrC.MFSIZE);


    return { "TOPLEFT", x + 3, y - 20, "TOPLEFT" };
end -- }}}


function MicroUnitF:Delayed_MFsDisplay_Update ()
    if (Dcr.profile.ShowDebuffsFrame) then
	Dcr:ScheduleEvent("UpdateMUFsNUM", MicroUnitF.MFsDisplay_Update, 0.2, MicroUnitF);
    end
end

-- This update the MUFs display, show and hide MUFs as necessary
function MicroUnitF:MFsDisplay_Update () -- {{{

    if (not Dcr.profile.ShowDebuffsFrame) then
	return false;
    end

    -- This function cannot do anything if we are fighting
    if (Dcr.Status.Combat) then
	-- if we are fighting, postpone the call
	Dcr:AddDelayedFunctionCall (
	"UpdateMicroUnitFrameDisplay", self.MFsDisplay_Update,
	self);
	return false;
    end

    -- Get an up to date unit array if necessary
    Dcr:GetUnitArray();

    -- =======
    --  Begin
    -- =======
   
    -- get the number of MUFs we should display
    local NumToShow = MicroUnitF:MFUsableNumber();


    -- if we don't have all the MUFs needed then return, we are not ready
    if (MicroUnitF.Number < NumToShow) then
	return false;
    end


    local MF_f = false;
    local MF = false;

    --  Dcr:Debug("MicroUnitF.Number = %d", MicroUnitF.Number);

    local start;

    -- if there are more MUFs than the actual unit number
    if MicroUnitF.UnitShown > NumToShow then
	start = NumToShow + 1;
    -- if there is not enough MUFs
    elseif MicroUnitF.UnitShown < NumToShow then
	start = MicroUnitF.UnitShown + 1;
    else
	start = NumToShow;
    end

    Dcr:Debug("Update required: NumToShow = %d, starting at: %d", NumToShow, start);

    for i=start, MicroUnitF.Number do

	if MicroUnitF.ExistingPerID[i] then
	    MF = MicroUnitF.ExistingPerID[i];
	    MF_f = MF.Frame;
	else
	    -- this should not happen
	    Dcr:Debug("%s (positionned at %d) does not has a frame yet", Dcr.Status.Unit_Array[i], i);
	    break;
	end

	-- show/hide and update position if necessary
	if (i <= NumToShow and not MF.Shown) then

	    MF_f:SetPoint(unpack(MicroUnitF:GiveMFAnchor(i)));
	    MF_f:Show();
	    MF.Shown = true;
	    MicroUnitF.UnitShown = MicroUnitF.UnitShown + 1;

	    -- Schedule an update for the MUF we just shown
	    Dcr:ScheduleEvent("Update"..MF.CurrUnit, MF.Update, Dcr.profile.DebuffsFrameRefreshRate * (NumToShow + 1 - i), MF);
	    --Dcr:Debug("Showing %d, scheduling update in %f", i, Dcr.profile.DebuffsFrameRefreshRate * (NumToShow + 1 - i));

	elseif (i > NumToShow and MF.Shown) then
	    Dcr:Debug("Hidding %d", i);

	    MF.Shown = false;
	    MicroUnitF.UnitShown = MicroUnitF.UnitShown - 1;
	    Dcr:Debug("Hiding %d, scheduling update in %f", i, Dcr.profile.DebuffsFrameRefreshRate * (i - NumToShow));
	    Dcr:ScheduleEvent("Update"..MF.CurrUnit, MF.Update, Dcr.profile.DebuffsFrameRefreshRate * (i - NumToShow), MF, false, false);
	    MF_f:Hide();

	end

    end

    return true;
end -- }}}

-- Those set the scalling of the MUF container
-- SACALING FUNCTIONS (MicroUnitF Children) {{{
-- Place the MUFs container according to its scale
function MicroUnitF:Place () -- {{{
    local UIScale	= UIParent:GetEffectiveScale()
    local FrameScale	= self.Frame:GetEffectiveScale();
    local x, y = Dcr.profile.DebuffsFrame_x, Dcr.profile.DebuffsFrame_y;

    -- Executed for the very first time, then put it in the top right corner of the screen
    if (not x or not y) then
	x =    (UIParent:GetWidth()  * UIScale) / 2 + 200;
	y =  - (UIParent:GetHeight() * UIScale) / 2 + 250;
    end

    -- set to the scaled position
    self.Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x/FrameScale , y/FrameScale);
end -- }}}

-- Save the position of the frame without its scale
function MicroUnitF:SavePos () -- {{{
    if self.Frame:IsVisible() then
	-- We save the unscalled position (no problem if the sacale is changed behind our back)
	Dcr.profile.DebuffsFrame_x = self.Frame:GetEffectiveScale() * self.Frame:GetLeft();
	Dcr.profile.DebuffsFrame_y = self.Frame:GetEffectiveScale() * self.Frame:GetTop() - UIParent:GetHeight() * UIParent:GetEffectiveScale();

	--	Dcr:Debug("Frame position saved");
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
function MicroUnitF:UpdateMUFUnit(Unitid)
    if not Dcr.profile.ShowDebuffsFrame then
	return;
    end

    if (not Unitid) then
	Dcr:Debug("XXXXX ==> UpdateMUFUnit: Unitid was nil!");
    end

    -- Update the unit array (GetUnitArray() will do something only if necessary)
    Dcr:GetUnitArray();

    local unit = false;

    if (Unitid == "focus") then
	unit = "focus";
    elseif (UnitInRaid(Unitid) or UnitInParty(Unitid)) then
	--unit = Dcr:NameToUnit(UnitName(Unitid)); -- needed so we have the same IDs than the ones we have in our lists (we won't get party\d when we are in raid but raid\d+)
	unit = Unitid;
    else
	return;
    end

    -- get the MUF index that should represent this unit
    local MUF_index = Dcr.Status.Unit_Array_UnitToIndex[unit];

    if (not MUF_index) then
	--Dcr:Debug("XXXXX ==> UpdateMUFUnit: Unitid (%s) was not found in table Unit_Array_UnitToIndex!", unit);
	return;
    end

    -- get the MUF object
    local MF = MicroUnitF:Exists(MUF_index);

    if (MF and MF.Shown) then
	-- The MUF will be updated only every DebuffsFrameRefreshRate seconds at most
	-- but we don't miss any event
	if (not Dcr:IsEventScheduled("Update"..unit)) then
	    Dcr:ScheduleEvent("Update"..unit, MF.Update, Dcr.profile.DebuffsFrameRefreshRate, MF, false, false);
	    Dcr:Debug("Update scheduled for, ", unit, MUF_index);
	end
    end
end

-- Event management functions
-- MUF EVENTS (MicroUnitF children) (OnEnter, OnLeave, OnCornerClick, OnLoad, OnPreClick) {{{

-- It's outside the function to avoid creating and discarding this table at each call
local DefaultTTAnchor = {"ANCHOR_TOPLEFT", 0, 6};
-- This function is responsible for showing the tooltip when the mouse pointer is over a MUF
function MicroUnitF:OnEnter() -- {{{
    Dcr.Status.MouseOveringMUF = true;

    local MF = this.Object;
    local Status;

    if (Dcr.profile.AfflictionTooltips ) then
	MF:Update(); -- will reset the color early and set the current status of the MUF
	MF:SetClassBorder(); -- set the border if it wasn't possible at the time the unit was discovered

	-- removes the CHARMED bit from Status, we don't need it
	Status = bit.band(MF.UnitStatus,  bit.bnot(CHARMED));

	local Unit = MF.CurrUnit; -- shortcut

	local TooltipText = "";

	-- First, write the name of the unit in its class color
	if (UnitExists(MF.CurrUnit)) then
	    TooltipText =
	    -- Colored unit name
	    Dcr:ColorText(	    (UnitName(	  Unit    ))
	    , "FF" .. ((UnitClass(Unit)) and BC:GetHexColor( (select(2, UnitClass(Unit))) ) or "AAAAAA"));
	end


	-- set UnitStatus text
	local StatusText = "";

	-- set the status text, just translate the bitfield to readable text
	if (Status == NORMAL) then
	    StatusText = L[Dcr.LOC.NORMAL];

	elseif (Status == ABSENT) then
	    StatusText = string.format(L[Dcr.LOC.ABSENT], Unit);

	elseif (Status == FAR) then
	    StatusText = L[Dcr.LOC.TOOFAR];

	elseif (Status == STEALTHED) then
	    StatusText = L[Dcr.LOC.STEALTHED];

	elseif (Status == BLACKLISTED) then
	    StatusText = L[Dcr.LOC.BLACKLISTED];

	elseif (MF.Debuffs and (Status == AFFLICTED or Status == AFFLICTED_NIR)) then
	    local DebuffType = MF.Debuffs[1].Type;
	    StatusText = string.format(L[Dcr.LOC.AFFLICTEDBY], Dcr:ColorText( L[DcrC.TypeNames[DebuffType]], "FF" .. DcrC.TypeColors[DebuffType]) );
	end

	-- Unit Status
	TooltipText = TooltipText .. "\n" .. L[Dcr.LOC.UNITSTATUS] .. StatusText .. "\n";

	-- list the debuff(s) names
	if (MF.Debuffs) then
	    for i, Debuff in ipairs(MF.Debuffs) do
		if (Debuff.Type) then
		    local DebuffApps = Debuff.Applications;
		    TooltipText = TooltipText .. "\n" .. string.format("%s", Dcr:ColorText(Debuff.Name, "FF" .. DcrC.TypeColors[Debuff.Type])) .. (DebuffApps>0 and string.format(" (%d)", DebuffApps) or "");
		else
		    break;
		end
	    end
	end

	-- we use it to anchor the tooltip
	local FirstMUF = MicroUnitF.ExistingPerNum[1].Frame;

	-- finally display the tooltip
	Dcr:DisplayTooltip( TooltipText , FirstMUF, DefaultTTAnchor);
    end

    -- show a help text in the Game default tooltip
    if (Dcr.profile.DebuffsFrameShowHelp) then
	local helpText = MF.TooltipButtonsInfo;
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetText(helpText);
	GameTooltip:Show();

    end

end -- }}}

function MicroUnitF:OnLeave() -- {{{
    Dcr.Status.MouseOveringMUF = false;
    --Dcr:Debug("Micro unit Hidden");
    DcrDisplay_Tooltip:Hide();

    if (Dcr.profile.DebuffsFrameShowHelp) then
	GameTooltip:Hide();
    end
end -- }}}

function MicroUnitF:OnCornerClick (arg1, this) -- {{{
    Dcr:Debug("clicked");
    if (arg1 == "RightButton" and not IsShiftKeyDown()) then

	if (not IsAltKeyDown()) then
	    Dcr.DewDrop:Open(this,
	    'children', function()
		Dcr.DewDrop:FeedAceOptionsTable( Dcr.options )
	    end
	    );
	else
	    Dcr.Waterfall:Open("Decursive");
	end

    elseif (arg1 == "RightButton" and IsShiftKeyDown()) then
	Dcr:HideBar();
    elseif (arg1 == "LeftButton" and IsControlKeyDown()) then
	Dcr:ShowHidePriorityListUI();
    elseif (arg1 == "LeftButton" and IsShiftKeyDown()) then
	Dcr:ShowHideSkipListUI();
    end

end -- }}}

function Dcr.MicroUnitF:OnCornerEnter()
    if (Dcr.profile.DebuffsFrameShowHelp) then
	Dcr:DisplayGameTooltip(
	string.format(
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r: %s\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
	"|cFF11FF11%s|r-|cFF11FF11%s|r: %s",

	Dcr.L[Dcr.LOC.ALT],		Dcr.L[Dcr.LOC.HLP_LEFTCLICK],	Dcr.L[Dcr.LOC.HANDLEHELP],

	Dcr.L[Dcr.LOC.HLP_RIGHTCLICK],	Dcr.L[Dcr.LOC.STR_OPTIONS],
	Dcr.L[Dcr.LOC.ALT],		Dcr.L[Dcr.LOC.HLP_RIGHTCLICK],	Dcr.L[BINDING_NAME_DCRSHOWOPTION],

	Dcr.L[Dcr.LOC.CTRL],		Dcr.L[Dcr.LOC.HLP_LEFTCLICK],	Dcr.L[BINDING_NAME_DCRPRSHOW], 
	Dcr.L[Dcr.LOC.SHIFT],		Dcr.L[Dcr.LOC.HLP_LEFTCLICK],	Dcr.L[BINDING_NAME_DCRSKSHOW],

	Dcr.L[Dcr.LOC.SHIFT],		Dcr.L[Dcr.LOC.HLP_RIGHTCLICK],	Dcr.L[BINDING_NAME_DCRSHOW]
	));
    end;
end


function MicroUnitF:OnLoad() -- {{{
    this:SetScript("PreClick", MicroUnitF.OnPreClick);
    this:SetScript("PostClick", MicroUnitF.OnPostClick);
end
-- }}}

function MicroUnitF:OnPreClick(Button) -- {{{
	-- Dcr:Debug("Micro unit Preclicked: ", Button);
	Dcr.Status.ClickedMF = this.Object; -- used to update the MUF on cast success

	if (this.Object.UnitStatus == NORMAL and (Button == "LeftButton" or Button == "RightButton")) then

	    Dcr:Println(L[Dcr.LOC.HLP_NOTHINGTOCURE]);

	elseif (this.Object.UnitStatus == AFFLICTED) then
	    local NeededPrio = Dcr:GiveSpellPrioNum(this.Object.Debuffs[1].Type);
	    local RequestedPrio = false;

	    if (Button == "LeftButton") then
		if (IsControlKeyDown()) then
		    RequestedPrio = 3;
		else
		    RequestedPrio = 1;
		end
	    elseif (Button == "RightButton") then
		RequestedPrio = 2;
	    end

	    if (RequestedPrio and NeededPrio ~= RequestedPrio) then
		Dcr:errln(L[Dcr.LOC.HLP_WRONGMBUTTON]);
		Dcr:Println(L[Dcr.LOC.HLP_USEXBUTTONTOCURE], Dcr:ColorText(AvailableButtonsReadable[NeededPrio], Dcr:NumToHexColor(MF_colors[NeededPrio])));
	    end
	end
end -- }}}

-- }}}

-- }}}



-- MicroUnitF NON STATIC METHODS {{{
-- init a new micro frame (Call internally by :new() only)
function MicroUnitF.prototype:init(Container,ID, Unit, FrameNum) -- {{{
	MicroUnitF.super.prototype.init(self); -- needed

	Dcr:Debug("Initializing MicroUnit object '%s' with FrameNum=%d", ID, FrameNum);


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

	-- create the frame
	self.Frame  = CreateFrame ("Button", "DcrMicroUnit"..ID, self.Parent, "DcrMicroUnitTemplateSecure");

	-- outer texture (the class border)
	-- Bottom side
	self.OuterTexture1 = self.Frame:CreateTexture(nil, "BORDER");
	self.OuterTexture1:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 0);
	self.OuterTexture1:SetPoint("TOPRIGHT", self.Frame, "BOTTOMRIGHT",  0, 2);

	-- left side
	self.OuterTexture2 = self.Frame:CreateTexture(nil, "BORDER");
	self.OuterTexture2:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, -2);
	self.OuterTexture2:SetPoint("BOTTOMRIGHT", self.Frame, "BOTTOMLEFT", 2, 2);

	-- top side
	self.OuterTexture3 = self.Frame:CreateTexture(nil, "BORDER");
	self.OuterTexture3:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, 0);
	self.OuterTexture3:SetPoint("BOTTOMRIGHT", self.Frame, "TOPRIGHT", 0, -2);

	-- right side
	self.OuterTexture4 = self.Frame:CreateTexture(nil, "BORDER");
	self.OuterTexture4:SetPoint("TOPRIGHT", self.Frame, "TOPRIGHT", 0, -2);
	self.OuterTexture4:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMRIGHT", -2, 2);


	-- global texture
	self.Texture = self.Frame:CreateTexture(nil, "ARTWORK");
	self.Texture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.Texture:SetHeight(16);
	self.Texture:SetWidth(16);

	-- inner Texture (Charmed special texture)
	self.InnerTexture = self.Frame:CreateTexture(nil, "OVERLAY");
	self.InnerTexture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.InnerTexture:SetHeight(7);
	self.InnerTexture:SetWidth(7);
	--self.InnerTexture:SetDrawLayer("OVERLAY");
	self.InnerTexture:SetTexture(unpack(MF_colors["InnerCharmed"]));

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


function MicroUnitF.prototype:Update(SkipSetColor, SkipDebuffs)

    -- get the unit this MUF should show
    local MF = self;
    local Unit = Dcr.Status.Unit_Array[MF.ID];
    local ActionsDone = 0;

    if not Unit then 
	Dcr:Debug("No Unit for MUF #", MF.ID);
	return 0
    end

    -- Update the frame attribute if necessary
    if (Dcr.Status.SpellsChanged ~= MF.LastAttribUpdate or MF.CurrUnit ~= Unit) then
	Dcr:Debug("Attributes update required");
	if (MF:UpdateAttributes(Unit, true)) then
	    ActionsDone = ActionsDone + 1; -- count expensive things done
	    SkipSetColor = false; SkipDebuffs = false; -- if some attributes were updated then update the rest
	end
    end

    if (not SkipSetColor) then
	if (not SkipDebuffs) then
	    -- get the manageable debuffs of this unit
	    MF:SetDebuffs();
	    --Dcr:Debug("Debuff set for ", MF.ID);
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
	if (Dcr.Status.Combat) then
	    if not DoNotDelay then
		Dcr:AddDelayedFunctionCall (
		"MicroUnit_" .. self.ID, self.UpdateAttributes,
		self, Unit);
	    end
	    return false;
	end

	--Dcr:Debug("UpdateAttributes called for %s", Unit);

	ReturnValue = false;

	-- if the unit changed
	if (self.CurrUnit ~= Unit) then 
	    self.Frame:SetAttribute("unit", "player"); -- XXX test if the unit really changes without this line
	    self.Frame:SetAttribute("unit", Unit);

	    self.CurrUnit = Unit;

	    self:SetClassBorder();

	    -- set the return value because we did something expensive
	    ReturnValue = self;
	end

	-- if the spell settings (the priority order or available spells) did not changed
	if (Dcr.Status.SpellsChanged == self.LastAttribUpdate) then
	    return ReturnValue;
	end

	Dcr:Debug("UpdateAttributes() executed");
	-- set the mouse middle-button action
	self.Frame:SetAttribute("type3", "target"); --never changes

	-- set the mouse ctrl-middle-button action
	self.Frame:SetAttribute("ctrl-type3", "focus"); -- never changes

	-- set the mouse left-button action
	self.Frame:SetAttribute("type1", "target"); -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("type1", "macro");

	-- set the mouse ctrl-left-button action
	self.Frame:SetAttribute("ctrl-type1", "target");  -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("ctrl-type1", "macro");

	-- set the mouse right-button action
	self.Frame:SetAttribute("type2", "target"); -- required to disable an hidden cache somewhere...
	self.Frame:SetAttribute("type2", "macro");

	-- We need:
	--
	--  - a table telling the priority of each spell
	--		Dcr.Status.CuringSpellsPrio [ __SPELL_NAME__ ] = __PRIO_NUM__

	-- if necessary we will update the help tooltip text
	if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
	    self.TooltipButtonsInfo = {};
	end

	-- set the spells attributes using the lookup tables above
	for Spell, Prio in pairs(Dcr.Status.CuringSpellsPrio) do

	    --self.Frame:SetAttribute(string.format(AvailableButtons[Prio], "spell"), Spell);
	    self.Frame:SetAttribute(string.format(AvailableButtons[Prio], "macrotext"), string.format("/stopcasting\n/cast [target=mouseover] %s", Spell));

	    -- set the tooltip text for the current prio if necessary
	    if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
		self.TooltipButtonsInfo[Prio] =
		string.format("%s: %s", Dcr:ColorText(AvailableButtonsReadable[Prio], Dcr:NumToHexColor(MF_colors[Prio])), Spell);
	    end
	end

	-- concatenate the tooltip text if necessary
	if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
	    table.insert(self.TooltipButtonsInfo, string.format("%s: %s", L[Dcr.LOC.HLP_MIDDLECLICK], L[Dcr.LOC.TARGETUNIT]));
	    table.insert(self.TooltipButtonsInfo, string.format("%s: %s", L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_MIDDLECLICK], L[Dcr.LOC.FOCUSUNIT]));
	    self.TooltipButtonsInfo = table.concat(self.TooltipButtonsInfo, "\n");
	    self.TooltipUpdate = Dcr.Status.SpellsChanged;
	end

	self.Debuff1Prio = false;

	-- the update timestamp
	self.LastAttribUpdate = Dcr.Status.SpellsChanged;
	return self;
    end
end -- }}}

function MicroUnitF.prototype:SetDebuffs() -- {{{
    self.Debuffs, self.IsCharmed = Dcr:UnitCurableDebuffs(self.CurrUnit);


    if (self.Debuffs and self.Debuffs[1] and self.Debuffs[1].Type) then
	self.IsDebuffed = true;
	self.Debuff1Prio = Dcr:GiveSpellPrioNum( self.Debuffs[1].Type );

    else
	self.IsDebuffed = false;
	self.Debuff1Prio = false;
	self.PrevDebuff1Prio = false;
	Dcr.UnitDebuffed[self.CurrUnit] = false; -- used by the live-list only
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
    local DebuffType, Unit, PreviousStatus, BorderAlpha, Class, ReturnValue, RangeStatus, Alpha;
    local profile = {};
    function MicroUnitF.prototype:SetColor() -- {{{

	profile = Dcr.profile;

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
	    end

	    -- UnitIsVisible() behavior is not 100% reliable so we also use UnitLevel() that will return -1 when the Unit is too far...
	elseif not UnitIsVisible(Unit) or UnitLevel(Unit) < 1 then
	    if PreviousStatus ~= FAR then
		self.Color = MF_colors[FAR];
		self.UnitStatus = FAR;
	    end

	    -- If the Unit is invisible
	else
	    if Dcr.profile.Ingore_Stealthed and Dcr.Stealthed_Units[Unit] then
		if PreviousStatus ~= STEALTHED then
		    self.Color = MF_colors[STEALTHED];
		    self.UnitStatus = STEALTHED;
		end

		-- if unit is blacklisted
	    elseif Dcr.Status.Blacklisted_Array[Unit] then
		if PreviousStatus ~= BLACKLISTED then
		    self.Color = MF_colors[BLACKLISTED];
		    self.UnitStatus = BLACKLISTED;
		end

		-- if the unit has some debuffs we can handle
	    elseif (self.IsDebuffed) then
		DebuffType = self.Debuffs[1].Type;

		if self.PrevDebuff1Prio ~= self.Debuff1Prio then
		    self.Color = MF_colors[self.Debuff1Prio];
		    self.PrevDebuff1Prio = self.Debuff1Prio;
		end

		-- Test if the spell we are going to use is in range
		RangeStatus = IsSpellInRange(Dcr.Status.CuringSpells[DebuffType], Unit);

		-- set the status according to RangeStatus
		if (not RangeStatus or RangeStatus == 0) then
		    Alpha = 0.40;
		    self.UnitStatus = AFFLICTED_NIR;

		    if profile.LV_OnlyInRange then
			Dcr.UnitDebuffed[self.CurrUnit] = false;
		    end
		else
		    Alpha = 1;
		    self.UnitStatus = AFFLICTED;
		    BorderAlpha = 1;

		    Dcr.DebuffedUnitsNum = Dcr.DebuffedUnitsNum + 1;
		    if (not Dcr.Status.SoundPlayed) then
			Dcr:PlaySound (self.CurrUnit);
		    end
		    if profile.LV_OnlyInRange then
			Dcr.UnitDebuffed[self.CurrUnit] = true;
		    end

		end
	    elseif PreviousStatus ~= NORMAL then
		-- the unit has nothing special, set the status to normal
		self.Color = MF_colors[NORMAL];
		self.UnitStatus = NORMAL;
	    end
	end

	if PreviousStatus == AFFLICTED or PreviousStatus == AFFLICTED_AND_CHARMED  then
	    Dcr.DebuffedUnitsNum = Dcr.DebuffedUnitsNum - 1;

	    if (Dcr.DebuffedUnitsNum == 0) then
		Dcr.Status.SoundPlayed = false;
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
	    Dcr:Debug("border alpha set");
	end


	-- Add the charm status to the bitfield (note that it's treated separatly because it's shown even if the unit is not afflicetd by anything we can cure)
	if (self.IsCharmed) then
	    self.UnitStatus = bit.bor( self.UnitStatus, CHARMED);
	end

	-- if the unit is not afflicted or too far set the color to a lower alpha
	if (not DebuffType) then -- if DebuffType was not set, it means that the unit is too far
	    Alpha = self.Color[4] * profile.DebuffsFrameElemAlpha;
	    self.PrevDebuff1Prio = false;
	end


	-- Apply the colors and alphas only if necessary
	--	The MUF status changed
	--	The user changed the defaultAlpha
	--	The first affliction changed
	if (self.UnitStatus ~= PreviousStatus or self.NormalAlpha ~= profile.DebuffsFrameElemAlpha or self.FirstDebuffType ~= DebuffType) then

	    -- Set the main texture
	    self.Texture:SetTexture(self.Color[1], self.Color[2], self.Color[3], Alpha);
	    --self.Texture:SetAlpha(Alpha);

	    -- Show the charmed alert square
	    if (self.IsCharmed) then
		self.InnerTexture:Show();
	    else
		self.InnerTexture:Hide();
	    end

	    Dcr:Debug("Color Applied, MUF Status:", self.UnitStatus);


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

	if (Dcr.profile.DebuffsFrameElemBorderShow and (Dcr.Status.Unit_Array_UnitToName[self.CurrUnit] ~= self.UnitName or (not self.UnitClass and UnitExists(self.CurrUnit)))) then

	    -- Get the name of this unit
	    self.UnitName = Dcr.Status.Unit_Array_UnitToName[self.CurrUnit];

	    if self.UnitName then -- can be nil because of focus...
		-- Get its class
		Class = select(2, UnitClass(self.CurrUnit));
	    else
		Class = false;
	    end

	    -- if the class changed
	    if (Class and Class ~= self.UnitClass) then
		-- update the border color (the four borders)
		self.OuterTexture1:SetTexture( BC:GetColor(Class) );
		self.OuterTexture2:SetTexture( BC:GetColor(Class) );
		self.OuterTexture3:SetTexture( BC:GetColor(Class) );
		self.OuterTexture4:SetTexture( BC:GetColor(Class) );

		-- save the class for futur reference
		self.UnitClass = Class;

		-- set this to true because we just did something expensive...
		ReturnValue = true;

		Dcr:Debug("Class '%s' set for '%s'", Class, self.CurrUnit);
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
		--Dcr:Debug("Class of unit %s is Nil", self.CurrUnit);
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
    function Dcr:DebuffsFrame_Update() -- {{{

	-- Update the unit array (GetUnitArray() will do something only if necessary)
	if (Dcr.Groups_datas_are_invalid) then
	    Dcr:GetUnitArray();
	end

	NumToShow = ((MicroUnitF.MaxUnit > Dcr.Status.UnitNum) and Dcr.Status.UnitNum or MicroUnitF.MaxUnit);
	--NumToShow = MicroUnitF:MFUsableNumber();

	ActionsDone = 0; -- used to limit the maximum number of consecutive UI actions

	--if 1 then return false; end -- XXX

	-- we don't check all the MUF at each call, only some of them (changed in the options)
	for pass = 1, Dcr.profile.DebuffsFramePerUPdate do

	    -- When all frames have been updated, go back to the first
	    if (MicroFrameUpdateIndex > NumToShow) then
		MicroFrameUpdateIndex = 1;
		-- Dcr:Debug("last micro frame updated,,:: %d", #Dcr.Status.Unit_Array);
	    end

	    -- get a unit
	    Unit = Dcr.Status.Unit_Array[MicroFrameUpdateIndex];

	    -- should never fire unless the player choosed to ignore everything or something is wrong somewhere in the code
	    if not Unit then
		--Dcr:Debug("Unit is nil :/");
		return false;
	    end

	    -- get it's MUF
	    MF = MicroUnitF.ExistingPerID[MicroFrameUpdateIndex];
	    --MF = MicroUnitF:Exists(MicroFrameUpdateIndex);

	    -- if no MUF then create it (All MUFs are created here)
	    if (not MF) then
		if (not Dcr.Status.Combat) then
		    MF = MicroUnitF:Create(MicroFrameUpdateIndex, Unit);
		    ActionsDone = ActionsDone + 1;
		end
	    end

	    -- update the MUF attributes and its colors XXX
	    --ActionsDone = ActionsDone + MF:Update(not MF.IsDebuffed and true or false, true);
	    if MF then
		if not MF.IsDebuffed and MF.UpdateCountDown ~= 0 then
		    MF.UpdateCountDown = MF.UpdateCountDown - 1;
		else -- if MF.IsDebuffed or MF.UpdateCountDown == 0
		    ActionsDone = ActionsDone + MF:Update(false, true);--not MF.IsDebuffed and true or false, true);
		    MF.UpdateCountDown = 3;
		end
	    end

	    -- we are done for this frame, go to te next
	    MicroFrameUpdateIndex = MicroFrameUpdateIndex + 1;

	    if (ActionsDone > 5 or pass == NumToShow) then
		--Dcr:Debug("Max actions count reached");
		break;
	    end

	    -- don't loop when reaching the end, wait for the next call (useful when less MUFs than PerUpdate)
	    --if (pass == NumToShow) then
	--	break;
	   -- end
	end
	--    end
    end -- }}}
end

-- This little function returns the priority of the spell corresponding to an affliction type (one spell can be used for several types)
function Dcr:GiveSpellPrioNum (Type) -- {{{
    return Dcr.Status.CuringSpellsPrio[Dcr.Status.CuringSpells[Type]];
end -- }}}








-- old unused variables and functions
-- UNUSED STUFF {{{
-- Micro Frame Events, useless for now

function MicroUnitF:OnPostClick()
--	Dcr:Debug("Micro unit PostClicked");
end

function MicroUnitF:OnAttributeChanged(self, name, value)
	Dcr:Debug("Micro unit '%s' AttributeChanged to '%s'", name, value);
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

