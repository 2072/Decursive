Decursive 2.7.6.4-beta_3
========================


Decursive 2.7.6.4-beta_3 (2019-09-09)
-------------------------------------

- Fix more WOW Classic spell issues:
    - Priests and Felhunters could not remove magic on friendly players.
    - Mages' Polymorph may not have been available.


Decursive 2.7.6.4-beta_2 (2019-09-08)
-------------------------------------

- WOW Classic: Fix missing `Cure Poison` for Druids.

- WOW Classic: Fix Paladins' `Purify` to remove poison instead of magic.

If you encounter other mismatched abilities, please provide the class AND the spell
along with any other relevant details.
Also note that you can change the default spell mappings by checking the
"Allow internal macro editing..." checkbox in the "Custom spell" option tab.

- Rename all .md.txt files to .md so that they are properly formatted on
  Github.com


Decursive 2.7.6.4-beta_1 (2019-09-03)
-------------------------------------

- Compatible with WoW Classic. You need to use the _"*-classic.zip" packages_ or
  the Twitch client.

- Due to the switch to Bigwig's packager -nolib packages are only available
  from Github.


Decursive 2.7.6.3 (2019-07-07)
------------------------------

- TOC update


Decursive 2.7.6.2 (2019-01-07)
------------------------------

- TOC update


Decursive 2.7.6.1 (2018-08-10)
------------------------------

- Prevent error reports from being created due to bad embedding of
  LibNameplateRegistry in other add-ons.

- Fix email address in HHTD debug reports.


Decursive 2.7.6 (2018-07-22)
----------------------------

- Fix WoW 8 compatibility issue where nothing was displayed on the MUFs.

- Re-added `Remove Curse` for Mages.

- Added `Consume Magic` for Demon Hunters and `Spellsteal` for Mages to remove
  magical mind-controlled effects on friendly units.

- Added a graceful period of 10 seconds after startup before complaining about
  other add-ons errors as the new LUA_WARNING WoW 8 feature unveils many
  non-consequential errors in other add-ons.


***
For older versions changes, see OldChangelog.txt


[ticket]: http://www.wowace.com/addons/decursive/tickets/
