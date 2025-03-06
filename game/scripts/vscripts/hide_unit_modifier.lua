hide_unit_modifier = class({})

require('queue')
require('libraries/timers')

function hide_unit_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function hide_unit_modifier:GetEffectName()
    return nil
end

function hide_unit_modifier:CreateUnit(data)

    --local modifier = self:GetParent():AddNewModifier(self:GetParent(), nil, name, kv)
    self.queue:enqueue(data)  
    self.data = data
    
    PlayerResource:SpendGold(self:GetParent():GetPlayerOwnerID(),self.data.gold_cost,DOTA_ModifyGold_AbilityCost)

    -- if self.queue.size() > 0 then
        
    -- end
    
end

function hide_unit_modifier:Spawn(name, ability)
    local ability = self:GetParent():FindAbilityByName(ability)
    local spawn_pos = ability.spawn_pos
    local unit = CreateUnitByName(name, spawn_pos, true, self:GetParent(), nil, self:GetParent():GetTeamNumber())
    print(unit)
    Timers:CreateTimer(0.1, function()
        ability:MoveUnitToPosition(unit, ability.enemy_spawn)
    end)
    self.queue:dequeue()
    self.last_spawn_time = GameRules:GetGameTime()
end

function hide_unit_modifier:OnCreated( kv )
    self:GetParent():AddNoDraw()

    self.queue = Queue:new()

    self.last_spawn_time = GameRules:GetGameTime()

    if(self:GetParent():GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
        --radiant spawn pos
         self.spawn_pos = Vector(0, -2322.42, 128)
         self.enemy_spawn = Vector(195.836, 2322.42, 128)
    elseif self:GetParent():GetTeamNumber() == DOTA_TEAM_BADGUYS then
        --dire spawn pos
         self.spawn_pos = Vector(195.836, 2322.42, 128)
         self.enemy_spawn = Vector(0, -2322.42, 128)
    end

    self:StartIntervalThink(0.1)
end

function hide_unit_modifier:CheckState()
    return {
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true, -- Hides the health bar
        [MODIFIER_STATE_OUT_OF_GAME] = true, -- Fully removes unit from the game world
        [MODIFIER_STATE_UNSELECTABLE] = true, -- Cannot be selected
        [MODIFIER_STATE_NO_HEALTH_BAR] = true, -- Hides health bar
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true, -- Allows passing through units
        [MODIFIER_STATE_INVULNERABLE] = true, -- Prevents all damage
        [MODIFIER_STATE_ROOTED] = true,
    }
end


--------------------------------------------------------------------------------

function hide_unit_modifier:OnDestroy()
    self:GetParent():RemoveNoDraw()
end

--------------------------------------------------------------------------------

function hide_unit_modifier:OnIntervalThink()

    


    if not self.queue:isEmpty() then
        if GameRules:GetGameTime() >= self.last_spawn_time + self.queue:peek().spawn_time then
            self:Spawn(self.queue:peek().name, self.queue:peek().ability)


        end
    end

end