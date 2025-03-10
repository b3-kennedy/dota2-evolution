build_barracks = class({})

LinkLuaModifier("create_unit_modifier", LUA_MODIFIER_MOTION_NONE)

function build_barracks:OnSpellStart()
    if PlayerResource:GetGold(self:GetCaster():GetPlayerOwnerID()) >= 250 then
        self.caster = self:GetCaster()
        self.mouse_pos = self:GetCursorPosition()
        self.player = PlayerResource:GetSelectedHeroEntity(self:GetCaster():GetPlayerOwnerID())

        local dir = (self.mouse_pos - self.caster:GetAbsOrigin()):Normalized()

        self.caster:SetForwardVector(dir)

        local building = CreateUnitByName("npc_dota_unit_creator", self.mouse_pos, false, self.player, self.player, self.player:GetTeamNumber())

        local kv = {
            duration = -1, 
            spawn_x = self.mouse_pos.x, 
            spawn_y = self.mouse_pos.y, 
            spawn_z = self.mouse_pos.z
        }
        building:AddNewModifier(self.player, self, "create_unit_modifier", kv)
        building:SetOwner(self.player)
        building:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)

        PlayerResource:SpendGold(self:GetCaster():GetPlayerOwnerID(),250,DOTA_ModifyGold_AbilityCost)

    else
        print("NOT ENOUGH GOLD TO BUILD TOWER")
    end
end