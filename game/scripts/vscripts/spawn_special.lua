spawn_special = class({})


require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_special:OnSpellStart()

    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    local testunit = CreateUnitByName("npc_dota_creep_badguys_flagbearer", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)

    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")

    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    
    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())
end

function spawn_special:GetAbilityTag()
    return "spawner"
end

function spawn_special:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "npc_dota_creep_goodguys_flagbearer", 
        spawn_time = 2, 
        ability = "spawn_special",
        gold_cost = self:GetManaCost(self:GetLevel()),
        ability1 = "special_creep_aura"
    }
end

function spawn_special:SpawnLevelOne()
    self:SetUpUnitData()
    if(self.team == DOTA_TEAM_GOODGUYS) then
        self.unit_data.name = "npc_dota_creep_goodguys_flagbearer"
    else
        self.unit_data.name = "npc_dota_creep_badguys_flagbearer"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

function spawn_special:SpawnLevelTwo()
    self:SetUpUnitData()
    if(self.team == DOTA_TEAM_GOODGUYS) then
        self.unit_data.name = "npc_dota_creep_goodguys_flagbearer_mega"
    else
        self.unit_data.name = "npc_dota_creep_badguys_flagbearer_mega"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

function spawn_special:SpawnLevelThree()
    self:SetUpUnitData()
    if(self.team == DOTA_TEAM_GOODGUYS) then
        self.unit_data.name = "npc_dota_creep_ancient_golem"
    else
        self.unit_data.name = "npc_dota_creep_ancient_golem"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

function spawn_special:SpawnLevelFour()
    self:SetUpUnitData()
    if(self.team == DOTA_TEAM_GOODGUYS) then
        self.unit_data.name = "npc_dota_creep_ancient_golem"
    else
        self.unit_data.name = "npc_dota_creep_ancient_golem"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

