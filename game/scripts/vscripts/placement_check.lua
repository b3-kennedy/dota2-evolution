placement_check = class({})

function placement_check:IsPlacementBlocked(player, position, caster, radius)
    local all_buildings = Entities:FindAllByClassname("npc_dota_tower")
    for _, building in pairs(all_buildings) do
        local building_pos = building:GetAbsOrigin()
        local distance_sqr = (position - building_pos):Length2D() -- Squared distance

        print("Building found:", building:GetUnitName(), "DistanceSqr:", distance_sqr)

        -- Check if within blocking radius
        if distance_sqr < radius then
            self:SendPlacementError(caster)
            return true
        end
    end
    
    return false
end

function placement_check:SendPlacementError(caster)
    CustomGameEventManager:Send_ServerToPlayer(
        PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), 
        "display_custom_error", 
        { message = "Cannot place building here - too close to another unit" }
    )
end