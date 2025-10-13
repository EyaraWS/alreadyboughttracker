if GetLocale() ~= "esES" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- Español (esES)
L.ADDON_NAME = "Already Bought Tracker"

-- Categorías
L.DISPLAY = "Visualización"
L.TRACKING = "Seguimiento"

-- Opciones de visualización
L.MARK = "Marcar"
L.MARK_TOOLTIP = "Mostrar marcas/cruces para coleccionables"

L.DIM = "Atenuar"
L.DIM_TOOLTIP = "Atenuar los objetos ya coleccionados"

L.DIM_ALPHA = "Opacidad de atenuación"
L.DIM_ALPHA_TOOLTIP = "Opacidad para objetos conocidos en modo Atenuar"

L.UPDATE_NOTIFY = "Notificaciones de actualización"
L.UPDATE_NOTIFY_TOOLTIP = "Mostrar mensajes en el chat cuando el addon se actualiza o hay una versión más reciente disponible."

-- Opciones de seguimiento
L.MOUNTS = "Monturas"
L.MOUNTS_TOOLTIP = "Seguir objetos de montura."
L.PETS = "Mascotas"
L.PETS_TOOLTIP = "Seguir mascotas de combate y objetos que enseñan mascotas."
L.TOYS = "Juguetes"
L.TOYS_TOOLTIP = "Seguir objetos de juguete."
L.HEIRLOOMS = "Herencias"
L.HEIRLOOMS_TOOLTIP = "Seguir objetos de herencia."
L.ENSEMBLES = "Conjuntos"
L.ENSEMBLES_TOOLTIP = "Seguir objetos de conjunto."
L.EQUIPMENT = "Equipo"
L.EQUIPMENT_TOOLTIP = "Seguir objetos de equipo."

-- Palabras clave de herramienta (heurísticas)
L.TOKEN_ENSEMBLE = "Conjunto"
L.TOKEN_APPEARANCE = "apariencia"
L.TOKEN_TOY = "Juguete"
L.TOKEN_TOYBOX = "Caja de juguetes"
L.TOKEN_PET = "Mascota"
L.TOKEN_BATTLE_PET = "Mascota de batalla"
L.TOKEN_SUMMON = "Invocar"
L.TOKEN_USE = "Usar:"

-- Aviso de actualización
L.UPDATED_TO = "Actualizado a %s."
L.UPDATE_AVAILABLE = "Hay una nueva versión disponible: %s (tienes %s)."
L.UPDATE_CHECK_LINK = "Descárgala en: %s"
L.REPO_URL = "https://github.com/EyaraWS/alreadyboughttracker/releases"
L.CURSE_URL = "https://www.curseforge.com/wow/addons/already-bought-tracker"