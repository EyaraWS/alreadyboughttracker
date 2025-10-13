if GetLocale() ~= "zhTW" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- 繁體中文 (zhTW)
L.ADDON_NAME = "Already Bought Tracker"

-- 類別
L.DISPLAY = "顯示"
L.TRACKING = "追蹤"

-- 顯示選項
L.MARK = "標記"
L.MARK_TOOLTIP = "為可收藏物品顯示勾選/叉號覆蓋"

L.DIM = "變暗"
L.DIM_TOOLTIP = "將已收藏的物品變暗"

L.DIM_ALPHA = "變暗不透明度"
L.DIM_ALPHA_TOOLTIP = "在變暗模式下已知物品的不透明度"

-- 追蹤選項
L.MOUNTS = "坐騎"
L.MOUNTS_TOOLTIP = "追蹤坐騎物品。"
L.PETS = "寵物"
L.PETS_TOOLTIP = "追蹤戰寵與教學寵物物品。"
L.TOYS = "玩具"
L.TOYS_TOOLTIP = "追蹤玩具物品。"
L.HEIRLOOMS = "傳家寶"
L.HEIRLOOMS_TOOLTIP = "追蹤傳家寶物品。"
L.ENSEMBLES = "套裝"
L.ENSEMBLES_TOOLTIP = "追蹤套裝物品。"
L.EQUIPMENT = "裝備"
L.EQUIPMENT_TOOLTIP = "追蹤裝備物品。"

-- 工具提示關鍵字（啟發式）
L.TOKEN_ENSEMBLE = "套裝"
L.TOKEN_APPEARANCE = "外觀"
L.TOKEN_TOY = "玩具"
L.TOKEN_TOYBOX = "玩具箱"
L.TOKEN_PET = "寵物"
L.TOKEN_BATTLE_PET = "戰鬥寵物"
L.TOKEN_SUMMON = "召喚"
L.TOKEN_USE = "使用："