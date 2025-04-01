summon_ward = class({})

LinkLuaModifier("plague_ward_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("summon_ward_modifier", LUA_MODIFIER_MOTION_NONE)

function summon_ward:GetIntrinsicModifierName()
    return "plague_ward_modifier"
end

function summon_ward:OnSpellStart()
    self.ward_name = "npc_dota_custom_plague_ward"
    local player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())


    local ward = CreateUnitByName(
        self.ward_name, 
        self:GetCaster():GetAbsOrigin(), 
        true, 
        player, 
        player,
        self:GetCaster():GetTeamNumber()
    )

    local kv = {duration = -1, entindex = self:GetCaster():entindex()}

    ward:AddNewModifier(self, self:GetCaster(), "summon_ward_modifier", kv)

end