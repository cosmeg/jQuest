local ABF = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"
local FONT_SIZE = 12
local TITLE_FONT_SIZE = 16

--- Style tracker lines.
-- TODO have this run early enough to get already tracked quests
hooksecurefunc("WatchFrameLineTemplate_OnLoad", function(self, ...)
  --print("WatchFrameLineTemplate_OnLoad")
  -- TODO tighten up spacing?
  self.text:SetFont(ABF, FONT_SIZE)
  self.dash:SetFont(ABF, FONT_SIZE)
end)

--- Style tracker title.
hooksecurefunc("WatchFrame_OnLoad", function(self, ...)
  print("WatchFrame_OnLoad")
  self:SetScale(0.8)
  WatchFrameTitle:SetFont(ABF, TITLE_FONT_LINE)
end)


--- Style existing lines.
-- TODO remove this if I get the above to load early enough
WatchFrame:SetScale(0.8)
WatchFrameTitle:SetFont(ABF, TITLE_FONT_LINE)
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
