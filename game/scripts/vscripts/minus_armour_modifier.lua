minus_armour_modifier = class({})

function minus_armour_modifier:IsDebuff() return true end
function minus_armour_modifier:IsPurgable() return true end

function minus_armour_modifier:DeclareFunctions()
    return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function minus_armour_modifier:GetModifierPhysicalArmorBonus()
    return -3  -- Reduces armor by 5
end