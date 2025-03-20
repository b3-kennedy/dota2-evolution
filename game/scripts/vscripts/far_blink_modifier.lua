far_blink_modifier = class({})


require('positions')

function far_blink_modifier:OnCreated(kv)
    if not IsServer() then return end
    self.target = nil
    self.parent = self:GetParent()
    self.team_number = self.parent:GetTeamNumber()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1.2)

    if self.team_number == DOTA_TEAM_GOODGUYS then
        self.enemy_spawn = PLAYER_SPAWN_DIRE
    else
        self.enemy_spawn = PLAYER_SPAWN_RADIANT
    end

end

function far_blink_modifier:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH         -- For any unit kills
    }
    return funcs
end

function far_blink_modifier:OnDeath(params)
    if not IsServer() then return end
    
    -- Check if the killer is the owner of this modifier
    local killer = params.attacker
    local victim = params.unit

    if victim == self.target and self.parent:FindModifierByName("invisibility_modifier") then
        self.parent:FindAbilityByName("far_blink"):EndCooldown()
    end

    if victim == self.target then
        self.target = nil
        self.parent:FindAbilityByName("phantom_assassin_coup_de_grace"):SetLevel(0)
        
    end 


end

function far_blink_modifier:OnIntervalThink()
    if not IsServer() then return end
    
    -- Check if parent is alive first
    if not self.parent or not self.parent:IsAlive() then
        return
    end
    
    -- First check if ability is ready before searching for targets
    if not self:GetAbility() or not self:GetAbility():IsCooldownReady() then
        -- If ability is on cooldown and we have no target, attack move to spawn
        if not self.target or not self.target:IsAlive() then
            self.target = nil
            
            -- Attack move to enemy spawn
            if self.enemy_spawn then
                ExecuteOrderFromTable({
                    UnitIndex = self.parent:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                    Position = self.enemy_spawn,
                    Queue = false,
                })
            end
        end
        return
    end
    
    -- Only search for targets if ability is ready
    local enemies = FindUnitsInRadius(
        self.team_number,
        self.parent:GetAbsOrigin(),
        nil,
        5000,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    local furthest_distance = 0
    local found_valid_target = false

    for _, enemy in pairs(enemies) do
        if enemy and enemy:IsAlive() then
            local distance = (enemy:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()
            if distance > furthest_distance then
                furthest_distance = distance
                self.target = enemy
                found_valid_target = true
            end
        end
    end
    
    -- Cast ability if we found a valid target
    if found_valid_target and self.target then
        self.parent:CastAbilityOnTarget(self.target, self.ability, self.parent:GetPlayerOwnerID())
    else
        -- No valid target found, attack move to enemy spawn
        self.target = nil
        
        if self.enemy_spawn then
            ExecuteOrderFromTable({
                UnitIndex = self.parent:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = self.enemy_spawn,
                Queue = false,
            })
        end
    end
end