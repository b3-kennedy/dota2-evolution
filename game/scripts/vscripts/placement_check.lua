placement_check = class({})

function placement_check:IsPlacementBlocked(player, position, caster, radius)
    local all_buildings = Entities:FindAllByClassname("npc_dota_tower")
    
    if position.z < 256 then
        self:SendPlacementError(caster, "Cannot place building on water")
        return true
    end


    for _, building in pairs(all_buildings) do
        local building_pos = building:GetAbsOrigin()
        local distance_sqr = (position - building_pos):Length2D() -- Squared distance
        -- Check if within blocking radius
        if distance_sqr < radius then
            self:SendPlacementError(caster, "Cannot place building here - too close to another building")
            return true
        end
    end
    
    return false
end

function placement_check:SendPlacementError(caster, msg)
    CustomGameEventManager:Send_ServerToPlayer(
        PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), 
        "display_custom_error", 
        { message = msg }
    )
end
