build_tower = class({})

function build_tower:OnSpellStart()

    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= self:GetManaCost(self:GetLevel()) then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        if not placement_check:IsPlacementBlocked(self.player, self.mouse_pos, self.caster, 200) then
            local tower = CreateUnitByName("npc_dota_tower", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

            PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()),DOTA_ModifyGold_AbilityCost)
        end
    else
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
end

function build_tower:GetAbilityTag()
    return "builder"
end