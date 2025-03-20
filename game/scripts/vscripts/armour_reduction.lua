armour_reduction = class({})

LinkLuaModifier("armour_reduction_modifier", LUA_MODIFIER_MOTION_NONE)

function armour_reduction:GetIntrinsicModifierName()
    return "armour_reduction_modifier"
end