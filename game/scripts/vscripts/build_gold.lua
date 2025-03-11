build_gold = class({})

LinkLuaModifier("gpm_modifier", LUA_MODIFIER_MOTION_NONE)

function build_gold:OnSpellStart()
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= self:GetManaCost(self:GetLevel()) then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        local building = CreateUnitByName("npc_dota_gold_building", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

        PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()),DOTA_ModifyGold_AbilityCost)

        local kv = {duration = -1}

        print(self.player)

        self.player:AddNewModifier(self.player, self, "gpm_modifier", kv)

    else
        print("NOT ENOUGH GOLD TO BUILD GOLD BUILDING")
    end
end