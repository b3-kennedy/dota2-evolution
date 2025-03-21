far_blink = class({})

LinkLuaModifier("far_blink_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("invisibility_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("basic_root_modifier", LUA_MODIFIER_MOTION_NONE)




function far_blink:GetIntrinsicModifierName()
    return "far_blink_modifier"
end

function far_blink:OnSpellStart()
    local caster = self:GetCaster()
    local modifier = caster:FindModifierByName("far_blink_modifier")
    local target = modifier.target

    caster:FindAbilityByName("phantom_assassin_coup_de_grace"):SetLevel(3)

    if target ~= nil then
        caster:AddNewModifier(caster,self,"invisibility_modifier", {duration = 3})
        local direction = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
        local position = modifier.target:GetAbsOrigin() - (direction * 100)
        FindClearSpaceForUnit(caster, position, true)
        target:AddNewModifier(target, self, "basic_root_modifier", {duration = 3})
        ExecuteOrderFromTable({
            UnitIndex = caster:entindex(),  -- The unit that should attack
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,  -- For attacking a specific target
            TargetIndex = target:entindex(),  -- The target unit's index (required for attack target)
            Queue = false  -- Whether to queue this order after current orders
        })
        
    end
end