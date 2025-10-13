if GetLocale() ~= "zhCN" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- 简体中文 (zhCN)
L.ADDON_NAME = "Already Bought Tracker"

-- 类别
L.DISPLAY = "显示"
L.TRACKING = "跟踪"

-- 显示选项
L.MARK = "标记"
L.MARK_TOOLTIP = "为可收藏物品显示勾选/叉号覆盖"

L.DIM = "变暗"
L.DIM_TOOLTIP = "将已收藏的物品变暗"

L.DIM_ALPHA = "变暗透明度"
L.DIM_ALPHA_TOOLTIP = "在变暗模式下已知物品的不透明度"

-- 跟踪选项
L.MOUNTS = "坐骑"
L.MOUNTS_TOOLTIP = "跟踪坐骑物品。"
L.PETS = "宠物"
L.PETS_TOOLTIP = "跟踪战斗宠物和教学宠物物品。"
L.TOYS = "玩具"
L.TOYS_TOOLTIP = "跟踪玩具物品。"
L.HEIRLOOMS = "传家宝"
L.HEIRLOOMS_TOOLTIP = "跟踪传家宝物品。"
L.ENSEMBLES = "套装"
L.ENSEMBLES_TOOLTIP = "跟踪套装物品。"
L.EQUIPMENT = "装备"
L.EQUIPMENT_TOOLTIP = "跟踪装备物品。"

-- 提示词（启发式）
L.TOKEN_ENSEMBLE = "套装"
L.TOKEN_APPEARANCE = "外观"
L.TOKEN_TOY = "玩具"
L.TOKEN_TOYBOX = "玩具箱"
L.TOKEN_PET = "宠物"
L.TOKEN_BATTLE_PET = "战斗宠物"
L.TOKEN_SUMMON = "召唤"
L.TOKEN_USE = "使用："