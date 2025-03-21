lina_dragon_slave = class({})


LinkLuaModifier("lina_dragon_slave_modifier", LUA_MODIFIER_MOTION_NONE)

function lina_dragon_slave:GetIntrinsicModifierName()
    return "lina_dragon_slave_modifier"
end

function lina_dragon_slave:GetTarget()
    local modifier = self:GetCaster():FindModifierByName("lina_dragon_slave_modifier")
    return modifier.target
end 

function lina_dragon_slave:OnSpellStart()
	self.dragon_slave_speed = 1200
	self.dragon_slave_width_initial = 275
	self.dragon_slave_width_end = 200
	self.dragon_slave_distance = 1075
	self.dragon_slave_damage = 110
    self.target = nil

	EmitSoundOn( "Hero_Lina.DragonSlave.Cast", self:GetCaster() )

    self.target = self:GetTarget()

	if self.target then
        vPos = self.target:GetAbsOrigin()
    end

	local vDirection = vPos - self:GetCaster():GetOrigin()
	vDirection.z = 0.0
	vDirection = vDirection:Normalized()

	local dir = Vector(vDirection.x, vDirection.y, 0)

	self.dragon_slave_speed = self.dragon_slave_speed * ( self.dragon_slave_distance / ( self.dragon_slave_distance - self.dragon_slave_width_initial ) )

	

	local info = {
		EffectName = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf",
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetOrigin(), 
		fStartRadius = self.dragon_slave_width_initial,
		fEndRadius = self.dragon_slave_width_end,
		vVelocity = dir * self.dragon_slave_speed,
		fDistance = self.dragon_slave_distance,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}

	ProjectileManager:CreateLinearProjectile( info )
	EmitSoundOn( "Hero_Lina.DragonSlave", self:GetCaster() )
end

--------------------------------------------------------------------------------

function lina_dragon_slave:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) then
		local damage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = self.dragon_slave_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}

		ApplyDamage( damage )

		local vDirection = vLocation - self:GetCaster():GetOrigin()
		vDirection.z = 0.0
		vDirection = vDirection:Normalized()
		
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget )
		ParticleManager:SetParticleControlForward( nFXIndex, 1, vDirection )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	end

	return false
end