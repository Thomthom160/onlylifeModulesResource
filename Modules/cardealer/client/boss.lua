ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}
local societyPDMmoney = nil
local societyblackPDMmoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    Citizen.Wait(5000)
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    PlayerData.job2 = job2
    Citizen.Wait(5000)
end)

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('PDM:getBlackMoneySociety', function(inventory)
        argent = inventory
    end)
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
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

local OnlyLife = {}

OnlyLife.Client = {}
OnlyLife.Client.BossMenuIsOpened = false
OnlyLife.Client.CardealerMenu = RageUI.CreateMenu('Boss', 'Gestion entreprise')
OnlyLife.Client.CardealerMenu.Closed = function()
    OnlyLife.Client.BossMenuIsOpened = false
    FreezeEntityPosition(PlayerPedId(), false)
end

function OnlyLife.Client.BossMenu()
    if OnlyLife.Client.BossMenuIsOpened then
        OnlyLife.Client.BossMenuIsOpened = false
        RageUI.Visible(OnlyLife.Client.CardealerMenu, false)
        return
    else
        OnlyLife.Client.BossMenuIsOpened = true
        RageUI.Visible(OnlyLife.Client.CardealerMenu, true)
        CreateThread(function()
            while OnlyLife.Client.BossMenuIsOpened do
                --FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(OnlyLife.Client.CardealerMenu, function()

                    if societyPDMmoney ~= nil then
                        RageUI.Button("Argent de la société :", nil, {
                            RightLabel = "$" .. societyPDMmoney
                        }, true, {
                            onSelected = function()
                            end
                        })
                    end

                    RageUI.Button("Retirer l'argent de la société :", nil, {
                        RightLabel = "→→"
                    }, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Montant", "Montant", 50000)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({
                                    message = "Montant présenté invalide"
                                })
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'cardealer', amount)
                                RefreshPDMMoney()
                            end
                        end
                    })
                    RageUI.Button("Déposer l'argent de la société :", nil, {
                        RightLabel = "→→"
                    }, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Montant", "Montant", 50000)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({
                                    message = "Montant présenté invalide"
                                })
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'cardealer', amount)
                                RefreshPDMMoney()
                            end
                        end

                    })

                    RageUI.Button("Accéder aux actions de Management :", nil, {
                        RightLabel = "→→"
                    }, true, {
                        onSelected = function()
                            PDMboss()
                            RageUI.CloseAll()
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' or
            ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'cardealer' and ESX.PlayerData.job2.grade_name == 'boss' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, PDM.pos.boss.x, PDM.pos.boss.y, PDM.pos.boss.z)
            if dist3 <= 7.0 and PDM.jeveuxmarker then
                Timer = 0
                DrawMarker(20, PDM.pos.boss.x, PDM.pos.boss.y, PDM.pos.boss.z,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 38, 154, 205, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Actions Patron")
                if IsControlJustPressed(1, 51) then
                    RefreshPDMMoney()
                    RefreshblackPDMMoney()
                    OnlyLife.Client.BossMenu()
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

function RefreshPDMMoney()
    if ESX.PlayerData.job == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyhimmoMoney(money)
        end, ESX.PlayerData.job.name)
    elseif ESX.PlayerData.job2 == 'cardealer' and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyhimmoMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackPDMMoney()
    if ESX.PlayerData.job == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('PDM:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackPDMMoney(inventory)
        end, ESX.PlayerData.job.name)
    elseif ESX.PlayerData.job2 == 'cardealer' and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('PDM:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackPDMMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackPDMMoney(inventory)
    societyblackPDMmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyPDMMoney(money)
    societyPDMmoney = ESX.Math.GroupDigits(money)
end

function PDMboss()
    TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data, menu)
        menu.close()
    end, {
        wash = false
    })
end

function Deposerargentsale()
    ESX.TriggerServerCallback('PDM:getPlayerInventoryBlack', function(inventory)
        while DepositBlackPDM do
            Citizen.Wait(0)
        end
    end)
end

function RetirerargentsalePDM()
    ESX.TriggerServerCallback('PDM:getBlackMoneySociety', function(inventory)
        while StockBlackPDM do
            Citizen.Wait(0)
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
