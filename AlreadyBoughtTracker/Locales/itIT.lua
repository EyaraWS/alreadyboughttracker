if GetLocale() ~= "itIT" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Italiano (itIT)
L.ADDON_NAME = "Already Bought Tracker"

-- Categorie
L.DISPLAY = "Visualizzazione"
L.TRACKING = "Tracciamento"

-- Opzioni di visualizzazione
L.MARK = "Segna"
L.MARK_TOOLTIP = "Mostra spunte/croci per i collezionabili"

L.DIM = "Offusca"
L.DIM_TOOLTIP = "Offusca gli oggetti già collezionati"

L.DIM_ALPHA = "Opacità offuscata"
L.DIM_ALPHA_TOOLTIP = "Opacità per gli oggetti conosciuti in modalità Offusca"

-- Opzioni di tracciamento
L.MOUNTS = "Cavalcature"
L.MOUNTS_TOOLTIP = "Traccia oggetti cavalcatura."
L.PETS = "Mascotte"
L.PETS_TOOLTIP = "Traccia mascotte da battaglia e oggetti che insegnano mascotte."
L.TOYS = "Giocattoli"
L.TOYS_TOOLTIP = "Traccia giocattoli."
L.HEIRLOOMS = "Cimeli"
L.HEIRLOOMS_TOOLTIP = "Traccia cimeli."
L.ENSEMBLES = "Completi"
L.ENSEMBLES_TOOLTIP = "Traccia completi."
L.EQUIPMENT = "Equipaggiamento"
L.EQUIPMENT_TOOLTIP = "Traccia oggetti di equipaggiamento."

-- Token delle descrizioni (euristiche)
L.TOKEN_ENSEMBLE = "Completo"
L.TOKEN_APPEARANCE = "aspetto"
L.TOKEN_TOY = "Giocattolo"
L.TOKEN_TOYBOX = "Scatola dei giocattoli"
L.TOKEN_PET = "Mascotte"
L.TOKEN_BATTLE_PET = "Mascotte da battaglia"
L.TOKEN_SUMMON = "Evoca"
L.TOKEN_USE = "Usa:"