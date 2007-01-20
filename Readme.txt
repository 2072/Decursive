Decursive 2.0 ( Main download: http://www.2072productions.com/?to=decursive.php )


This is a cleaning mod. Its job is to help a class that can remove afflictions to do it with ease.

Load the mod, bind a key and run, no further configuration or editing needed, it auto configures.

Currently Decursive is configured to automatically select Druid, Priest, Mage, Paladin, Shaman, Felhunter, and Doomguard cleansing spells.
Mage are also able to monitor mind controlled unit and sheep them if needed.

Decursive makes your life easier, it clearly shows you who is afflicted by something you can remove, this is done using "Micro-unit-frames" (MUF): a micro-unit-frame is a little square on your screen that changes of appearance according to the unit status
If you click on a MUF, it automatically cast a cleaning spell, the choice of the spell depends of the mouse button you click, Decursive manages the button mapping automatically.
MUF have several colors:

- Full red: the unit is in range and is affected by something you can cure by left-clicking on the MUF.
- Transparent red: the unit is out of range and affected by something you could cure by left-clicking on the MUF

- Full blue: idem as red but with right-clicking instead of left-clicking

- Full orange: idem as blue or red but with ctrl-left-clicking

- Transparent grey: The unit does not exists.

- Dark Transparent green: the unit is in scan range and is not afflicted by something you can cure

- Transparent purple: The unit is too far to be scan or cured

- Black, the unit has been blaclisted because it was out-of-sight when you tried to cure it, the time in blacklist can be change in the options.

MUFs display is done according to your settings, you can change their number and size easily (only when not in combat).

MUFs are very discreet when no action is required, you can see right through them.

You can change the spell mapping when you are not in combat, the mapping is done according to your cure priorities.

Besides casting, MUFs allow you to target the units by middle-clicking, ctrl-middle-clicking will focus them.

The informations above are also indicated by tool-tips in the game.

IMPORTANT: TO MOVE THE MUFS, CLICK AND HOLD THE HANDLE JUST ABOVE THE FIRST MUF (IT HAS THE SAME SIZE AS A MUF AND HIGHLIGHTS WHEN YOUR MOUSE POINTER IS OVER IT).
This handle has several uses, a tooltip explains them all.

Decursive also creates and manages a macro that allows you to cure units (or other unit frames) you mouse-over, you choose the key in Decursive's options.
Hitting the key alone will try to cast the first spell, ctrl-hitting, the second and shift-hitting will try to cast the third.
Decursive will show you if the unit beneath your cursor is afflicted by something through its 'live-list'.
You can also take the macro and place it on one of your action bar using the default Macros window.

NOTE: To change the default key, ([`]) use the graphical menu, the graphical menu is accessed by right-clicking the handle or the "Decursive" bar.
You can also use the command line for exemple, "/dcr macro SetKey V" wlll set the new key to [V].


MUFs are organized intelligently by default, you're always first then the rest of your group, the groups after yours, the group before yours and the pets (you can choose to monitor them or not) and, at last, your focused unit (changed by wow when using /focus 'name' or by ctrl-middle-clicking on a MUF).
You can completely change this by using the priority and skip list, a very manageable list of players.

Decursive has been written with optimisation, quality and performances in mind, it should not affect you refresh rate at all.
Decursive uses the expertise of the ACE 2.0 libraries (those libraries are embedded, you don't need to install any dependency).

Many options are available, don't forget to try them.

Decursive also have a skip list, people in this list will be completely ignored and not displayed in the MUFs.


COMMANDS YOU CAN USE:
/dcrshow
---> To show main Decursive window (also available by alt-left-clicking the MUFs handle)
/dcrhide
---> To hide main Decursive window (leaving live-list displayed)
/dcrreset
---> To reset Decursive windows position to the middle of your screen (useful when you loose a frame)
/dcrpradd
---> Add the current target to the priority list
/dcrprclear
---> clear the priority list
/dcrprshow
---> Display the priority list UI (where you can add,delete,move players) (Ctrl-left-clicking the MUFs handle does the same)
/dcrskadd
---> Add the current target to the skip list
/dcrskclear
---> Clear the skip list
/dcrskshow
---> Display the skip list UI (where you can add,delete,clear) (Shift-left-clicking the MUFs handle does the same)

NOTE that all these commands can also be bound to a key through the key-binding WoW interface.

ACTIONS YOU CAN TAKE:

    - IN MAIN DCR BAR:
    Middle-Clicking or ctrl-left-clicking on the label "Decursive" will hide the buttons and lock the frame and the live-list.

    - IN WOW KEY BINDING INTERFACE:
    You can bind a lot of things to keys under "Decursive" section.

    - BIND THE DECURSIVE MACRO TO A KEY (By default, it's bind to the '`' key, the key just beneath 'Esc' (non QWERTY keyboard owner will have to set a reachable key).
    This is done through Decursive menu options (Decursive maintain its macro and update it according to your settings and capabilities)

    - Hitting the bound key will cure the unit under your mouse pointer (the key alone is the first spell, use ctrl+key for 2nd spell and shift for the third)

    - If you've displayed the Micro-Unit-Frame (on by default) you can click on the micro-frames to cure, target or focus.

    - IN THE OPTION MENU, you can choose what you want to cure and the priority of each affliction, the priority determines what affliction is shown first but also the key mapping of your spells (look at the tool-tips to know the current bindings)

    - IN THE OPTION MENU, you can choose/add/delete debuffs to ignore while in combat per class, it avoids to waste time and mana ; Decurive already has a comprehensive Debuff list ignored on specific classes.

    - You can easily organize the unit frame order by using the priority and skip list, clicking on the buttons in the Decursive bar.

    - IN THE OPTION MENU, you can save your options per character/server/class.

    - Choose the appearance of the Micro-Unit frames container, you can change the size the number of unit displayed, the number of units per lines...

    - MOVE THE MICRO_UNIT_FRAMES by clicking above the first one, there is a handle to move the frame.


OPTIONS YOU CAN SET:
(on the "Decursive" bar or on the MUFs handle, right-click to display a drop-down menu option, or type /Dcr to access the options by command line)
Note that each options has an explanation tool-tip. Just explore the menus.


