spawn_melee = class({})


require('libraries/timers')
require('queue')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_melee:OnSpellStart()
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    local testunit = CreateUnitByName("npc_dota_creep_bad_melee", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)


    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetName())

end

function spawn_melee:SetUpUnitData()
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
        ability = "spawn_melee",
        gold_cost = self:GetManaCost(self:GetLevel()-1),
    }
end

function spawn_melee:SpawnLevelOne()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_good_melee"
    else
        self.unit_data.name = "npc_dota_creep_bad_melee" 
    end
    self.create_unit_modifier:CreateUnit(self.unit_data)
        
end

function spawn_melee:SpawnLevelTwo()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_good_melee_mega"
    else
        self.unit_data.name = "npc_dota_creep_bad_melee_mega" 
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

