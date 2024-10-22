ESX = exports["es_extended"]:getSharedObject()

Onlylife_Conces = {
    catevehi = {},
    listecatevehi = {}
}

local sortirvoitureacheter = {}
local derniervoituresorti = {}

Citizen.CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()
    while ESX.GetPlayerData().job == nil do
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

function MenuF6Concess()
    local f6concess = OnlylifeUI.CreateMenu("concession", "Interactions")
    OnlylifeUI.Visible(f6concess, not OnlylifeUI.Visible(f6concess))
    while f6concess do
        Citizen.Wait(0)
        OnlylifeUI.IsVisible(f6concess, true, true, true, function()
            OnlylifeUI.Separator("↓ Facture ↓")

            OnlylifeUI.ButtonWithStyle("Annonce d'ouverture", nil, { RightLabel = "→" }, true,
                function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('Onlylife:Cardealer:Announce', 'open')
                    end
                end)

            OnlylifeUI.ButtonWithStyle("Annonce de fermeture", nil, { RightLabel = "→" }, true,
                function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('Onlylife:Cardealer:Announce', 'close')
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
                                            'society_cardealer', ("PDM"), montant)
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank',
                                            'Facture envoyée : ',
                                            'Vous avez envoyé une facture d\'un montant de : ~g~' ..
                                            montant .. '$ ~s~pour cette raison : ~b~' .. raison .. '', 'CHAR_BANK_FLEECA',
                                            9)
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

        if not OnlylifeUI.Visible(f6concess) then
            f6concess = RMenu:DeleteType("concession", true)
        end
    end
end

RegisterNetEvent("OnlyLife:Cardealer:OpenMenu")
AddEventHandler("OnlyLife:Cardealer:OpenMenu", function()
    MenuF6Concess()
end)

