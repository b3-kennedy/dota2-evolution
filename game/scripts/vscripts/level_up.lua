level_up = class({})

function level_up:OnAbilityPhaseStart()
    self.gold_cost = 700
    self.caster = self:GetCaster()
    if PlayerResource:GetGold(self.caster:GetPlayerOwnerID()) < self.gold_cost then
        self.caster:Interrupt()
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.caster:GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
end

function level_up:OnSpellStart()
    self.current_max_level = 4
    local panel_modifier = self.caster:FindModifierByName("world_panel_holder_modifier")
    PlayerResource:SpendGold(self.caster:GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()-1),DOTA_ModifyGold_AbilityCost)
    

    if self.caster:GetUnitName() == "npc_dota_special_unit_creator" then
        
        if self:GetLevel()+1 == 2 then
            self.caster:RemoveAbility("spawn_scout_hawk")
            self.caster:AddAbility("spawn_assassin")

            self.caster:RemoveAbility("spawn_tank")
            self.caster:AddAbility("spawn_magic_resist")

            self.caster:RemoveAbility("spawn_heal")
            self.caster:AddAbility("spawn_lina")
        elseif self:GetLevel()+1 == 3 then
            self.caster:RemoveAbility("spawn_magic_resist")
            self.caster:AddAbility("spawn_centaur")

            self.caster:RemoveAbility("spawn_assassin")
            self.caster:AddAbility("spawn_sniper")

            self.caster:RemoveAbility("spawn_lina")
            self.caster:AddAbility("spawn_lion")
        elseif self:GetLevel()+1 == 4 then
            self.caster:RemoveAbility("spawn_centaur")
            self.caster:AddAbility("spawn_treant")

            self.caster:RemoveAbility("spawn_sniper")
            self.caster:AddAbility("spawn_veno")

            self.caster:RemoveAbility("spawn_lion")
            self.caster:AddAbility("spawn_ancient_apparition")
        end
    elseif self.caster:GetUnitName() == "npc_dota_special_ability_building" then
        if self:GetLevel()+1 == 2 then
            self.caster:RemoveAbilityByHandle(self.caster:GetAbilityByIndex(1))
            self.caster:AddAbility("mortimer_kisses")
        elseif self:GetLevel()+1 == 3 then
            self.caster:RemoveAbilityByHandle(self.caster:GetAbilityByIndex(2))
            self.caster:AddAbility("invulnerable")
        elseif self:GetLevel()+1 == 4 then
            self.caster:RemoveAbilityByHandle(self.caster:GetAbilityByIndex(3))
            self.caster:AddAbility("special_ability")

        end
    end

    for i=0, self.caster:GetAbilityCount()-1 do
        local ability = self.caster:GetAbilityByIndex(i)
        if ability then
            ability:SetLevel(ability:GetLevel()+1)
        end
        
    end



    if self:GetLevel() == self.current_max_level then
        self:SetActivated(false)
    end

    if panel_modifier then
        panel_modifier:OnLevel(self:GetLevel())
    end

end

function level_up:GetAbilityTag()
    return "level"
end