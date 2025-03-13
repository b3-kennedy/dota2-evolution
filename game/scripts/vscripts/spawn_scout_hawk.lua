spawn_scout_hawk = class({})

require('libraries/timers')
require('queue')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_scout_hawk:OnSpellStart()

    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())

end

function spawn_scout_hawk:GetAbilityTag()
    return "spawner"
end

function spawn_scout_hawk:SetUpUnitData()
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
        ability = "spawn_scout_hawk",
        gold_cost = self:GetManaCost(self:GetLevel()-1),
        is_controllable = true

    }
end

function spawn_scout_hawk:SpawnLevelOne()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_scout_hawk"
    else
        self.unit_data.name = "npc_dota_scout_hawk" 
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
        
end
