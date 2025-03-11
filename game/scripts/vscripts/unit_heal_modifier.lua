unit_heal_modifier = class({})

require('positions')

function unit_heal_modifier:OnCreated(kv)
    if not IsServer() then return end
    self.team_number = self:GetParent():GetTeamNumber()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
    self.lowest_health_ally = nil
end



function unit_heal_modifier:OnIntervalThink()
    local allies = FindUnitsInRadius(
        self.team_number,  -- Team of the caster
        self:GetParent():GetAbsOrigin(),  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        500,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    self.filtered_allies = {}
    for _, ally in pairs(allies) do
        if ally ~= self:GetParent() and (ally:GetHealth() < ally:GetMaxHealth()) then
            table.insert(self.filtered_allies, ally)
        end
    end

    local lowest_health = 999999

    for _, ally in pairs(self.filtered_allies) do
        local health = ally:GetHealth()
        if health < lowest_health then
            self.lowest_health_ally = ally
        end
    end

    if #self.filtered_allies > 0 then
        ExecuteOrderFromTable({
            UnitIndex = self:GetParent():entindex(),  -- The unit that will execute the stop
            OrderType = DOTA_UNIT_ORDER_STOP,  -- The stop order
            Queue = false  -- Whether to queue this action (false means execute immediately)
        })
    else
        ExecuteOrderFromTable({
            UnitIndex = self:GetParent():entindex(),    -- The unit that should move
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION, -- The order type (move to position)
            Position = PLAYER_SPAWN_DIRE,            -- The target position (Vector)
            Queue = false,                  -- Whether to queue this order after current orders
        })
    end

    if self.lowest_health_ally and self.ability:IsCooldownReady() then
        self:GetParent():CastAbilityOnTarget(self.lowest_health_ally, self.ability, self:GetParent():GetPlayerOwnerID())
    else

    end
end