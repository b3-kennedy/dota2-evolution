ice_vortex_modifier_thinker = class({})


LinkLuaModifier("heal_reduction_modifier", LUA_MODIFIER_MOTION_NONE)

function ice_vortex_modifier_thinker:OnCreated()

    if not IsServer() then return end

    self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex")
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex.lp")

    local particle_name = "particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf"
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 5, Vector(400, 0, 0))

    self:StartIntervalThink(0.5)

end

function ice_vortex_modifier_thinker:OnIntervalThink()
    local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),  -- Team of the caster
        self:GetParent():GetAbsOrigin(),  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        300,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_ENEMY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    if #enemies > 0 then
        for _, enemy in pairs(enemies) do
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "heal_reduction_modifier", {duration = 1})

        end
    end
end