fireball = class({})

LinkLuaModifier("small_black_dragon_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("fireball_modifier_thinker", LUA_MODIFIER_MOTION_NONE)

function fireball:SetTargetPosition(pos)
    self.target_position = pos
end 

function fireball:GetIntrinsicModifierName()
    return "small_black_dragon_modifier"
end

function fireball:OnSpellStart()

    local pos = Vector(self.target_position.x, self.target_position.y, 500)
    print(tostring(self.target_position))
    local kv = {duration = 3}
    CreateModifierThinker(
        self:GetCaster(), 
        self, 
        "fireball_modifier_thinker", 
        kv
        , 
        pos, 
        self:GetCaster():GetTeamNumber(),
        false
    )
end

