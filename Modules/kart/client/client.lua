ESX = exports["es_extended"]:getSharedObject()



local haveKart = 0

local kart = 0



local cars = 'veto2'



local rentpoint = vector3(-161.89416503906, -2134.3852539062, 16.705030441284)

local returnpoint = vector3(-160.38623046875, -2137.6467285156, 16.705018997192)

local spawnpoint = vector3(-160.31, -2143.92, 15.84)

local areapoint = vector3(-85.162, -2067.108, 21.797)

local areazone = 175



-- 

Citizen.CreateThread(function()

	local w = 150

	while true do

		Wait(w)

		local coords = GetEntityCoords(PlayerPedId())

		if haveKart == 0 and #(coords - rentpoint) < 15 then

			w = 0

			DrawMarker(36, rentpoint.x, rentpoint.y, rentpoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 255, 68, 255, false, true, 2, false, false, false, false)

			if #(coords - rentpoint) < 1.5 then

				ESX.ShowHelpNotification('Appuis ~INPUT_CONTEXT~ pour louer un kart à ~y~100$~s~')

				if IsControlJustPressed(0, 38) then

					spawnCar(cars)

					exports["WaveShield"]:TriggerServerEvent('huid_kart:cobro')

					haveKart = 1

				end 

			end 

		else

			if w ~= 150 then w = 150 end

		end

	end

end)



Citizen.CreateThread(function()

	local w = 150

	while true do

		Wait(w)

		local coords = GetEntityCoords(PlayerPedId())

		if haveKart == 1 and #(coords - returnpoint) < 10 then

			w = 0

			DrawMarker(27, returnpoint.x, returnpoint.y, returnpoint.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)

			if #(coords - returnpoint) < 1.5 then

				ESX.ShowHelpNotification('Appuis sur ~INPUT_CONTEXT~ pour rendre le kart')

				if IsControlJustPressed(0, 38) then 

					DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))

					haveKart = 0

				end

			end

		else

			if w ~= 150 then w = 150 end

		end

	end

end)



function spawnCar(car)

    local car = GetHashKey(car)



    RequestModel(car)

    while not HasModelLoaded(car) do

        RequestModel(car)

        Wait(1)

    end



    kart = CreateVehicle(car, spawnpoint.x, spawnpoint.y, spawnpoint.z, 286.0, true, false)

    SetEntityAsMissionEntity(kart, true, true)



    TaskWarpPedIntoVehicle(PlayerPedId(), kart, -1)

end



Citizen.CreateThread(

	function()

		while true do

			Wait(3000)

            local coords = GetEntityCoords(PlayerPedId())

			if haveKart == 1 and (#(coords - areapoint) > areazone) then

				ESX.ShowNotification("Tu as 10 secondes pour retourner dans la zone")

				Wait(5000)	

				if #(coords - areapoint) > areazone then

					ESX.ShowNotification("Tu as 5 secondes pour retourner dans la zone")

					Wait(5000)

					if #(coords - areapoint) > areazone then

						ESX.ShowNotification("Ton véhicule est supprimer tu as pris la mauvaise direction!")

						SetEntityAsNoLongerNeeded(kart)

						DeleteEntity(kart)

                    	haveKart = 0

					end

				end

			end

		end

	end

)



Citizen.CreateThread(function()

	local blip = AddBlipForCoord(rentpoint.x, rentpoint.y, rentpoint.z)

	SetBlipSprite(blip , 309)

	SetBlipAsShortRange(blip, true)

	SetBlipColour(blip, 0)

	SetBlipScale(blip, 1.0)

	BeginTextCommandSetBlipName("STRING")

	AddTextComponentString("Karting")

	EndTextCommandSetBlipName(blip)

end)

