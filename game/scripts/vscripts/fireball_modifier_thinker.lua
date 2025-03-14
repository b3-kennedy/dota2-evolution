fireball_modifier_thinker = class({})

LinkLuaModifier("fireball_modifier", LUA_MODIFIER_MOTION_NONE)

function fireball_modifier_thinker:OnCreated(kv)

    if not IsServer() then return end

    --particles/econ/items/viper/viper_immortal_tail_ti8/viper_immortal_ti8_nethertoxin.vpcf
    self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", PATTACH_WORLDORIGIN, nil)

    local parent = self:GetParent()

    ParticleManager:SetParticleControl(self.effect_cast, 0, parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(200, 1, 1))

    self:StartIntervalThink(0.2)
end

function fireball_modifier_thinker:OnIntervalThink()
    local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),  -- Team of the caster
        self:GetParent():GetAbsOrigin(),  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        200,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_ENEMY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    for _,enemy in pairs(enemies) do
        local kv = {duration = 1}
        enemy:AddNewModifier(self:GetCaster(), nil, "fireball_modifier", kv)
    end

end


function fireball_modifier_thinker:OnDestroy()
    if not IsServer() then return end

    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    UTIL_Remove(self:GetParent())
end