hide_unit_modifier = class({})

require('queue')
require('libraries/timers')

function hide_unit_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function hide_unit_modifier:GetEffectName()
    return nil
end


function hide_unit_modifier:OnCreated( kv )
    self:GetParent():AddNoDraw()
end

function hide_unit_modifier:CheckState()
    return {
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true, -- Hides the health bar
        [MODIFIER_STATE_OUT_OF_GAME] = true, -- Fully removes unit from the game world
        [MODIFIER_STATE_UNSELECTABLE] = true, -- Cannot be selected
        [MODIFIER_STATE_NO_HEALTH_BAR] = true, -- Hides health bar
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true, -- Allows passing through units
        [MODIFIER_STATE_INVULNERABLE] = true, -- Prevents all damage
        [MODIFIER_STATE_ROOTED] = true,
    }
end


--------------------------------------------------------------------------------

function hide_unit_modifier:OnDestroy()
    self:GetParent():RemoveNoDraw()
end

--------------------------------------------------------------------------------