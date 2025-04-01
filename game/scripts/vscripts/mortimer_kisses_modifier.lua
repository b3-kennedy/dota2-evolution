
--------------------------------------------------------------------------------
mortimer_kisses_modifier = class({})

--------------------------------------------------------------------------------
-- Classifications
function mortimer_kisses_modifier:IsHidden()
	return false
end

function mortimer_kisses_modifier:IsDebuff()
	return false
end

function mortimer_kisses_modifier:IsStunDebuff()
	return false
end

function mortimer_kisses_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function mortimer_kisses_modifier:OnCreated( kv )
	-- references
	self.min_range = 0
	self.max_range = 5000
	self.range = self.max_range-self.min_range
	
	self.min_travel = 0.1
	self.max_travel = 2
	self.travel_range = self.max_travel-self.min_travel
	
	self.projectile_speed = 700
	local projectile_vision = 100
	
	self.turn_rate = 100

	if not IsServer() then return end

	-- load data
	local interval = self:GetAbility():GetDuration()/1 + 0.01 -- so it only have 8 projectiles instead of 9
	self:SetValidTarget( Vector( kv.pos_x, kv.pos_y, 0 ) )
	local projectile_name = "particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf"
	local projectile_start_radius = 0
	local projectile_end_radius = 0

	-- precache projectile
	self.info = {
		-- Target = target,
		Source = self:GetCaster(),
		Ability = self:GetAbility(),	
		
		EffectName = projectile_name,
		iMoveSpeed = self.projectile_speed,
		bDodgeable = false,                           -- Optional
	
		vSourceLoc = self:GetCaster():GetOrigin(),                -- Optional (HOW)
		
		bDrawsOnMinimap = false,                          -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = projectile_vision,                              -- Optional
		iVisionTeamNumber = self:GetCaster():GetTeamNumber()        -- Optional
	}

	-- Start interval
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
end

function mortimer_kisses_modifier:OnRefresh( kv )
	
end

function mortimer_kisses_modifier:OnRemoved()
end

function mortimer_kisses_modifier:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function mortimer_kisses_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,

		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}

	return funcs
end

function mortimer_kisses_modifier:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	-- right click, switch position
	if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		self:SetValidTarget( params.new_pos )
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		self:SetValidTarget( params.target:GetOrigin() )

	-- stop or hold
	elseif 
		params.order_type==DOTA_UNIT_ORDER_STOP or
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end
end

function mortimer_kisses_modifier:GetModifierMoveSpeed_Limit()
	return 0.1
end

function mortimer_kisses_modifier:GetModifierTurnRate_Percentage()
	return -self.turn_rate
end

--------------------------------------------------------------------------------
-- Status Effects
function mortimer_kisses_modifier:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function mortimer_kisses_modifier:OnIntervalThink()
	-- create target thinker
	local thinker = CreateModifierThinker(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"mortimer_kisses_modifier_thinker", -- modifier name
		{ travel_time = self.travel_time }, -- kv
		self.target,
		self:GetParent():GetTeamNumber(),
		false
	)

	-- set projectile
	self.info.iMoveSpeed = self.vector:Length2D()/self.travel_time
	self.info.Target = thinker

	-- launch projectile
	ProjectileManager:CreateTrackingProjectile( self.info )

	-- create FOW
	AddFOWViewer( self:GetParent():GetTeamNumber(), thinker:GetOrigin(), 100, 1, false )

	-- play sound
	local sound_cast = "Hero_Snapfire.MortimerBlob.Launch"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Helper
function mortimer_kisses_modifier:SetValidTarget( location )
	local origin = self:GetParent():GetOrigin()
	local vec = location-origin
	local direction = vec
	direction.z = 0
	direction = direction:Normalized()

	if vec:Length2D()<self.min_range then
		vec = direction * self.min_range
	elseif vec:Length2D()>self.max_range then
		vec = direction * self.max_range
	end

	self.target = GetGroundPosition( origin + vec, nil )
	self.vector = vec
	self.travel_time = (vec:Length2D()-self.min_range)/self.range * self.travel_range + self.min_travel
end