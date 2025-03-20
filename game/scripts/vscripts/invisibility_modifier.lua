invisibility_modifier = class({})


function invisibility_modifier:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
    return funcs
end

function invisibility_modifier:OnCreated(kv)
	if not IsServer() then return end


	if self:GetParent():FindModifierByName("wearables_modifier") then
		 self.modifier = self:GetParent():FindModifierByName("wearables_modifier")
		 self.modifier:HideWearables()
	end
end

function invisibility_modifier:GetModifierInvisibilityLevel()
	return 1
end

function invisibility_modifier:OnRemoved()

	if not IsServer() then return end

	if self:GetParent():FindModifierByName("wearables_modifier") then
		self.modifier = self:GetParent():FindModifierByName("wearables_modifier")
		self.modifier:ShowWearables()
   end
end

function invisibility_modifier:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end