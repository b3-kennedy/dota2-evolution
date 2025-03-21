magic_resist = class({})

LinkLuaModifier("magic_resist_modifier", LUA_MODIFIER_MOTION_NONE)

function magic_resist:GetIntrinsicModifierName()
    return "magic_resist_modifier"
end