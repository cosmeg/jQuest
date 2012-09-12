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

	-- this is probably too often
	-- - do it when I pick up the quest
	-- - keep track and only do it if I need a new row created
	-- - somehow hook into the new row creation
	-- XXX this isn't even soon enough anyway
	--self.StyleWatchFrame()
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

-- TODO think this is how this should be done:
--function frame:StyleWatchFrame()
function frame.StyleWatchFrame(self)
	print("StyleWatchFrame")
	WatchFrameTitle:SetFont(ABF, SIZE)
	for i = 1, 50 do
		line = _G["WatchFrameLine"..i]
		if line then
			line.text:SetFont(ABF, SIZE)
			line.dash:SetFont(ABF, SIZE)
		else
			break
		end
	end
	WatchFrame_Update()
end

--frame.StyleWatchFrame()

--WatchFrameLineTemplate
-- does this variable exist? 
--   *when* can I modify it?
-- I think this will work! at least for new quests
-- *if* I change this early enough I think it'll solve it everywhere
-- I may need to remove delayed loading however (?)
-- XXX if this is virtual does this mean that I can't reference it here?
-- 	can I modify the template?
-- 	  can I even *reference* it?
-- 	or change which template is used?
-- 	  TODO:
--[[
JQuest_WatchFrameLineTemplate = CreateFrame("FRAME", "JQuest_WatchFrameLineTemplate", WatchFrameLineTemplate, "WatchFrameLineTemplate")
-- so how much will I fuck things up if I replace this at runtime?
WatchFrame.lineCache = UIFrameCache:New("FRAME", "WatchFrameLine", WatchFrameLines, "JQuest_WatchFrameLineTemplate");
-- TODO somehow cleanup the old cache
--]]

--[[
local oldWFOL = WatchFrame_OnLoad
function MyWatchFrame_OnLoad(self)
	oldWFOL(self)
	print("WFOL")
end
WatchFrame_OnLoad = MyWatchFrame_OnLoad
]]--

--WatchFrameLineTemplate.text:SetFont(ABF, SIZE)
--WatchFrameLineTemplate.dash:SetFont(ABF, SIZE)
-- XXX also virtual
--WatchFontTemplate:SetFont(ABF, SIZE)

local oldWFLTOL = WatchFrameLineTemplate_OnLoad
local function JQuest_WatchFrameLineTemplate_OnLoad(self)
  print("WatchFrameLineTemplate_OnLoad")
  oldWFLTOL(self)
  self.text:SetFont(ABF, SIZE)
  self.dash:SetFont(ABF, SIZE)
end
WatchFrameLineTemplate_OnLoad = JQuest_WatchFrameLineTemplate_OnLoad
