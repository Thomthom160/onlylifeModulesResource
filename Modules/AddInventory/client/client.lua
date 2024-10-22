ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
	Citizen.Wait(10)
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(10)
end)

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end
	if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

RegisterNetEvent('Huid_AddInventory:idcard')
AddEventHandler('Huid_AddInventory:idcard', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
	end
end)

RegisterNetEvent('Huid_AddInventory:idcayocard')
AddEventHandler('Huid_AddInventory:idcayocard', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'cayocard')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'cayocard')
	end
end)


RegisterNetEvent('Huid_AddInventory:permitdriver')
AddEventHandler('Huid_AddInventory:permitdriver', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
	end
end)
RegisterNetEvent('Huid_AddInventory:permitfire')
AddEventHandler('Huid_AddInventory:permitfire', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
	end
end)

RegisterNetEvent('Huid_AddInventory:permithunt')
AddEventHandler('Huid_AddInventory:permithunt', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'hunt')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'hunt')
	end
end)
