local saveAppearance = function ()
	if GetPedDrawableVariation(PlayerPedId(), 1) == 0 then
		TriggerServerEvent('illenium-appearance:server:saveAppearance', exports['illenium-appearance']:getPedAppearance(PlayerPedId()))
	end
end

RegisterNetEvent('clothes:all')
AddEventHandler('clothes:all', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local components = {
		{ component_id = 3,  drawable = metadata.arms,    texture = metadata.arms2 or 0 },
		{ component_id = 4,  drawable = metadata.pant1,   texture = metadata.pant2 or 0 },
		{ component_id = 6,  drawable = metadata.shoes1,  texture = metadata.shoes2 or 0 },
		{ component_id = 7,  drawable = metadata.chain1,  texture = metadata.chain2 or 0 },
		{ component_id = 8,  drawable = metadata.shirt1,  texture = metadata.shirt2 or 0 },
		{ component_id = 9,  drawable = metadata.bproof1, texture = metadata.bproof2 or 0 },
		{ component_id = 10, drawable = metadata.decals1, texture = metadata.decals2 or 0 },
		{ component_id = 11, drawable = metadata.torso1,  texture = metadata.torso2 or 0 },
	}
	exports['illenium-appearance']:setPedComponents(PlayerPedId(), components)
	saveAppearance()
end)

RegisterNetEvent('clothes:tshirt')
AddEventHandler('clothes:tshirt', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local components = {
		{ component_id = 3,  drawable = metadata.arms,    texture = metadata.arms2 or 0 },
		{ component_id = 7,  drawable = metadata.chain1,  texture = metadata.chain2 or 0 },
		{ component_id = 8,  drawable = metadata.shirt1,  texture = metadata.shirt2 or 0 },
		{ component_id = 9,  drawable = metadata.bproof1, texture = metadata.bproof2 or 0 },
		{ component_id = 10, drawable = metadata.decals1, texture = metadata.decals2 or 0 },
		{ component_id = 11, drawable = metadata.torso1,  texture = metadata.torso2 or 0 },
	}
	exports['illenium-appearance']:setPedComponents(PlayerPedId(), components)
	saveAppearance()
end)

RegisterNetEvent('clothes:pant')
AddEventHandler('clothes:pant', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local component = { component_id = 4, drawable = metadata.pant1, texture = metadata.pant2 or 0 }
	--if GetPedDrawableVariation(PlayerPedId(), component.component_id) >= 0 then component.drawable = 0 end
	exports['illenium-appearance']:setPedComponent(PlayerPedId(), component)
	saveAppearance()
end)

RegisterNetEvent('clothes:shoes')
AddEventHandler('clothes:shoes', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local component = { component_id = 6, drawable = metadata.shoes1, texture = metadata.shoes2 or 0 }
	--if GetPedDrawableVariation(PlayerPedId(), component.component_id) > 0 then component.drawable = 0 end
	exports['illenium-appearance']:setPedComponent(PlayerPedId(), component)
	saveAppearance()
end)

RegisterNetEvent('clothes:bags')
AddEventHandler('clothes:bags', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local component = { component_id = 5, drawable = metadata.bag1, texture = metadata.bag2 or 0 }
	if GetPedDrawableVariation(PlayerPedId(), component.component_id) > 0 then
		component.drawable = 0
		component.texture = 0
		TriggerServerEvent('Huid_ClotheShop:EditWeight', false)
	else
		TriggerServerEvent('Huid_ClotheShop:EditWeight', true)
	end
	exports['illenium-appearance']:setPedComponent(PlayerPedId(), component)
	saveAppearance()
end)

RegisterNetEvent('clothes:mask')
AddEventHandler('clothes:mask', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local component = { component_id = 1, drawable = metadata.mask1, texture = metadata.mask2 or 0 }
	if GetPedDrawableVariation(PlayerPedId(), component.component_id) > 0 then component.drawable = 0 end
	exports['illenium-appearance']:setPedComponent(PlayerPedId(), component)
	saveAppearance()
end)

