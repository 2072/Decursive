Decursive 2.7.6.4
=================

Decursive 2.7.6.4 (2019-09-13)
-------------------------------------

- Compatible with WoW Classic. You need to use the _"*-classic.zip" packages_
  or install Decursive through Twitch.

If you encounter mismatched abilities in WoW Classic, please provide the class
AND the spell along with any other relevant details, type /dcrdiag and follow
the instructions displayed to send your report.

Also note that you can change the default spell mappings by typing /decursive
and checking the _"Allow internal macro editing..."_ checkbox in the  _"Custom spells / items"_
option tab and then re-adding the spell you want to use with Decursive.

- Due to the switch to [Bigwigs' packager][BigwigsPackager] `-nolib` packages are only available
  from [Github's release page][GithubReleases].


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


[ticket]: https://www.wowace.com/projects/decursive/issues
[GithubReleases]: https://github.com/2072/Decursive/releases
[BigwigsPackager]: https://github.com/BigWigsMods/packager
