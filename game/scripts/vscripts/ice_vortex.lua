ice_vortex = class({})


LinkLuaModifier("ice_vortex_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("ice_vortex_modifier_thinker", LUA_MODIFIER_MOTION_NONE)

function ice_vortex:GetIntrinsicModifierName()
    return "ice_vortex_modifier"
end


function ice_vortex:GetTarget()
    local modifier = self:GetCaster():FindModifierByName("ice_vortex_modifier")
    return modifier.target
end

function ice_vortex:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetTarget()
    
    CreateModifierThinker(caster,self,"ice_vortex_modifier_thinker",{duration = 5},target:GetAbsOrigin(),self:GetCaster():GetTeamNumber(),false)
end