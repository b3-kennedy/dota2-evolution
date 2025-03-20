


function AttachWearable(unit, modelPath,part)
    local wearable = SpawnEntityFromTableSynchronous("prop_dynamic", {model = modelPath, DefaultAnim=animation, targetname=DoUniqueString("prop_dynamic")})
    wearable:FollowEntity(unit, true)
    
    if part ~= nil then
            local mask1_particle = ParticleManager:CreateParticle( part, PATTACH_ABSORIGIN_FOLLOW, wearable )
			ParticleManager:SetParticleControlEnt( mask1_particle, 0, wearable, PATTACH_POINT_FOLLOW, "attach_part" , unit:GetOrigin(), true )
			ParticleManager:SetParticleControlEnt( mask1_particle, 1, wearable, PATTACH_POINT_FOLLOW, "attach_part" , unit:GetOrigin(), true )
			ParticleManager:SetParticleControlEnt( mask1_particle, 2, wearable, PATTACH_POINT_FOLLOW, "attach_part" , unit:GetOrigin(), true )
    end
    
    -- unit.wearables = unit.wearables or {}
    -- table.insert(unit.wearables, wearable)

    return wearable
end