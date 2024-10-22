ESX = exports["es_extended"]:getSharedObject()

local playerCars = {}

Onlylife_bikedealer = {
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

local BuyBike = {}
local LastBike = {}
local CurrentAction, CurrentActionMsg, LastZone, currentDisplayVehicle, CurrentVehicleData
local CurrentActionData, Vehicles, Categories = {}, {}, {}

Citizen.CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
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

function MenuF6Sanders()
    local f6Sanders = OnlylifeUI.CreateMenu("Sanders", "Interactions")
    OnlylifeUI.Visible(f6Sanders, not OnlylifeUI.Visible(f6Sanders))
    while f6Sanders do
        Citizen.Wait(0)
        OnlylifeUI.IsVisible(f6Sanders, true, true, true, function()
            OnlylifeUI.Separator("↓ Facture ↓")

            OnlylifeUI.ButtonWithStyle("Annonce d'ouverture", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('hSanders:Ouvert')
                end
            end)
            OnlylifeUI.ButtonWithStyle("Annonce de fermeture", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('hSanders:Fermer')
                end
            end)
            OnlylifeUI.ButtonWithStyle("Personnaliser", nil, {
                RightLabel = nil
            }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local msg = KeyboardInput("Message", "", 100)
                    TriggerServerEvent('hSanders:Perso', msg)
                end
            end)

            OnlylifeUI.ButtonWithStyle("Facture", nil, {
                RightLabel = "→"
            }, true, function(_, _, s)
                local player, distance = ESX.Game.GetClosestPlayer()
                if s then
                    local raison = ""
                    local montant = 0
                    AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            raison = result
                            result = nil
                            AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "",
                                "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                result = GetOnscreenKeyboardResult()
                                if result then
                                    montant = result
                                    result = nil
                                    if player ~= -1 and distance <= 3.0 then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player),
                                            'society_bikedealer', ("Sanders"), montant)
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank',
                                            'Facture envoyée : ',
                                            'Vous avez envoyé une facture d\'un montant de : ~g~' .. montant ..
                                            '$ ~s~pour cette raison : ~b~' .. raison .. '', 'CHAR_BANK_FLEECA', 9)
                                    else
                                        ESX.ShowNotification("~b~Probleme~s~: Aucuns joueurs proche")
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end, function()
        end)

        if not OnlylifeUI.Visible(f6Sanders) then
            f6Sanders = RMenu:DeleteType("Sanders", true)
        end
    end
end

RegisterNetEvent("Sanders:openmenu")
AddEventHandler("Sanders:openmenu", function()
    MenuF6Sanders()
end)

