gpm_modifier = class({})

function gpm_modifier:OnCreated(kv)
    if not IsServer() then return end
    self.player = PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID())

    if self:GetStackCount() == 0 then
        self:SetStackCount(1)
    end
    
    self.gpm = self:GetStackCount()

    self:StartIntervalThink(1)


end

function gpm_modifier:OnRefresh(kv)
    if not IsServer() then return end

    self.player = PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID())
    
    if self:GetStackCount() == 0 then
        self:SetStackCount(1)
    end

    self:SetStackCount(self:GetStackCount()+1)

    self.gpm = self:GetStackCount()
end

function gpm_modifier:OnIntervalThink()
    PlayerResource:ModifyGold(self:GetParent():GetPlayerOwnerID(), self.gpm, true, DOTA_ModifyGold_AbilityCost)
end