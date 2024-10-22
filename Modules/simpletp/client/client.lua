local key_to_teleport = 38
ESX = exports["es_extended"]:getSharedObject()

positions = {
    { -- blanchiseur
        tp1 = vector4(1138.0032, -3198.3413, -39.6657, 62.4163),
        tp2 = vector4(-702.83, -1023.36, 14.46, 116.4),
        color = { r = 0, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour ouvrir la Porte",
        job = {
            mayans = 0,
            milicecayo = 0,
            police = 0
        }
    },
    { -- bureau f1
        tp1 = vector4(-1379.6483, -500.2912, 33.1574, 10.2770),
        tp2 = vector4(-1393.8429, -479.5630, 72.0421, 275.5155),
        color = { r = 0, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour ouvrir la Porte"    
    },
    { -- Assenceur Casino
        tp1 = vector3(937.93, 56.86, 79.9),
        tp2 = vector3(969.79, 46.57, 111.61),
        color = { r = 255, g = 255, b = 255 },
        label = "~INPUT_CONTEXT~ pour Monter/Descendre"
    },
    { -- Assenceur voiture Casino
        tp1 = vector3(956.08, 12.63, 77.84),
        tp2 = vector3(958.39, 38.7, 71.87),
        color = { r = 255, g = 255, b = 255 },
        label = "~INPUT_CONTEXT~ pour Monter/Descendre"
    },
    --{
    --    tp1 = vector4(-2219.68, 1155.0, -23.26, 220.53),
    --    tp2 = vector4(758.28, -1865.44, 29.29, 263.73),
    --    color = {r = 255, g = 255, b = 255},
    --    label = "Entrer / Sortir de la zone"
    --},
    --{
    --    tp1 = vector4(-2138.33, 1105.88, -26.25, 266.91),
    --    tp2 = vector4(-2153.21, 1106.02, -24.37, 90.22),
    --    color = {r = 255, g = 155, b = 155},
    --    label = "Entrer / Sortir du circuit"
    --},
    { -- Morgue Hopital
        tp1 = vector4(275.4064, -1361.3525, 23.6378, 47.2649),
        tp2 = vector4(-444.31, -319.79, -131.88, 199.01),
        color = { r = 255, g = 155, b = 155 },
        label = "~INPUT_CONTEXT~ pour Entrer / Sortir de la morgue"
    },
    { --bunker usmarshal
        tp1 = vector4(482.27, 4810.59, -59.38, 194.13),
        tp2 = vector4(2454.15, -398.15, 91.99, 98.46),
        color = { r = 102, g = 148, b = 203 },
        label = "~INPUT_CONTEXT~ pour Entrer / Sortir"
    },
    { -- Assenceur Human Labs
        tp1 = vector4(3540.4653, 3675.6526, 20.9918, 183.1499),
        tp2 = vector4(3540.5359, 3675.1306, 28.1211, 170.8417),
        color = { r = 255, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    },
    { -- Assenceur Hotel Pearce
        tp1 = vector4(415.2027, -15.1813, 99.6455, 236.6249),
        tp2 = vector4(380.3240, -15.2088, 82.9978, 38.7863),
        color = { r = 255, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    },
    { -- Cayo
        tp1 = vector4(5012.72, -5746.44, 15.48, 333.95),
        tp2 = vector4(5012.62, -5748.91, 28.95, 325.0),
        color = { r = 255, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    },
    { -- Chantier haut
        tp1 = vector4(-155.7191, -945.5608, 268.1352, 248.6058),
        tp2 = vector4(-155.2124, -945.3748, 113.1361, 248.4695),
        color = { r = 255, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    },
    { -- Chantier bas
        tp1 = vector4(-178.8055, -1012.8111, 113.1361, 330.0031),
        tp2 = vector4(-181.6738, -1020.8026, 28.2919, 163.1073),
        color = { r = 255, g = 0, b = 0 },
        label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    }
    --{ -- Penthouse RD
    --    tp1 = vector4(-305.0410, -721.0540, 28.0286, 330.6024),
    --    tp2 = vector4(-288.1825, -722.4452, 125.4732, 151.7639),
    --    color = { r = 255, g = 0, b = 0 },
    --    label = "~INPUT_CONTEXT~ pour Monter / Descendre"
    --},
    --{ -- Garage Guss (Event Février)
    --    tp1 = vector4(1189.2404, -3103.8135, 5.7901, 181.8569),
    --    tp2 = vector4(972.5113, -2996.8899, -39.6470, 190.1443),
    --    color = { r = 255, g = 0, b = 0 },
    --    label = "Entrée/Sortir"
    --},

}
-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------

CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(50)
    end
    while true do
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)
        local Timer = 500
        
        for _, location in ipairs(positions) do
            local canSeePoint = true

            if location.job then
                canSeePoint = false
                for job, grade in pairs(location.job) do
                    if (ESX.PlayerData.job.name == job and ESX.PlayerData.job.grade >= grade) or (ESX.PlayerData.job2.name == job and ESX.PlayerData.job2.grade >= grade) then
                        canSeePoint = true
                        break
                    end
                end
            end
            if canSeePoint then
                if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, location.tp1.x, location.tp1.y, location.tp1.z, 15) then
                    DrawMarker(1, location.tp1.x, location.tp1.y, location.tp1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, location.color.r, location.color.g, location.color.b, 200, 0, 0, 0, 0)
                    Timer = 0
                end
                if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, location.tp2.x, location.tp2.y, location.tp2.z, 15) then
                    DrawMarker(1, location.tp2.x, location.tp2.y, location.tp2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, location.color.r, location.color.g, location.color.b, 200, 0, 0, 0, 0)
                    Timer = 0
                end
                if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, location.tp1.x, location.tp1.y, location.tp1.z, 2) then
                    ESX.ShowHelpNotification(location.label, true, false)
                    if IsControlJustReleased(1, key_to_teleport) then
                        DoScreenFadeOut(1000)
                        Wait(1000)
                        if IsPedInAnyVehicle(player, true) then
                            SetEntityCoords(GetVehiclePedIsUsing(player), location.tp2.x, location.tp2.y, location.tp2.z)
                            SetEntityHeading(GetVehiclePedIsUsing(player), location.tp2.w)
                        else
                            SetEntityCoords(player, location.tp2.x, location.tp2.y, location.tp2.z)
                            SetEntityHeading(player, location.tp2.w)
                        end
                        DoScreenFadeIn(1000)
                        Wait(1000)
                    end
                elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, location.tp2.x, location.tp2.y, location.tp2.z, 2) then
                    ESX.ShowHelpNotification(location.label, true, false)
                    if IsControlJustReleased(1, key_to_teleport) then
                        DoScreenFadeOut(1000)
                        Wait(1000)
                        if IsPedInAnyVehicle(player, true) then
                            SetEntityCoords(GetVehiclePedIsUsing(player), location.tp1.x, location.tp1.y, location.tp1.z)
                            SetEntityHeading(GetVehiclePedIsUsing(player), location.tp1.w)
                        else
                            SetEntityCoords(player, location.tp1.x, location.tp1.y, location.tp1.z)
                            SetEntityHeading(player, location.tp1.w)
                        end
                        DoScreenFadeIn(1000)
                        Wait(1000)
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1 ^ 2

    local t2 = y - cy
    local t21 = t2 ^ 2

    local t3 = z - cz
    local t31 = t3 ^ 2

    return (t12 + t21 + t31) <= radius ^ 2
end
