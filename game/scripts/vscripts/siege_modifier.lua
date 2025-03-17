siege_modifier = class({})

function siege_modifier:OnCreated(kv)
    
end

function siege_modifier:OnRefresh(kv)

end

function siege_modifier:DeclareFunctions()
    return {MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end

function siege_modifier:GetModifierDamageOutgoing_Percentage(params)

    if not IsServer() then return end
    if params.target ~= nil then
        if params.target:IsBuilding() or params.target:GetAbilityByIndex(0):GetName() == "siege" then
            return 100
        else
            return -50
        end
    end
    
end