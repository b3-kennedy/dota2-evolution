split = class({})

LinkLuaModifier("split_modifier", LUA_MODIFIER_MOTION_NONE)

function split:GetIntrinsicModifierName()
    return "split_modifier"
end

function split:OnSpellStart()
end