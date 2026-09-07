Decursive 2.9.0-RC2
===================

Decursive 2.9.0-RC2 (2026-09-07)
--------------------------------

Midnight: improve debuff sound registration:
- Don't register for types the user has explicitely disabled.
- Only register for units which are shown in the MUFs.
- Memory and CPU optimizations + code simplifications.


Decursive 2.9.0-RC1 (2026-09-06)
--------------------------------


This is an early release that brings basic compatibility with WoW 12.1

Decursive now uses the restricted/mandatory Blizzard API to show debuffs.
Decursive is now just conveying the information Blizzard provides without the
ability to filter or format anything depending on certain conditions apart from
the filtering options Blizzard is providing.

This has a few implications, first the bad and then the good ones:

The bad news:
-------------
- The alert sound only works consistently for the mind-controlled state and the
  current season's known debuffs (thanks to [RejectKid][RejectKid] and [Randy  Lorfing][RandyLorfing]).
  There might be a way to make Decursive learn and register debuffs the players dispell when outside of combat,
  it will be explored for a later release.

- The range indicator (dimmed MUF) is not working anymore (might be restored in
  a different way in a later release).

- The remaining duration/elapsed time or stack count of the debuff is gone for now (some of them might return in
  a later version if formatting functions from Blizzard are usable enough).

- Debuff filtering is mostly gone as it only works for NeverSecret debuffs.

- The LiveList only works for mind-controlled units and won't show any other debuffs.

- The bleed effect detection system cannot work anymore.

- Many still accessible options have no longer any effect in 12.1, they'll be hidden in future releases.

- As with 12.0, wrong-mouse-button detection is gone as well as out-of-line-of-sight cast error detection and unit black-listing.

- See the release notes for 2.8.0-RC2 for other Midnight related restrictions not listed here.

The good news:
--------------

- ✨ Stealth detection has been restored.

- ✨ Dispel type priority has been restored. (Thanks to [RejectKid][RejectKid] for his work on this)

- ✨ Unlike with wow 12.0 Decursive should be able to display all debuffs now (to be comfirmed)


- ✨ This release is also compatible with the Chinese client (Titan Reforged) of WoW thanks to [WidgetA][WidgetA]


Decursive 2.8.3 (2026-08-21)
----------------------------

- TOC update for BCC Anniversary


Decursive 2.8.2 (2026-08-12)
----------------------------


WoW 12.1 status:

Decursive is currently not compatible with WoW 12.1. It will display a message
to that effect and will not initialize (preventing Lua errors). The message is
shown only once.

An update might come in the following weeks if I can find some time to work on
it (tens of hours of work involved with uncertain results...)
You can keep Decursive enabled as it won't use any CPU and hopefully, one day it'll work again once it is updated.


Decursive 2.8.1 (2026-07-22)
----------------------------

- Fix for WoW classic

- Disable scanning for debuffs in 12.1

  Blizzard broke everything again so a lot of work is once more required to make Decursive compatible...
  So until then, this version of Decursive will just not report debuffs if used in 12.1.


Decursive 2.8.0 (2026-07-05)
----------------------------

- Fix for Classic-MOP

- Mark release stable for all classic version of WoW


Decursive 2.8.0-RC7 (2026-05-22)
--------------------------------

Midnight: Fix when switching from a character with a pet with a curing ability
 to a character without a pet, Decursive would still detect the pet spell
 (C_SpellBook.IsSpellInSpellBook() API bug)

Midnight: Disable "Wrong button" warnings as this feature cannot work anymore in midnight and created confusion.


Decursive 2.8.0-RC6 (2026-05-17)
--------------------------------

Midnight: fix another rare secret value error

Midnight: Add some debug to diagnose a tainting issue involving tooltips...


Decursive 2.8.0-RC5 (2026-04-18)
--------------------------------

- No visible change apart from the strengthening of a compatibility layer.
  Staying in the RC release stage until 12.0.5 lest something else gets broken.


Decursive 2.8.0-RC4 (2026-03-22)
--------------------------------

Midnight fixes
:
 - New attempt to fix GameTooltip tainting issue (see GitHub issue #51)
 - Always hide the spell cool down countdown on MUFs
 - fix another secret value issue


Decursive 2.8.0-RC3 (2026-03-16)
--------------------------------

Fix compatibility with new BugGrabber, fixing error at login.


Decursive 2.8.0-RC2 (2026-03-08)
--------------------------------

Decursive is now Compatible with Midnight but some features are either gone or severely impaired:

Some features will be missing depending on the dynamic add-on restrictions
being applied, notably the affliction type priority order which is no longer
applicable when auras are hidden. In that case Decursive will always assume
that the detected aura is your first aura type. The result is that:

 - The spell cooldown used on the MUFs will be the one from your first debuff
   type (so it might be wrong if you have several dispelling abilities).

 - Wrong mouse button click detection will not work (no alert will be given).

 - Range detection might not work or be wrong (you can set the most appropriate
   spell as your first priority to control that).


Broken features in Midgnight:
  - Debuff timers on MUFs (remaining and elapsed). Decursive will default to
    the number of stacks instead. You can still mouse over the live-list to see
    the debuff timers.

  - Line-of-sight failed cast detection and the resulting unit black-listing. (Decursive
    was using the combat log to do that)

  - Bleed debuff detection (aura's spell ids are no longer accessible)

  - Debuff filtering (may work in the open world while outside of combat...)

  - Stealth detection and reporting while in combat.

  - Decursive can now only be triggered by debuffs that WoW APIs tells you
    can dispel so it's uncertain if items can still be used reliably...

  - Specific buff/debuff detection such as "Unstable Affliction" are no longer possible.


Please note that this is an early release and that there still might be issues.

I'd like to give my warm thanks to Bozoweed for their help in making this release possible.


Decursive 2.7.36 (2026-01-25)
-----------------------------

- Fix TOC for midnight pre-patch

- Fix reported Lua error when debuffs are secret (note that Decursive is
  currently useless in this situation—see the note about midnight below...


**MIDNIGHT NOTE**:

 CLEU being gone and APIs returning secret values, there is little hope but the
 MUFs and spell detection are still working so there might be a way to do
 something with the debuf types and the curve color secret related APIs to
 change the MUFs color depending on the type of debuf...

 For now Decursive will just do nothing if the APIs are in secret mode.



***
For older versions changes, see OldChangelog.txt


[ticket]: https://www.wowace.com/projects/decursive/issues
[GithubReleases]: https://github.com/2072/Decursive/releases
[BigwigsPackager]: https://github.com/BigWigsMods/packager
[WidgetA]: https://github.com/WidgetA
[RejectKid]: https://github.com/RejectKid
[RandyLorfing]: https://github.com/randylorfing