function MenuConcess(configIndex)
    local MConcess = OnlylifeUI.CreateMenu("", "Concessionnaire")
    local MConcessSub = OnlylifeUI.CreateSubMenu(MConcess, "", "Concessionnaire")
    local MConcessSub1 = OnlylifeUI.CreateSubMenu(MConcess, "", "Concessionnaire")
    local MConcessSub2 = OnlylifeUI.CreateSubMenu(MConcess, "", "Concessionnaire")
    MConcessSub2.Closed = function()
        supprimervehiculeconcess()
    end
    OnlylifeUI.Visible(MConcess, not OnlylifeUI.Visible(MConcess))
    while MConcess do
        Wait(0)
        OnlylifeUI.IsVisible(MConcess, true, true, true, function()
            OnlylifeUI.Separator("↓ Actions véhicules ↓")
            OnlylifeUI.ButtonWithStyle("Liste des véhicules", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
            end, MConcessSub)
        end, function()
        end)

        OnlylifeUI.IsVisible(MConcessSub, true, true, true, function()
            for i = 1, #Onlylife_Conces.catevehi, 1 do
                OnlylifeUI.ButtonWithStyle("Catégorie - " .. Onlylife_Conces.catevehi[i].label, nil, {
                    RightLabel = "→→→"
                }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        nomcategorie = Onlylife_Conces.catevehi[i].label
                        categorievehi = Onlylife_Conces.catevehi[i].name
                        ESX.TriggerServerCallback('Onlylife_Conces:recupererlistevehicule', function(listevehi)
                            Onlylife_Conces.listecatevehi = listevehi
                        end, categorievehi)
                    end
                end, MConcessSub1)
            end
        end, function()
        end)

        OnlylifeUI.IsVisible(MConcessSub1, true, true, true, function()
            OnlylifeUI.Separator("↓ Catégorie : " .. nomcategorie .. " ↓")
            for i2 = 1, #Onlylife_Conces.listecatevehi, 1 do
                OnlylifeUI.ButtonWithStyle(Onlylife_Conces.listecatevehi[i2].name, "Pour acheter ce véhicule", {
                    RightLabel = Onlylife_Conces.listecatevehi[i2].price .. "$"
                }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        nomvoiture = Onlylife_Conces.listecatevehi[i2].name
                        prixvoiture = Onlylife_Conces.listecatevehi[i2].price
                        modelevoiture = Onlylife_Conces.listecatevehi[i2].model
                        supprimervehiculeconcess()
                        chargementvoiture(modelevoiture)

                        ESX.Game.SpawnVehicle(modelevoiture, PDM.pos.MenuBuy[configIndex].vehiclePreviewSpawn.xyz, PDM.pos.MenuBuy[configIndex].vehiclePreviewSpawn.w,
                            function(vehicle)
                                table.insert(derniervoituresorti, vehicle)
                                FreezeEntityPosition(vehicle, true)
                                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                SetModelAsNoLongerNeeded(modelevoiture)
                            end)
                    end
                end, MConcessSub2)
            end
        end, function()
        end)

        OnlylifeUI.IsVisible(MConcessSub2, true, true, true, function()
            OnlylifeUI.ButtonWithStyle("⚠️ Cette Action est Définitive ! ⚠️", nil, {
                RightLabel = ""
            }, true, function(Hovered, Active, Selected)
                if (Selected) then

                end
            end)

            OnlylifeUI.Separator("~b~↓ Vendre au joueur le plus proche ↓")
            OnlylifeUI.ButtonWithStyle("Vendre le véhicule", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ESX.TriggerServerCallback('Onlylife_Conces:GetPlayerIsMoney', function(suffisantsous)
                        if suffisantsous then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Personne autour')
                            else
                                supprimervehiculeconcess()
                                chargementvoiture(modelevoiture)
                                ESX.Game.SpawnVehicle(modelevoiture, PDM.pos.MenuBuy[configIndex].vehicleBuyedSpawn.xyz, PDM.pos.MenuBuy[configIndex].vehicleBuyedSpawn.w,
                                    function(vehicle)
                                        table.insert(sortirvoitureacheter, vehicle)
                                        FreezeEntityPosition(vehicle, true)
                                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                        SetModelAsNoLongerNeeded(modelevoiture)
                                        local plaque = GeneratePlate()
                                        local vehicleProps = ESX.Game.GetVehicleProperties(sortirvoitureacheter
                                        [#sortirvoitureacheter])
                                        vehicleProps.plate = plaque
                                        SetVehicleNumberPlateText(sortirvoitureacheter[#sortirvoitureacheter], plaque)
                                        FreezeEntityPosition(sortirvoitureacheter[#sortirvoitureacheter], false)
                                        TriggerServerEvent('Onlylife_Conces:vendrevoiturejoueur',
                                            GetPlayerServerId(closestPlayer), vehicleProps, prixvoiture, nomvoiture)
                                        TriggerServerEvent('OnlyLogs:PDM_Sell', {
                                            ['vendeur'] = GetPlayerServerId(PlayerId()),
                                            ['acheteur'] = GetPlayerServerId(closestPlayer),
                                            ['vehicule'] = nomvoiture,
                                            ['prix'] = prixvoiture
                                        })
                                        TriggerServerEvent('garage:RegisterNewKey', GetPlayerServerId(closestPlayer),
                                            vehicleProps.plate)
                                        ESX.ShowNotification('Le véhicule ' ..
                                        nomvoiture ..
                                        ' avec la plaque ' ..
                                        vehicleProps.plate .. ' a été vendu à ' .. GetPlayerName(closestPlayer))
                                    end)
                            end
                        else
                            ESX.ShowNotification('La société n\'as pas assez d\'argent pour ce véhicule!')
                        end
                    end, prixvoiture)
                    OnlylifeUI.CloseAll()
                end
            end)

            --[[            OnlylifeUI.Separator("~b~↓ Acheter avec l'argent de la societé ↓")
            OnlylifeUI.ButtonWithStyle("Acheter le véhicule", nil, {
                RightLabel = "→"
            }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ESX.TriggerServerCallback('Onlylife_Conces:GetPlayerIsMoney', function(suffisantsous)
                        if suffisantsous then
                            supprimervehiculeconcess()
                            chargementvoiture(modelevoiture)
                            ESX.Game.SpawnVehicle(modelevoiture, {
                                x = -29.52,
                                y = -1082.59,
                                z = 27.04
                            }, 68.34, function(vehicle)
                                table.insert(sortirvoitureacheter, vehicle)
                                FreezeEntityPosition(vehicle, true)
                                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                SetModelAsNoLongerNeeded(modelevoiture)
                                local plaque = GeneratePlate()
                                local vehicleProps = ESX.Game.GetVehicleProperties(
                                    sortirvoitureacheter[#sortirvoitureacheter])
                                vehicleProps.plate = plaque
                                SetVehicleNumberPlateText(sortirvoitureacheter[#sortirvoitureacheter], plaque)
                                FreezeEntityPosition(sortirvoitureacheter[#sortirvoitureacheter], false)
                                TriggerServerEvent('shop:vehicule', vehicleProps, prixvoiture, nomvoiture)
                                TriggerServerEvent('garage:RegisterNewKey', GetPlayerServerId(PlayerId()),
                                    vehicleProps.plate)
                                ESX.ShowNotification('Le véhicule ' .. nomvoiture .. ' avec la plaque ' ..
                                                         vehicleProps.plate .. ' a été vendu à ' ..
                                                         GetPlayerName(PlayerId()))
                            end)

                        else
                            ESX.ShowNotification('La société n\'as pas assez d\'argent pour ce véhicule!')
                        end

                    end, prixvoiture)
                end
            end)]]
        end, function()
        end)

        if not OnlylifeUI.Visible(MConcess) and not OnlylifeUI.Visible(MConcessSub) and
            not OnlylifeUI.Visible(MConcessSub1) and not OnlylifeUI.Visible(MConcessSub2) then
            MConcess = RMenu:DeleteType("MConcess", true)
        end
    end
end

--[[
Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cardealer' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cardealer' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Concess.pos.menu.position.x, Concess.pos.menu.position.y, Concess.pos.menu.position.z)
            if jobdist <= 10.0 and Concess.MarkerIsVisible then
                Timer = 0
                DrawMarker(20, Concess.pos.menu.position.x, Concess.pos.menu.position.y, Concess.pos.menu.position.z,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if jobdist <= 1.0 then
                Timer = 0
                OnlylifeUI.Text({
                    message = "Appuyez sur ~y~[E]~s~ pour accéder au menu",
                    time_display = 1
                })
                if IsControlJustPressed(1, 51) then
                    ESX.TriggerServerCallback('Onlylife_Conces:recuperercategorievehicule', function(catevehi)
                        Onlylife_Conces.catevehi = catevehi
                    end)
                    MenuConcess()
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)
]]

local onEnterCardealerMenu = function(self)
    if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'cardealer') or (ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cardealer') then
        self.isInMenuRange = true
        Citizen.CreateThread(function()
            while self.isInMenuRange do
                DrawMarker(20, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3,
                    255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                local plyCoords = GetEntityCoords(PlayerPedId())
                if #(self.coords - plyCoords) <= 1.5 then
                    OnlylifeUI.Text({
                        message = "Appuyez sur ~y~[E]~s~ pour accéder au menu",
                        time_display = 1
                    })
                    if IsControlJustPressed(1, 51) then
                        ESX.TriggerServerCallback('Onlylife_Conces:recuperercategorievehicule', function(catevehi)
                            Onlylife_Conces.catevehi = catevehi
                            MenuConcess(self.index)
                        end)
                    end
                end
                Citizen.Wait(0)
            end
        end)
    end
end

local onExitCardealerMenu = function(self)
    self.isInMenuRange = false
end

local zones = {}
for k, v in pairs(PDM.pos.MenuBuy) do
    local temp = lib.zones.sphere({
        coords = v.computer,
        radius = 10,
        onEnter = onEnterCardealerMenu,
        onExit = onExitCardealerMenu,
        isInMenuRange = false,
        index = k
    })
    table.insert(zones, temp)
end

function supprimervehiculeconcess()
    while #derniervoituresorti > 0 do
        local vehicle = derniervoituresorti[1]

        ESX.Game.DeleteVehicle(vehicle)
        table.remove(derniervoituresorti, 1)
    end
end

function chargementvoiture(modelHash)
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

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for k, v in pairs(zones) do
        v:remove()
    end
end)
