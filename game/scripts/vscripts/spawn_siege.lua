spawn_siege = class({})


require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_siege:OnSpellStart()


    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    
    local testunit = CreateUnitByName("npc_dota_creep_badguys_siege", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)


    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetName())

end

function spawn_siege:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "npc_dota_creep_goodguys_siege", 
        spawn_time = 2, 
        ability = "spawn_siege",
        gold_cost = self:GetManaCost(self:GetLevel()),
    }
end

function spawn_siege:SpawnLevelOne()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_siege"
    else
        self.unit_data.name = "npc_dota_creep_badguys_siege"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end