juggernaut_modifier = class({})

local STATE_IDLE = 0
local STATE_MOVING = 1
local STATE_ATTACKING = 2


function juggernaut_modifier:OnCreated(kv)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.parent:Stop()
    self.state = STATE_IDLE
    self.state_actions = {
        [STATE_IDLE] = self.IdleThink,
        [STATE_MOVING] = self.MovingThink,
        [STATE_ATTACKING] = self.AttackingThink,
    }
    
    self:StartIntervalThink(1)
end

--run_reverse_walk

function juggernaut_modifier:OnIntervalThink()


    self.state_actions[self.state](self)    
end

function juggernaut_modifier:IdleThink()
    print("Idle")
    self.parent:RemoveGesture(ACT_DOTA_SPAWN)
    self.parent:RemoveGesture(ACT_DOTA_RUN)
    self.parent:RemoveGesture(ACT_DOTA_ATTACK)
    self.parent:StartGesture(ACT_DOTA_IDLE)
    if self.parent:IsMoving() then
        self.state = STATE_MOVING
    end
end

function juggernaut_modifier:MovingThink()
    print("Moving: " .. tostring(self.parent:GetSequence()))
    self.parent:RemoveGesture(ACT_DOTA_SPAWN)
    self.parent:RemoveGesture(ACT_DOTA_IDLE)
    self.parent:RemoveGesture(ACT_DOTA_ATTACK)
    self.parent:StartGesture(ACT_DOTA_RUN)
    if not self.parent:IsMoving() then
        self.state = STATE_ATTACKING
    end
end

function juggernaut_modifier:AttackingThink()
    print("Attacking")
    self.parent:RemoveGesture(ACT_DOTA_RUN)
    self.parent:RemoveGesture(ACT_DOTA_IDLE)
    --self.parent:StartGesture(ACT_DOTA_ATTACK)
end

-- modifier_ai = class({})

-- local AI_STATE_IDLE = 0
-- local AI_STATE_AGGRESSIVE = 1
-- local AI_STATE_RETURNING = 2

-- local AI_THINK_INTERVAL = 0.5

-- function modifier_ai:OnCreated(params)
--     -- Only do AI on server
--     if IsServer() then
--         -- Set initial state
--         self.state = AI_STATE_IDLE

--         -- Store parameters from AI creation:
--         -- unit:AddNewModifier(caster, ability, "modifier_ai", { aggroRange = X, leashRange = Y })
--         self.aggroRange = params.aggroRange
--         self.leashRange = params.leashRange

--         -- Store unit handle so we don't have to call self:GetParent() every time
--         self.unit = self:GetParent()

--         -- Set state -> action mapping
--         self.stateActions = {
--             [AI_STATE_IDLE] = self.IdleThink,
--             [AI_STATE_AGGRESSIVE] = self.AggressiveThink,
--             [AI_STATE_RETURNING] = self.ReturningThink,
--         }

--         -- Start thinking
--         self:StartIntervalThink(AI_THINK_INTERVAL)
--     end
-- end

-- function modifier_ai:OnIntervalThink()
--     -- Execute action corresponding to the current state
--     self.stateActions[self.state](self)    
-- end

-- function modifier_ai:IdleThink()
--     -- Find any enemy units around the AI unit inside the aggroRange
--     local units = FindUnitsInRadius(self.unit:GetTeam(), self.unit:GetAbsOrigin(), nil,
--         self.aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
--         FIND_ANY_ORDER, false)

--     -- If one or more units were found, start attacking the first one
--     if #units > 0 then
--         self.spawnPos = self.unit:GetAbsOrigin() -- Remember position to return to
--         self.aggroTarget = units[1] -- Remember who to attack
--         self.unit:MoveToTargetToAttack(self.aggroTarget) --Start attacking
--         self.state = AI_STATE_AGGRESSIVE --State transition
--         return -- Stop processing this state
--     end

--     -- Nothing else to do in Idle state
-- end

-- function modifier_ai:AggressiveThink()
--     -- Check if the unit has walked outside its leash range
--     if (self.spawnPos - self.unit:GetAbsOrigin()):Length() > self.leashRange then
--         self.unit:MoveToPosition(self.spawnPos) --Move back to the spawnpoint
--         self.state = AI_STATE_RETURNING --Transition the state to the 'Returning' state(!)
--         return -- Stop processing this state
--     end
    
--     -- Check if the target has died
--     if not self.aggroTarget:IsAlive() then
--         self.unit:MoveToPosition(self.spawnPos) --Move back to the spawnpoint
--         self.state = AI_STATE_RETURNING --Transition the state to the 'Returning' state(!)
--         return -- Stop processing this state
--     end
    
--     -- Still in the aggressive state, so do some aggressive stuff.
--     self.unit:MoveToTargetToAttack(self.aggroTarget)
-- end

-- function modifier_ai:ReturningThink()
--     -- Check if the AI unit has reached its spawn location yet
--     if (self.spawnPos - self.unit:GetAbsOrigin()):Length() < 10 then
--         self.state = AI_STATE_IDLE -- Transition the state to the 'Idle' state(!)
--         return -- Stop processing this state
--     end

--     -- If not at return position yet, try to move there again
--     self.unit:MoveToPosition(self.spawnPos)
-- end