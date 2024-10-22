ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    RefreshlabelMoney()
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
    RefreshlabelMoney()
end)


local open = false
local mainMenu = RageUI.CreateMenu('label', ' ')
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
end
local societylabelmoney = nil


function OpenMenuBosslabel()
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()

                    RageUI.Separator("↓  Gestion label  ~s~↓")

                    RageUI.Button("Gestion de l'entreprise", nil, { RightLabel = "→" }, true, {
                        onSelected = function()
                            aboss()
                            RageUI.CloseAll()
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end

function RefreshlabelMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietylabelMoney(money)
        end, ESX.PlayerData.job.name)
    elseif ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietylabelMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietylabelMoney(money)
    societylabelmoney = ESX.Math.GroupDigits(money)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

local position = {
    vector3(-1009.05, -266.09, 44.8)
}

CreateThread(function()
    while true do
        local wait = 750

        for k in pairs(position) do
            if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'label' and ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'label' and ESX.PlayerData.job2.grade_name == 'boss') then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 10.0 then
                    wait = 0
                    DrawMarker(2, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3,
                        0.3, 50, 153, 100, 255, true, true, p19, true)


                    if dist <= 1.0 then
                        wait = 0
                        Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1)
                        if IsControlJustPressed(1, 51) then
                            OpenMenuBosslabel()
                        end
                    end
                end
            end
            Citizen.Wait(wait)
        end
    end
end)

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'label', function(data, menu)
        menu.close()
    end, { wash = false })
end
