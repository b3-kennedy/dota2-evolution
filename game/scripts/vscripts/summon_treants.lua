summon_treants = class({})

require('positions')

LinkLuaModifier("summon_treants_modifier", LUA_MODIFIER_MOTION_NONE)

function summon_treants:GetIntrinsicModifierName()
    return "summon_treants_modifier"
end

function summon_treants:OnSpellStart()
    local caster = self:GetCaster()
    local summon_pos = caster:GetAbsOrigin()
    local player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

    for i=0, 1 do
        local treant = CreateUnitByName(
            "npc_dota_custom_treant", 
            summon_pos, 
            true, 
            player, 
            player, 
            caster:GetTeamNumber()
        )

        treant:FindAbilityByName("siege"):SetLevel(4)

        if caster:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
            Timers:CreateTimer(0.1, function()
                self:MoveUnitToPosition(treant, PLAYER_SPAWN_DIRE)
            end)
        else
            Timers:CreateTimer(0.1, function()
                self:MoveUnitToPosition(treant, PLAYER_SPAWN_RADIANT)
            end)
        end
    end

end


function summon_treants:MoveUnitToPosition(unit, position)
    local order = DOTA_UNIT_ORDER_ATTACK_MOVE
    if unit:GetName() ~= "npc_dota_heal_unit" then
        order = DOTA_UNIT_ORDER_ATTACK_MOVE
    else
        order = DOTA_UNIT_ORDER_MOVE_TO_POSITION
    end

    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = order, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end