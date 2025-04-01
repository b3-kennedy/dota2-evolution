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
mortimer_kisses_debuff_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function mortimer_kisses_debuff_modifier:IsHidden()
	return false
end

function mortimer_kisses_debuff_modifier:IsDebuff()
	return true
end

function mortimer_kisses_debuff_modifier:IsStunDebuff()
	return false
end

function mortimer_kisses_debuff_modifier:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function mortimer_kisses_debuff_modifier:OnCreated( kv )
	-- references
	self.slow = -25
	self.dps = 25
	local interval = 1

	if not IsServer() then return end

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps*interval,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
end

function mortimer_kisses_debuff_modifier:OnRefresh( kv )
	
end

function mortimer_kisses_debuff_modifier:OnRemoved()
end

function mortimer_kisses_debuff_modifier:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function mortimer_kisses_debuff_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function mortimer_kisses_debuff_modifier:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function mortimer_kisses_debuff_modifier:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )

	-- play overhead
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function mortimer_kisses_debuff_modifier:GetEffectName()
	return "particles/units/heroes/hero_snapfire/hero_snapfire_burn_debuff.vpcf"
end

function mortimer_kisses_debuff_modifier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function mortimer_kisses_debuff_modifier:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_magma.vpcf"
end

function mortimer_kisses_debuff_modifier:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end