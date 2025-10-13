if GetLocale() ~= "ptBR" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Português (Brasil) ptBR
L.ADDON_NAME = "Already Bought Tracker"

-- Categorias
L.DISPLAY = "Exibição"
L.TRACKING = "Rastreamento"

-- Opções de exibição
L.MARK = "Marcar"
L.MARK_TOOLTIP = "Mostrar marcas/cruzes para colecionáveis"

L.DIM = "Atenuar"
L.DIM_TOOLTIP = "Atenuar itens já coletados"

L.DIM_ALPHA = "Opacidade de atenuação"
L.DIM_ALPHA_TOOLTIP = "Opacidade para itens conhecidos no modo Atenuar"

-- Opções de rastreamento
L.MOUNTS = "Montarias"
L.MOUNTS_TOOLTIP = "Rastrear itens de montaria."
L.PETS = "Mascotes"
L.PETS_TOOLTIP = "Rastrear mascotes de batalha e itens que ensinam mascotes."
L.TOYS = "Brinquedos"
L.TOYS_TOOLTIP = "Rastrear brinquedos."
L.HEIRLOOMS = "Heranças"
L.HEIRLOOMS_TOOLTIP = "Rastrear itens de herança."
L.ENSEMBLES = "Conjuntos"
L.ENSEMBLES_TOOLTIP = "Rastrear conjuntos."
L.EQUIPMENT = "Equipamento"
L.EQUIPMENT_TOOLTIP = "Rastrear itens de equipamento."

-- Tokens de dica (heurísticas)
L.TOKEN_ENSEMBLE = "Conjunto"
L.TOKEN_APPEARANCE = "aparência"
L.TOKEN_TOY = "Brinquedo"
L.TOKEN_TOYBOX = "Caixa de brinquedos"
L.TOKEN_PET = "Mascote"
L.TOKEN_BATTLE_PET = "Mascote de Batalha"
L.TOKEN_SUMMON = "Invocar"
L.TOKEN_USE = "Usar:"