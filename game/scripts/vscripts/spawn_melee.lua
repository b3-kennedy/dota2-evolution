spawn_melee = class({})


require('libraries/timers')
require('queue')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_melee:OnSpellStart()

    
    self.hide_unit_modifier = self:GetCaster():FindModifierByName("hide_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("hide_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("hide_unit_modifier").enemy_spawn
    self.queue = self:GetCaster():FindModifierByName("hide_unit_modifier").queue
    self.spawn_time = 1
    self.team = self:GetCaster():GetTeamNumber()

    
    
    self.unit_data = 
    {
        name = "", 
        spawn_time = 1, 
        ability = "spawn_melee",
        gold_cost = 25,

    }

    local testunit = CreateUnitByName("npc_dota_creep_bad_melee", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    Timers:CreateTimer(0.1, function()
        self:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    if self:GetLevel() == 1 then
        self:SpawnLevelOne()
    elseif self:GetLevel() == 2 then
        self:SpawnLevelOne()
    end

end

function spawn_melee:SpawnLevelOne()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_good_melee"
    else
        self.unit_data.name = "npc_dota_creep_bad_melee" 
    end

    self.hide_unit_modifier:CreateUnit(self.unit_data)
        
end

function spawn_melee:MoveUnitToPosition(unit, position)
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end