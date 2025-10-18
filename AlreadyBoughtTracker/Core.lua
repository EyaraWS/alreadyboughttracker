-- Already Bought Tracker (ABT)
-- Adds overlays (check/cross) to vendor items to indicate already known/collected.
-- Visual options: Mark overlays and independent Dim for known items. Configurable via Settings. Uses SavedVariables ABT_Saved.

local ADDON_NAME = ...
local ABT = CreateFrame("Frame", ADDON_NAME)

ABT:RegisterEvent("ADDON_LOADED")
ABT:RegisterEvent("MERCHANT_SHOW")
ABT:RegisterEvent("MERCHANT_UPDATE")
ABT:RegisterEvent("PLAYER_LOGIN")
ABT:RegisterEvent("PLAYER_ENTERING_WORLD")
ABT:RegisterEvent("CHAT_MSG_ADDON")

local defaults = {
  enableMark = true,
  enableDim = false,
  dimAlpha = 0.35,
  enableUpdateNotify = true,

  enableMounts = true,
  enablePets = true,
  enableToys = true,
  enableHeirlooms = true,
  enableEnsembles = true,
  enableEquipment = true,
}

ABT_Saved = ABT_Saved or nil

local function CopyDefaults(src, dst)
  if type(dst) ~= "table" then dst = {} end
  for k, v in pairs(src) do
    if type(v) == "table" then
      dst[k] = CopyDefaults(v, dst[k])
    elseif dst[k] == nil then
      dst[k] = v
    end
  end
  return dst
end

local L = _G[ADDON_NAME.."Locale"] or setmetatable({}, {__index=function(t,k) return k end})

local function GetVersion()
  local v
  if C_AddOns and C_AddOns.GetAddOnMetadata then
    v = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
  elseif GetAddOnMetadata then
    v = GetAddOnMetadata(ADDON_NAME, "Version")
  end
  return v or "v0.0.0"
end

local function ParseVersion(v)
  if type(v) ~= "string" then return 0,0,0 end
  local a,b,c = v:match("v?(%d+)%.(%d+)%.(%d+)")
  return tonumber(a) or 0, tonumber(b) or 0, tonumber(c) or 0
end

local function IsVersionGreater(a, b)
  local a1,a2,a3 = ParseVersion(a)
  local b1,b2,b3 = ParseVersion(b)
  if a1 ~= b1 then return a1 > b1 end
  if a2 ~= b2 then return a2 > b2 end
  return a3 > b3
end

ABT.version = GetVersion()

local COLOR_GREEN = "|cff00ff00"
local COLOR_YELLOW = "|cffffff00"
local COLOR_RESET = "|r"

local function PrintPrefix()
  return COLOR_GREEN .. "ABT" .. COLOR_RESET .. ": "
end

local function NotifyUpdatedIfNewInstall()
  if not ABT_Saved.enableUpdateNotify then return end
  if not ABT_Saved then return end
  local seen = ABT_Saved.seenVersion
  if seen ~= ABT.version then
    local fmt = L.UPDATED_TO
    local ver = COLOR_YELLOW .. (ABT.version or "") .. COLOR_RESET
    print(PrintPrefix() .. string.format(fmt, ver))
    local repo = rawget(L, "REPO_URL")
    local curse = rawget(L, "CURSE_URL")
    local linkFmt = L.UPDATE_CHECK_LINK
    if repo then print(PrintPrefix() .. string.format(linkFmt, COLOR_YELLOW .. repo .. COLOR_RESET)) end
    if curse then print(PrintPrefix() .. string.format(linkFmt, COLOR_YELLOW .. curse .. COLOR_RESET)) end
    ABT_Saved.seenVersion = ABT.version
  end
end

local function ABT_SendVersionPing()
  if not ABT_Saved.enableUpdateNotify then return end
  if not C_ChatInfo or not C_ChatInfo.SendAddonMessage then return end
  if C_ChatInfo.RegisterAddonMessagePrefix then pcall(C_ChatInfo.RegisterAddonMessagePrefix, "ABTVER") end
  local msg = "VER " .. (ABT.version or "v0.0.0")
  local function send(chan)
    pcall(C_ChatInfo.SendAddonMessage, "ABTVER", msg, chan)
  end
  if IsInGuild and IsInGuild() then send("GUILD") end
  if IsInGroup and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then send("INSTANCE_CHAT") end
  if IsInRaid and IsInRaid() then
    send("RAID")
  elseif IsInGroup and IsInGroup() then
    send("PARTY")
  end
