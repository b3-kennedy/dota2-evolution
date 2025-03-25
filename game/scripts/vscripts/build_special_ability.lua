build_special_ability = class({})

require('positions')
require('placement_check')


function build_special_ability:OnSpellStart()
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= self:GetManaCost(self:GetLevel()) then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        if not placement_check:IsPlacementBlocked(self.player, self.mouse_pos, self.caster, 500) then
            local building = CreateUnitByName("npc_dota_special_ability_building", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

            building:SetOwner(self.player)
            building:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)

            PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()),DOTA_ModifyGold_AbilityCost)
        end
    else
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
end

function build_special_ability:GetAbilityTag()
    return "builder"
end