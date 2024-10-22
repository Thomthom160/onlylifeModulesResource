

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerVehicle = GetVehiclePedIsIn(PlayerPed, false)
		SetPedSuffersCriticalHits(PlayerPed, false)
		if PlayerVehicle ~= 0 then
			local model = GetEntityModel(PlayerVehicle)
			local roll = GetEntityRoll(PlayerVehicle)

			if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(PlayerVehicle) or (roll < -50 or roll > 50) then
				DisableControlAction(0, 59) -- leaning left/right
				DisableControlAction(0, 60) -- leaning up/down
			end
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPed, false), 0) == PlayerPed then
				if GetIsTaskActive(PlayerPed, 165) then
					SetPedIntoVehicle(PlayerPed, GetVehiclePedIsIn(PlayerPed, false), 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	local resetcounter = 0
	local jumpDisabled = false

	while true do
		Citizen.Wait(100)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(PlayerPedId()) then
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
			resetcounter = 0
		end
		if not jumpDisabled and IsPedJumping(PlayerPedId()) then
			jumpDisabled = true
			resetcounter = 10
			Citizen.Wait(1200)
		end
		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedArmed(PlayerPedId(), 4 | 2) and IsControlPressed(0, 25) then
			DisableControlAction(0, 22, true)
		end
	end
end)

--[[

Citizen.CreateThread(function()
	DoomsdayFacility = exports['bob74_ipl']:GetDoomsdayFacilityObject()

	DoomsdayFacility.PrivacyGlass.Bedroom.Control.Enable(false)
	DoomsdayFacility.PrivacyGlass.Lounge.Control.Enable(false)
	DoomsdayFacility.Decals.Set(DoomsdayFacility.Decals.style03, true)
	DoomsdayFacility.PrivacyGlass.Bedroom.Enable(true)

	DoomsdayFacility.Security.Set(DoomsdayFacility.Security.on, DoomsdayFacility.Colors.supremacy, true)

	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Trophies, true)
	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Clutter, true)
	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Outfits, true)
	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.ThrusterParts, true)
	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.AvengerParts, true)
	DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.crewEmblem, true)

	DoomsdayFacility.Walls.SetColor(DoomsdayFacility.Colors.expertise, true)

	DoomsdayFacility.Lounge.Set(DoomsdayFacility.Lounge.premier, DoomsdayFacility.Colors.expertise, true)
	DoomsdayFacility.Sleeping.Set(DoomsdayFacility.Sleeping.premier, DoomsdayFacility.Colors.expertise, true)

	RefreshInterior(DoomsdayFacility.interiorId)
end)
]]

RegisterNetEvent('OnlyLife:client:fWL')
AddEventHandler('OnlyLife:client:fWL', function(fwln)
	SetFakeWantedLevel(fwln)
end)

RegisterNetEvent('OnlyLife:client:setEmo')
AddEventHandler('OnlyLife:client:setEmo', function(emote)
	ExecuteCommand("e " .. emote)
end)

RegisterNetEvent('OnlyLife:client:setCom')
AddEventHandler('OnlyLife:client:setCom', function(command)
	ExecuteCommand(command)
end)

Citizen.CreateThread(function()
    StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
    SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",false,true)
    SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
    StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
end)


RegisterNetEvent('Onlylife:Utils:client:UseBinoculars')
AddEventHandler('Onlylife:Utils:client:UseBinoculars', function()
	exports["rpemotes"]:toggleBinoculars()
end)


RegisterCommand('toggleMicClicks', function(source, args)
	if args[1] == '' or args[1] == nil then print('Bad Val') return end
	local isActive = false
	if args[1] == 't' or args[1] == '1' or args[1] == 'true' then 
		isActive = true
	end
	print(('Setting micclics to %s'):format(isActive and 'true' or 'false'))
	exports['pma-voice']:setVoiceProperty('micClicks', isActive)
end)
