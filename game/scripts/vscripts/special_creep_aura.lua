special_creep_aura = class({})

LinkLuaModifier("special_creep_aura_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("special_creep_aura_effect_modifier", LUA_MODIFIER_MOTION_NONE)


function special_creep_aura:GetIntrinsicModifierName()
    return "special_creep_aura_modifier"
end