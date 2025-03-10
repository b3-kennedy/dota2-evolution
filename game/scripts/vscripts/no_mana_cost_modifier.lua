no_mana_cost_modifier = class({})

function no_mana_cost_modifier:OnCreated(kv)

end

function no_mana_cost_modifier:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_SPENT_MANA,
    }
    return funcs
end

function no_mana_cost_modifier:OnSpentMana(params)
    if params.unit == self:GetParent() then
        self:GetParent():GiveMana(params.cost)
    end
end