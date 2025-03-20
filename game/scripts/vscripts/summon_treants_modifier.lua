summon_treants_modifier = class({})

require('positions')

function summon_treants_modifier:OnCreated(kv)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.team = self.parent:GetTeamNumber()
    self.dist = 999999
    

    self:StartIntervalThink(1)
end

function summon_treants_modifier:OnIntervalThink()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.dist = (self.parent:GetAbsOrigin() - PLAYER_SPAWN_DIRE):Length2D()
    else
        self.dist = (self.parent:GetAbsOrigin() - PLAYER_SPAWN_RADIANT):Length2D()
    end

    if self.dist <= 600 and self:GetAbility():IsCooldownReady() then
        --self:GetParent():CastAbilityOnTarget(self.lowest_health_ally, self.ability, self:GetParent():GetPlayerOwnerID())
        self.parent:CastAbilityNoTarget(self:GetAbility(), self.parent:GetPlayerOwnerID())
    end
end