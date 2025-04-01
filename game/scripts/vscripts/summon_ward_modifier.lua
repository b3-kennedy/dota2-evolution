summon_ward_modifier = class({})

function summon_ward_modifier:OnCreated(kv)

    if not IsServer() then return end

    self.parent = EntIndexToHScript(kv.entindex)
    self.plague_modifier = self.parent:FindModifierByName("plague_ward_modifier")
    
    table.insert(self.plague_modifier.summoned_wards, self:GetParent())
    
end

function summon_ward_modifier:DeclareFunctions()
    return { MODIFIER_PROPERTY_NO_UNIT_COLLISION }
end

function summon_ward_modifier:CheckState()
    return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
