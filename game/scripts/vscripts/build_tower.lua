build_tower = class({})

function build_tower:OnSpellStart()

    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= 500 then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        local tower = CreateUnitByName("npc_dota_tower", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

        PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),500,DOTA_ModifyGold_AbilityCost)

    else
        print("NOT ENOUGH GOLD TO BUILD TOWER")
    end
end