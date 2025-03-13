special_ability = class({})


LinkLuaModifier("special_ability_modifier_thinker", LUA_MODIFIER_MOTION_NONE)

function special_ability:GetAbilityTag()
    return "special"
end

function special_ability:OnSpellStart()


    if self:GetCaster():GetTeamNumber() == DOTA_TEAM_GOODGUYS then
        self.start = Vector(0,-2300,150)
    else
        self.start = Vector(0,2300,150)
    end

    CreateModifierThinker(
        self:GetCaster(),
        self,
        "special_ability_modifier_thinker",
        {duration = 7},
        self.start,
        self:GetCaster():GetTeamNumber(),
        false
    )
end