# WoW Forever release candidate

This fork adds initial Decursive support for **World of Warcraft: Forever**
(codename Camelot). The first target is beta build `1.60.1.69913`, interface
`16001`.

Forever is an unusual compatibility target: it has Classic-era classes, spell
ranks, and dispels, but it runs on the modern client and uses the restricted
aura APIs introduced for Midnight. Decursive therefore enables a hybrid path:

- Classic spell tables, rank handling, and class availability.
- Modern `AuraContainer`, secret-value, and addon-restriction handling.
- Forever-aware AceDB realm and region keys.

## RC3 changes

RC3 includes the upstream 12.1 restricted-aura fixes, the raid-icon clearing
fix, and debuff sound discovery during aura scanning. The sound registration
path checks that both optional aura-sound APIs are available. Classic-era
client flavors continue through the legacy scanner and do not call those APIs.
The package workflow now validates pull requests and reserves uploads for tags.

## Dependency status

The release archive embeds dependencies through `.pkgmeta`. Its CI build uses
BigWigs Packager `v2.6.1`, which recognizes the `forever`/`camelot` flavor and
rewrites the packaged TOC to interface `16001`.

AceDB-3.0 revision 36 or newer is required on Forever. That revision contains
the upstream Forever realm-rule fix and a fallback for beta clients that do not
return a conventional region. CI verifies both the embedded revision and the
relevant Forever code before publishing an archive.

## Current testing scope

The package is statically checked against Blizzard's extracted Forever UI
source and built with the Forever-aware packager. The remaining RC work is
in-game coverage across dispelling classes and group/combat states. Forever is
still in beta, so spell IDs and protected-aura behavior may change between
builds.

When reporting a problem, include the Forever build number, character class,
whether the error occurred in combat, and the complete Lua error text.

## Install

Exit WoW completely, extract the full Forever release archive under
`_classic_beta_/Interface/AddOns`, and verify that the final path is
`_classic_beta_/Interface/AddOns/Decursive/Decursive.toc`. Enable Lua errors in
the client while testing (`/console scriptErrors 1`).