function MenuSanders()
    local MSanders = OnlylifeUI.CreateMenu("Sanders", "Intéractions")
    local MSandersSub = OnlylifeUI.CreateSubMenu(MSanders, "Sanders", "Intéractions")
    local MSandersSub1 = OnlylifeUI.CreateSubMenu(MSanders, "Sanders", "Intéractions")
    local MSandersSub2 = OnlylifeUI.CreateSubMenu(MSanders, "Sanders", "Intéractions")
    MSandersSub2.Closed = function()
        supprimervehiculeSanders()
    end
    OnlylifeUI.Visible(MSanders, not OnlylifeUI.Visible(MSanders))
    while MSanders do
        Wait(0)
        OnlylifeUI.IsVisible(MSanders, true, true, true, function()
            OnlylifeUI.Separator("~b~" .. ESX.PlayerData.job.grade_label .. " - " .. GetPlayerName(PlayerId()))
            OnlylifeUI.Separator("↓ Actions véhicules ↓")
            OnlylifeUI.ButtonWithStyle("Liste des véhicules", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
            end, MSandersSub)
        end, function()
        end)

        OnlylifeUI.IsVisible(MSandersSub, true, true, true, function()
            for i = 1, #Onlylife_bikedealer.catevehi, 1 do
                OnlylifeUI.ButtonWithStyle("Catégorie - " .. Onlylife_bikedealer.catevehi[i].label, nil, {
                    RightLabel = "→→→"
                }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        nomcategorie = Onlylife_bikedealer.catevehi[i].label
                        categorievehi = Onlylife_bikedealer.catevehi[i].name
                        ESX.TriggerServerCallback('Onlylife_Sanders:recupererlistevehicule', function(listevehi)
                            Onlylife_bikedealer.listecatevehi = listevehi
                        end, categorievehi)
                    end
                end, MSandersSub1)
            end
        end, function()
        end)

        OnlylifeUI.IsVisible(MSandersSub1, true, true, true, function()
            OnlylifeUI.Separator("↓ Catégorie : " .. nomcategorie .. " ↓")
            for i2 = 1, #Onlylife_bikedealer.listecatevehi, 1 do
                OnlylifeUI.ButtonWithStyle(Onlylife_bikedealer.listecatevehi[i2].name, "Pour acheter ce véhicule", {
                    RightLabel = Onlylife_bikedealer.listecatevehi[i2].price .. "$"
                }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        namebike = Onlylife_bikedealer.listecatevehi[i2].name
                        PriceBike = Onlylife_bikedealer.listecatevehi[i2].price
                        modelbike = Onlylife_bikedealer.listecatevehi[i2].model
                        supprimervehiculeSanders()
                        LoadVehicle(modelbike)
                        ESX.Game.SpawnVehicle(modelbike, {
                            x = -422.05,
                            y = 6149.2,
                            z = 30.99
                        }, 353.6100, function(vehicle)
                            table.insert(LastBike, vehicle)
                            FreezeEntityPosition(vehicle, true)
                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                            SetModelAsNoLongerNeeded(modelbike)
                        end)
                    end
                end, MSandersSub2)
            end
        end, function()
        end)

        OnlylifeUI.IsVisible(MSandersSub2, true, true, true, function()
            OnlylifeUI.Separator("~b~↓ Vendre au joueur le plus proche ↓")
            OnlylifeUI.ButtonWithStyle("Vendre le véhicule", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ESX.TriggerServerCallback('Onlylife_Sanders:GetPlayerIsMoney', function(suffisantsous)
                        if suffisantsous then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Personne autour')
                            else
                                supprimervehiculeSanders()
                                LoadVehicle(modelbike)
                                ESX.Game.SpawnVehicle(modelbike, {
                                    x = -436.84,
                                    y = 6152.36,
                                    z = 30.99
                                }, 78.29, function(vehicle)
                                    table.insert(BuyBike, vehicle)
                                    FreezeEntityPosition(vehicle, true)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                    SetModelAsNoLongerNeeded(modelbike)
                                    local plaque = GeneratePlate()
                                    local vehicleProps = ESX.Game.GetVehicleProperties(BuyBike[#BuyBike])
                                    vehicleProps.plate = plaque
                                    SetVehicleNumberPlateText(BuyBike[#BuyBike], plaque)
                                    FreezeEntityPosition(BuyBike[#BuyBike], false)
                                    TriggerServerEvent('Onlylife_Sanders:vendrevoiturejoueur',
                                        GetPlayerServerId(closestPlayer), vehicleProps, PriceBike, namebike)
                                    TriggerServerEvent('garage:RegisterNewKey', GetPlayerServerId(closestPlayer),
                                        vehicleProps.plate)
                                    ESX.ShowNotification('Le véhicule ' .. namebike .. ' avec la plaque ' ..
                                        vehicleProps.plate .. ' a été vendu à ' ..
                                        GetPlayerName(closestPlayer))
                                end)
                            end
                        else
                            ESX.ShowNotification('La société n\'as pas assez d\'argent pour ce véhicule!')
                        end
                    end, PriceBike)
                    OnlylifeUI.CloseAll()
                end
            end)
        end, function()
        end)

        if not OnlylifeUI.Visible(MSanders) and not OnlylifeUI.Visible(MSandersSub) and
            not OnlylifeUI.Visible(MSandersSub1) and not OnlylifeUI.Visible(MSandersSub2) then
            MSanders = RMenu:DeleteType("MSanders", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bikedealer' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bikedealer' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Sanders.pos.menu.position.x,
                Sanders.pos.menu.position.y, Sanders.pos.menu.position.z)
            if jobdist <= 10.0 and Sanders.MarkerIsVisible then
                Timer = 0
                DrawMarker(20, Sanders.pos.menu.position.x, Sanders.pos.menu.position.y, Sanders.pos.menu.position.z,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if jobdist <= 1.0 then
                Timer = 0
                OnlylifeUI.Text({
                    message = "Appuyez sur ~y~[E]~s~ pour accéder au menu",
                    time_display = 1
                })
                if IsControlJustPressed(1, 51) then
                    MenuSanders()
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

function supprimervehiculeSanders()
    while #LastBike > 0 do
        local vehicle = LastBike[1]

        ESX.Game.DeleteVehicle(vehicle)
        table.remove(LastBike, 1)
    end
end

function LoadVehicle(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        BeginTextCommandBusyString('STRING')
        AddTextComponentSubstringPlayerName('Chargement du véhicule')
        EndTextCommandBusyString(4)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
            DisableAllControlActions(0)
        end

        RemoveLoadingPrompt()
    end
end

