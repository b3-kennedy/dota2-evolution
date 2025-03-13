create_unit_modifier = class({})

require('queue')
require('libraries/timers')
require('libraries/notifications')

function create_unit_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function create_unit_modifier:GetEffectName()
    return nil
end

function create_unit_modifier:CreateUnit(data)

    if PlayerResource:GetGold(self:GetParent():GetPlayerOwnerID()) >= data.gold_cost then
        if self.queue:size() == 0 then
            self.last_spawn_time = GameRules:GetGameTime()
        end
        --local modifier = self:GetParent():AddNewModifier(self:GetParent(), nil, name, kv)
        self.queue:enqueue(data)  
        self.data = data
        
        PlayerResource:SpendGold(self:GetParent():GetPlayerOwnerID(),self.data.gold_cost,DOTA_ModifyGold_AbilityCost)
        --play buy sound
        EmitSoundOnClient("Hero_Furion.ForceOfNature", PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()))
    else
        -- Notifications:Bottom(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), {
        --     text = "Not Enough Gold", 
        --     duration = 1, 
        --     style = {
        --         color = "white",  -- Set text color to white for contrast
        --         ["font-size"] = "15px", 
        --         ["background-color"] = "rgba(255, 0, 0, 0.7)",  -- Red background with 70% opacity (translucent)
        --         padding_left = "20px",  -- Add padding to the left
        --         padding_right = "20px",  -- Add padding to the right
        --     }
        -- })

        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
    
    -- if self.queue.size() > 0 then
        
    -- end
    
end

function create_unit_modifier:CastWithSelection(caster, ability_name)
    local count = PlayerResource:GetSelectedEntityCount(caster:GetPlayerOwnerID())
    local selection = PlayerResource:GetSelectedEntities(caster:GetPlayerOwnerID())
    local valid_unit_count = 0
    for i=0, count-1 do
        local unit = EntIndexToHScript(selection[tostring(i)])
        local ent_index = selection[tostring(i)]
        local ability = unit:FindAbilityByName(ability_name)
        if ability then
            if ability:GetLevel() == 1 then
                ability:SpawnLevelOne()
            elseif ability:GetLevel() == 2 then
                ability:SpawnLevelTwo()
            end
        end
    end
end

function create_unit_modifier:Spawn(data)
    local ability = self:GetParent():FindAbilityByName(data.ability)
    local spawn_pos = ability.spawn_pos

    local unit = CreateUnitByName(data.name, spawn_pos, true, self.player, self.player, self.player:GetTeamNumber())

    if data.is_controllable then
        unit:SetOwner(self.player)
        unit:SetControllableByPlayer(self.player:GetPlayerOwnerID(), true)
    end

    Timers:CreateTimer(0.1, function()
        self:MoveUnitToPosition(unit, ability.enemy_spawn)
    end)
    self.last_spawn_time = GameRules:GetGameTime()

    if data.ability1 ~= nil then
        unit:FindAbilityByName(data.ability1):SetLevel(4)
    end

    self.queue:dequeue()
end

function create_unit_modifier:OnCreated( kv )

    if not IsServer() then return end

    self.queue = Queue:new()



    self.last_spawn_time = GameRules:GetGameTime()
    local player_index = kv.player
    self.player = EntIndexToHScript(player_index)

    print(self.player)


    local spawn = Vector(kv.spawn_x, kv.spawn_y, kv.spawn_z)

    if(self:GetParent():GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
        --radiant spawn pos
         self.spawn_pos = spawn
         self.enemy_spawn = Vector(195.836, 2322.42, 128)
    elseif self:GetParent():GetTeamNumber() == DOTA_TEAM_BADGUYS then
        --dire spawn pos
         self.spawn_pos = spawn
         self.enemy_spawn = Vector(0, -2322.42, 128)
    end

    self:StartIntervalThink(0.1)
end
--------------------------------------------------------------------------------

function create_unit_modifier:ManageQueue()
    if not self.queue:isEmpty() then
        if GameRules:GetGameTime() >= self.last_spawn_time + self.queue:peek().spawn_time then
            self:Spawn(self.queue:peek())


        end
    end
end

function create_unit_modifier:MoveUnitToPosition(unit, position)
    ExecuteOrderFromTable({
        UnitIndex = unit:entindex(),    -- The unit that should move
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, -- The order type (move to position)
        Position = position,            -- The target position (Vector)
        Queue = false,                  -- Whether to queue this order after current orders
    })
end

function create_unit_modifier:EnoughGoldForAbilityCheck()

    if not IsServer() then return end


    for i=0, self:GetParent():GetAbilityCount()-1 do
        local ability = self:GetParent():GetAbilityByIndex(i)
        local gold = PlayerResource:GetGold(self:GetParent():GetPlayerOwnerID())
        if ability then
            if gold < ability:GetManaCost(ability:GetLevel()) then
                ability:SetActivated(false)
            else
                ability:SetActivated(true)
            end

        end
    end
end

function create_unit_modifier:OnIntervalThink()

    self:ManageQueue()
    --self:EnoughGoldForAbilityCheck()


end