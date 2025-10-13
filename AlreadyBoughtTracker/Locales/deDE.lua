if GetLocale() ~= "deDE" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Deutsch (deDE)
L.ADDON_NAME = "Already Bought Tracker"

-- Kategorien
L.DISPLAY = "Anzeige"
L.TRACKING = "Nachverfolgung"

-- Anzeigeoptionen
L.MARK = "Markieren"
L.MARK_TOOLTIP = "Zeige Häkchen/Kreuz-Overlays für Sammlerstücke"

L.DIM = "Abdunkeln"
L.DIM_TOOLTIP = "Bekannte/gesammelte Gegenstände abdunkeln"

L.DIM_ALPHA = "Abdunklungs-Alpha"
L.DIM_ALPHA_TOOLTIP = "Transparenz für bekannte Gegenstände im Abdunkeln-Modus"

-- Nachverfolgungsoptionen
L.MOUNTS = "Reittiere"
L.MOUNTS_TOOLTIP = "Reittier-Gegenstände verfolgen."
L.PETS = "Haustiere"
L.PETS_TOOLTIP = "Kampfhaustiere und haustierlehrende Gegenstände verfolgen."
L.TOYS = "Spielzeuge"
L.TOYS_TOOLTIP = "Spielzeuge verfolgen."
L.HEIRLOOMS = "Erbstücke"
L.HEIRLOOMS_TOOLTIP = "Erbstücke verfolgen."
L.ENSEMBLES = "Ensembles"
L.ENSEMBLES_TOOLTIP = "Ensemble-Gegenstände verfolgen."
L.EQUIPMENT = "Ausrüstung"
L.EQUIPMENT_TOOLTIP = "Ausrüstungsgegenstände verfolgen."

-- Tooltip-Begriffe (Heuristiken)
L.TOKEN_ENSEMBLE = "Ensemble"
L.TOKEN_APPEARANCE = "erscheinung"
L.TOKEN_TOY = "Spielzeug"
L.TOKEN_TOYBOX = "Spielzeugkiste"
L.TOKEN_PET = "Haustier"
L.TOKEN_BATTLE_PET = "Kampfhaustier"
L.TOKEN_SUMMON = "Beschwören"
L.TOKEN_USE = "Benutzen:"