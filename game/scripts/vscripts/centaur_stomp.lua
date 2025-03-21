centaur_stomp = class({})

LinkLuaModifier("centaur_stomp_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("basic_stun_modifier", LUA_MODIFIER_MOTION_NONE)

function centaur_stomp:GetIntrinsicModifierName()
    return "centaur_stomp_modifier"
end

function centaur_stomp:OnSpellStart()
	-- get references
	local radius = 315
	local damage = 100
	local stun_duration = 2

	-- find affected units
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- Prepare damage table
	local damageTable = {
		victim = nil,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}

	-- for each caught enemies
	for _,enemy in pairs(enemies) do
		-- Apply Damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- Apply stun debuff
		enemy:AddNewModifier( self:GetCaster(), self, "basic_stun_modifier", { duration = stun_duration } )
	end

	-- Play effects
	self:PlayEffects()
end

function centaur_stomp:PlayEffects()
	-- get particles
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
	local sound_cast = "Hero_Centaur.HoofStomp"

	-- get data
	local radius = self:GetSpecialValueFor("radius")


	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_L",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_R",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
end