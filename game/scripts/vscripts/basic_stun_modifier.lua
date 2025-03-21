basic_stun_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function basic_stun_modifier:IsDebuff()
	return true
end

function basic_stun_modifier:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function basic_stun_modifier:OnCreated( kv )
	if not IsServer() then return end

	self.particle = "particles/generic_gameplay/generic_stunned.vpcf"
	if kv.bash==1 then
		self.particle = "particles/generic_gameplay/generic_bashed.vpcf"
	end


	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()
	local duration = kv.duration*resist
	self:SetDuration( duration, true )
end

function basic_stun_modifier:OnRefresh( kv )
	self:OnCreated( kv )
end

function basic_stun_modifier:OnRemoved()
end

function basic_stun_modifier:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function basic_stun_modifier:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function basic_stun_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function basic_stun_modifier:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function basic_stun_modifier:GetEffectName()
	return self.particle
end

function basic_stun_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end