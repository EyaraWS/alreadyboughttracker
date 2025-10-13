# Copilot Instructions for Already Bought Tracker

These guidelines capture how this repo is structured, what to change (and what not to), and how to automate releases. Follow them to keep contributions consistent.

## Overview
- Project type: World of Warcraft Retail addon (Lua)
- Addon folder: `AlreadyBoughtTracker/`
- Manifest: `AlreadyBoughtTracker/AlreadyBoughtTracker.toc` (Interface: 110205; SavedVariables: `ABT_Saved`)
- Core: `AlreadyBoughtTracker/Core.lua`
- Localization: `AlreadyBoughtTracker/Locales/*.lua` with per-locale guards
- Settings UI: Blizzard Settings Framework (categories/subcategories)
- Docs:
  - Addon docs: `AlreadyBoughtTracker/README.md` and `AlreadyBoughtTracker/CHANGELOG.md`
  - Repo docs: `README.md`, `CONVENTION.md`
- CI: `.github/workflows/release.yml` packages a zip and attaches it to Releases on tag push.

## Behavior and UX
- Overlays on vendor items:
  - Checkmark for known/collected
  - Red cross for unknown
- Settings (Game Menu > Options > AddOns > Already Bought Tracker):
  - Display: `Mark`, `Dim`, `Dim alpha`
  - Tracking categories: `Mounts`, `Pets`, `Toys`, `Heirlooms`, `Ensembles`, `Equipment`
- Dim is independent from Mark (both can be enabled or disabled separately).
- “Equipment” is the unified category for appearance-based gear (weapons/armor). Do not create separate “Transmog items” toggles.

## Do’s
- Use Blizzard APIs for detection first; fallback to tooltip scanning heuristics when needed.
- Keep overlay icons consistent (ReadyCheck textures).
- Maintain paging robustness for vendor lists; ensure overlays refresh when pages change.
- Keep `enUS.lua` as the canonical key set; other locales should mirror keys and translate values.
- Add setting migrations when renaming/removing options (see `NormalizeSettings` in `Core.lua`).
- Update `AlreadyBoughtTracker/CHANGELOG.md` with a new `## vX.Y.Z` section when bumping versions and update the version in `AlreadyBoughtTracker.toc`.
- Validate Lua syntax after edits.

## Don’ts
- Do not reintroduce “Hide” mode.
- Do not re-add purchase tracking.
- Do not add a separate “Consider known appearances” setting.
- Do not hardcode UI strings; use the locale table `L` everywhere.
- Do not split “Equipment” into multiple toggles.
- Do not change historical changelog entries.
- Do not run git operations unless explicitly requested by the user.

## Localization policy
- Canonical keys live in `Locales/enUS.lua` and are referenced in code.
- Each locale file must start with a guard: `if GetLocale() ~= "<locale>" then return end`.
- Use native-language translations; missing keys can fall back to the key via the `L` metatable defined in `Locales/Locales.lua`.
- Tooltip token keys (used by heuristics) include, but aren’t limited to:
  - `TOKEN_ENSEMBLE`, `TOKEN_APPEARANCE`, `TOKEN_TOY`, `TOKEN_TOYBOX`, `TOKEN_PET`, `TOKEN_BATTLE_PET`, `TOKEN_SUMMON`, `TOKEN_USE`

## Settings & architecture notes
- Use the Blizzard Settings Framework for UI controls (checkboxes, slider) and place them under two subcategories: `Display` and `Tracking`.
- Always source labels/tooltips from locale keys (e.g., `L.MARK`, `L.MARK_TOOLTIP`).
- `NormalizeSettings` handles legacy migrations (e.g., merging transmog flags into `enableEquipment`).
- Detection:
  - Gating: restrict overlays to real collectibles (mounts, pets, toys, heirlooms, ensembles, equipment).
  - Known-state: use Blizzard collection APIs; fallback to tooltip tokens for edge cases.

## Release automation
- Tag pattern: `vX.Y.Z`.
- CI (`.github/workflows/release.yml`) runs on tag push:
  - Zips `AlreadyBoughtTracker/` into `AlreadyBoughtTracker-${tag}.zip`.
  - Extracts release notes from `AlreadyBoughtTracker/CHANGELOG.md` matching the tag header `## vX.Y.Z` and appends a Full Changelog link.
  - Publishes/updates the GitHub Release with the zip attached.

## Commit conventions
- See `CONVENTION.md` for details.
- Branch naming: `type/purpose` (e.g., `docs/branch-naming`).
- Commit message Tag (capitalized): one of `Fix`, `Update`, `Breaking`, `Docs`, `Build`, `New`, `Upgrade`, `Refacto`, `Test`, `Chore`.
  - Examples:
    - `New: add addon core and enUS locale`
    - `Update: add non-enUS locales (deDE, frFR, esES, esMX, itIT, koKR, ptBR, ruRU, zhCN, zhTW)`
    - `Docs: update addon README and changelog for v0.1.5`
- Granularity:
  - It’s acceptable to group all non-enUS locale adds into a single `Update` commit.
  - Keep code changes and docs in separate commits where practical.

## Quick checklists
- Adding a locale
  - [ ] Copy keys from `enUS.lua`
  - [ ] Add locale guard and translate values
  - [ ] Validate syntax
  - [ ] Group non-enUS additions into a single `Update` commit if doing many at once

- Releasing a version
  - [ ] Update `AlreadyBoughtTracker.toc` version
  - [ ] Add `## vX.Y.Z` to `AlreadyBoughtTracker/CHANGELOG.md` at the end of the file
  - [ ] Ensure changelog text matches what you want in the release notes
  - [ ] Tag `vX.Y.Z` and push (CI will publish release and asset)

## Coding style
- Lua: follow existing patterns and indentation; avoid reformatting unrelated code.
- Keep functions small and cohesive; prefer early returns.
- Avoid introducing external dependencies.

## Support notes
- Works on any WoW client language via locales.
- Some niche items may require tooltip fallbacks; keep tokens localized and minimal.
- Known issues should be documented in `AlreadyBoughtTracker/README.md` under Notes.
