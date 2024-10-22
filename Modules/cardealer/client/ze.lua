ESX = exports["es_extended"]:getSharedObject()

huid_conc = {
    catevehi = {},
    listecatevehi = {},
}
huid_catalog = {
    catevehi = {},
    listecatevehi = {},
}




local vehicleentity
local cam, cam2      = nil, nil
local isCameraActive = false
local heading        = 90.0
local zoomOffset     = 0.0
local camOffset      = 0.0

function Catalog()
    local MConcess = OnlylifeUI.CreateMenu("Menu", "Concessionnaire")
    local MConcessSub = OnlylifeUI.CreateSubMenu(MConcess, "Menu", "Concessionnaire")
    local MConcessSub1 = OnlylifeUI.CreateSubMenu(MConcess, "Menu", "Concessionnaire")

    OnlylifeUI.Visible(MConcess, not OnlylifeUI.Visible(MConcess))
    while MConcess do
        Wait(0)
        OnlylifeUI.IsVisible(MConcess, true, true, true, function()
            OnlylifeUI.ButtonWithStyle("Liste des véhicules", nil, { RightLabel = "→" }, true,
                function(Hovered, Active, Selected)
                end, MConcessSub)
        end, function()
        end)

        OnlylifeUI.IsVisible(MConcessSub, true, true, true, function()
            for i = 1, #huid_catalog.catevehi, 1 do
                OnlylifeUI.ButtonWithStyle("Catégorie - " .. huid_catalog.catevehi[i].label, nil,
                    { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            nomcategorie = huid_catalog.catevehi[i].label
                            categorievehi = huid_catalog.catevehi[i].name
                            ESX.TriggerServerCallback('Onlylife_Conces:recupererlistevehicule', function(listevehi)
                                huid_catalog.listecatevehi = listevehi
                            end, categorievehi)
                        end
                    end, MConcessSub1)
            end
        end, function()
        end)

        OnlylifeUI.IsVisible(MConcessSub1, true, true, true, function()
            for i2 = 1, #huid_catalog.listecatevehi, 1 do
                local newprice = ESX.Math.Round(huid_catalog.listecatevehi[i2].price * 1.1)
                OnlylifeUI.ButtonWithStyle(huid_catalog.listecatevehi[i2].name, nil, { RightLabel = ">" }, true,
                    function(Hovered, Active, Selected)
                        if (Selected) then
                            local intnew = math.random(1, 63)
                            TriggerServerEvent('catalog:set', intnew * 13, true)
                            ESX.Game.SpawnLocalVehicle(huid_catalog.listecatevehi[i2].model, {
                                x = PDM.pos.ShowCars.x,
                                y = PDM.pos.ShowCars.y,
                                z = PDM.pos.ShowCars.z
                            }, PDM.pos.ShowCars.h, function(vehicle)
                                if vehicleentity ~= nil then
                                    DeleteEntity(vehicleentity)
                                end
                                cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 167.91, -1104.08, 29.2, 0.33, 0.00,
                                    0.00, 70.00, false, 0)
                                SetCamActive(cam, true)
                                PointCamAtEntity(cam, vehicle, 0.0, 0.0, 0.0, true)
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



        if not OnlylifeUI.Visible(MConcess) and not OnlylifeUI.Visible(MConcessSub) and not OnlylifeUI.Visible(MConcessSub1) then
            TriggerServerEvent('catalog:set', 0, false)
            for i2 = 1, #huid_catalog.listecatevehi, 1 do
                if huid_catalog.listecatevehi[i2].model and vehicleentity >= 0 then
                    DeleteEntity(vehicleentity)
                end
            end
            SetCamActive(cam, false)
            RenderScriptCams(false, false, 1, true, true)
            DestroyCam(cam, true)
            FreezeEntityPosition(PlayerId(), false)
            MConcess = RMenu:DeleteType("MConcess", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, PDM.pos.Catalog.x, PDM.pos.Catalog.y,
            PDM.pos.Catalog.z)
        if dist3 <= 7.0 and PDM.jeveuxmarker then
            Timer = 0
            DrawMarker(6, PDM.pos.Catalog.x, PDM.pos.Catalog.y, PDM.pos.Catalog.z - 1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0,
                0.6, 0.6, 0.6, 38, 154, 205, 150, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 0.8 then
            Timer = 0
            ESX.Game.Utils.DrawText3D(vector3(-43.0803, -1090.4072, 27.2744),
                'Appuyer sur ~b~E~s~ pour ~b~regarder le catalogue~s~', 0.5)
            if IsControlJustPressed(1, 51) then
                ESX.TriggerServerCallback('Onlylife_Conces:recuperercategorievehicule', function(catevehi)
                    huid_catalog.catevehi = catevehi
                end)
                Catalog()
            end
        end
        Citizen.Wait(Timer)
    end
end)
