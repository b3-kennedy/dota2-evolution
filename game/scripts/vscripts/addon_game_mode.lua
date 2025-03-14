-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

-- Creating a global gamemode class variable;
if barebones == nil then
	_G.barebones = class({})
else
	DebugPrint("[BAREBONES] barebones class name is already in use, change the name if this is the first time you launch the game!")
	DebugPrint("[BAREBONES] If this is not your first time, you probably used script_reload in console.")
end

require('util')
require('libraries/timers')                      -- Core lua library
require('libraries/player_resource')             -- Core lua library
require('gamemode')                              -- Core barebones file

function Precache(context)
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

	DebugPrint("[BAREBONES] Performing pre-load precache")

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	PrecacheResource("particle_folder", "particles/test_particle", context)
	PrecacheModel("models/creeps/lane_creeps/creep_dire_hulk/creep_dire_ancient_hulk.vmdl", context)
	PrecacheModel("models/creeps/lane_creeps/creep_radiant_hulk/creep_radiant_ancient_hulk.vmdl", context)
	PrecacheModel("models/props_gameplay/fountain_of_life/fountain_of_life.vmdl", context)
	PrecacheModel("models/props_structures/radiant_tower001.vmdl", context)
	PrecacheModel("models/heroes/undying/undying_tower.vmdl", context)
	PrecacheModel("models/props_structures/good_barracks_melee001.vmdl", context)
	PrecacheModel("models/props_structures/good_barracks_ranged001.vmdl", context)
	PrecacheModel("models/creeps/neutral_creeps/n_creep_satyr_b/n_creep_satyr_b.vmdl", context)
	PrecacheModel("models/items/beastmaster/hawk/fotw_eagle/fotw_eagle.vmdl", context)
	PrecacheModel("models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mega.vmdl", context)
	PrecacheModel("models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega.vmdl", context)
	PrecacheModel("models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context)
	PrecacheModel("models/props_structures/radiant_ancient001.vmdl", context)
	PrecacheModel("models/props_structures/bad_ancient002.vmdl",context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context)
	PrecacheResource("particle", "particles/radiant_fx2/good_ancient001_ambient.vpcf", context)
	PrecacheResource("particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_right.vpcf", context)
	PrecacheResource("particle", "particles/creeps/lane_creeps/creep_radiant_hulk_swipe_left.vpcf", context)
	PrecacheResource("particle", "particles/creeps/lane_creeps/creep_dire_hulk_swipe_right.vpcf", context)
	PrecacheResource("particle", "particles/creeps/lane_creeps/creep_dire_hulk_swipe_right.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/black_dragon_fireball.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", context)

	

	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models

	--PrecacheResource("model_folder", "particles/heroes/antimage", context)
	--PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	--PrecacheModel("models/heroes/viper/viper.vmdl", context)
	--PrecacheModel("models/props_gameplay/treasure_chest001.vmdl", context)
	--PrecacheModel("models/props_debris/merchant_debris_chest001.vmdl", context)
	--PrecacheModel("models/props_debris/merchant_debris_chest002.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	PrecacheItemByNameSync("example_ability", context)
	PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
end

-- Create the game mode when we activate
function Activate()
	DebugPrint("[BAREBONES] Activating ...")
	print("Your custom game is activating.")
	barebones:InitGameMode()
end
