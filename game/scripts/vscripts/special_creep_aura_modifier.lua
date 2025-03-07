special_creep_aura_modifier = class({})

LinkLuaModifier("special_creep_aura_effect_modifier", LUA_MODIFIER_MOTION_NONE)

function special_creep_aura_modifier:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function special_creep_aura_modifier:IsAura()
	return true
end

function special_creep_aura_modifier:GetModifierAura()
	return "special_creep_aura_effect_modifier"
end


--------------------------------------------------------------------------------

function special_creep_aura_modifier:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function special_creep_aura_modifier:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

function special_creep_aura_modifier:GetAuraRadius()
	return self.aura_radius
end

--------------------------------------------------------------------------------

function special_creep_aura_modifier:OnCreated( kv )
	self.aura_radius = 800
	-- if IsServer() and self:GetParent() ~= self:GetCaster() then
	-- 	self:StartIntervalThink( 0.5 )
	-- end
end