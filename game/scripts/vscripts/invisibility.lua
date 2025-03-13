invisibility = class({})

LinkLuaModifier("invisibility_modifier", LUA_MODIFIER_MOTION_NONE)

function invisibility:GetIntrinsicModifierName()
    return "invisibility_modifier"
end

function invisibility:GetAbilityTag()
    return "hawk_invis"
end