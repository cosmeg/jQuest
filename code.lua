WatchFrame:SetScale(0.9)

local ABF = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"
local SIZE = 12

WatchFrameTitle:SetFont(ABF, SIZE)

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
