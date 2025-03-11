spawn_heal = class({})


require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_heal:OnSpellStart()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "npc_dota_heal_unit", 
        spawn_time = 3, 
        ability = "spawn_heal",
        gold_cost = self:GetManaCost(self:GetLevel()),
    }



    local testunit = CreateUnitByName("npc_dota_heal_unit", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    Timers:CreateTimer(0.1, function()
        self:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    if self:GetLevel() == 1 then
        self:SpawnLevelOne()
    elseif self:GetLevel() == 2 then
        self:SpawnLevelOne()
    end

end

function spawn_heal:SpawnLevelOne()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_heal_unit"
    else
        self.unit_data.name = "npc_dota_heal_unit"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
end

function spawn_heal:MoveUnitToPosition(unit, position)
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end