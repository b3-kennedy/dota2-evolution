spawn_special = class({})


require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_special:OnSpellStart()
    self.hide_unit_modifier = self:GetCaster():FindModifierByName("hide_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("hide_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("hide_unit_modifier").enemy_spawn
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "npc_dota_creep_goodguys_flagbearer", 
        spawn_time = 2, 
        ability = "spawn_special",
        gold_cost = 50,
        ability1 = "special_creep_aura"
    }

    local testunit = CreateUnitByName("npc_dota_creep_badguys_flagbearer", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)

    Timers:CreateTimer(0.1, function()
        self:MoveUnitToPosition(testunit, self.spawn_pos)
    end)
    

    if self:GetLevel() == 1 then
        self:SpawnLevelOne()
    elseif self:GetLevel() == 2 then
        self:SpawnLevelOne()
    end


end

function spawn_special:SpawnLevelOne()
    if(self.team == DOTA_TEAM_GOODGUYS) then
        self.unit_data.name = "npc_dota_creep_goodguys_flagbearer"
    else
        self.unit_data.name = "npc_dota_creep_badguys_flagbearer"
    end

    self.hide_unit_modifier:CreateUnit(self.unit_data)
end

function spawn_special:MoveUnitToPosition(unit, position)
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end