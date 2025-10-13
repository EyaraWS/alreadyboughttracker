if GetLocale() ~= "deDE" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

L.ADDON_NAME = "Already Bought Tracker"

L.DISPLAY = "Anzeige"
L.TRACKING = "Nachverfolgung"

L.MARK = "Markieren"
L.MARK_TOOLTIP = "Zeige Häkchen/Kreuz-Overlays für Sammlerstücke"

L.DIM = "Abdunkeln"
L.DIM_TOOLTIP = "Bekannte/gesammelte Gegenstände abdunkeln"

L.DIM_ALPHA = "Abdunklungs-Alpha"
L.DIM_ALPHA_TOOLTIP = "Transparenz für bekannte Gegenstände im Abdunkeln-Modus"

L.UPDATE_NOTIFY = "Update-Benachrichtigungen"
L.UPDATE_NOTIFY_TOOLTIP = "Chat-Nachrichten anzeigen, wenn das Addon aktualisiert wurde oder eine neuere Version verfügbar ist."

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

L.TOKEN_ENSEMBLE = "Ensemble"
L.TOKEN_APPEARANCE = "erscheinung"
L.TOKEN_TOY = "Spielzeug"
L.TOKEN_TOYBOX = "Spielzeugkiste"
L.TOKEN_PET = "Haustier"
L.TOKEN_BATTLE_PET = "Kampfhaustier"
L.TOKEN_SUMMON = "Beschwören"
L.TOKEN_USE = "Verwenden:"

-- Update-Hinweis
L.UPDATED_TO = "Aktualisiert auf %s."
L.UPDATE_AVAILABLE = "Eine neuere Version ist verfügbar: %s (du hast %s)."
L.UPDATE_CHECK_LINK = "Herunterladen: %s"
L.REPO_URL = "https://github.com/EyaraWS/alreadyboughttracker/releases"
L.CURSE_URL = "https://www.curseforge.com/wow/addons/already-bought-tracker"