end

local function ABT_OnAddonMessage(prefix, message, channel, sender)
  if not ABT_Saved.enableUpdateNotify then return end
  if prefix ~= "ABTVER" or type(message) ~= "string" then return end
  local me = UnitName and UnitName("player") or nil
  if sender and me then
    if sender == me then return end
    local sep = sender:find("-", 1, true)
    if sep and sender:sub(1, sep - 1) == me then return end
  end
  local ver = message:match("^VER%s+(.+)$")
  if not ver then return end
  if IsVersionGreater(ver, ABT.version) then
    if ABT_Saved.notifiedOutdatedFor ~= ver then
      local fmt = L.UPDATE_AVAILABLE
      local verNew = COLOR_YELLOW .. ver .. COLOR_RESET
      local verHave = COLOR_YELLOW .. (ABT.version or "") .. COLOR_RESET
      print(PrintPrefix() .. string.format(fmt, verNew, verHave))
      local repo = rawget(L, "REPO_URL")
      local curse = rawget(L, "CURSE_URL")
      local linkFmt = L.UPDATE_CHECK_LINK
      if repo then print(PrintPrefix() .. string.format(linkFmt, COLOR_YELLOW .. repo .. COLOR_RESET)) end
      if curse then print(PrintPrefix() .. string.format(linkFmt, COLOR_YELLOW .. curse .. COLOR_RESET)) end
      ABT_Saved.notifiedOutdatedFor = ver
    end
  end
end

local function NormalizeSettings()
  if type(ABT_Saved) ~= "table" then ABT_Saved = {} end
  ABT_Saved = CopyDefaults(defaults, ABT_Saved)
  ABT_Saved.enableMark = not not ABT_Saved.enableMark
  ABT_Saved.enableDim = not not ABT_Saved.enableDim
  ABT_Saved.enableUpdateNotify = not not ABT_Saved.enableUpdateNotify

  ABT_Saved.enableMounts = not not ABT_Saved.enableMounts
  ABT_Saved.enablePets = not not ABT_Saved.enablePets
  ABT_Saved.enableToys = not not ABT_Saved.enableToys
  ABT_Saved.enableHeirlooms = not not ABT_Saved.enableHeirlooms
  ABT_Saved.enableEnsembles = not not ABT_Saved.enableEnsembles
  ABT_Saved.enableEquipment = not not ABT_Saved.enableEquipment
end

local function GetItemID(itemLink)
  if not itemLink then return nil end
  local itemID = tonumber(itemLink:match("item:(%d+):"))
  return itemID
end

local function GetItemClassAndSubClass(itemLink)
  local _, _, _, _, _, _, _, _, _, _, _, classID, subClassID = GetItemInfo(itemLink)
  return classID, subClassID
end

local function GetBattlePetSpeciesID(link)
  if type(link) ~= "string" then return nil end
  local speciesID = link:match("^battlepet:(%d+):")
  return speciesID and tonumber(speciesID) or nil
end

local tooltipScanner
local function CreateTooltipScanner()
  if tooltipScanner then return tooltipScanner end
  local tip = CreateFrame("GameTooltip", ADDON_NAME.."Scanner", nil, "GameTooltipTemplate")
  tip:SetOwner(UIParent, "ANCHOR_NONE")
  tooltipScanner = tip
  return tip
end

local function TooltipHasAny(link, candidates)
  if not link or not candidates or #candidates == 0 then return false end
  local tip = CreateTooltipScanner()
  tip:ClearLines()
  tip:SetHyperlink(link)
  for i = 2, tip:NumLines() do
    local left = _G[tip:GetName() .. "TextLeft" .. i]
    if left then
      local text = left:GetText()
      if text and type(text) == "string" then
        local t = text:lower()
        for _, needle in ipairs(candidates) do
          if needle and t:find(needle, 1, true) then
            return true
          end
        end
      end
    end
  end
  return false