RegisterNetEvent('clothes:bracelet')
AddEventHandler('clothes:bracelet', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local props = {
		{ prop_id = 7, drawable = metadata.bracelet1, texture = metadata.bracelet2 or 0 }
	}
	if GetPedPropIndex(PlayerPedId(), props[1].prop_id) >= 0 then props[1].drawable = -1 end
	exports['illenium-appearance']:setPedProps(PlayerPedId(), props)
	saveAppearance()
end)

RegisterNetEvent('clothes:ears')
AddEventHandler('clothes:ears', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local props = {
		{ prop_id = 2, drawable = metadata.ears1, texture = metadata.ears2 or 0 }
	}
	if GetPedPropIndex(PlayerPedId(), props[1].prop_id) >= 0 then props[1].drawable = -1 end
	exports['illenium-appearance']:setPedProps(PlayerPedId(), props)
	saveAppearance()
end)

RegisterNetEvent('clothes:watche')
AddEventHandler('clothes:watche', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local props = {
		{ prop_id = 6, drawable = metadata.watche1, texture = metadata.watche2 or 0 }
	}
	if GetPedPropIndex(PlayerPedId(), props[1].prop_id) >= 0 then props[1].drawable = -1 end
	exports['illenium-appearance']:setPedProps(PlayerPedId(), props)
	saveAppearance()
end)

RegisterNetEvent('clothes:glasse')
AddEventHandler('clothes:glasse', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local props = {
		{ prop_id = 1, drawable = metadata.glasse1, texture = metadata.glasse2 or 0 }
	}
	if GetPedPropIndex(PlayerPedId(), props[1].prop_id) >= 0 then props[1].drawable = -1 end
	exports['illenium-appearance']:setPedProps(PlayerPedId(), props)
	saveAppearance()
end)

RegisterNetEvent('clothes:cap')
AddEventHandler('clothes:cap', function(item, wait, cb)
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local props = {
		{ prop_id = 0, drawable = metadata.helmet1, texture = metadata.helmet2 or 0 }
	}
	if GetPedPropIndex(PlayerPedId(), props[1].prop_id) >= 0 then props[1].drawable = -1 end
	exports['illenium-appearance']:setPedProps(PlayerPedId(), props)
	saveAppearance()
end)

RegisterCommand('adminbags', function()
	exports["WaveShield"]:TriggerServerEvent('Huid_ClotheShop:Admin')
end, false)




--RegisterCommand('tempTest', function() 
--
--	print(json.encode(exports['illenium-appearance']:getPedProps(PlayerPedId())[5], {indent = true}))
--	--local clothName = lib.inputDialog('Achat de la tenue', {
--	--	{type = 'input', label = 'Nom de la tenue', description = 'Un petit nom pour ta nouvelle tenue', placeholder = 'MaSuperTenueTropBelle', required = true},
--	--	{type = 'number', label = 'Nombre d\'exemplaires', default = 1, step = 1, min = 1, icon = 'hashtag', required = true}
--	--})
--	print(json.encode(clothName))
--	--TriggerServerEvent("clothshop:server:buyClothingItem", {type = 'all', price = 40, components = client.getPedComponents(PlayerPedId()), label = clothName})
--end, false)
--
--
--
--RegisterCommand('tempTry', function()
--	local config = exports['illenium-appearance']:GetDefaultConfig()
--	config.components = true
--	config.props = true
--	config.ped = true
--	--print(json.encode(config, {indent = true}))
--	
--	exports['illenium-appearance']:startPlayerCustomization(function(appearance)
--		if appearance then
--			local temp = {
--				props = appearance.props,
--				components = appearance.components
--			}
--			print(json.encode(temp, {indent = true}))
--			TriggerEvent("illenium-appearance:client:reloadSkin", true)
--		end
--	end, config)
--end, false)