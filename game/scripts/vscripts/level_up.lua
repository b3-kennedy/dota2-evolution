level_up = class({})

function level_up:OnAbilityPhaseStart()
    self.gold_cost = 700
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) < self.gold_cost then
        self:GetCaster():Interrupt()
        print("NOT ENOUGH GOLD")
    end
end

function level_up:OnSpellStart()
    self.current_max_level = 2
    

    for i=0, self:GetCaster():GetAbilityCount()-1 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability then
            ability:SetLevel(ability:GetLevel()+1)
        end
        
    end



    if self:GetLevel() == self.current_max_level then
        self:SetActivated(false)
    end
end