if GetLocale() ~= "frFR" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Français (frFR)
L.ADDON_NAME = "Already Bought Tracker"

-- Catégories
L.DISPLAY = "Affichage"
L.TRACKING = "Suivi"

-- Options d'affichage
L.MARK = "Marquer"
L.MARK_TOOLTIP = "Afficher des coches/croix pour les objets collectionnables"

L.DIM = "Estomper"
L.DIM_TOOLTIP = "Estomper les objets collectés"

L.DIM_ALPHA = "Opacité"
L.DIM_ALPHA_TOOLTIP = "Opacité des objets connus en mode Estomper"

-- Options de suivi
L.MOUNTS = "Montures"
L.MOUNTS_TOOLTIP = "Suivre les objets monture."
L.PETS = "Mascottes"
L.PETS_TOOLTIP = "Suivre les mascottes de combat et les objets apprenant une mascotte."
L.TOYS = "Jouets"
L.TOYS_TOOLTIP = "Suivre les jouets."
L.HEIRLOOMS = "Héritages"
L.HEIRLOOMS_TOOLTIP = "Suivre les objets d'héritage."
L.ENSEMBLES = "Ensembles"
L.ENSEMBLES_TOOLTIP = "Suivre les ensembles."
L.EQUIPMENT = "Équipement"
L.EQUIPMENT_TOOLTIP = "Suivre les objets d'équipement."

-- Jetons d'info-bulle (heuristiques)
L.TOKEN_ENSEMBLE = "Ensemble"
L.TOKEN_APPEARANCE = "apparence"
L.TOKEN_TOY = "Jouet"
L.TOKEN_TOYBOX = "Boîte à jouets"
L.TOKEN_PET = "Mascotte"
L.TOKEN_BATTLE_PET = "Mascotte de combat"
L.TOKEN_SUMMON = "Invoquer"
L.TOKEN_USE = "Utiliser :"
