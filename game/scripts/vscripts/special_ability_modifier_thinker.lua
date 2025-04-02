special_ability_modifier_thinker = class({})


function special_ability_modifier_thinker:OnCreated(kv)

    if not IsServer() then return end

    self.start_pos = self:GetParent():GetAbsOrigin()
    self.new_pos = 0
    self:StartIntervalThink(0.5)
end

function special_ability_modifier_thinker:OnIntervalThink()

    local team_number = self:GetCaster():GetTeamNumber()  -- The team of the caster

    if team_number == DOTA_TEAM_GOODGUYS then
        self.new_pos = self.start_pos.x - 300
    else
        self.new_pos = self.start_pos.x + 300
    end

    local vec = Vector(self.new_pos, self.start_pos.y, self.start_pos.z)
    self:GetParent():SetAbsOrigin(vec)
    self.start_pos = vec
    print(self:GetParent():GetAbsOrigin())

    local particle = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", 
        PATTACH_WORLDORIGIN,
        nil
    )

    AddFOWViewer( team_number, self:GetParent():GetAbsOrigin(), 500, 3, false )

    local radius = 500  -- AoE radius
    local damage = 1000  -- Amount of damage to deal
    local damage_type = DAMAGE_TYPE_MAGICAL  -- Damage type (MAGICAL, PHYSICAL, etc.)


    local enemies = FindUnitsInRadius(
        team_number,  -- Team of the caster
        vec,  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        radius,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_ENEMY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    for _, enemy in pairs(enemies) do
        local damage_table = {
            victim = enemy,
            attacker = self:GetCaster(),  -- The caster
            damage = damage,  -- The damage to deal
            damage_type = damage_type,  -- The type of damage
            ability = self:GetAbility(),  -- The ability causing the damage (optional)
        }
        ApplyDamage(damage_table)
    end
    ParticleManager:SetParticleControl(particle, 0, vec)  -- AoE Radius
    ParticleManager:SetParticleControl(particle, 1, Vector(800, 0, 0))  -- AoE Radius
end