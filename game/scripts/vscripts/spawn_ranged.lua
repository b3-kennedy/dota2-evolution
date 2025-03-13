spawn_ranged = class({})


require('libraries/timers')
require('queue')

LinkLuaModifier("spawner_modifier_ranged", LUA_MODIFIER_MOTION_NONE)

function spawn_ranged:OnSpellStart()
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn

    local testunit = CreateUnitByName("npc_dota_creep_badguys_ranged", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())


end

function spawn_ranged:GetAbilityTag()
    return "spawner"
end

function spawn_ranged:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.queue = self:GetCaster():FindModifierByName("create_unit_modifier").queue
    self.spawn_time = 1
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "", 
        spawn_time = 1, 
        ability = self:GetName(),
        gold_cost = self:GetManaCost(self:GetLevel()-1),
    }
end

function spawn_ranged:SpawnLevelOne()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_ranged"
    else
        self.unit_data.name = "npc_dota_creep_badguys_ranged"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)

end

function spawn_ranged:SpawnLevelTwo()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_ranged_mega"
    else
        self.unit_data.name = "npc_dota_creep_badguys_ranged_mega"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end