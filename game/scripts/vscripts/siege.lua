siege = class({})

LinkLuaModifier("siege_modifier", LUA_MODIFIER_MOTION_NONE)

function siege:GetIntrinsicModifierName()
    return "siege_modifier"
end