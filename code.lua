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
  -- TODO handle more block types
  if block.HeaderText then
    block.HeaderText:SetFont(FONT, FONT_SIZE)
  end
  if block.currentLine then
    if block.currentLine.Text then
      block.currentLine.Text:SetFont(FONT, FONT_SIZE)
    end
  end
end


local function styleTracker()
  ObjectiveTrackerFrame:SetScale(0.8)
  for i, m in ipairs(ObjectiveTrackerFrame.MODULES) do
    m.Header.Background:Hide()
    m.Header.Text:SetFont(TITLE_FONT, TITLE_FONT_SIZE)
  end
  ScenarioStageBlock.FinalBG:Hide()
  ScenarioStageBlock.NormalBG:Hide()
  ScenarioStageBlock.CompleteLabel:SetFont(FONT, FONT_SIZE)
  ScenarioStageBlock.Stage:SetFont(FONT, FONT_SIZE)
  ScenarioStageBlock.Name:SetFont(FONT, FONT_SIZE)
end


-- make quest poi buttons semi-transparent
-- XXX this isn't getting called
local function FadePOIButton(parent, onCreateFunc)
  --[[
  -- from blizz code
  local buttonName = "poi"..parentName..buttonType.."_"..buttonIndex;
  _G[buttonName]:SetAlpha(0.5)
  if QUEST_POI_SWAP_BUTTONS[parentName] then
    QUEST_POI_SWAP_BUTTONS[parentName]:SetAlpha(0.5)
  end
  ]]
  print("FadePOIButton")
  parent:SetAlpha(0.5)
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

  hooksecurefunc("QuestPOI_Initialize", FadePOIButton)

  -- this guy tells us what quest is affected but fires before the completion
  -- status is updated
  frame:RegisterEvent("QUEST_WATCH_UPDATE")
  -- this provides different info but fires at the right time!
  -- also fires when turning in quests but I don't think I care too much
  frame:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
end


local lastQuestIndex = -1
function frame:QUEST_WATCH_UPDATE(event, questIndex)
  lastQuestIndex = questIndex
end


function frame:UNIT_QUEST_LOG_CHANGED(event, unitID)
  if unitID ~= "player" then return end
  local index = lastQuestIndex
  local _, _, _, _, _, isComplete, _, _, _, _, _, _, _, _ =
    GetQuestLogTitle(index)
  if isComplete == 1 then RemoveQuestWatch(index) end
end


frame:RegisterEvent("ADDON_LOADED")
