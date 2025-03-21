lion_finger = class({})

LinkLuaModifier("lion_finger_modifier", LUA_MODIFIER_MOTION_NONE)

function lion_finger:GetIntrinsicModifierName()
    return "lion_finger_modifier"
end

function lion_finger:GetTarget()
    local modifier = self:GetCaster():FindModifierByName("lion_finger_modifier")
    return modifier.target
end

function lion_finger:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetTarget()

	-- pre-effects
	local sound_cast = "Hero_Lion.FingerOfDeath"
	EmitSoundOn( sound_cast, caster )


    self:PlayEffects( target )

    local damageTable = {
        victim = target,                -- The enemy unit taking damage
        attacker = caster,              -- The unit dealing damage
        damage = 600,                   -- Amount of damage
        damage_type = DAMAGE_TYPE_MAGICAL,  -- Can be MAGICAL, PHYSICAL, or PURE
        ability = self                  -- The ability causing the damage
    }

    ApplyDamage(damageTable)
    
end

--------------------------------------------------------------------------------
function lion_finger:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf"
	local sound_cast = "Hero_Lion.FingerOfDeathImpact"

    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil );
    ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
    ParticleManager:SetParticleControlEnt( nFXIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true );
    ParticleManager:ReleaseParticleIndex( nFXIndex );
    
    -- Optional: Destroy particle after delay
    --ParticleManager:ReleaseParticleIndex(particle)

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end