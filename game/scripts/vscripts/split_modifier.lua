split_modifier = class({})

require("libraries/timers")
require("positions")

function split_modifier:OnCreated(kv)

end

function split_modifier:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH
    }
    return funcs
end

function split_modifier:OnDeath(params)
    if not IsServer() then return end

    local move_pos = nil
    local player = self:GetParent():GetPlayerOwner()

    if self:GetParent():GetTeamNumber() == DOTA_TEAM_GOODGUYS then
        move_pos = PLAYER_SPAWN_DIRE
    else
        move_pos = PLAYER_SPAWN_RADIANT
    end

    if params.unit == self:GetParent() then
        print("split")
        for i=0, 1 do
            local unit = CreateUnitByName(
                "npc_dota_creep_mud_golem", 
                self:GetParent():GetAbsOrigin(),
                true,
                player,
                player,
                self:GetParent():GetTeamNumber()
            )
            unit:SetOwner(self:GetParent():GetOwnerEntity())
            unit:SetModelScale(unit:GetModelScale()/2)
            local min_damage = unit:GetBaseDamageMin()
            local max_damage = unit:GetBaseDamageMax()
            unit:SetBaseDamageMin(min_damage/2)
            unit:SetBaseDamageMax(max_damage/2)
            print(min_damage)
            Timers:CreateTimer(0.1, function()
                self:MoveUnitToPosition(unit, move_pos)
            end)
        end
    end
end

function split_modifier:MoveUnitToPosition(unit, position)
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