end

local function TooltipHasAll(link, groups)
  if not link or not groups or #groups == 0 then return false end
  for _, candidates in ipairs(groups) do
    local found = TooltipHasAny(link, candidates)
    if not found then return false end
  end
  return true
end

local function IsLikelyEnsemble(itemLink)
  if not itemLink then return false end
  local tokens = {}
  local t1 = rawget(L, "TOKEN_ENSEMBLE")
  local t2 = rawget(L, "TOKEN_APPEARANCE")
  if type(t1) == "string" then table.insert(tokens, t1:lower()) end
  if type(t2) == "string" then table.insert(tokens, t2:lower()) end
  table.insert(tokens, "ensemble")
  table.insert(tokens, "appearance")
  return TooltipHasAny(itemLink, tokens)
end

local function IsLikelyPetTeach(itemLink)
  local petTokens = {}
  local p1 = rawget(L, "TOKEN_PET")
  local p2 = rawget(L, "TOKEN_BATTLE_PET")
  if type(p1) == "string" then table.insert(petTokens, p1:lower()) end
  if type(p2) == "string" then table.insert(petTokens, p2:lower()) end
  table.insert(petTokens, "battle pet")
  table.insert(petTokens, "companion")

  local useTokens = {}
  local u1 = rawget(L, "TOKEN_USE")
  if type(u1) == "string" then table.insert(useTokens, u1:lower()) end
  table.insert(useTokens, "use:")

  return TooltipHasAll(itemLink, {useTokens, petTokens})
end

local function IsLikelyToy(itemLink)
  if not itemLink then return false end
  local tokens = {}
  local t1 = rawget(L, "TOKEN_TOY")
  local t2 = rawget(L, "TOKEN_TOYBOX")
  if type(t1) == "string" then table.insert(tokens, t1:lower()) end
  if type(t2) == "string" then table.insert(tokens, t2:lower()) end
  table.insert(tokens, "toy box")
  table.insert(tokens, "toy")
  return TooltipHasAny(itemLink, tokens)
end

local function ItemIsKnownOrCollected(itemLink)
  if not itemLink then return false end

  -- Pets
  if ABT_Saved.enablePets and C_PetJournal then
    local speciesID = (type(itemLink) == "string") and itemLink:match("^battlepet:(%d+):")
    speciesID = speciesID and tonumber(speciesID) or nil
    if speciesID then
      local numOwned = C_PetJournal.GetNumCollectedInfo and C_PetJournal.GetNumCollectedInfo(speciesID)
      if type(numOwned) == "number" and numOwned > 0 then
        return true
      end
      return false
    end
  end

  -- Mounts
  if ABT_Saved.enableMounts and C_MountJournal and C_MountJournal.GetMountFromItem then
    local id = GetItemID(itemLink)
    if id then
      local mountID = C_MountJournal.GetMountFromItem(id)
      if mountID then
        local collected
        if C_MountJournal.PlayerHasMount then
          collected = C_MountJournal.PlayerHasMount(mountID)
        else
          local _, _, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
          collected = isCollected and true or false
        end
        if collected then return true end
      end
    end
  end

  -- Toys
  if ABT_Saved.enableToys and C_ToyBox and PlayerHasToy then
    local id = GetItemID(itemLink)
    if id and PlayerHasToy(id) then return true end
  end

  -- Heirlooms
  if ABT_Saved.enableHeirlooms and C_Heirloom and C_Heirloom.PlayerHasHeirloom then
    local id = GetItemID(itemLink)
    if id and C_Heirloom.PlayerHasHeirloom(id) then return true end
  end

  -- Equipments
  if ABT_Saved.enableEquipment and C_TransmogCollection and C_TransmogCollection.PlayerHasTransmogByItemInfo then
    local ok = C_TransmogCollection.PlayerHasTransmogByItemInfo(itemLink)
    if ok then return true end
  end

  local tip = CreateTooltipScanner()
  tip:ClearLines()
  tip:SetHyperlink(itemLink)
  local hasCollectedHint, hasNotCollectedHint = false, false
  for i = 2, tip:NumLines() do
    local left = _G[tip:GetName() .. "TextLeft" .. i]
    if left then
      local text = left:GetText()
      if text and ITEM_SPELL_KNOWN and text:find(ITEM_SPELL_KNOWN) then
        return true
      end
      if text then
        if COLLECTED and text:find(COLLECTED) then hasCollectedHint = true end
        if NOT_COLLECTED and text:find(NOT_COLLECTED) then hasNotCollectedHint = true end
      end
    end
  end
  if hasCollectedHint and not hasNotCollectedHint then return true end
  return false
