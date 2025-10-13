# Already Bought Tracker (ABT)

Adds a small overlay (check or cross) to vendor item icons to indicate whether you already know/collected that item (e.g., mounts, toys, heirlooms, equipment appearances). Optionally dim known items.

## Features
- Overlay checkmark on known/collected items and red cross on unknown (toggleable "Mark")
- Optional Dim for known items
- Per-category toggles: Mounts, Pets, Toys, Heirlooms, Equipment, Ensembles
- Saved settings per account

## Settings
Game Menu > Options > AddOns > Already Bought Tracker

- Mark: On/Off
- Dim alpha: 0.10 – 0.90
- Category toggles: Mounts, Pets, Toys, Heirlooms, Equipment, Ensembles

## Installation
1. Copy the `AlreadyBoughtTracker` folder into your WoW AddOns directory:
   - Retail: `_retail_/Interface/AddOns/`
2. Restart the game or reload UI.

## Notes
- Known detection uses Blizzard APIs (MountJournal, ToyBox, Heirlooms, Transmog) plus tooltip scanning fallback. Some niche items may not be detected perfectly.

## Localization
The addon works in any client language. Included locales: enUS, deDE, frFR, esES, esMX, itIT, koKR, ruRU, ptBR, zhCN, zhTW. Missing strings fall back to English.
