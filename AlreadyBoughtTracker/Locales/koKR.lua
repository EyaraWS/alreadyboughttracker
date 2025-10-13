if GetLocale() ~= "koKR" then return end
local ADDON_NAME = ...
local L = _G[ADDON_NAME.."Locale"]

-- 한국어 (koKR)
L.ADDON_NAME = "Already Bought Tracker"

-- 분류
L.DISPLAY = "표시"
L.TRACKING = "추적"

-- 표시 옵션
L.MARK = "표시"
L.MARK_TOOLTIP = "수집품에 체크/크로스 오버레이 표시"

L.DIM = "어둡게"
L.DIM_TOOLTIP = "이미 수집한 아이템을 어둡게"

L.DIM_ALPHA = "어둡기 투명도"
L.DIM_ALPHA_TOOLTIP = "어둡게 모드에서 이미 아는 아이템의 투명도"

L.UPDATE_NOTIFY = "업데이트 알림"
L.UPDATE_NOTIFY_TOOLTIP = "애드온 업데이트 또는 새 버전이 있을 때 채팅 메시지를 표시합니다."

-- 추적 옵션
L.MOUNTS = "탈것"
L.MOUNTS_TOOLTIP = "탈것 아이템 추적."
L.PETS = "애완동물"
L.PETS_TOOLTIP = "전투 애완동물과 애완동물 습득 아이템 추적."
L.TOYS = "장난감"
L.TOYS_TOOLTIP = "장난감 아이템 추적."
L.HEIRLOOMS = "유물"
L.HEIRLOOMS_TOOLTIP = "유물 아이템 추적."
L.ENSEMBLES = "형상 세트"
L.ENSEMBLES_TOOLTIP = "형상 세트 아이템 추적."
L.EQUIPMENT = "장비"
L.EQUIPMENT_TOOLTIP = "장비 아이템 추적."

-- 툴팁 토큰 (휴리스틱)
L.TOKEN_ENSEMBLE = "연합"
L.TOKEN_APPEARANCE = "외형"
L.TOKEN_TOY = "장난감"
L.TOKEN_TOYBOX = "장난감 상자"
L.TOKEN_PET = "애완동물"
L.TOKEN_BATTLE_PET = "전투 애완동물"
L.TOKEN_SUMMON = "소환"
L.TOKEN_USE = "사용:"

-- 업데이트 알림
L.UPDATED_TO = "버전 %s(으)로 업데이트되었습니다."
L.UPDATE_AVAILABLE = "새 버전이 있습니다: %s (현재 %s)."
L.UPDATE_CHECK_LINK = "다운로드: %s"
L.REPO_URL = "https://github.com/EyaraWS/alreadyboughttracker/releases"
L.CURSE_URL = "https://www.curseforge.com/wow/addons/already-bought-tracker"