end

local function IsCollectibleCandidate(itemLink)
  if not itemLink then return false end
  do
    local id = GetItemID(itemLink)
    if id then
      local WL = _G[ADDON_NAME .. "Whitelist"]
      local BL = _G[ADDON_NAME .. "Blacklist"]
      if WL and WL[id] then return true end
      if BL and BL[id] then return false end
    end
  end
  if ABT_Saved.enablePets and type(itemLink) == "string" and itemLink:find("^battlepet:") then return true end
  local id = GetItemID(itemLink)
  if id then
    if ABT_Saved.enableMounts and C_MountJournal and C_MountJournal.GetMountFromItem and C_MountJournal.GetMountFromItem(id) then return true end
    if ABT_Saved.enableToys and C_ToyBox and C_ToyBox.IsToy and C_ToyBox.IsToy(id) then return true end
    if ABT_Saved.enableHeirlooms and C_Heirloom and C_Heirloom.IsItemHeirloom and C_Heirloom.IsItemHeirloom(id) then return true end
  end
  local classID, subClassID = GetItemClassAndSubClass(itemLink)
  if classID ~= nil then
    local weaponClass = (Enum and Enum.ItemClass and Enum.ItemClass.Weapon) or _G.LE_ITEM_CLASS_WEAPON
    local armorClass = (Enum and Enum.ItemClass and Enum.ItemClass.Armor) or _G.LE_ITEM_CLASS_ARMOR
    if ABT_Saved.enableEquipment and (classID == weaponClass or classID == armorClass) then return true end
    local miscClass = (Enum and Enum.ItemClass and Enum.ItemClass.Miscellaneous) or _G.LE_ITEM_CLASS_MISCELLANEOUS
    local petSub = (Enum and Enum.ItemMiscellaneousSubclass and Enum.ItemMiscellaneousSubclass.CompanionPet) or _G.LE_ITEM_MISCELLANEOUS_COMPANION_PET
    if ABT_Saved.enablePets and miscClass and petSub and classID == miscClass and subClassID == petSub then return true end
  end
  if ABT_Saved.enableEnsembles and IsLikelyEnsemble(itemLink) then return true end
  if ABT_Saved.enableToys and IsLikelyToy(itemLink) then return true end
  if ABT_Saved.enablePets and IsLikelyPetTeach(itemLink) then return true end
  return false
end

local function EnsureOverlay(button)
  if button.ABTOverlay then return button.ABTOverlay end
  local frame = CreateFrame("Frame", nil, button)
  frame:SetAllPoints(button)
  frame:SetFrameLevel(button:GetFrameLevel() + 5)
  frame:EnableMouse(false)

  local tex = frame:CreateTexture(nil, "OVERLAY")
  tex:SetSize(18, 18)
  tex:SetPoint("TOPRIGHT", -2, -2)
  frame.icon = tex

  button.ABTOverlay = frame
  return frame
end

local function SetOverlay(button, state)
  local overlay = EnsureOverlay(button)
  if not state then
    overlay:Hide()
    return
  end
  overlay:Show()
  if state == "known" then
    overlay.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    overlay.icon:SetVertexColor(0.25, 1, 0.25, 1)
  else
    overlay.icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
    overlay.icon:SetVertexColor(1, 0.25, 0.25, 1)
  end
end

local function RestoreButton(button)
  button:SetAlpha(1)
  button:EnableMouse(true)
  button:Show()
  local row = button:GetParent()
  if row and row.Show then row:Show() end
end

local function ShouldTreatAsKnown(itemLink, itemID)
  if ItemIsKnownOrCollected(itemLink) then return true end
  return false
end

