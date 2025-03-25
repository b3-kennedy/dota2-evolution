world_panel_holder_modifier = class({})


require("libraries/worldpanels")
function world_panel_holder_modifier:OnCreated(kv)


    if not IsServer() then return end

     self.panel = WorldPanels:CreateWorldPanel(self:GetParent():GetPlayerOwnerID(), 
    {layout = "file://{resources}/layout/custom_game/level_panel.xml",
      entity = self:GetParent(),
      entityHeight = 210,
      index = self:GetParent():entindex()
    })

end

function world_panel_holder_modifier:OnLevel(level)
    self.panel:Delete()
    self.panel = WorldPanels:CreateWorldPanel(self:GetParent():GetPlayerOwnerID(), 
    {layout = "file://{resources}/layout/custom_game/level_panel" .. tostring(level) ..".xml",
      entity = self:GetParent(),
      entityHeight = 210,
      index = self:GetParent():entindex()
    })
end