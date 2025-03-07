basic_root_modifier = class({})

function basic_root_modifier:IsHidden()
    return false -- Shows the modifier icon
end

function basic_root_modifier:IsDebuff()
    return false -- Treated as a negative effect
end

function basic_root_modifier:IsPurgable()
    return false -- Can be removed by dispels
end

function basic_root_modifier:DeclareFunctions()
    return { MODIFIER_PROPERTY_DISABLE_TURNING }
end

function basic_root_modifier:GetModifierDisableTurning()
    return 1
end

function basic_root_modifier:CheckState()
    local state = {
        [MODIFIER_STATE_ROOTED] = true, -- Prevents movement
    }
    return state
end