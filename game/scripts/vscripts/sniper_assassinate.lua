sniper_assassinate = class({})


LinkLuaModifier("sniper_assassinate_modifier", LUA_MODIFIER_MOTION_NONE)

function sniper_assassinate:GetIntrinsicModifierName()
    return "sniper_assassinate_modifier"
end

function sniper_assassinate:GetTarget()
    local modifier = self:GetCaster():FindModifierByName("sniper_assassinate_modifier")
    return modifier.target
end

function sniper_assassinate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetTarget()
	-- local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf"
	local projectile_speed = 2500

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
	self.modifier = nil

	-- effects
	local sound_cast = "Ability.Assassinate"
	EmitSoundOn( sound_cast, caster )
	local sound_target = "Hero_Sniper.AssassinateProjectile"
	EmitSoundOn( sound_cast, target )
end


--------------------------------------------------------------------------------
-- Projectile
function sniper_assassinate:OnProjectileHit( target, location)

	-- apply damage
	local damage = self:GetAbilityDamage()
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- effects
	local sound_cast = "Hero_Sniper.AssassinateDamage"
	EmitSoundOn( sound_cast, target )
end

function sniper_assassinate:OnAbilityPhaseInterrupted()
	local modifier = self:GetCaster():FindModifierByName("sniper_assassinate_modifier")
	ExecuteOrderFromTable({
		UnitIndex = self:GetCaster():entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = modifier.enemy_spawn,
		Queue = false,
	})
end