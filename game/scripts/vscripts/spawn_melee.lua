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

    self.unit_data = 
    {
        name = "npc_dota_creep_goodguys_melee", 
        spawn_time = 1, 
        ability = "spawn_melee",
        gold_bounty = 50,
        gold_cost = 25,

    }

    if self:GetCaster():GetTeamNumber() == DOTA_TEAM_GOODGUYS then

        print(GameRules:GetGameTime() + 1)

        local kv = {unit = "npc_dota_creep_goodguys_melee", pos = self.spawn_pos}

        self.hide_unit_modifier:CreateUnit(self.unit_data)

        local testunit = CreateUnitByName("npc_dota_creep_badguys_melee", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)

    end

end

function spawn_melee:MoveUnitToPosition(unit, position)
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end