local function UpdateMerchant()
  if not MerchantFrame or not MerchantFrame:IsShown() then return end
  local markEnabled = ABT_Saved.enableMark
  local function GetButtonIcon(button)
    return button.icon or button.Icon or button.IconTexture or _G[button:GetName().."IconTexture"]
  end
  local function ApplyDim(button, shouldDim)
    local iconTex = GetButtonIcon(button)
    if not iconTex then return end
    if ABT_Saved.enableDim and shouldDim then
      iconTex:SetAlpha(ABT_Saved.dimAlpha or 0.35)
    else
      iconTex:SetAlpha(1)
    end
  end

  local numItems = GetMerchantNumItems() or 0
  local page = MerchantFrame.page or 1
  for index = 1, MERCHANT_ITEMS_PER_PAGE do
    local button = _G["MerchantItem" .. index .. "ItemButton"]
    if button then
      local merchantIndex = ((page - 1) * MERCHANT_ITEMS_PER_PAGE) + index
      if merchantIndex <= numItems then
        local link = GetMerchantItemLink(merchantIndex)
        local id = GetItemID(link)
        local known = ShouldTreatAsKnown(link, id)
        local isCollectible = IsCollectibleCandidate(link)

        RestoreButton(button)
        if not isCollectible then
          SetOverlay(button, nil)
          ApplyDim(button, false)
        else
          ApplyDim(button, known)
          if not markEnabled then
            SetOverlay(button, nil)
          else
            if known then
              SetOverlay(button, "known")
            else
              SetOverlay(button, "unknown")
            end
          end
        end
      else
        SetOverlay(button, nil)
        ApplyDim(button, false)
      end
    end
  end
end

local function ABT_ScheduleUpdateBurst()
  if not MerchantFrame or not MerchantFrame:IsShown() then return end
  local delays = {0, 0.05, 0.1, 0.2, 0.35}
  for _, d in ipairs(delays) do
    C_Timer.After(d, UpdateMerchant)
  end
end

ABT.settingsRegistered = ABT.settingsRegistered or false
ABT:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" and select(1, ...) == ADDON_NAME then
    NormalizeSettings()
    if not ABT.settingsRegistered then ABT:RegisterSettings() end
    NotifyUpdatedIfNewInstall()
    ABT:UnregisterEvent("ADDON_LOADED")
  elseif event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
    if not ABT.settingsRegistered then ABT:RegisterSettings() end
    C_Timer.After(5, ABT_SendVersionPing)
  elseif event == "MERCHANT_SHOW" or event == "MERCHANT_UPDATE" then
    ABT_ScheduleUpdateBurst()
  elseif event == "CHAT_MSG_ADDON" then
    ABT_OnAddonMessage(...)
  end
end)

