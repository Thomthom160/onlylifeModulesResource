local societylsdmoney = 0

local function RefreshMoney()
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
        societylsdmoney = money
    end, 'lsd')
end


local OnlyLife = {}
OnlyLife.Client = {}
OnlyLife.Client.Cooldown = false
OnlyLife.Client.Boss_Menu = RageUI.CreateMenu("Actions Patron", "lsd")
OnlyLife.Client.Boss_Menu.Closed = function()
        OnlyLife.Client.open = false
        FreezeEntityPosition(PlayerPedId(), false)
end

function OnlyLife.Client:OpenBossMenu()
    if OnlyLife.Client.open then
        OnlyLife.Client.open = false
        RageUI.Visible(OnlyLife.Client.Boss_Menu, false)
        return
    else
		OnlyLife.Client.open = true
        RageUI.Visible(OnlyLife.Client.Boss_Menu, true)
		RefreshMoney()

		Citizen.CreateThread(function()
            while OnlyLife.Client.open do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(OnlyLife.Client.Boss_Menu, function()
                    RageUI.Button("Argent de la société :", nil, { RightLabel = "$" .. societylsdmoney }, true, {})
					RageUI.Button("Retirer l'argent de la société", nil, { RightLabel = "" }, true, {
						onSelected = function ()
							local amount = KeyboardInput("Montant", "", 10)
							amount = tonumber(amount)
							if amount == nil then
								RageUI.Popup({ message = "Montant présenté invalide" })
							else
								TriggerServerEvent('esx_society:withdrawMoney', 'lsd', amount)
								RefreshMoney()
							end
						end
					})
					RageUI.Button("Déposer l'argent de la société", nil, { RightLabel = "" }, true, {
						onSelected = function ()
							local amount = KeyboardInput("Montant", "", 10)
							amount = tonumber(amount)
							if amount == nil then
								RageUI.Popup({ message = "Montant présenté invalide" })
							else
								TriggerServerEvent('esx_society:depositMoney', 'lsd', amount)
								RefreshMoney()
							end
						end
					})
                end)
                Wait(1)
            end
        end)
	end
end



local isInBossMenu = false
local function onEnter(self)
	isInBossMenu = (ESX.PlayerData.job and ESX.PlayerData.job.name == self.job and ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job2 and ESX.PlayerData.job2.name == self.job and ESX.PlayerData.job2.grade_name == 'boss')
	Citizen.CreateThread(function()
		while isInBossMenu do
			DrawMarker(self.Marker.Type, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, self.Marker.Taille, self.Marker.Taille, self.Marker.Taille, self.Marker.r, self.Marker.g, self.Marker.b, 170, 0, 1, 2, 0, nil, nil, 0)
			local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, self.coords.x, self.coords.y, self.coords.z)
			if dist3 <= 1.5 then
				ESX.ShowHelpNotification('Appuyez sur ~INPUT_PICKUP~ pour ouvrir le coffre d\'argent', false, false)
				if IsControlJustPressed(1,51) then
					OnlyLife.Client:OpenBossMenu()
	  			end
			end
			Citizen.Wait(0)
		end	
	end)
end
local function onExit(self)
	isInBossMenu = false
end

lib.zones.sphere({
	coords = vector3(452.6189, -1318.2036, 29.4324),
	radius = 6,
	onEnter = onEnter,
	onExit = onExit,
	Marker = { Type = 6, r = 117, g = 117, b = 117, Taille = 1.2 },
	job = 'lsd'
})