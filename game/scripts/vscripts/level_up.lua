level_up = class({})

function level_up:OnAbilityPhaseStart()
    self.gold_cost = 700
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) < self.gold_cost then
        self:GetCaster():Interrupt()
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
end

function level_up:OnSpellStart()
    self.current_max_level = 4
    
    PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()-1),DOTA_ModifyGold_AbilityCost)

    if self:GetCaster():GetUnitName() == "npc_dota_special_unit_creator" then
        
        if self:GetLevel()+1 == 2 then
            self:GetCaster():RemoveAbility("spawn_scout_hawk")
            self:GetCaster():AddAbility("spawn_assassin")

            self:GetCaster():RemoveAbility("spawn_tank")
            self:GetCaster():AddAbility("spawn_magic_resist")

            self:GetCaster():RemoveAbility("spawn_heal")
            self:GetCaster():AddAbility("spawn_lina")
        elseif self:GetLevel()+1 == 3 then
            self:GetCaster():RemoveAbility("spawn_magic_resist")
            self:GetCaster():AddAbility("spawn_centaur")

            self:GetCaster():RemoveAbility("spawn_assassin")
            self:GetCaster():AddAbility("spawn_sniper")

            self:GetCaster():RemoveAbility("spawn_lina")
            self:GetCaster():AddAbility("spawn_lion")
        end
    end

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

function level_up:GetAbilityTag()
    return "level"
end