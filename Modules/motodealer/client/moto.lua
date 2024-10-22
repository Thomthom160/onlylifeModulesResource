ESX                  = exports["es_extended"]:getSharedObject()

Onlylife_bikedealer  = {
    catevehi = {
        {
            name = "motorcycles",
            label = "Moto"
        },
        {
            name = "velo",
            label = "Vélo"
        }
    },
    listecatevehi = {}
}

local vehicleentity
local cam2           = nil
local isCameraActive = false
local heading        = 90.0
local zoomOffset     = 0.0
local camOffset      = 0.0

function Catalog2()
    local Sanders = OnlylifeUI.CreateMenu("Moto", "Moto")
    local SanderssSub = OnlylifeUI.CreateSubMenu(Sanders, "Moto", "Moto")
    local SanderssSub1 = OnlylifeUI.CreateSubMenu(Sanders, "Moto", "Moto")

    OnlylifeUI.Visible(Sanders, not OnlylifeUI.Visible(Sanders))
    while Sanders do
        Wait(0)
        OnlylifeUI.IsVisible(Sanders, true, true, true, function()
            OnlylifeUI.ButtonWithStyle("Liste des véhicules", nil, { RightLabel = "→" }, true,
                function(Hovered, Active, Selected)
                end, SanderssSub)
        end, function()
        end)

        OnlylifeUI.IsVisible(SanderssSub, true, true, true, function()
            for i = 1, #Onlylife_bikedealer.catevehi, 1 do
                --if Onlylife_bikedealer.catevehi[i].name ~= "motorcycles" then
                OnlylifeUI.ButtonWithStyle("Catégorie - " .. Onlylife_bikedealer.catevehi[i].label, nil,
                    { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        nomcategorie = Onlylife_bikedealer.catevehi[i].label
                        categorievehi = Onlylife_bikedealer.catevehi[i].name
                        ESX.TriggerServerCallback('Onlylife_Sanders:recupererlistevehicule', function(listevehi)
                            Onlylife_bikedealer.listecatevehi = listevehi
                        end, categorievehi)
                    end
                end, SanderssSub1)
            end
            --    end
        end, function()
        end)

        OnlylifeUI.IsVisible(SanderssSub1, true, true, true, function()
            for i2 = 1, #Onlylife_bikedealer.listecatevehi, 1 do
                local newprice = ESX.Math.Round(Onlylife_bikedealer.listecatevehi[i2].price * 1.1)
                OnlylifeUI.ButtonWithStyle(Onlylife_bikedealer.listecatevehi[i2].name, nil, { RightLabel = ">" }, true,
                    function(Hovered, Active, Selected)
                        if (Selected) then
                            local intnew = math.random(1, 63)
                            TriggerServerEvent('catalog:set', intnew * 13, true)
                            ESX.Game.SpawnLocalVehicle(Onlylife_bikedealer.listecatevehi[i2].model,
                                {                                                                             -- --413.1593, 6157.6460, 30.9452, 43.9325
                                    x = -413.1593,
                                    y = 6157.6460,
                                    z = 30.9452
                                }, 43.9325, function(vehicle)
                                if vehicleentity ~= nil then
                                    DeleteEntity(vehicleentity)
                                end
                                cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -412.1095, 6158.6646, 32.4753, 0.33,
                                    0.00, 0.00, 70.00, false, 0)
                                SetCamActive(cam2, true)
                                PointCamAtEntity(cam2, vehicle, 0.0, 0.0, 0.0, true)
                                RenderScriptCams(true, false, 1, true, true)
                                FreezeEntityPosition(PlayerId(), true)
                                vehicleentity = vehicle
                                TaskWarpPedIntoVehicle(playerPed, vehicle, 1)
                                FreezeEntityPosition(vehicle, true)
                            end)
                        end
                    end)
            end
        end, function()
        end)



        if not OnlylifeUI.Visible(Sanders) and not OnlylifeUI.Visible(SanderssSub) and not OnlylifeUI.Visible(SanderssSub1) then
            TriggerServerEvent('catalog:set', 0, false)
            for i2 = 1, #Onlylife_bikedealer.listecatevehi, 1 do
                if Onlylife_bikedealer.listecatevehi[i2].model and vehicleentity >= 0 then
                    DeleteEntity(vehicleentity)
                end
            end
            SetCamActive(cam2, false)
            RenderScriptCams(false, false, 1, true, true)
            DestroyCam(cam2, true)
            FreezeEntityPosition(PlayerId(), false)
            Sanders = RMenu:DeleteType("Sanders", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vector3(-409.2535, 6162.8877, 31.4753))
        if dist3 <= 7.0 and Sanders.jeveuxmarker then
            Timer = 0
            DrawMarker(6, vector3(-409.2535, 6162.8877, 31.4753 - 1), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.6, 0.6, 0.6, 38,
                154, 205, 150, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 0.8 then
            Timer = 0
            ESX.Game.Utils.DrawText3D(vector3(-409.2535, 6162.8877, 31.4753),
                'Appuyer sur ~b~E~s~ pour ~b~regarder le catalogue~s~', 0.5)
            if IsControlJustPressed(1, 51) then
                Catalog2()
            end
        end
        Citizen.Wait(Timer)
    end
end)
