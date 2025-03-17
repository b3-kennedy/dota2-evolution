special_creep_aura_effect_modifier = class({})

function special_creep_aura_effect_modifier:OnCreated( kv )
    if not IsServer() then return end



    
end

function special_creep_aura_effect_modifier:OnRefresh( kv )
	if not IsServer() then return end
end



function special_creep_aura_effect_modifier:DeclareFunctions()
    local ability = self:GetAbility()

    if ability:GetLevel() == 1 then
        local funcs = {
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        }
        return funcs
    elseif ability:GetLevel() == 2 then
        local funcs = {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        }
        return funcs
    elseif ability:GetLevel() == 3 then
        local funcs = {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        }
        return funcs
    elseif ability:GetLevel() == 4 then
        local funcs = {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        }
        return funcs
    end



	return funcs
end

function special_creep_aura_effect_modifier:GetModifierAttackSpeedBonus_Constant()
    return 25
end

function special_creep_aura_effect_modifier:GetModifierMoveSpeedBonus_Percentage()
	return 10
end

function special_creep_aura_effect_modifier:GetModifierPhysicalArmorBonus()
    return 2
end

function special_creep_aura_effect_modifier:GetModifierBaseAttack_BonusDamage()
    return 50
end