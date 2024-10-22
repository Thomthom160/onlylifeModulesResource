local OnlyLife = {}
OnlyLife.Client = {}
OnlyLife.Client.Cooldown = false
OnlyLife.Client.Location_Boat = RageUI.CreateMenu('Location_Boat', 'Location_Boat')
OnlyLife.Client.Location_Boat.Closed = function()
        OnlyLife.Client.open = false
        FreezeEntityPosition(PlayerPedId(), false)
    end
function OnlyLife.Client:OpenMenuarivant()
        if OnlyLife.Client.open then
            OnlyLife.Client.open = false
            RageUI.Visible(OnlyLife.Client.Location_Boat, false)
            return
    else
            OnlyLife.Client.open = true
            RageUI.Visible(OnlyLife.Client.Location_Boat, true)
            CreateThread(function()
                while OnlyLife.Client.open do
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.IsVisible(OnlyLife.Client.Location_Boat, function()
                        for k, v in pairs(Location_Boat_cfg.location) do
                            RageUI.Button(v.label, nil, {RightLabel = '$'..v.price}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('Onlylife:Location_Boat2.checkMoney', function(payed)
                                        if not payed then ESX.ShowNotification('Tu n\'a pas assez d\'argent') return end
                                        self:SpawnVehicle(v.car)
                                        ESX.ShowNotification("Votre véhicule a été livré !")
                                    end, v.price)  
                                end
                            })
                        end
                    end)
                Wait(1)
            end
        end)
    end
end
function OnlyLife.Client:SpawnVehicle(car)
    --local carHash = GetHashKey(car)
    --RequestModel(carHash)
    --while not HasModelLoaded(carHash) do
    --    RequestModel(carHash)
    --    Citizen.Wait(0)
    --end
    for k, v in pairs(Location_Boat_cfg.Spawn) do
        if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 2.0) then
            TriggerServerEvent('Onlylife:Location_Boat2.spawnBoat', car, vector3(v.x, v.y, v.z), v.h)
            break
        end
    end
end
Citizen.CreateThread(function()
        while true do
            local Waito = false
            for _, info in pairs(Location_Boat_cfg.Position) do
                local dist = Vdist2(GetEntityCoords(GetPlayerPed(-1)), info.x, info.y, info.z)
                if dist < 3 then
                    Waito = true
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la location de bateau")
                    if dist < 2 then
                        if IsControlJustPressed(0, 51) then
                            OnlyLife.Client:OpenMenuarivant()
                    end
                end
            end
        end
        if Waito then
                Wait(0)
        else
                Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
        for _, info in pairs(Location_Boat_cfg.Position) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, info.sprite)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, info.scale)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)
        end
end)
    CreateThread(function()
        RequestModel("a_m_y_beach_01")
        while not HasModelLoaded("a_m_y_beach_01") do Wait(10) end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do Wait(10) end
    local npc = CreatePed(4, "a_m_y_beach_01", -808.50, -1411.42, 0.59, "a_m_y_beach_01", false, true)
    SetEntityHeading(npc, 318.07)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    TaskPlayAnim(npc, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end)
