unit_heal = class({})

LinkLuaModifier("unit_heal_modifier", LUA_MODIFIER_MOTION_NONE)

function unit_heal:GetIntrinsicModifierName()
    return "unit_heal_modifier"
end

function unit_heal:GetAbilityTag()
    return "unit_heal"
end

function unit_heal:OnSpellStart()
    self.target = self:GetCaster():FindModifierByName("unit_heal_modifier").lowest_health_ally

    if self.target then
        self.target:ModifyHealth(self.target:GetHealth() + 25, self, true,0)
    end
end