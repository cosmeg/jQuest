local addonName, addon = ...


local FONT = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\HelveticaNeue.ttf"
local FONT_SIZE = 12
local TITLE_FONT = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\HelveticaNeueBold.ttf"
local TITLE_FONT_SIZE = 14


local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...)
  if self[event] then return self[event](self, event, ...) end
end)


local function styleBlock(block)
  block.HeaderText:SetFont(FONT, FONT_SIZE)
  block.currentLine.Text:SetFont(FONT, FONT_SIZE)
end


local function styleTracker()
  QUEST_TRACKER_MODULE.Header.Text:SetFont(TITLE_FONT, TITLE_FONT_SIZE)
  ObjectiveTrackerFrame:SetScale(0.8)
  QUEST_TRACKER_MODULE.Header.Background:Hide()
end


function frame:ADDON_LOADED(event, name)
  if name ~= addonName then return end

  self:UnregisterEvent("ADDON_LOADED")

  styleTracker()
  local block = QUEST_TRACKER_MODULE.firstBlock
  while (block) do
    styleBlock(block)
    block = block.nextBlock
  end

  hooksecurefunc("ObjectiveTracker_AddBlock", function(block, ...)
    styleBlock(block)
  end)

  hooksecurefunc("ObjectiveTracker_OnLoad", function(self, ...)
    styleTracker()
  end)
end


frame:RegisterEvent("ADDON_LOADED")
