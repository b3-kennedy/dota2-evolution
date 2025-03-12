gold_check_modifier = class({})

function gold_check_modifier:OnCreated(kv)

    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function gold_check_modifier:OnIntervalThink()
    self:EnoughGoldForAbilityCheck()
end

function gold_check_modifier:EnoughGoldForAbilityCheck()

    if not IsServer() then return end


    for i=0, self:GetParent():GetAbilityCount()-1 do
        local ability = self:GetParent():GetAbilityByIndex(i)
        local gold = PlayerResource:GetGold(self:GetParent():GetPlayerOwnerID())
        if ability then
            if gold < ability:GetManaCost(ability:GetLevel()) then
                ability:SetActivated(false)
            else
                ability:SetActivated(true)
            end

        end
    end
end