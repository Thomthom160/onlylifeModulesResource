ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'cardealer', 'cardealer', 'society_cardealer', 'society_cardealer', 'society_cardealer', 'society_cardealer_black', {type = 'public'})


RegisterServerEvent('catalog:set')
AddEventHandler('catalog:set', function(instance, bool)
	SetPlayerRoutingBucket(source, instance)
end)

ESX.RegisterServerCallback('Onlylife_Conces:recuperercategorievehicule', function(source, cb)
    local catevehi = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        for i = 1, #result, 1 do

            table.insert(catevehi, {
                name = result[i].name,
                label = result[i].label
            })
        end
        cb(catevehi)
    end)
end)

ESX.RegisterServerCallback('Onlylife_Conces:recupererlistevehicule', function(source, cb, categorievehi)
    local catevehi = categorievehi
    local listevehi = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicles WHERE category = @category', {
        ['@category'] = catevehi
    }, function(result)
        for i = 1, #result, 1 do
            table.insert(listevehi, {
                name = result[i].name,
                model = result[i].model,
                price = result[i].price
            })
        end

        cb(listevehi)
    end)
end)

ESX.RegisterServerCallback('Onlylife_Conces:verifierplaquedispo', function (source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)

RegisterNetEvent('Onlylife_Conces:vendrevoiturejoueur')
AddEventHandler('Onlylife_Conces:vendrevoiturejoueur', function(playerId, vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(playerId) 
	local levendeur = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function (account)
        account.removeMoney(prix)
    end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function (rowsChanged)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Tu as reçu la voiture ~g~"..nom.."~s~ immatriculé ~g~"..vehicleProps.plate)
    end)
end)

RegisterNetEvent('shop:vehicule')
AddEventHandler('shop:vehicule', function(vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function (account)
        account.removeMoney(prix)
end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
        TriggerClientEvent('esx:showNotification', xPlayer, "Tu as reçu la voiture ~g~"..json.encode(vehicleProps).."~s~ immatriculé ~g~"..vehicleProps.plate)
    end)
end)

ESX.RegisterServerCallback('Onlylife_Conces:GetPlayerIsMoney', function(source, cb, prixvoiture)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function (account)
        if account.money >= prixvoiture then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('fConcess:Ouvert')
AddEventHandler('fConcess:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if xPlayer.job.name == 'cardealer' then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Onlylife Auto', 'Publicité', 'Le Concessionnaire Automobile est désormais ~g~Ouvert~s~ !', 'CHAR_FCONCESS', 8)
        end
    end
end)

RegisterServerEvent('fConcess:Fermer')
AddEventHandler('fConcess:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if xPlayer.job.name == 'cardealer' then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Onlylife Auto', 'Publicité', 'Le Concessionnaire Automobile est désormais ~b~Fermer~s~ !', 'CHAR_FCONCESS', 8)
        end
    end
end)

RegisterCommand("sync", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {
    }, function (result)
        for k,v in pairs(result) do
            MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
                ['@owner'] = v.owner,
                ['@plate'] = v.plate,
                ['@NB'] = 1,
            })
        end
    end)
end)


RegisterServerEvent('Onlylife:Cardealer:Announce')
AddEventHandler('Onlylife:Cardealer:Announce', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if type == 'open' then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'PDM', '~r~Ouverture', 'Votre concession Premium Delux Motorsport est ouvert', 'PDM', 2)
        
        end
    elseif type == 'close' then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'PDM', '~r~Fermeture', 'Votre concession Premium Delux Motorsport est fermé', 'PDM', 2)
        
        end
    end
end)

ESX.RegisterServerCallback('PDM:getBlackMoneySociety', function(source, cb)
    local _source = source
    local xPlayer    = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

  
ESX.RegisterServerCallback('PDM:getPlayerInventoryBlack', function(source, cb)
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(_source)
	local blackMoney = xPlayer.getAccount('black_money').money
  
	cb({
	  blackMoney = blackMoney
	})
  end)
