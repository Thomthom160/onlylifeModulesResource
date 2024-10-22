ESX = exports["es_extended"]:getSharedObject()

local bagonhead = false
local enabled = false
local bag = nil
local isdead = false

RegisterCommand("bags", function(source, args, raw)
local player, distance = ESX.Game.GetClosestPlayer()
local idkurwy = GetPlayerServerId(GetPlayerIndex())
	if not isdead then
		if distance ~= -1 and distance <= 1.0 then
			exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:check', GetPlayerServerId(player), idkurwy)
		else
			if bagonhead and not IsPedCuffed(PlayerPedId()) then
				bagonhead = false
				TriggerEvent('atlantisHeadbag:display', false)
				exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:item', 'give')
			end
		end
	end
end, false)

RegisterNetEvent('atlantisHeadbag:checkthiskurwe')
AddEventHandler('atlantisHeadbag:checkthiskurwe', function(chujmnieobchodzitojebaneid)
local ktokurwa = chujmnieobchodzitojebaneid
	if bagonhead then
		bagonhead = false
		TriggerEvent('atlantisHeadbag:display', false)
		exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:itemhuj', ktokurwa, 'give')
	end
end)

RegisterNetEvent('atlantisHeadbag:checkplayers')
AddEventHandler('atlantisHeadbag:checkplayers', function()
local player, distance = ESX.Game.GetClosestPlayer()
local idkurwy = GetPlayerServerId(GetPlayerIndex())
	if distance ~= -1 and distance <= 1.0 then
		if not IsPedSprinting(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedRunning(PlayerPedId()) then
			exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:setbagon', GetPlayerServerId(player), idkurwy)
		end
	else
		ESX.ShowNotification('Aucun joueur autour.')
	end
end)

RegisterNetEvent('atlantisHeadbag:setbag')
AddEventHandler('atlantisHeadbag:setbag', function(idkurwy)
local _idkurwy = idkurwy
	if bagonhead then
		bagonhead = false
		TriggerEvent('atlantisHeadbag:display', false)
		exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:itemhuj', _idkurwy, 'give')
		exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:woreknaleb', _idkurwy, 0)
	else
		bagonhead = true
		TriggerEvent('atlantisHeadbag:display', true)
		exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:itemhuj', _idkurwy, 'remove')
		exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:woreknaleb', _idkurwy, 1)
	end
end)

RegisterNetEvent('atlantisHeadbag:kurwodajitem')
AddEventHandler('atlantisHeadbag:kurwodajitem', function(gowno)
	local co = gowno
		if co == 'give' then
			exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:item', 'give')
		elseif co == 'remove' then
			exports["WaveShield"]:TriggerServerEvent('atlantisHeadbag:item', 'remove')
		end
end)

RegisterNetEvent('atlantisHeadbag:display')
AddEventHandler('atlantisHeadbag:display', function(value)
	if value == true then
    bag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
		enabled = true
	elseif value == false then
		DeleteEntity(bag)
		SetEntityAsNoLongerNeeded(bag)
		enabled = false
	end
  SendNUIMessage({
    display = enabled
  })
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		if bagonhead then
			if IsPedSprinting(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedJumping(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedInMeleeCombat(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
			if IsPedHurt(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			end
		end
	end
end)

AddEventHandler('playerSpawned', function()
	bagonhead = false
	isdead = false
	DeleteEntity(bag)
	SetEntityAsNoLongerNeeded(bag)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isdead = true
	  SendNUIMessage({
    display = false
  })
end)