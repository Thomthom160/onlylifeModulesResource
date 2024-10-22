ESX = exports["es_extended"]:getSharedObject()

local NextAction = GetGameTimer()

CreateThread(function()
    while ESX == nil do
        Citizen.Wait(50)
    end
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 303) and IsInputDisabled(2) then
            ToggleVehicleLock()
        end
    end
end)

function ToggleVehicleLock(targetVeh)
    if GetGameTimer() < NextAction then return end
    local playerPed = PlayerPedId(-1)
    local vehicle = targetVeh or ESX.Game.GetClosestVehicle()
    PlayKeyAnimation()
    ESX.TriggerServerCallback('carlock:isVehicleOwner', function(isOwnedVehicle)
        if isOwnedVehicle then
            --local lockStatus = GetVehicleDoorLockStatus(vehicle)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            if GetLabelText(vehicleLabel) ~= 'NULL' then vehicleLabel = GetLabelText(vehicleLabel) end
            ESX.TriggerServerCallback('carlock:lockVehicle', function(is_locked)
                if is_locked then
                    Entity(vehicle).state.ignoreLocks = true
                    PlaySoundFromEntity(-1, "Remote_Control_Open", playerPed, "PI_Menu_Sounds", true, 0)
                    ESX.ShowNotification('Vous avez ~r~verrouillé~s~ votre ~y~' .. vehicleLabel)
                    PlayVehicleDoorCloseSound(vehicle, 0)
                    StartVehicleHorn(vehicle, 100, 1, true)
                    Wait(200)
                    SetVehicleLights(vehicle, 2)
                    Wait(200)
                    SetVehicleLights(vehicle, 0)
                    Wait(400)
                else
                    Entity(vehicle).state.ignoreLocks = true
                    PlaySoundFromEntity(-1, "Remote_Control_Close", playerPed, "PI_Menu_Sounds", true, 0)
                    ESX.ShowNotification('Vous avez ~g~déverrouillé~s~ votre ~y~' .. vehicleLabel)
                    StartVehicleHorn(vehicle, 100, 0, false)
                    PlayVehicleDoorOpenSound(vehicle, 0)
                    SetVehicleLights(vehicle, 2)
                    Wait(200)
                    SetVehicleLights(vehicle, 0)
                    Wait(200)
                    SetVehicleLights(vehicle, 2)
                    Wait(400)
                    SetVehicleLights(vehicle, 0)
                end
                NextAction = GetGameTimer() + 500 -- Anti spam
            end, NetworkGetNetworkIdFromEntity(vehicle))
        end
    end, GetVehicleNumberPlateText(vehicle))
end

exports('ToggleVehicleLock', ToggleVehicleLock)

function PlayKeyAnimation()
    CreateThread(function()
        local dict = "anim@mp_player_intmenu@key_fob@"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(playerCoords)
        local isNetwork = closestPlayer > 0 and closestDistance < 10.0
        local vehicleKeys = CreateObject(`prop_cuff_keys_01`, playerCoords.x, playerCoords.y, playerCoords.z, isNetwork,
            false, false)
        AttachEntityToEntity(vehicleKeys, playerPed, GetPedBoneIndex(playerPed, 57005), 0.11, 0.03, -0.03, 90.0, 0.0, 0.0,
            true, true, false, true, 1, true)
        TaskPlayAnim(playerPed, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

        Citizen.Wait(1500)

        DeleteEntity(vehicleKeys)
    end)
end
