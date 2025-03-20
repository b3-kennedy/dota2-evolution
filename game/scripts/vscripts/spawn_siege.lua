spawn_siege = class({})


require('libraries/timers')

LinkLuaModifier("spawner_modifier", LUA_MODIFIER_MOTION_NONE)

function spawn_siege:OnSpellStart()

    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    
    
    
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    Timers:CreateTimer(0.1, function()
        self.create_unit_modifier:MoveUnitToPosition(testunit, self.spawn_pos)
    end)

    self.create_unit_modifier:CastWithSelection(self:GetCaster(), self:GetAbilityIndex())

end

function spawn_siege:GetAbilityTag()
    return "spawner"
end

function spawn_siege:SetUpUnitData()
    self.create_unit_modifier = self:GetCaster():FindModifierByName("create_unit_modifier")
    self.spawn_pos = self:GetCaster():FindModifierByName("create_unit_modifier").spawn_pos
    self.enemy_spawn = self:GetCaster():FindModifierByName("create_unit_modifier").enemy_spawn
    self.team = self:GetCaster():GetTeamNumber()
    self.unit_data = 
    {
        name = "npc_dota_creep_goodguys_siege", 
        spawn_time = 2, 
        ability = "spawn_siege",
        ability1 = "siege",
        gold_cost = self:GetManaCost(self:GetLevel()),
    }
end

function spawn_siege:SpawnLevelOne()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_siege"
    else
        self.unit_data.name = "npc_dota_creep_badguys_siege"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
    local testunit = CreateUnitByName("npc_dota_creep_badguys_siege", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    testunit:FindAbilityByName("siege"):SetLevel(4)
    Timers(0.1, function() self:MoveUnitToPosition(testunit, self.spawn_pos) end)
end

function spawn_siege:SpawnLevelTwo()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_siege_mega"
    else
        self.unit_data.name = "npc_dota_creep_badguys_siege_mega"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
    local testunit = CreateUnitByName("npc_dota_creep_badguys_siege_mega", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    Timers(0.1, function() self:MoveUnitToPosition(testunit, self.spawn_pos) end)
end

function spawn_siege:SpawnLevelThree()
    self:SetUpUnitData()
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_creep_goodguys_siege_three"
    else
        self.unit_data.name = "npc_dota_creep_badguys_siege_three"
    end

    self.create_unit_modifier:CreateUnit(self.unit_data)
    local testunit = CreateUnitByName("npc_dota_creep_badguys_siege_three", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    testunit:FindAbilityByName("siege"):SetLevel(4)
    Timers(0.1, function() self:MoveUnitToPosition(testunit, self.spawn_pos) end)
end

function spawn_siege:SpawnLevelFour()
    self:SetUpUnitData()
    self.unit_data.ability1 = "summon_treants"
    if self.team == DOTA_TEAM_GOODGUYS then
        self.unit_data.name = "npc_dota_custom_furion"
    else
        self.unit_data.name = "npc_dota_custom_furion"
    end

    local testunit = CreateUnitByName("npc_dota_custom_furion", self.enemy_spawn, true, self:GetCaster(), nil, DOTA_TEAM_BADGUYS)
    self.create_unit_modifier:CreateUnit(self.unit_data)
    Timers(0.1, function() self:MoveUnitToPosition(testunit, self.spawn_pos) end)
end

function spawn_siege:MoveUnitToPosition(unit, position)
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