spawn_lion = class({})

require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_lion:OnSpellStart()
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn



    local testunit = CreateUnitByName("npc_dota_custom_lion", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier") 
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())

end

function spawn_lion:GetAbilityTag()
    return "spawner"
end

function spawn_lion:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.queue = self:GetCaster():FindModifierByName("create_unit_modifier").queue
    self.spawn_time = 1
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "", 
        spawn_time = 3, 
        ability = self:GetName(),
        gold_cost = self:GetManaCost(self:GetLevel()-1),
    }
end

function spawn_lion:SpawnLevelOne()
    self:SetUpUnitData()
    self.unit_data.ability1 = "lion_finger"
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_custom_lion"
    else
        self.unit_data.name = "npc_dota_custom_lion"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end