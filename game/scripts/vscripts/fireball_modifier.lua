fireball_modifier = class({})

function fireball_modifier:OnCreated(kv)
    if not IsServer() then return end
    self:StartIntervalThink(0.5)


    self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = 10,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}
end

function fireball_modifier:OnIntervalThink()

    self.damageTable.victim = self:GetParent()
    ApplyDamage( self.damageTable )
end