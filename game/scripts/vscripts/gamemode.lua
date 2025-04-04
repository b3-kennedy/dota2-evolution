-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "2.0.18"

-- Selection library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')
require('libraries/playertables')
require('libraries/worldpanels')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')
-- filters.lua
require('filters')

require('positions')

require('wearables')

require('string_functions')

LinkLuaModifier("hide_unit_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("basic_root_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("no_mana_cost_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("create_unit_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("gold_check_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wearables_modifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("treant_protector_modifier", LUA_MODIFIER_MOTION_NONE)


if USE_CUSTOM_ROSHAN then
	require('components/roshan/init')
end

if USE_CUSTOM_TORMENTOR then
	require('components/tormentor/init')
end

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability#
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function barebones:PostLoadPrecache()
	DebugPrint("[BAREBONES] Performing Post-Load precache.")
	--PrecacheItemByNameAsync("item_example_item", function(...) end)
	--PrecacheItemByNameAsync("example_ability", function(...) end)

	--PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
	--PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function barebones:OnAllPlayersLoaded()
	DebugPrint("[BAREBONES] All Players have loaded into the game.")
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function barebones:OnGameInProgress()
	DebugPrint("[BAREBONES] The game has officially begun.")

	-- If the day/night is not changed at 00:00, the following line is needed:
	GameRules:SetTimeOfDay(0.251)
end

function barebones:SetUpHeroes(unit)
	local wearables = {}
	if unit:GetUnitName() == "npc_dota_custom_sven" then
		table.insert(wearables,AttachWearable(unit, "models/heroes/sven/sven_belt.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/sven/sven_gauntlet.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/sven/sven_mask.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/sven/sven_shoulder.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/sven/sven_sword.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_drow" then
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_armor.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_bracer.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_cape.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_haircowl.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_legs.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_quiver.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/drow/drow_weapon.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_furion" then
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_beard.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_bracer.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_cape.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_horns.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_necklace.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/furion/furion_staff.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_tidehunter" then
		table.insert(wearables,AttachWearable(unit, "models/heroes/tidehunter/tidehunter_anchor.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/tidehunter/tidehunter_belt.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/tidehunter/tidehunter_bracer.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/tidehunter/tidehunter_fish.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_phantom_assassin" then
		table.insert(wearables,AttachWearable(unit, "models/heroes/phantom_assassin/phantom_assassin_cape.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/phantom_assassin/phantom_assassin_daggers.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/phantom_assassin/phantom_assassin_helmet.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/phantom_assassin/phantom_assassin_shoulders.vmdl", nil))
		table.insert(wearables,AttachWearable(unit, "models/heroes/phantom_assassin/phantom_assassin_weapon.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_slardar" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/slardar/slardar_arms.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/slardar/slardar_back.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/slardar/slardar_weapon.vmdl", nil))
		self:AddWearablesToModifier(wearables, unit)
	elseif unit:GetUnitName() == "npc_dota_custom_lina" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/lina/lina_arms.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lina/lina_belt.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lina/lina_head.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lina/lina_neck.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_centaur" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/belt.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/bracer.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/shield.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/shoulder.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/tail.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/weapon.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/centaur/headitem.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_sniper" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/sniper/bracer.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/sniper/cape.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/sniper/headitem.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/sniper/shoulder.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/sniper/weapon.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_lion" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/lion/lion_cape.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lion/lion_cape.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lion/lion_hat.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lion/lion_shoulder.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/lion/lion_weapon.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_treant_protector" then
		unit:AddNewModifier(unit, nil, "treant_protector_modifier", {duration = -1})
		table.insert(wearables, AttachWearable(unit, "models/heroes/treant_protector/foliage.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/treant_protector/hands.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/treant_protector/head.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/treant_protector/legs.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/treant_protector/treant_crow.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_venomancer" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/venomancer/venomancer_arms.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/venomancer/venomancer_jaw.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/venomancer/venomancer_shoulder.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/venomancer/venomancer_tail.vmdl", nil))
	elseif unit:GetUnitName() == "npc_dota_custom_ancient_apparition" then
		table.insert(wearables, AttachWearable(unit, "models/heroes/ancient_apparition/ancient_apparition_shoulder.vmdl", nil))
		table.insert(wearables, AttachWearable(unit, "models/heroes/ancient_apparition/ancient_apparition_tail.vmdl", nil))
	end
	--table.insert(wearables, AttachWearable(unit, "", nil))
end

function barebones:AddWearablesToModifier(wearables, unit)
	local string_table = ""
	for i = 1, #wearables do
		if i == 1 then
			string_table = tostring(wearables[i]:entindex())
		else
			string_table = string_table .. "," .. tostring(wearables[i]:entindex())
		end
	end
	unit:AddNewModifier(unit, nil, "wearables_modifier", {string_table = string_table})
end

function barebones:OnNPCSpawned(keys)
	local unit = EntIndexToHScript(keys.entindex)

	print(unit:GetUnitName())

	self:SetUpHeroes(unit)

	if unit and unit:IsHero() and unit:IsRealHero() and unit:GetName() == "npc_dota_hero_wisp" then

		self:SpawnBuilderNpcs(unit)
		
		for i=0, unit:GetAbilityCount()-1 do
			local ability = unit:GetAbilityByIndex(i)
			if ability then
				ability:SetLevel(1)
			end
		end



		unit:AddNewModifier(unit, nil, "hide_unit_modifier", {duration = -1})
		unit:AddNewModifier(unit, nil, "no_mana_cost_modifier", {duration = -1})

		if unit:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			local spawn = PLAYER_SPAWN_RADIANT
			local kv = {duration = -1, spawn_x = spawn.x, spawn_y = spawn.y, spawn_z = spawn.z, player = unit:entindex()}
			unit:AddNewModifier(unit, nil, "create_unit_modifier", kv)
		else
			local spawn = PLAYER_SPAWN_DIRE
			local kv = {duration = -1, spawn_x = spawn.x, spawn_y = spawn.y, spawn_z = spawn.z,  player = unit:entindex()}
			unit:AddNewModifier(unit, nil, "create_unit_modifier", kv)
		end

		
		
	end
end

function barebones:SpawnBuilderNpcs(unit)

	-- {
	-- 	origin = "0 -2589.26 140"
	-- }
	if unit:GetTeamNumber() == DOTA_TEAM_GOODGUYS then

		-- {
		-- 	origin = "2130.44 57.7247 128"
		-- }
		local tower_builder = CreateUnitByName("npc_dota_tower_builder_good", PLAYER_SPAWN_RADIANT, false, unit, unit, unit:GetTeamNumber())
		for i=0, tower_builder:GetAbilityCount()-1 do
			local ability = tower_builder:GetAbilityByIndex(i)
			ability:SetLevel(1)
		end
		tower_builder:SetOwner(unit)
		tower_builder:SetControllableByPlayer(unit:GetPlayerOwnerID(), true)
		tower_builder:AddNewModifier(tower_builder, nil, "basic_root_modifier", {duration = -1})
		tower_builder:RemoveModifierByName("modifier_invulnerable")

		-- {
		-- 	origin = "631.045 -2264.37 128.062"
		-- }

		local barracks = CreateUnitByName("npc_dota_unit_creator", BUILDING_SPAWN_RADIANT, false, unit, unit, unit:GetTeamNumber())
		barracks:SetOwner(unit)
		barracks:SetControllableByPlayer(unit:GetPlayerOwnerID(), true)
		local kv = {
            duration = -1, 
            spawn_x = PLAYER_SPAWN_RADIANT.x, 
            spawn_y = PLAYER_SPAWN_RADIANT.y, 
            spawn_z = PLAYER_SPAWN_RADIANT.z,
            player = unit:entindex()
        }
		barracks:AddNewModifier(barracks, barracks, "create_unit_modifier", kv)
		barracks:AddNewModifier(barracks, nil, "basic_root_modifier", {duration = -1})
		barracks:AddNewModifier(barracks, nil, "modifier_invulnerable", {duration = -1})
		barracks:AddNewModifier(barracks, nil, "world_panel_holder_modifier", {duration = -1})

	else
		local tower_builder = CreateUnitByName("npc_dota_tower_builder_bad", PLAYER_SPAWN_DIRE, false, unit, unit, unit:GetTeamNumber())
		for i=0, tower_builder:GetAbilityCount()-1 do
			local ability = tower_builder:GetAbilityByIndex(i)
			ability:SetLevel(1)
		end
		tower_builder:SetOwner(unit)
		tower_builder:SetControllableByPlayer(unit:GetPlayerOwnerID(), true)
		tower_builder:AddNewModifier(tower_builder, nil, "basic_root_modifier", {duration = -1})
		tower_builder:RemoveModifierByName("modifier_invulnerable")
		local barracks = CreateUnitByName("npc_dota_unit_creator", BUILDING_SPAWN_DIRE, false, unit, unit, unit:GetTeamNumber())
		barracks:SetOwner(unit)
		barracks:SetControllableByPlayer(unit:GetPlayerOwnerID(), true)
		local kv = {
            duration = -1, 
            spawn_x = PLAYER_SPAWN_DIRE.x, 
            spawn_y = PLAYER_SPAWN_DIRE.y, 
            spawn_z = PLAYER_SPAWN_DIRE.z,
            player = unit:entindex()
        }
		barracks:AddNewModifier(barracks, barracks, "create_unit_modifier", kv)
		barracks:AddNewModifier(barracks, nil, "basic_root_modifier", {duration = -1})
		barracks:AddNewModifier(barracks, nil, "modifier_invulnerable", {duration = -1})
		barracks:AddNewModifier(barracks, nil, "world_panel_holder_modifier", {duration = -1})
	end

	


end

function barebones:OnUpdateWorldPanelText()

end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function barebones:InitGameMode()
	DebugPrint("[BAREBONES] Starting to load Game Rules.")

	-- {
	-- 	origin = "0 -2589.26 140"
	-- }



	-- local radiant_ancient = Entities:FindByName(nil, "dota_goodguys_fort")
	-- local dire_ancient = Entities:FindByName(nil, "dota_badguys_fort")



	-- if radiant_ancient then
	-- 	radiant_ancient:RemoveModifierByName("modifier_invulnerable")
	-- 	radiant_ancient:RemoveModifierByName("modifier_backdoor_protection")
	-- 	radiant_ancient:GetAbilityByIndex(0):SetHidden(true)
	-- 	radiant_ancient:GetAbilityByIndex(1):SetHidden(true)
	-- 	radiant_ancient:SetMana(20000)
	-- end

	-- if dire_ancient then
	-- 	dire_ancient:RemoveModifierByName("modifier_invulnerable")
	-- 	dire_ancient:RemoveModifierByName("modifier_backdoor_protection")
	-- 	dire_ancient:GetAbilityByIndex(0):SetHidden(true)
	-- 	dire_ancient:GetAbilityByIndex(1):SetHidden(true)
	-- end
	-- Setup rules
	GameRules:SetSameHeroSelectionEnabled(ALLOW_SAME_HERO_SELECTION)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)

	GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME) -- THIS IS IGNORED when "EnablePickRules" is "1" in 'addoninfo.txt' !
	GameRules:SetHeroSelectPenaltyTime(HERO_SELECTION_PENALTY_TIME)

	GameRules:SetPreGameTime(PRE_GAME_TIME)
	GameRules:SetPostGameTime(POST_GAME_TIME)
	GameRules:SetShowcaseTime(SHOWCASE_TIME)
	GameRules:SetStrategyTime(STRATEGY_TIME)

	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)

	if USE_CUSTOM_HERO_LEVELS then
		GameRules:SetUseCustomHeroXPValues(true)
	end

	--GameRules:SetGoldPerTick(GOLD_PER_TICK) -- Doesn't work; Last time tested: 24.2.2020
	--GameRules:SetGoldTickTime(GOLD_TICK_TIME) -- Doesn't work; Last time tested: 24.2.2020
	GameRules:SetStartingGold(NORMAL_START_GOLD)

	if USE_CUSTOM_HERO_GOLD_BOUNTY then
		GameRules:SetUseBaseGoldBountyOnHeroes(false) -- if true Heroes will use their default base gold bounty which is similar to creep gold bounty, rather than DOTA specific formulas
	end

	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE)
	GameRules:SetCreepMinimapIconScale(MINIMAP_CREEP_ICON_SIZE)
	GameRules:SetRuneMinimapIconScale(MINIMAP_RUNE_ICON_SIZE)
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	GameRules:LockCustomGameSetupTeamAssignment(LOCK_TEAMS)
	
	-- TO TEST:
	--GameRules:SetAllowOutpostBonuses(true)
	--GameRules:SetEnableAlternateHeroGrids(false) -- disable alternate hero grids to be used (DOTA+, etc) useful when you have custom heroes
	--GameRules:SetSuggestItemsEnabled(false)
	-- HERO BLACK LIST
	--GameRules:SetHideBlacklistedHeroes(true) -- true is hidden, false is dimmed during hero selection
	--GameRules:AddHeroIDToBlacklist(int)
	--GameRules:AddHeroToBlacklist(string)
	--GameRules:ClearHeroBlacklist()
	--GameRules:RemoveHeroFromBlacklist(string)
	--GameRules:RemoveHeroIDFromBlacklist(int)
	-- ITEM WHITE LIST
	--GameRules:SetWhiteListEnabled(true)
	--GameRules:AddItemToWhiteList(string)
	--GameRules:IsItemInWhiteList(string)
	--GameRules:RemoveItemFromWhiteList(string)

	-- This is multi-team configuration stuff
	if USE_AUTOMATIC_PLAYERS_PER_TEAM then
		local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
		local count = 0
		for team, number in pairs(TEAM_COLORS) do
			if count >= MAX_NUMBER_OF_TEAMS then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, num)
			end
			count = count + 1
		end
	else
		local count = 0
		for team, number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
			if count >= MAX_NUMBER_OF_TEAMS then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, number)
			end
			count = count + 1
		end
	end

	if USE_CUSTOM_TEAM_COLORS then
		for team, color in pairs(TEAM_COLORS) do
			SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
		end
	end

	DebugPrint("[BAREBONES] Done with setting Game Rules.")

	-- Event Hooks / Listeners
	DebugPrint("[BAREBONES] Setting Event Hooks / Listeners.")

	

	CustomGameEventManager:RegisterListener("update_world_panel_text", Dynamic_Wrap(barebones, "OnUpdateWorldPanelText"))


	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(barebones, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(barebones, 'OnPlayerLearnedAbility'), self)
	--ListenToGameEvent('entity_killed', Dynamic_Wrap(barebones, 'OnUnitKilled'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(barebones, 'OnConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(barebones, 'OnDisconnect'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(barebones, 'OnItemPickedUp'), self)
	ListenToGameEvent('last_hit', Dynamic_Wrap(barebones, 'OnLastHit'), self)
	ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(barebones, 'OnRuneActivated'), self)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(barebones, 'OnTreeCut'), self)

	ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(barebones, 'OnAbilityUsed'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(barebones, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(barebones, 'OnNPCSpawned'), self)
	--ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(barebones, 'OnPlayerPickHero'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(barebones, 'OnPlayerReconnect'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(barebones, 'OnPlayerChat'), self)

	ListenToGameEvent("dota_tower_kill", Dynamic_Wrap(barebones, 'OnTowerKill'), self)
	ListenToGameEvent("dota_player_selected_custom_team", Dynamic_Wrap(barebones, 'OnPlayerSelectedCustomTeam'), self)
	ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(barebones, 'OnNPCGoalReached'), self)
	ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(barebones, 'OnNPCGoalReached'), self)

	-- Change random seed for math.random function
	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
	local timeNumber = tonumber(timeTxt)
	if timeNumber then
		math.randomseed(timeNumber) -- use 'RandomInt' or 'RandomFloat' instead of math.random
	end

	DebugPrint("[BAREBONES] Setting Filters.")

	local gamemode = GameRules:GetGameModeEntity()

	-- Setting the Order filter
	gamemode:SetExecuteOrderFilter(Dynamic_Wrap(barebones, "OrderFilter"), self)

	-- Setting the Damage filter
	gamemode:SetDamageFilter(Dynamic_Wrap(barebones, "DamageFilter"), self)

	-- Setting the Modifier filter
	gamemode:SetModifierGainedFilter(Dynamic_Wrap(barebones, "ModifierFilter"), self)

	-- Setting the Experience filter
	gamemode:SetModifyExperienceFilter(Dynamic_Wrap(barebones, "ExperienceFilter"), self)

	-- Setting the Tracking Projectile filter
	gamemode:SetTrackingProjectileFilter(Dynamic_Wrap(barebones, "ProjectileFilter"), self)

	-- Setting the bounty rune pickup filter
	gamemode:SetBountyRunePickupFilter(Dynamic_Wrap(barebones, "BountyRuneFilter"), self)

	-- Setting the Healing filter
	gamemode:SetHealingFilter(Dynamic_Wrap(barebones, "HealingFilter"), self)

	-- Setting the Gold Filter
	gamemode:SetModifyGoldFilter(Dynamic_Wrap(barebones, "GoldFilter"), self)

	-- Setting the Inventory filter
	gamemode:SetItemAddedToInventoryFilter(Dynamic_Wrap(barebones, "InventoryFilter"), self)

	DebugPrint("[BAREBONES] Done with setting Filters.")

	-- Global Lua Modifiers
	LinkLuaModifier("modifier_custom_invulnerable", "modifiers/modifier_custom_invulnerable.lua", LUA_MODIFIER_MOTION_NONE)
	LinkLuaModifier("modifier_custom_passive_gold", "modifiers/modifier_custom_passive_gold_example.lua", LUA_MODIFIER_MOTION_NONE)

	print("[BAREBONES] initialized.")
	DebugPrint("[BAREBONES] Done loading the game mode!\n\n")

	-- Increase/decrease maximum item limit per hero
	Convars:SetInt('dota_max_physical_items_purchase_limit', 64)
end

-- This function is called as the first player loads and sets up the game mode parameters
function barebones:CaptureGameMode()
	local gamemode = GameRules:GetGameModeEntity()

	-- Set GameMode parameters
	gamemode:SetRecommendedItemsDisabled(RECOMMENDED_BUILDS_DISABLED)
	gamemode:SetCameraDistanceOverride(CAMERA_DISTANCE_OVERRIDE)
	gamemode:SetBuybackEnabled(BUYBACK_ENABLED)
	gamemode:SetCustomBuybackCostEnabled(CUSTOM_BUYBACK_COST_ENABLED)
	gamemode:SetCustomBuybackCooldownEnabled(CUSTOM_BUYBACK_COOLDOWN_ENABLED)
	gamemode:SetTopBarTeamValuesOverride(USE_CUSTOM_TOP_BAR_VALUES) -- Probably does nothing, but I will leave it
	gamemode:SetTopBarTeamValuesVisible(TOP_BAR_VISIBLE)

	if USE_CUSTOM_XP_VALUES then
		gamemode:SetUseCustomHeroLevels(true)
		gamemode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	elseif MAX_LEVEL ~= 30 then
		gamemode:SetCustomHeroMaxLevel(MAX_LEVEL) -- this is not needed if SetCustomXPRequiredToReachNextLevel is used
	end

	gamemode:SetBotThinkingEnabled(USE_STANDARD_DOTA_BOT_THINKING)
	gamemode:SetTowerBackdoorProtectionEnabled(ENABLE_TOWER_BACKDOOR_PROTECTION)

	gamemode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
	gamemode:SetGoldSoundDisabled(DISABLE_GOLD_SOUNDS)
	--gamemode:SetRemoveIllusionsOnDeath(REMOVE_ILLUSIONS_ON_DEATH) -- Didnt work last time I tried

	gamemode:SetAlwaysShowPlayerInventory(SHOW_ONLY_PLAYER_INVENTORY)
	--gamemode:SetAlwaysShowPlayerNames(true) -- use this when you need to hide real hero names
	gamemode:SetAnnouncerDisabled(DISABLE_ANNOUNCER)

	if FORCE_PICKED_HERO then -- FORCE_PICKED_HERO must be a string name of an existing hero, or there will be a big fat error
		gamemode:SetCustomGameForceHero(FORCE_PICKED_HERO) -- THIS WILL NOT WORK when "EnablePickRules" is "1" in 'addoninfo.txt' !
	else
		gamemode:SetDraftingHeroPickSelectTimeOverride(HERO_SELECTION_TIME)
		gamemode:SetDraftingBanningTimeOverride(0)
		if ENABLE_BANNING_PHASE then
			gamemode:SetDraftingBanningTimeOverride(BANNING_PHASE_TIME)
			GameRules:SetCustomGameBansPerTeam(5)
		end
	end

	--gamemode:SetFixedRespawnTime(FIXED_RESPAWN_TIME) -- FIXED_RESPAWN_TIME should be float
	gamemode:SetFountainConstantManaRegen(FOUNTAIN_CONSTANT_MANA_REGEN)
	gamemode:SetFountainPercentageHealthRegen(FOUNTAIN_PERCENTAGE_HEALTH_REGEN)
	gamemode:SetFountainPercentageManaRegen(FOUNTAIN_PERCENTAGE_MANA_REGEN)
	gamemode:SetLoseGoldOnDeath(LOSE_GOLD_ON_DEATH)
	gamemode:SetMaximumAttackSpeed(MAXIMUM_ATTACK_SPEED)
	gamemode:SetMinimumAttackSpeed(MINIMUM_ATTACK_SPEED)
	gamemode:SetStashPurchasingDisabled(DISABLE_STASH_PURCHASING)

	if USE_DEFAULT_RUNE_SYSTEM then
		gamemode:SetUseDefaultDOTARuneSpawnLogic(true)
	else
		-- Some runes are broken by Valve, RuneSpawnFilter also didn't work last time I tried
		for rune, spawn in pairs(ENABLED_RUNES) do
			gamemode:SetRuneEnabled(rune, spawn)
		end
		gamemode:SetBountyRuneSpawnInterval(BOUNTY_RUNE_SPAWN_INTERVAL)
		gamemode:SetPowerRuneSpawnInterval(POWER_RUNE_SPAWN_INTERVAL)
	end

	gamemode:SetUnseenFogOfWarEnabled(USE_UNSEEN_FOG_OF_WAR)
	gamemode:SetDaynightCycleDisabled(DISABLE_DAY_NIGHT_CYCLE)
	gamemode:SetKillingSpreeAnnouncerDisabled(DISABLE_KILLING_SPREE_ANNOUNCER)
	gamemode:SetStickyItemDisabled(DISABLE_STICKY_ITEM)
	gamemode:SetPauseEnabled(ENABLE_PAUSING)
	gamemode:SetCustomScanCooldown(CUSTOM_SCAN_COOLDOWN)
	gamemode:SetCustomGlyphCooldown(CUSTOM_GLYPH_COOLDOWN)
	gamemode:DisableHudFlip(FORCE_MINIMAP_ON_THE_LEFT)

	--gamemode:SetFreeCourierModeEnabled(true) -- without this, passive GPM doesn't work, Thanks Valve
	--gamemode:SetUseTurboCouriers(true)
	--gamemode:SetGiveFreeTPOnDeath(false) -- disables free tp scroll on death
	--gamemode:SetTPScrollSlotItemOverride(itemname) -- replace tp scroll slot with something else
	--gamemode:SetSelectionGoldPenaltyEnabled(false) -- disables hero selection penalty

	-- TO TEST:
	--gamemode:SetAllowNeutralItemDrops(false) -- disables neutral items from dropping?
	--gamemode:SetCanSellAnywhere(true) -- global shop?
	--gamemode:SetFriendlyBuildingMoveToEnabled(true) -- maybe enables rightclicking friendly buildings without meepmeep invulnerable warning
	--gamemode:SetKillableTombstones(true) -- drops tombstone on death or useless?
	--gamemode:SetNeutralItemHideUndiscoveredEnabled(true) -- undiscovered items in the neutral item stash are hidden.
	--gamemode:SetNeutralStashTeamViewOnlyEnabled(true) -- the all neutral items tab cannot be viewed? you can't see all neutrals but only found?
	--gamemode:SetRandomHeroBonusItemGrantDisabled(false) -- enables faerie fire and mango maybe when randoming
end
