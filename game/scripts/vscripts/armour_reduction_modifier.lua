armour_reduction_modifier = class({})


LinkLuaModifier("minus_armour_modifier", LUA_MODIFIER_MOTION_NONE)

function armour_reduction_modifier:DeclareFunctions()
    return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function armour_reduction_modifier:OnAttackLanded(params)
    if params.attacker == self:GetParent() then
        params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "minus_armour_modifier", { duration = 3 })
    end
end