function ABT:RegisterSettings()
  if not Settings or not Settings.RegisterAddOnCategory then
    if C_AddOns and C_AddOns.LoadAddOn then pcall(C_AddOns.LoadAddOn, "Blizzard_Settings") end
  end
  if not Settings or not Settings.RegisterAddOnCategory then return end
  ABT.settingsRegistered = true

  local category = Settings.RegisterVerticalLayoutCategory(L.ADDON_NAME)
  category.ID = ADDON_NAME
  ABT.category = category

  local hasSub = type(Settings.RegisterVerticalLayoutSubcategory) == "function"
  local displayCat = category
  local trackingCat = category
  if hasSub then
    displayCat = Settings.RegisterVerticalLayoutSubcategory(category, L.DISPLAY)
    trackingCat = Settings.RegisterVerticalLayoutSubcategory(category, L.TRACKING)
  end

  do
    local variable = "abt_enable_mark"
    local setting = Settings.RegisterProxySetting(displayCat, variable, Settings.VarType.Boolean, L.MARK, defaults.enableMark,
      function() return ABT_Saved.enableMark end,
      function(val) ABT_Saved.enableMark = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(displayCat, setting, L.MARK_TOOLTIP)
  end

  do
    local variable = "abt_enable_dim"
    local setting = Settings.RegisterProxySetting(displayCat, variable, Settings.VarType.Boolean, L.DIM, defaults.enableDim,
      function() return ABT_Saved.enableDim end,
      function(val) ABT_Saved.enableDim = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(displayCat, setting, L.DIM_TOOLTIP)
  end

  do
    local variable = "abt_enable_update_notify"
    local setting = Settings.RegisterProxySetting(displayCat, variable, Settings.VarType.Boolean, L.UPDATE_NOTIFY, defaults.enableUpdateNotify,
      function() return ABT_Saved.enableUpdateNotify end,
      function(val) ABT_Saved.enableUpdateNotify = not not val end)
    Settings.CreateCheckbox(displayCat, setting, L.UPDATE_NOTIFY_TOOLTIP)
  end

  do
    local variable = "abt_dim_alpha"
    local function getter()
      return ABT_Saved.dimAlpha
    end
    local function setter(val)
      ABT_Saved.dimAlpha = val
      UpdateMerchant()
    end
    local defaultValue = defaults.dimAlpha
    local setting = Settings.RegisterProxySetting(displayCat, variable, Settings.VarType.Number, L.DIM_ALPHA, defaultValue, getter, setter)
    local options = Settings.CreateSliderOptions(0.1, 0.9, 0.05)
    Settings.CreateSlider(displayCat, setting, options, L.DIM_ALPHA_TOOLTIP)
  end

  if not hasSub then
    pcall(function() Settings.CreateHeader(category, L.TRACKING) end)
  end

  do
    local variable = "abt_enable_mounts"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.MOUNTS, defaults.enableMounts,
      function() return ABT_Saved.enableMounts end,
      function(val) ABT_Saved.enableMounts = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.MOUNTS_TOOLTIP)
  end

  do
    local variable = "abt_enable_pets"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.PETS, defaults.enablePets,
      function() return ABT_Saved.enablePets end,
      function(val) ABT_Saved.enablePets = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.PETS_TOOLTIP)
  end

  do
    local variable = "abt_enable_toys"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.TOYS, defaults.enableToys,
      function() return ABT_Saved.enableToys end,
      function(val) ABT_Saved.enableToys = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.TOYS_TOOLTIP)
  end

  do
    local variable = "abt_enable_heirlooms"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.HEIRLOOMS, defaults.enableHeirlooms,
      function() return ABT_Saved.enableHeirlooms end,
      function(val) ABT_Saved.enableHeirlooms = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.HEIRLOOMS_TOOLTIP)
  end

  do
    local variable = "abt_enable_ensembles"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.ENSEMBLES, defaults.enableEnsembles,
      function() return ABT_Saved.enableEnsembles end,
      function(val) ABT_Saved.enableEnsembles = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.ENSEMBLES_TOOLTIP)
  end

  do
    local variable = "abt_enable_equipment"
    local setting = Settings.RegisterProxySetting(trackingCat, variable, Settings.VarType.Boolean, L.EQUIPMENT, defaults.enableEquipment,
      function() return ABT_Saved.enableEquipment end,
      function(val) ABT_Saved.enableEquipment = not not val; UpdateMerchant() end)
    Settings.CreateCheckbox(trackingCat, setting, L.EQUIPMENT_TOOLTIP)
  end

  if hasSub then
    Settings.RegisterAddOnCategory(displayCat)
    Settings.RegisterAddOnCategory(trackingCat)
  end
  Settings.RegisterAddOnCategory(category)
end

ABT.merchantHooksDone = false
local function ABT_HookMerchantPaging()
  if ABT.merchantHooksDone then return end
  if MerchantNextPageButton and MerchantNextPageButton.HookScript then
    MerchantNextPageButton:HookScript("OnClick", function() ABT_ScheduleUpdateBurst() end)
  end
  if MerchantPrevPageButton and MerchantPrevPageButton.HookScript then
    MerchantPrevPageButton:HookScript("OnClick", function() ABT_ScheduleUpdateBurst() end)
  end
  if type(MerchantFrame_Update) == "function" then
    hooksecurefunc("MerchantFrame_Update", function() ABT_ScheduleUpdateBurst() end)
  end
  ABT.merchantHooksDone = true
end

if MerchantFrame and MerchantFrame.HookScript then
  MerchantFrame:HookScript("OnShow", function()
    ABT_HookMerchantPaging()
    C_Timer.After(0, UpdateMerchant)
  end)
end
