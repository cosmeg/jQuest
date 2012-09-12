local ABF = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"
local FONT_SIZE = 12

-- TODO have this run early enough to get already tracked quests
local oldWFLTOL = WatchFrameLineTemplate_OnLoad
local function JQuest_WatchFrameLineTemplate_OnLoad(self)
  --print("WatchFrameLineTemplate_OnLoad")
  oldWFLTOL(self)
  -- TODO tighten up spacing?
  self.text:SetFont(ABF, FONT_SIZE)
  self.dash:SetFont(ABF, FONT_SIZE)
end
WatchFrameLineTemplate_OnLoad = JQuest_WatchFrameLineTemplate_OnLoad

-- XXX this needs to be redone if the tracker is ever hidden
-- XXX uh does this happen?
local oldWFOL = WatchFrame_OnLoad
local function JQuest_WatchFrame_OnLoad(self)
  print("WatchFrame_OnLoad")
  oldWFOL(self)
  self:SetScale(0.9)
  WatchFrameTitle:SetFont(ABF, FONT_SIZE)
end
WatchFrame_OnLoad = JQuest_WatchFrame_OnLoad
WatchFrame:SetScale(0.9)
WatchFrameTitle:SetFont(ABF, FONT_SIZE)
