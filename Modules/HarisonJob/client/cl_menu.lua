ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
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

local open = false
local harinsonMain2 = RageUI.CreateMenu('Harinson', ' ')
local subMenu5 = RageUI.CreateSubMenu(harinsonMain2, "Annonces", " ")
harinsonMain2.Display.Header = true
harinsonMain2.Closed = function()
	open = false
end

function OpenMenuharinson()
	if open then
		open = false
		RageUI.Visible(harinsonMain2, false)
		return
	else
		open = true
		RageUI.Visible(harinsonMain2, true)
		CreateThread(function()
			while open do
				RageUI.IsVisible(harinsonMain2, function()
					RageUI.Separator("~b~↓ Annonces ↓")
					RageUI.Button("Annonces", nil, { RightLabel = "→→" }, true, {
						onSelected = function()
						end
					}, subMenu5)


					RageUI.Separator("~b~↓ Facture ↓")
					RageUI.Button("Faire une Facture", nil, { RightLabel = "→→" }, true, {
						onSelected = function()
							OpenBillingMenu2()
							RageUI.CloseAll()
						end
					})
				end)

				RageUI.IsVisible(subMenu5, function() --Annonces
					RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, { RightLabel = "→" }, true, {
						onSelected = function()
							exports["WaveShield"]:TriggerServerEvent('Ouvre:harinson')
						end
					})

					RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, { RightLabel = "→" }, true, {
						onSelected = function()
							exports["WaveShield"]:TriggerServerEvent('Ferme:harinson')
						end
					})
				end)
				Wait(0)
			end
		end)
	end
end

function OpenBillingMenu2() -- Facture
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'billing',
		{
			title = "Facture"
		},
		function(data, menu)
			local amount = tonumber(data.value)
			local player, distance = ESX.Game.GetClosestPlayer()

			if player ~= -1 and distance <= 3.0 then
				menu.close()
				if amount == nil then
					ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
				else
					local playerPed = PlayerPedId()
					TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
					Citizen.Wait(5000)
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_harinson', ('Harinson & Associés'),
						amount)
					ClearPedTasksImmediately(PlayerPedId())
					ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
				end
			else
				ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end


AddEventHandler('harinson:openmenu', function(type, data)
	OpenMenuharinson()
end)