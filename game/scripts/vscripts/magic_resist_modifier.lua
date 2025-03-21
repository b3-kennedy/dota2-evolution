magic_resist_modifier = class({})

LinkLuaModifier("magic_resist_effect_modifier", LUA_MODIFIER_MOTION_NONE)

function magic_resist_modifier:OnCreated(kv)

end

function magic_resist_modifier:IsAura()
    return true
end

function magic_resist_modifier:GetAuraRadius()
    return 500
end

function magic_resist_modifier:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function magic_resist_modifier:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function magic_resist_modifier:GetModifierAura()
    return "magic_resist_effect_modifier"
end