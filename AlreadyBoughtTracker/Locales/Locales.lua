local ADDON_NAME = ...
local L = {}
_G[ADDON_NAME.."Locale"] = L

setmetatable(L, { __index = function(t, k) return k end })
