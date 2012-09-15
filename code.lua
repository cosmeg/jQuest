local ABF = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"
local FONT_SIZE = 12

--- Style tracker lines.
-- TODO have this run early enough to get already tracked quests
-- TODO hooksecurefunc
local oldWFLTOL = WatchFrameLineTemplate_OnLoad
local function JQuest_WatchFrameLineTemplate_OnLoad(self)
  --print("WatchFrameLineTemplate_OnLoad")
  oldWFLTOL(self)
  -- TODO tighten up spacing?
  self.text:SetFont(ABF, FONT_SIZE)
  self.dash:SetFont(ABF, FONT_SIZE)
end
WatchFrameLineTemplate_OnLoad = JQuest_WatchFrameLineTemplate_OnLoad

--- Style tracker title.
local oldWFOL = WatchFrame_OnLoad
local function JQuest_WatchFrame_OnLoad(self)
  print("WatchFrame_OnLoad")
  oldWFOL(self)
  self:SetScale(0.8)
  WatchFrameTitle:SetFont(ABF, FONT_SIZE)
end
WatchFrame_OnLoad = JQuest_WatchFrame_OnLoad
WatchFrame:SetScale(0.8)
WatchFrameTitle:SetFont(ABF, FONT_SIZE)


--- Style existing lines.
-- TODO remove this if I get the above to work for existing buffs
for i = 1, 50 do
  line = _G["WatchFrameLine"..i]
  if line then
    line.text:SetFont(ABF, FONT_SIZE)
    line.dash:SetFont(ABF, FONT_SIZE)
  else
    break
  end
end
WatchFrame_Update()
