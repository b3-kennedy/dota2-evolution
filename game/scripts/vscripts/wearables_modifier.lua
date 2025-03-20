wearables_modifier = class({})

require('string_functions')
LinkLuaModifier("invisibility_modifier", LUA_MODIFIER_MOTION_NONE)

function wearables_modifier:OnCreated(kv)

    if not IsServer() then return end

    self.parent = self:GetParent()
    self.wearables = kv.string_table
    self.wearables_entities = SplitString(self.wearables, ",")
    self:PrintWearables()
    self:StartIntervalThink(0.1)
end

function wearables_modifier:OnRefresh(kv)
    self.wearables = kv.wearables
    self:PrintWearables()
end

function wearables_modifier:PrintWearables()
    if self.wearables ~= nil then
        print("wearables " .. tostring(self.wearables))
    end
end

function wearables_modifier:HideWearables()
    for _, wearable in pairs(self.wearables_entities) do
        local entity = EntIndexToHScript(tonumber(wearable))
        entity:AddEffects(EF_NODRAW)
    end
end

function wearables_modifier:ShowWearables()
    for _, wearable in pairs(self.wearables_entities) do
        local entity = EntIndexToHScript(tonumber(wearable))
        entity:RemoveEffects(EF_NODRAW)
    end
end
