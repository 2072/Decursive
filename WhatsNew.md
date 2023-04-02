Decursive 2.7.9.1
=================


Decursive 2.7.9.1 (2023-04-02)
------------------------------

- TOC Updates

- WotLK:Fix GetItemCooldown() Lua error

- WoW 10.1.0 (PTR): Fix GetAddOnMetadata Lua error


**New Way to support Decursive:** If you are an [ADA/Cardano](https://cardano.org) holder you can
delegate your stake to my pool: [anfra.io](https://anfra.io)


Decursive 2.7.9 (2023-02-25)
----------------------------

- Add support for by-specialization-profiles thanks to libDualSpec-1.0.

- Keep specific curing order for each class specialization (instead of just for each class).

- Add an option to hide Decursive's MUFs in raids.

- Decursive text anchor can be moved again.

- Do not report errors thrown in libraries embedded by Decursive on systems using '/' as directory separator.


Decursive 2.7.8.13 (2022-12-13)
-------------------------------

- Cauterizing Flame is no longer considered better than Expunge.

- Update CallBackHandler library to revision 8


Decursive 2.7.8.12 (2022-11-28)
-------------------------------

- Add support for the Evoker class and their Expunge (Poison) and Cauterizing
  Flame (Poison, Disease, Curse) as well as the Naturalize enhancement of the
  Expunge spell (Poison, Magic).

- WotLK: Added "Mutating Injection" to the "harmful debuff" list instead of the ignore list.
  You'll hear a sound and a warning will be displayed whenever your mouse cursor
  enters within a MUF with the Mutating Injection debuff.


Decursive 2.7.8.11 (2022-10-27)
-------------------------------

- Fix LUA error with LDB's tooltip creation.


Decursive 2.7.8.10 (2022-10-26)
-------------------------------

- TOC update for Dragonflight + fix XML error.

- WOTLK: Fix Body and Soul talent handling.


Decursive 2.7.8.9 (2022-09-22)
------------------------------

- WOTLK:
    - Fix Shaman's "Cleanse Spirit", Fellhunter's "Devour Magic" detection, Priests' "Body and Soul" talent detection.
    - Fix crash when adding custom pet spell by name in custom spell.


Decursive 2.7.8.8 (2022-09-10)
------------------------------

- WotLK: add missing spells for
    - Hunters: tranquilizing shot.
    - Shamans: Hex, Cleanse Spirit.
    - Priests: Dispell Magic (rank 1 is not detected once rank 2 is learned apparently...), Body and Soul talent detection (to cure poison on oneself).


Decursive 2.7.8.7 (2022-09-04)
------------------------------

- TOC updates

- Compatible with WotLK (if you find any issue, please create a [ticket](ticket).


Decursive 2.7.8.6 (2022-06-12)
------------------------------

- TOC updates


Decursive 2.7.8.5 (2022-02-27)
------------------------------

- TOC updates


Decursive 2.7.8.4 (2021-11-12)
------------------------------

- TOC + library update

- Add more information when the version of BugGrabber is wrong (very old
  version) to help people to fix the issue by themselves.


Decursive 2.7.8.3 (2021-07-04)
------------------------------

- Retail TOC Update


Decursive 2.7.8.2 (2021-05-20)
------------------------------

- Fix WoW classic detection.


Decursive 2.7.8.1 (2021-04-21)
------------------------------

- Fix Backdrop issue in WoW 9 (priority and skip lists UI).

- Fix for rare `Dcr_DebuffsFrame.lua:1469: attempt to index field '?' (a nil value)` Lua error.

- Remove old unknown rank text when a spell cast fails.


Decursive 2.7.8 (2020-11-21)
----------------------------

- Fix Mistweaver `Detox` detection.

- Adding pet abilities as custom spells in Decursive is now possible again
  (Decursive used to crash with an integer overflow error).

- WoW Classic: Fix pet abilities detection where only rank 1 could be detected.

- Full Spanish translation (thank to Sugymaylis)

- Full Barzilian Portuguese translation (thank to DarkbreakerSM)

- Add `Will Of The Forsaken` to automatic spell detection.

- Small enhancements to the custom spell interface.


Decursive 2.7.7.1 (2020-10-18)
------------------------------

- Prevent a damaged custom spell profile from crashing Decursive when loading.

- Add some resiliency to Decursive initialisation phase to mitigate some third party
  add-ons' bugs preventing Decursive from loading.

- In progress: Spanish localization by Sugymaylis.

- TOC update for WoW 9.


Decursive 2.7.7 (2020-05-09)
----------------------------

- It's now possible to change the color of the affliction types displayed in
  the MUF's tooltips and on the Live list.
  (see the "Colors" tab in the MUF option panel)

- Use lighter blues by default for the "Magic" and "Enemy Magic" affliction types.

- Revamped the `Affliction filtering` option panel to make it more intuitive
  and enforce the use of spell IDs to prevent non-working filters.


Decursive 2.7.6.7 (2020-02-27)
------------------------------

- TOC bumps to 11303 (classic) and 80300 (retail)


Decursive 2.7.6.6 (2019-11-18)
------------------------------

- Switch license back to GNU GPL V3. If you fork remember to change the report
  email address in `Dcr_DIAG.lua` via the `## X-eMail:` tag in `Decurive.toc` file.


Decursive 2.7.6.5 (2019-10-28)
-----------------------------

- TOC bump to 80205


Decursive 2.7.6.4 (2019-09-13)
-----------------------------

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
