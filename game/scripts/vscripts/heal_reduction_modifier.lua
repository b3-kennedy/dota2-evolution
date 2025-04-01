heal_reduction_modifier = class({})


function heal_reduction_modifier:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
end

function heal_reduction_modifier:DeclareFunctions()
    return { MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE }
end


function heal_reduction_modifier:GetModifierHealAmplify_PercentageSource()
    return -50
end

function heal_reduction_modifier:OnIntervalThink()
    local dmg = {
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = 50,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility()
    }
    ApplyDamage(dmg)
end