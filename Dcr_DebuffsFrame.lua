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


local L = Dcr.L;
local BC = Dcr.BC;
local BS = Dcr.BS;
local AceOO = Dcr.AOO;

Dcr.MicroUnitF = AceOO.Class();
local MicroUnitF = Dcr.MicroUnitF;

MicroUnitF.ExistingPerID = {};
MicroUnitF.ExistingPerNum = {};
MicroUnitF.Number   = 0;
MicroUnitF.UnitShown   = 0;

local MF_Textures = { -- unused
    "Interface/AddOns/Decursive/Textures/BackDrop-red", -- red
    "Interface/AddOns/Decursive/Textures/BackDrop-blue", -- blue
    "Interface/AddOns/Decursive/Textures/BackDrop-orange", -- orange
    ["grey"] = "Interface\\AddOns\\Decursive\\Textures\\BackDrop-grey-medium",
    ["black"] = "Interface/AddOns/Decursive/Textures/BackDrop",
};


-- using power 2 values just to OR them but only CHARMED is ORed
local NORMAL		    = 8;
local ABSENT		    = 16;
local FAR		    = 32;
local STEALTHED		    = 64;
local BLACKLISTED	    = 128;
local AFFLICTED		    = 256;
local AFFLICTED_NIR	    = 512;
local CHARMED		    = 1024;


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

local MUF_Status = {
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

-- defines what is printed when the object is read as a string
function MicroUnitF:ToString()
    return "Decursive Micro Unit Frame Object";
end

function MicroUnitF:Create(ID, Unit) -- The Factory for MicroUnitF objects
    if (MicroUnitF.ExistingPerID[ID]) then
	MicroUnitF.ExistingPerID[ID]:UpdateAttributes(Unit);
	-- Dcr:errln("Cannot create %s: already exists", ID);
	return MicroUnitF.ExistingPerID[ID];
    end

    MicroUnitF.Number = MicroUnitF.Number + 1;
    MicroUnitF.ExistingPerID[ID] = MicroUnitF:new(Dcr.MFContainer, ID, Unit, MicroUnitF.Number);


    MicroUnitF.ExistingPerNum[MicroUnitF.Number] = MicroUnitF.ExistingPerID[ID];

    return MicroUnitF.ExistingPerID[ID];
end

function MicroUnitF:Exists(IdOrNum)
    return MicroUnitF.ExistingPerID[IdOrNum] or MicroUnitF.ExistingPerNum[IdOrNum];
end

-- init a new micro frame (Call internally by :new() only)
function MicroUnitF.prototype:init(Container,ID, Unit, FrameNum)
	MicroUnitF.super.prototype.init(self); -- needed

	Dcr:Debug("Initializing MicroUnit object '%s' with FrameNum=%d", ID, FrameNum);


	self.Parent		= Container;
	self.ID			= ID;
	self.FrameNum		= FrameNum;
	self.Debuff		= false;
	self.CurrUnit		= false;
	self.UnitStatus		= 0;
	self.FirstDebuffType	= 0;
	self.NormalAlpha	= 0;
	self.BorderAlpha	= 0;
	self.Color		= false;
	self.IsCharmed		= false;
	self.UpdateMe		= true;
	self.LastAttribUpdate	= 0;

	self.Frame  = CreateFrame ("Button", "MicroUnit"..ID, self.Parent, "DcrMicroUnitTemplateSecure");

	-- outer texure (the class border)
	-- Bottom side
	self.OuterTexture1 = self.Frame:CreateTexture(nil, "MEDIUM");
	self.OuterTexture1:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 0);
	self.OuterTexture1:SetPoint("TOPRIGHT", self.Frame, "BOTTOMRIGHT",  0, 2);

	-- left side
	self.OuterTexture2 = self.Frame:CreateTexture(nil, "MEDIUM");
	self.OuterTexture2:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, -2);
	self.OuterTexture2:SetPoint("BOTTOMRIGHT", self.Frame, "BOTTOMLEFT", 2, 2);

	-- top side
	self.OuterTexture3 = self.Frame:CreateTexture(nil, "MEDIUM");
	self.OuterTexture3:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, 0);
	self.OuterTexture3:SetPoint("BOTTOMRIGHT", self.Frame, "TOPRIGHT", 0, -2);

	-- right side
	self.OuterTexture4 = self.Frame:CreateTexture(nil, "MEDIUM");
	self.OuterTexture4:SetPoint("TOPRIGHT", self.Frame, "TOPRIGHT", 0, -2);
	self.OuterTexture4:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMRIGHT", -2, 2);


	-- global texture
	self.Texture = self.Frame:CreateTexture(nil, "MEDIUM");
	self.Texture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.Texture:SetHeight(16);
	self.Texture:SetWidth(16);

	-- inner Texture (Charmed special texture)
	self.InnerTexture = self.Frame:CreateTexture(nil, "MEDIUM");
	self.InnerTexture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
	self.InnerTexture:SetHeight(7);
	self.InnerTexture:SetWidth(7);
	self.InnerTexture:SetTexture(unpack(MF_colors["InnerCharmed"]));


	self.Frame.Object = self;
	self.Frame:RegisterForClicks("AnyDown");
	self.Frame:SetFrameStrata("MEDIUM");

	Dcr.MFContainer.UpdateYourself = true;
	self:UpdateAttributes(Unit);
