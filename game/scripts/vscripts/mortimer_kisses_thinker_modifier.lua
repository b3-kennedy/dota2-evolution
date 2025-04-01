-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
mortimer_kisses_thinker_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications

--------------------------------------------------------------------------------
-- Initializations
function mortimer_kisses_thinker_modifier:OnCreated( kv )
	-- references
	self.max_travel = 2
	self.radius = 500
	self.linger = 1

	if not IsServer() then return end

	-- dont start aura right off
	self.start = false

	-- create aoe finder particle
	self:PlayEffects( kv.travel_time )
end

function mortimer_kisses_thinker_modifier:OnRefresh( kv )
	-- references
	self.max_travel = 2
	self.radius = 500
	self.linger = 1

	if not IsServer() then return end

	-- start aura
	self.start = true

	-- stop aoe finder particle
	self:StopEffects()
end

function mortimer_kisses_thinker_modifier:OnRemoved()
end

function mortimer_kisses_thinker_modifier:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Aura Effects
function mortimer_kisses_thinker_modifier:IsAura()
	return self.start
end

function mortimer_kisses_thinker_modifier:GetModifierAura()
	return "modifier_snapfire_mortimer_kisses_lua_debuff"
end

function mortimer_kisses_thinker_modifier:GetAuraRadius()
	return self.radius
end

function mortimer_kisses_thinker_modifier:GetAuraDuration()
	return self.linger
end

function mortimer_kisses_thinker_modifier:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function mortimer_kisses_thinker_modifier:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function mortimer_kisses_thinker_modifier:PlayEffects( time )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius*(self.max_travel/time) ) )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( time, 0, 0 ) )
end

function mortimer_kisses_thinker_modifier:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end