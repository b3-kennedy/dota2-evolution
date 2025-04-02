sunstrike = class({})

LinkLuaModifier("sunstrike_modifier_thinker", LUA_MODIFIER_MOTION_NONE)

function sunstrike:GetAOERadius()
    return 175
end

function sunstrike:OnSpellStart()
    local mouse_pos = self:GetCursorPosition()
    local caster = self:GetCaster()

    local delay = 1.7
    local vision_distance = 400
    local vision_duration = 4

    CreateModifierThinker(
        caster,
        self,
        "sunstrike_modifier_thinker",
        {duration = delay},
        mouse_pos,
        caster:GetTeamNumber(),
        false
    )

    AddFOWViewer( caster:GetTeamNumber(), mouse_pos, vision_distance, vision_duration, false )

end