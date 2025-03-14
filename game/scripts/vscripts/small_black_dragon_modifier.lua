small_black_dragon_modifier = class({})

require('positions')

function small_black_dragon_modifier:OnCreated(kv)

    if not IsServer() then return end
    self.ability = self:GetParent():FindAbilityByName("fireball")
    self:StartIntervalThink(0.2)
    self.move = false
end

function small_black_dragon_modifier:OnIntervalThink()
    local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),  -- Team of the caster
        self:GetParent():GetAbsOrigin(),  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        450,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_ENEMY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    local dist = 9999
    local closest_enemy = nil

    for _, enemy in pairs(enemies) do
        local new_dist = (self:GetParent():GetAbsOrigin() - enemy:GetAbsOrigin()):Length2D()
        if new_dist < dist then
            dist = new_dist
            closest_enemy = enemy
        end
    end

    if #enemies == 0 then
        self.move = true
    end

    if closest_enemy ~= nil and self.ability:IsCooldownReady() and not self.move then
        print(self.ability)
        self.ability:SetTargetPosition(closest_enemy:GetAbsOrigin())
        self:GetParent():CastAbilityOnTarget(closest_enemy, self.ability, self:GetParent():GetPlayerOwnerID())
        self.move = true
    elseif closest_enemy ~= nil then
        ExecuteOrderFromTable({
            UnitIndex = self:GetParent():entindex(),  -- The unit that should attack
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET, -- Attack target order
            TargetIndex = closest_enemy:entindex(),          -- The entity to attack
            Queue = false,                             -- Whether to queue this order after current orders
        })
    elseif #enemies == 0 and self.move then

        if(self:GetParent():GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
            pos = PLAYER_SPAWN_DIRE
        else
            pos = PLAYER_SPAWN_RADIANT
        end

        ExecuteOrderFromTable({
            UnitIndex = self:GetParent():entindex(),    -- The unit that should move
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, -- The order type (move to position)
            Position = pos,            -- The target position (Vector)
            Queue = false,                  -- Whether to queue this order after current orders
        })

        self.move = false
    end

end