end

function MicroUnitF.prototype:Destroy()
end


local MicroFrameThrottle = 1;

-- updates the micro frames if needed
function Dcr:DebuffsFrame_Update()


    -- get the most up to date Unit array
    Dcr:GetUnitArray();
    if (Dcr.Status.Unit_Array[#Dcr.Status.Unit_Array] ~= "focus" and UnitIsFriend("focus", "player")) then
	table.insert(Dcr.Status.Unit_Array, "focus");
--	table.insert(Dcr.Status.Unit_Array, 1, "target"); -- XXX re-add this later
    end

    Dcr.MFContainer.MaxUnit = Dcr.db.profile.DebuffsFrameMaxCount;

    -- is physical display update necessary?
    --   if there are more unit shown than available units
    --	 if There are less unit shown than available and authorized units

    local NumToShow = MicroUnitF:MFUsableNumber();

    if (not Dcr.Status.Combat and
	(Dcr.MFContainer.UnitShown > #Dcr.Status.Unit_Array or
	Dcr.MFContainer.UnitShown < NumToShow
	)) then
	Dcr.MFContainer.UpdateYourself = true;
--	Dcr:Debug("Dcr.MFContainer.UnitShown: %d/%d", Dcr.MFContainer.UnitShown, NumToShow);
    end

    -- update the display
    Dcr:UpdateMIcroFrameDisplay();

    local PerUpdate = Dcr.db.profile.DebuffsFramePerUPdate;
    local ActionsDone = 0;

    for pass = 1, PerUpdate do

	-- When all frames have been updated, go back to the first
	if (MicroFrameThrottle > Dcr.MFContainer.MaxUnit or MicroFrameThrottle > #Dcr.Status.Unit_Array) then
	    MicroFrameThrottle = 1;
	    -- Dcr:Debug("last micro frame updated,,:: %d", #Dcr.Status.Unit_Array);
	end

	local Unit = Dcr.Status.Unit_Array[MicroFrameThrottle];
	local MF = MicroUnitF:Exists(MicroFrameThrottle);

	-- should never fire unless the player choosed to ignore himself
	if not Unit then
	    Dcr:Debug("Unit is nil :/");
	    return false;
	end

	if (not MF) then
	    if (not Dcr.Status.Combat) then
		MF = MicroUnitF:Create(MicroFrameThrottle, Unit);
		ActionsDone = ActionsDone + 1;
	    end
	elseif (Dcr.Status.SpellsChanged ~= MF.LastAttribUpdate or MF.CurrUnit ~= Unit or not MF.UnitClass) then
	    if (MF:UpdateAttributes(Unit, true)) then
		ActionsDone = ActionsDone + 1;
	    end
	end


	if (MF) then
	    MF:SetColor();
	end

	MicroFrameThrottle = MicroFrameThrottle + 1;

	if (ActionsDone > 5) then
	    Dcr:Debug("Max actions count reached");
	    break;
	end

	if (pass == NumToShow) then
	    break; -- XXX to stress test memory leak, uncomment before release
	end
    end
    --    end
end


local function GiveMFAnchor (ID)
    local MFPerLine = Dcr.db.profile.DebuffsFramePerline;
    local MFSize = 20;
    local Spaces = {3, -3};

    local LineNum = math.floor( (ID - 1) / MFPerLine);
    local NumOnLine = math.fmod( (ID - 1), MFPerLine);

    local x = (Dcr.db.profile.DebuffsFrameGrowToTop and MFSize or 0) + NumOnLine * (MFSize + Spaces[1]);
    local y = (Dcr.db.profile.DebuffsFrameGrowToTop and -1 or 1) * LineNum * (Spaces[2] - MFSize);


    return { "TOPLEFT", x + 3, y - 20, "TOPLEFT" };


end

function MicroUnitF:MFUsableNumber ()
    return ((Dcr.MFContainer.MaxUnit > #Dcr.Status.Unit_Array) and #Dcr.Status.Unit_Array or Dcr.MFContainer.MaxUnit);
end

function MicroUnitF:Place ()
    local UIScale = UIParent:GetEffectiveScale()
    local FrameScale = self.Frame:GetEffectiveScale();
    local x, y = Dcr.db.profile.DebuffsFrame_x, Dcr.db.profile.DebuffsFrame_y;


    -- Executed for the very first time, then put it in the top right corner of the screen
    if (not x or not y) then
	x =    (UIParent:GetWidth()  * UIScale) / 2 + 200;
	y =  - (UIParent:GetHeight() * UIScale) / 2 + 250;
    end

    -- set to the scaled position
    self.Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x/FrameScale , y/FrameScale);
end

function MicroUnitF:SavePos ()
    if self.Frame:IsVisible() then
	-- We save the unscalled position (no problem if the sacale is changed behind our back)
	Dcr.db.profile.DebuffsFrame_x = self.Frame:GetEffectiveScale() * self.Frame:GetLeft();
	Dcr.db.profile.DebuffsFrame_y = self.Frame:GetEffectiveScale() * self.Frame:GetTop() - UIParent:GetHeight() * UIParent:GetEffectiveScale();

	--	Dcr:Debug("Frame position saved");
    end

end

function MicroUnitF:SetScale (NewScale)
    

    -- save the current position without any scaling
    self:SavePos ();
    -- Setting the new scale
    self.Frame:SetScale(NewScale);
    -- Place the frame adapting its position to the newscale
    self:Place ();

    
end

function MicroUnitF:ResetAllPositions ()
    local NumToShow = MicroUnitF:MFUsableNumber();
    local MicroFrame = false;

    Dcr:Debug("Restting all MF position");
    for i=1, MicroUnitF.Number do

	MicroFrame = MicroUnitF.ExistingPerID[i].Frame;

	if (i <= NumToShow and MicroFrame.Object.Shown) then
	    MicroFrame:SetPoint(unpack(GiveMFAnchor(i)));
	end

    end
end

function Dcr:UpdateMIcroFrameDisplay ()
    if (Dcr.Status.Combat) then
	Dcr:AddDelayedFunctionCall (
	"UpdateMicroUnitFrameDisplay", self.UpdateMIcroFrameDisplay,
	self);
	return false;
    end

    if (not Dcr.MFContainer.UpdateYourself) then
	return false;
    end
    Dcr.MFContainer.UpdateYourself = false;



    -- =======
    --  Begin
    -- =======
    
    local NumToShow = MicroUnitF:MFUsableNumber();


    if (MicroUnitF.Number < NumToShow) then
	return false;
    end


    Dcr:Debug("Update required: NumToShow = %d", NumToShow);

    local MicroFrame = false;

--    Dcr:Debug("MicroUnitF.Number = %d", MicroUnitF.Number);

    for i=1, MicroUnitF.Number do

	if MicroUnitF.ExistingPerID[i] then
	    MicroFrame = MicroUnitF.ExistingPerID[i].Frame;
	else
	    Dcr:Debug("%s (positionned at %d) does not has a frame yet", Dcr.Status.Unit_Array[i], i);
	    break;
	end

	if (i <= NumToShow and not MicroFrame.Object.Shown) then

	    Dcr:Debug("Showing %d", i);
	    MicroFrame:SetPoint(unpack(GiveMFAnchor(i)));
	    MicroFrame:Show();
	    MicroFrame.Object.Shown = true;
	    Dcr.MFContainer.UnitShown = Dcr.MFContainer.UnitShown + 1;

	elseif (i > NumToShow and MicroFrame.Object.Shown) then
	    Dcr:Debug("Hidding %d", i);

	    MicroFrame.Object.Shown = false;
	    Dcr.MFContainer.UnitShown = Dcr.MFContainer.UnitShown - 1;
	    MicroFrame:Hide();

	end

    end

    return true;
end


-- UPDATE attributes (Spells and Unit) {{{
local AvailableButtons = {
    "%s1", -- left mouse button
    "%s2", -- right mouse button
    "ctrl-%s1",
    "ctrl-%s2",
    "shift-%s1",
    "shift-%s2",
    "alt-%s1",
    "alt-%s2",
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
};

local AvailableButtonsReadable = {
    L[Dcr.LOC.HLP_LEFTCLICK], -- left mouse button
    L[Dcr.LOC.HLP_RIGHTCLICK], -- right mouse button
    L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    L[Dcr.LOC.SHIFT] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.SHIFT] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    L[Dcr.LOC.ALT] .. "-" .. L[Dcr.LOC.HLP_LEFTCLICK],
    L[Dcr.LOC.ALT] .. "-" .. L[Dcr.LOC.HLP_RIGHTCLICK],
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
};

local AvailableModifier = {
    "shift","ctrl","alt",
}

function MicroUnitF.prototype:UpdateAttributes(Unit, DoNotDelay)
    self.UpdateMe = false;
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

    local ReturnValue = false;
    if (self.CurrUnit ~= Unit or not self.UnitClass) then 
	if (self.CurrUnit ~= Unit) then
	    self.Frame:SetAttribute("unit", "player"); -- XXX test if the unit really changes
	    self.Frame:SetAttribute("unit", Unit); -- XXX test if the unit really changes
	    self.CurrUnit = Unit;
	end
	self.UnitClass = select(2, UnitClass(Unit));
	ReturnValue = self;

	if (self.UnitClass) then
	    -- update the border color
	    self.OuterTexture1:SetTexture( BC:GetColor(self.UnitClass) );
	    self.OuterTexture2:SetTexture( BC:GetColor(self.UnitClass) );
	    self.OuterTexture3:SetTexture( BC:GetColor(self.UnitClass) );
	    self.OuterTexture4:SetTexture( BC:GetColor(self.UnitClass) );
	    ReturnValue = self;
	--else
	  --  Dcr:Debug("Class of unit %s is Nil", Unit);
	end


    end

    if (Dcr.Status.SpellsChanged == self.LastAttribUpdate) then
	return ReturnValue;
    end
    Dcr:Debug("UpdateAttributes() executed");

    self.Frame:SetAttribute("type3", "target"); --never changes
    self.Frame:SetAttribute("ctrl-type3", "focus"); -- never changes
    self.Frame:SetAttribute("type1", "target"); -- required to disable an hidden cache somewhere...
    self.Frame:SetAttribute("type1", "spell");
    self.Frame:SetAttribute("ctrl-type1", "target");  -- required to disable an hidden cache somewhere...
    self.Frame:SetAttribute("ctrl-type1", "spell");
    self.Frame:SetAttribute("type2", "target"); -- required to disable an hidden cache somewhere...
    self.Frame:SetAttribute("type2", "spell");

    -- We need:
    --
    --  - a table telling the priority of each spell
    --		Dcr.Status.CuringSpellsPrio [ __SPELL_NAME__ ] = __PRIO_NUM__


    if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
	self.TooltipButtonsInfo = {};
    end

    for Spell, Prio in pairs(Dcr.Status.CuringSpellsPrio) do
	self.Frame:SetAttribute(string.format(AvailableButtons[Prio], "spell"), Spell);

	if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
	    self.TooltipButtonsInfo[Prio] =
	    string.format("%s: %s", Dcr:ColorText(AvailableButtonsReadable[Prio], Dcr:NumToHexColor(MF_colors[Prio])), Spell);
	end
    end

    if (Dcr.Status.SpellsChanged ~= self.TooltipUpdate) then
	table.insert(self.TooltipButtonsInfo, string.format("%s: %s", L[Dcr.LOC.HLP_MIDDLECLICK], L[Dcr.LOC.TARGETUNIT]));
	table.insert(self.TooltipButtonsInfo, string.format("%s: %s", L[Dcr.LOC.CTRL] .. "-" .. L[Dcr.LOC.HLP_MIDDLECLICK], L[Dcr.LOC.FOCUSUNIT]));
	self.TooltipButtonsInfo = table.concat(self.TooltipButtonsInfo, "\n");
	self.TooltipUpdate = Dcr.Status.SpellsChanged;
    end

    self.LastAttribUpdate = Dcr.Status.SpellsChanged;
    return self;
    -- Dcr:PrintLiteral(Dcr.Status.CuringSpellsPrio);
end -- }}}

-- Micro Frame Events
function Dcr:DebuffsFrameUnit_OnLoad()
	--Dcr:Debug("Micro unit loaded");
	this:SetScript("PreClick", Dcr.DebuffsFrameUnit_OnPreClick);
	this:SetScript("PostClick", Dcr.DebuffsFrameUnit_OnPostClick);
end

local DefaultTTAnchor = {"ANCHOR_TOPLEFT", 0, 6};

function Dcr:DebuffsFrameUnit_OnEnter()
    Dcr.Status.MouseOveringMUF = true;
    local MF = this.Object;
    local Status;

    -- removes the CHARMED bit from Status
    Status = bit.band(MF.UnitStatus,  bit.bnot(CHARMED));


    if (Dcr.db.profile.AfflictionTooltips ) then
	MF:SetColor();
	local Unit = MF.CurrUnit;

	local TooltipText = "";
	if (UnitExists(MF.CurrUnit)) then
	    TooltipText =
	    -- Colored unit name
	    Dcr:ColorText(	    (UnitName(	  Unit    ))
	    , "FF" .. ((UnitClass(Unit)) and BC:GetHexColor( (select(2, UnitClass(Unit))) ) or "AAAAAA"));
	end


	-- set UnitStatus text
	local StatusText = "";
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

	elseif (Status == AFFLICTED or Status == AFFLICTED_NIR) then
	    local DebuffType = MF.Debuffs[1].Type;
	    StatusText = string.format(L[Dcr.LOC.AFFLICTEDBY], Dcr:ColorText( L[DcrC.TypeNames[DebuffType]], "FF" .. DcrC.TypeColors[DebuffType]) );
	end

	-- Unit State
	TooltipText = TooltipText .. "\n" .. L[Dcr.LOC.UNITSTATUS] .. StatusText .. "\n";

	-- Debuff(s) names
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

	local FirstMUF = MicroUnitF.ExistingPerNum[1].Frame;

	Dcr:DisplayTooltip( TooltipText , FirstMUF, DefaultTTAnchor);
	--Dcr:PrintLiteral(MF.Debuffs);
    --else
--	Dcr:DisplayTooltip(MF.CurrUnit .. " does not exist",MF.Parent);
    end

    if (Dcr.db.profile.DebuffsFrameShowHelp) then
	local helpText = MF.TooltipButtonsInfo;
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetText(helpText);
	GameTooltip:Show();

    end

end

function Dcr:DebuffsFrameUnit_OnLeave()
    Dcr.Status.MouseOveringMUF = false;
    --Dcr:Debug("Micro unit Hidden");
    DcrDisplay_Tooltip:Hide();
    if (Dcr.db.profile.DebuffsFrameShowHelp) then
	GameTooltip:Hide();
    end
end

function Dcr:DebuffsFrameUnit_OnPreClick()
--	Dcr:Debug("Micro unit Preclicked");
	Dcr.Status.ClickedMF = this.Object;
end
function Dcr:DebuffsFrameUnit_OnPostClick()
--	Dcr:Debug("Micro unit PostClicked");
end

function Dcr:DebuffsFrameUnit_OnAttributeChanged(self, name, value)
	Dcr:Debug("Micro unit '%s' AttributeChanged to '%s'", name, value);
end

function MicroUnitF.prototype:SetDebuffs()
    self.Debuffs, self.IsCharmed = Dcr:UnitCurableDebuffs(self.CurrUnit);
end


function Dcr:OnCornerClick (arg1, this)
    if (arg1 == "RightButton") then
	Dcr.DewDrop:Open(this,
	'children', function()
	    Dcr.DewDrop:FeedAceOptionsTable( Dcr.options )
	end
	);
    elseif (arg1 == "LeftButton" and IsAltKeyDown()) then
	Dcr:Hide();
    elseif (arg1 == "LeftButton" and IsControlKeyDown()) then
	Dcr:ShowHidePriorityListUI();
    elseif (arg1 == "LeftButton" and IsShiftKeyDown()) then
	Dcr:ShowHideSkipListUI();
    end
end

do
    local color = {};
    local DebuffType, Unit, PreviousStatus, BorderAlpha;
    function MicroUnitF.prototype:SetColor()

	-- get the debuffs of this unit
	self:SetDebuffs();
	BorderAlpha =  Dcr.db.profile.DebuffsFrameElemAlpha / 2;
	DebuffType = false;
	Unit = self.CurrUnit;
	PreviousStatus = self.UnitStatus;

	--  if 1 then return false; end
	-- if unit not available
	if (not UnitExists(Unit)) then
	    Dcr:tcopy(color, MF_colors[ABSENT]);
	    self.UnitStatus = ABSENT;

	elseif (not UnitIsVisible(Unit) or UnitLevel(Unit) == -1) then
	    Dcr:tcopy(color, MF_colors[FAR]);
	    self.UnitStatus = FAR;

	elseif (Dcr:CheckUnitStealth(Unit)) then
	    Dcr:tcopy(color, MF_colors[STEALTHED]);
	    self.UnitStatus = STEALTHED;

	    -- if unit is blacklisted
	elseif (Dcr.Status.Blacklisted_Array[Unit]) then
	    Dcr:tcopy(color, MF_colors[BLACKLISTED]);
	    self.UnitStatus = BLACKLISTED;

	elseif (self.Debuffs and self.Debuffs[1] and self.Debuffs[1].Type) then
	    DebuffType = self.Debuffs[1].Type;
	    local priority = Dcr:GiveSpellPrioNum(DebuffType);

	    --if (Dcr.Status.CuringSpells[DebuffType]) then
	    Dcr:tcopy(color, MF_colors[priority]);

	    local RangeStatus = IsSpellInRange(Dcr.Status.CuringSpells[DebuffType], Unit);

	    if (not RangeStatus or RangeStatus == 0) then
		color[4] = 0.40;
		self.UnitStatus = AFFLICTED_NIR;
	    else
		self.UnitStatus = AFFLICTED;
		BorderAlpha = 1;
	    end
	    --end
	else
	    Dcr:tcopy(color, MF_colors[NORMAL]);
	    self.UnitStatus = NORMAL;
	end

	if (self.IsCharmed) then
	    self.UnitStatus = bit.bor( self.UnitStatus, CHARMED);
	end

	if (not DebuffType) then
	    color[4] = color[4] * Dcr.db.profile.DebuffsFrameElemAlpha;
	end

	if (self.UnitStatus ~= PreviousStatus or self.NormalAlpha ~= Dcr.db.profile.DebuffsFrameElemAlpha or self.FirstDebuffType ~= DebuffType) then
	    self.Texture:SetTexture(unpack(color));

	    if (self.IsCharmed) then
		self.InnerTexture:Show();
	    else
		self.InnerTexture:Hide();
	    end

	    if (self.BorderAlpha ~= BorderAlpha) then
		self.OuterTexture1:SetAlpha(BorderAlpha);
		self.OuterTexture2:SetAlpha(BorderAlpha);
		self.OuterTexture3:SetAlpha(BorderAlpha);
		self.OuterTexture4:SetAlpha(BorderAlpha);
	    end

	    Dcr:Debug("Color Applied", self.UnitStatus);


	    self.BorderAlpha = BorderAlpha;
	    self.NormalAlpha = Dcr.db.profile.DebuffsFrameElemAlpha;
	    self.FirstDebuffType = DebuffType;

	    --self.Color = savedcolor;
	    return true;
	end
	return false;

    end
end

function Dcr:GiveSpellPrioNum (Type)
    return Dcr.Status.CuringSpellsPrio[Dcr.Status.CuringSpells[Type]];
end

