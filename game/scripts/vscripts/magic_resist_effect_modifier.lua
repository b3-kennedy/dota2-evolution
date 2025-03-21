magic_resist_effect_modifier = class({})


function magic_resist_effect_modifier:OnCreated(kv)

end

function magic_resist_effect_modifier:OnRefresh(kv)

end

function magic_resist_effect_modifier:DeclareFunctions()
    return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end

function magic_resist_effect_modifier:GetModifierMagicalResistanceBonus()
    return 25  -- Increases magic resistance by 25%
end

