special_ability = class({})

require('positions')
LinkLuaModifier("special_ability_modifier_thinker", LUA_MODIFIER_MOTION_NONE)

function special_ability:GetAbilityTag()
    return "special"
end

function special_ability:OnSpellStart()


    if self:GetCaster():GetTeamNumber() == DOTA_TEAM_GOODGUYS then
        self.start = PLAYER_SPAWN_RADIANT
    else
        self.start = PLAYER_SPAWN_DIRE
    end

    CreateModifierThinker(
        self:GetCaster(),
        self,
        "special_ability_modifier_thinker",
        {duration = 8},
        self.start,
        self:GetCaster():GetTeamNumber(),
        false
    )
end