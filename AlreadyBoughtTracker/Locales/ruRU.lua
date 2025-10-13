if GetLocale() ~= "ruRU" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Русский (ruRU)
L.ADDON_NAME = "Already Bought Tracker"

-- Разделы
L.DISPLAY = "Отображение"
L.TRACKING = "Отслеживание"

-- Параметры отображения
L.MARK = "Отметить"
L.MARK_TOOLTIP = "Показывать галочки/кресты для коллекционных предметов"

L.DIM = "Затемнить"
L.DIM_TOOLTIP = "Затемнять уже собранные предметы"

L.DIM_ALPHA = "Степень затемнения"
L.DIM_ALPHA_TOOLTIP = "Непрозрачность для известных предметов в режиме затемнения"

L.UPDATE_NOTIFY = "Уведомления об обновлениях"
L.UPDATE_NOTIFY_TOOLTIP = "Показывать сообщения в чате при обновлении аддона или появлении новой версии."

-- Параметры отслеживания
L.MOUNTS = "Маунты"
L.MOUNTS_TOOLTIP = "Отслеживать предметы маунтов."
L.PETS = "Питомцы"
L.PETS_TOOLTIP = "Отслеживать боевых питомцев и обучающие предметы."
L.TOYS = "Игрушки"
L.TOYS_TOOLTIP = "Отслеживать игрушки."
L.HEIRLOOMS = "Наследуемые"
L.HEIRLOOMS_TOOLTIP = "Отслеживать наследуемые предметы."
L.ENSEMBLES = "Наборы"
L.ENSEMBLES_TOOLTIP = "Отслеживать наборы."
L.EQUIPMENT = "Снаряжение"
L.EQUIPMENT_TOOLTIP = "Отслеживать предметы снаряжения."

-- Токены для подсказок (эвристики)
L.TOKEN_ENSEMBLE = "Комплект"
L.TOKEN_APPEARANCE = "облик"
L.TOKEN_TOY = "Игрушка"
L.TOKEN_TOYBOX = "Игровая коллекция"
L.TOKEN_PET = "Питомец"
L.TOKEN_BATTLE_PET = "Боевой питомец"
L.TOKEN_SUMMON = "Призыв"
L.TOKEN_USE = "Использование:"

-- Уведомление об обновлении
L.UPDATED_TO = "Обновлено до %s."
L.UPDATE_AVAILABLE = "Доступна новая версия: %s (у вас %s)."
L.UPDATE_CHECK_LINK = "Скачать: %s"
L.REPO_URL = "https://github.com/EyaraWS/alreadyboughttracker/releases"
L.CURSE_URL = "https://www.curseforge.com/wow/addons/already-bought-tracker"
