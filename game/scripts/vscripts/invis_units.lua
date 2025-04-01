invis_units = class({})

LinkLuaModifier("invisibility_modifier", LUA_MODIFIER_MOTION_NONE)


function invis_units:GetAOERadius()
	return 500
end

function invis_units:OnSpellStart()

    local cursor_pos = self:GetCursorPosition()

    local units = FindUnitsInRadius(
        self:GetCaster():GetTeamNumber(),  -- Team of the caster
        cursor_pos,  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        500,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    print(#units)

    if #units > 0 then
        for _, unit in pairs(units) do
            unit:AddNewModifier(self, self:GetCaster(), "invisibility_modifier", {duration = 5})
        end
    end
end