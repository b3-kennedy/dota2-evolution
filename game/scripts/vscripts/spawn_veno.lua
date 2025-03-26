spawn_veno = class({})



require('libraries/timers')
require('queue')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_veno:OnSpellStart()

    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")

    local testunit = CreateUnitByName("npc_dota_custom_venomancer", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())

end

function spawn_veno:GetAbilityTag()
    return "spawner"
end

function spawn_veno:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.queue = self:GetCaster():FindModifierByName("create_unit_modifier").queue
    self.spawn_time = 1
    self.team = self:GetCaster():GetTeamNumber()
    
    self.unit_data = 
    {
        name = "", 
        spawn_time = 4, 
        ability = "spawn_veno",
        gold_cost = self:GetManaCost(self:GetLevel()),

    }
end

function spawn_veno:SpawnLevelOne()
    self:SetUpUnitData()
    self.unit_data.ability1 = "summon_ward"
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_custom_venomancer"
    else
        self.unit_data.name = "npc_dota_custom_venomancer" 
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
        
end