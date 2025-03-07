special_creep_aura_effect_modifier = class({})

function special_creep_aura_effect_modifier:OnCreated( kv )
    if not IsServer() then return end
    self.move_speed_buff = 25
end

function special_creep_aura_effect_modifier:OnRefresh( kv )
	if not IsServer() then return end
    self.move_speed_buff = 25

    self.attack_speed = self:GetParent():GetMaximumAttackSpeed()

    self.atk_speed_percent_value = self.attack_speed * 0.25
end

function special_creep_aura_effect_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function special_creep_aura_effect_modifier:GetModifierAttackSpeedBonus_Constant()
    return 25
end

function special_creep_aura_effect_modifier:GetModifierMoveSpeedBonus_Percentage()
	return 25
end