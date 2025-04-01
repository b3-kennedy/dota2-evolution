plague_ward_modifier = class({})

require('positions')

function plague_ward_modifier:OnCreated(kv)

    if not IsServer() then return end

    self:StartIntervalThink(1)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.target = nil
    self.team_number = self.parent:GetTeamNumber()
    self.attack_moved = false

    self.summoned_wards = {}

    if self.team_number == DOTA_TEAM_GOODGUYS then
        self.enemy_spawn = PLAYER_SPAWN_DIRE
    else
        self.enemy_spawn = PLAYER_SPAWN_RADIANT
    end
end

function plague_ward_modifier:DeclareFunctions()
    return {MODIFIER_EVENT_ON_DEATH}
end

function plague_ward_modifier:OnDeath(params)
    if params.unit == self:GetParent() then  -- Check if the dying unit is the one with this modifier
        local killer = params.attacker  -- The unit that killed the target
        if killer then
            for _, ward in pairs(self.summoned_wards) do
                if ward then
                    print(ward:GetUnitName())
                    ward:Kill(nil, killer)
                end
            end
        end
    end
end


function plague_ward_modifier:OnIntervalThink()


    -- First check if ability is ready before searching for targets
    if not self:GetAbility() or not self:GetAbility():IsCooldownReady() then
        -- If ability is on cooldown and we have no target, attack move to spawn
        if not self.attack_moved and (not self.target or not self.target:IsAlive()) then
            self.target = nil
            
            -- Attack move to enemy spawn
            if self.enemy_spawn then
                ExecuteOrderFromTable({
                    UnitIndex = self.parent:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                    Position = self.enemy_spawn,
                    Queue = false,
                })
                self.attack_moved = true
            end
        end
        return
    end


    local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),  -- Team of the caster
        self:GetParent():GetAbsOrigin(),  -- Position to center the AoE
        nil,  -- No specific unit to ignore
        500,  -- Radius of the AoE
        DOTA_UNIT_TARGET_TEAM_ENEMY,  -- Targeting enemy units
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,  -- Target all unit types
        DOTA_UNIT_TARGET_FLAG_NONE,  -- No specific flags
        FIND_ANY_ORDER,  -- Find in any order
        false  -- Ignore obstacles
    )

    if self.ability:IsCooldownReady() then

        local distance = 99999

        if #enemies > 0 then
            for _, enemy in pairs(enemies) do
                local new_dist = (self.parent:GetAbsOrigin() - enemy:GetAbsOrigin()):Length2D()
                if new_dist < distance then
                    distance = new_dist
                    self.target = enemy
                end
            end

            print("cast")

            if self.target then
                self.parent:CastAbilityNoTarget(self.ability, self.parent:GetPlayerOwnerID())
                self.attack_moved = false
            end
        end
    end
end