ESX = exports["es_extended"]:getSharedObject()
local oxInv = exports.ox_inventory

local hookId = oxInv:registerHook('swapItems', function(payload)
	local xPlayer = ESX.GetPlayerFromId(payload.source)
	if xPlayer == nil then return end
	local str = ''
	local data = {}
	local targetPlyIdentifier = nil

	if payload.fromInventory == payload.toInventory then return end
	if payload.fromInventory == payload.source then
		str = str .. '[' .. payload.source .. '] ' .. xPlayer.getName() .. ' à déposer '
		table.insert(data, {['from'] = xPlayer.getIdentifier()})
		if payload.toType == 'player' then
			local xTarget = ESX.GetPlayerFromId(payload.toInventory)
			str = str ..'dans l\'inventaire de ' ..'[' .. payload.toInventory .. '] ' .. xTarget.getName() .. ' ' .. payload.count ..' '.. payload.fromSlot.name
			table.insert(data, {['to'] = xTarget.getIdentifier()})
			targetPlyIdentifier = xTarget.getIdentifier()
		elseif payload.toType == 'stash' then
			str = str .. 'dans le coffre ' .. payload.toInventory .. ' ' .. payload.count ..' '.. payload.fromSlot.name
		elseif payload.toType == 'glovebox' then
			str = str .. 'dans la boite à gant du véhicule ' .. string.gsub(payload.toInventory, 'glove', '') .. ' ' .. payload.count ..' '.. payload.fromSlot.name
		elseif payload.toType == 'trunk' then
			str = str .. 'dans le coffre du véhicule ' .. string.gsub(payload.toInventory, 'trunk', '') .. ' ' .. payload.count ..' '.. payload.fromSlot.name
		elseif payload.toType == 'drop' then
			str = str .. 'au sol ' .. payload.count ..' ' .. payload.fromSlot.name
		else
			str = json.encode(payload)
		end
		MySQL.Async.insert('INSERT INTO `ox_inventory_logs` (byIdentifier, fromInventory, toInventory, quantity, itemName, isTypeGive) VALUES (?, ?, ?, ?, ?, ?)',{
			xPlayer.getIdentifier(), xPlayer.getIdentifier(), (targetPlyIdentifier or payload.toInventory), payload.count, payload.fromSlot.name, (payload.action == 'give')
		}, function(id) end)

	elseif payload.toInventory == payload.source then
		str = str .. '[' .. payload.source .. '] ' .. xPlayer.getName() .. ' à pris '
		table.insert(data, {['to'] = xPlayer.getIdentifier()})
		if payload.fromType == 'player' then
			local xTarget = ESX.GetPlayerFromId(payload.fromInventory)
			str = str ..'dans l\'inventaire de ' ..'[' .. payload.fromInventory .. '] ' .. xTarget.getName() .. ' ' .. payload.count ..' '.. payload.fromSlot.name
			table.insert(data, {['from'] = xTarget.getIdentifier()})
			targetPlyIdentifier = xTarget.getIdentifier()
		elseif payload.fromType == 'stash' then
			str = str .. 'dans le coffre ' .. payload.fromInventory .. ' ' .. payload.count .. payload.fromSlot.name
		elseif payload.fromType == 'glove' then
			str = str .. 'dans la boite à gant du véhicule ' .. string.gsub(payload.fromInventory, 'glove', '') .. ' ' .. payload.count ..' '.. payload.fromSlot.name
		elseif payload.fromType == 'trunk' then
			str = str .. 'dans le coffre du véhicule ' .. string.gsub(payload.fromInventory, 'trunk', '') .. ' ' .. payload.count ..' '.. payload.fromSlot.name
		elseif payload.fromType == 'drop' then
			str = str .. 'au sol ' .. payload.count ..' '.. payload.fromSlot.name
		else
			str = json.encode(payload)
		end

		MySQL.Async.insert('INSERT INTO `ox_inventory_logs` (byIdentifier, fromInventory, toInventory, quantity, itemName, isTypeGive) VALUES (?, ?, ?, ?, ?, ?)',{
			xPlayer.getIdentifier(), (targetPlyIdentifier or payload.fromInventory), xPlayer.getIdentifier(), payload.count, payload.fromSlot.name, (payload.action == 'give')
		}, function(id) end)
	end
	if payload.action == 'give' then
		str = str .. ' *quantité fause'
	end
	exports['esx_discord_bot']:inventoryLogs("https://discord.com/api/webhooks/1120751320916312106/JQ_T--z1RFok9oesukm9AInNiP-o4f9t6Fug4n_XyhAZ4EKFg1NCZUGeVFnT3OETagRW", str, data)
	--print(str)
	--print(json.encode(data, { indent = true }))

end)

local hookId2 = oxInv:registerHook('createItem', function(payload)
	local str = ''
	if type(payload.inventoryId) ~= "number" then return end
	local xPlayer = ESX.GetPlayerFromId(payload.inventoryId)
	if xPlayer == nil then return end
	str = '['..payload.inventoryId..'] '..xPlayer.getName()..' à reçu '..payload.count..' '..payload.item.name
	exports['esx_discord_bot']:inventoryLogs("https://discord.com/api/webhooks/1120751320916312106/JQ_T--z1RFok9oesukm9AInNiP-o4f9t6Fug4n_XyhAZ4EKFg1NCZUGeVFnT3OETagRW", str, {{['to'] = xPlayer.getIdentifier()}})

	MySQL.Async.insert('INSERT INTO `ox_inventory_logs` (byIdentifier, fromInventory, toInventory, quantity, itemName, isTypeGive) VALUES (?, ?, ?, ?, ?, ?)',{
		xPlayer.getIdentifier(), 'GiveItem', xPlayer.getIdentifier(), payload.count, payload.item.name, false
	}, function(id) end)
	--print(str)
end)

local hookId3 = oxInv:registerHook('craftItem', function(payload)
	local xPlayer = ESX.GetPlayerFromId(payload.source)
	if xPlayer == nil then return end
	local ingredient = ''
	for k, v in pairs(payload.recipe.ingredients) do
		ingredient = ingredient .. string.format('%d %s, ', v, k)
	end
	ingredient = ingredient:sub(1, -3)
	local str = string.format('[%s] %s à craft %s et à reçu %d %s', payload.source, xPlayer.getName(), ingredient, payload.recipe.count, payload.recipe.name)
	local data = {{['license'] = xPlayer.getIdentifier()}}
	MySQL.Async.insert('INSERT INTO `ox_inventory_craft_logs` (byIdentifier, toInventory, quantity, itemName, ingredients) VALUES (?, ?, ?, ?, ?)',{
		xPlayer.getIdentifier(), xPlayer.getIdentifier(), payload.recipe.count, payload.recipe.name, json.encode(payload.recipe.ingredients)
	}, function(id) end)

	exports['esx_discord_bot']:inventoryLogs("https://discord.com/api/webhooks/1237928668508979300/6SdWuzOyRFYGh4DjNwETm6uVSUt-jxW0v0MZa7RH_0aGpeeGWySvt3sy-sdHfblUlnEU", str, data)

end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		oxInv:removeHooks(hookId)
		oxInv:removeHooks(hookId2)
		oxInv:removeHooks(hookId3)
	end
end)