# Changelog

## v0.1.0
- Initial release with overlays, modes (mark/hide/dim), unknown cross toggle, and purchase tracking

## v0.1.1
- Added Settings panel (replacing slash commands)
- Added localization support and popular locales
- Bumped Interface to 110007
- Added option: Consider known appearances (off by default)
- Fixed false-positives by making transmog optional
- Added this changelog; exposed via Settings

## v0.1.2
- Removed Hide mode due to vendor list instability; Mark and Dim remain
- Reworked Settings “mode” as mutually exclusive radios for reliability
- Fixed pets: caged pet ownership detection restored; reduced false negatives
- Improved toys and ensembles detection; added locale-aware tooltip tokens
- Restricted overlays to real collectibles (mounts, pets, toys, heirlooms, optional transmog)
- Switched overlay icons to explicit ReadyCheck textures to avoid question marks
- Multipage vendor refresh and update stability improvements
- Added per-category enable toggles (Mounts, Pets, Toys, Heirlooms, Transmog items, Ensembles)
- Normalized saved settings to avoid “Custom” mode and bad defaults

## v0.1.3
- Removed purchase tracking and its setting; it's unnecessary since collectibles state won't change while the vendor UI is open
- Replaced "Show cross on unknown" with a single "Mark" toggle controlling overlays for both known (check) and unknown (cross)
- Added migration from legacy setting to ensure user preferences carry over

## v0.1.4
- Merged transmog-related options into a single unified "Equipment" toggle (weapons/armor)
- Reorganized Settings into two groups: Display (Mark, Dim, Dim alpha) and Enable tracking on (categories)
- Made Dim independent from Mark (you can run either or both)
- Cleaned up locales: removed deprecated keys, added MARK_TOGGLE_TOOLTIP, and ensured section labels are localized
- Updated README and TOC notes

## v0.1.5
- Completed full translation sweep for remaining locales: koKR, ptBR, ruRU, zhCN, zhTW
- Ensured all non-enUS locale files use the new canonical key set and native-language strings
- Minor tooltip wording polish across locales for clarity and consistency

## v0.2.0
- New: in-chat update notifier announces when the addon updates and when a newer version is available (localized, quiet by default)
- New: Display toggle to disable update notifications entirely
- Improvement: silent cross-player version discovery using addon messages (WhoTaunted-style)
- Cleanup: removed legacy transmog settings migration from NormalizeSettings
- Localization: added notifier labels across all locales and ensured URLs are localized keys

## v0.3.0
- New: maintainer-only whitelist/blacklist of itemIDs to force include/exclude specific items detected incorrectly
- Fix: stabilize overlays on rapid merchant page switches via burst refresh scheduling

## v0.3.1
- Bump version to v0.3.1

## v0.3.2
- Bump version to v0.3.2

## v0.3.3
- Bump version to v0.3.3
