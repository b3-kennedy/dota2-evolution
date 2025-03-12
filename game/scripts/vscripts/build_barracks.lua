build_barracks = class({})

require('positions')

LinkLuaModifier("create_unit_modifier", LUA_MODIFIER_MOTION_NONE)

function build_barracks:OnSpellStart()
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= self:GetManaCost(self:GetLevel()) then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.spawn_pos = nil
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        local building = CreateUnitByName("npc_dota_unit_creator", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

        if self.caster:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
            self.spawn_pos = PLAYER_SPAWN_RADIANT
        else
            self.spawn_pos = PLAYER_SPAWN_DIRE
        end

        local kv = {
            duration = -1, 
            spawn_x = self.spawn_pos.x, 
            spawn_y = self.spawn_pos.y, 
            spawn_z = self.spawn_pos.z,
            player = self.player:entindex()
        }
        building:AddNewModifier(self.player, self, "create_unit_modifier", kv)
        building:SetOwner(self.player)
        building:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)

        PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),self:GetManaCost(self:GetLevel()),DOTA_ModifyGold_AbilityCost)

    else
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "display_custom_error", { message = "Not Enough Gold" })
    end
end