local frame = CreateFrame('Frame')

local lastQuestIndex = -1

function frame.Update(self, event, ...)
	if ... then print(event .. " (" .. ... .. ")") else print(event) end

	if event == "QUEST_WATCH_UPDATE" then
		lastQuestIndex = ...
		return
	end
	-- UNIT_QUEST_LOG_CHANGED
	if ... ~= "player" then return end

	local index = lastQuestIndex
	--print(GetQuestLink(index))
	--print(GetQuestLogTitle(index))
	local _, _, _, _, _, _, isComplete, _, _, _, _ = GetQuestLogTitle(index)
	--print(isComplete)
	if isComplete then RemoveQuestWatch(index) end
end

-- this guy tells us what quest is affected but fires before the completion
-- status is updated
frame:RegisterEvent("QUEST_WATCH_UPDATE")
-- this provides different info but fires at the right time!
-- XXX also fires when turning in quests but I don't think I care too much
frame:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
-- Quixote uses this one w/ quest log scanning (but it requires more things I
-- don't need)
--frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:SetScript("OnEvent", frame.Update)


WatchFrame:SetScale(0.9)

local ABF = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"
local SIZE = 12

-- TODO have this run early enough to get already tracked quests
local oldWFLTOL = WatchFrameLineTemplate_OnLoad
local function JQuest_WatchFrameLineTemplate_OnLoad(self)
  --print("WatchFrameLineTemplate_OnLoad")
  oldWFLTOL(self)
  -- TODO tighten up spacing?
  self.text:SetFont(ABF, SIZE)
  self.dash:SetFont(ABF, SIZE)
end
WatchFrameLineTemplate_OnLoad = JQuest_WatchFrameLineTemplate_OnLoad
