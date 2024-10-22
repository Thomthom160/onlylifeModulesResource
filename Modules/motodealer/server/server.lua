ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'bikedealer', 'bikedealer', 'society_bikedealer', 'society_bikedealer',
    'society_bikedealer', 'society_bikedealer_black', {type = 'public'})

    ESX.RegisterServerCallback('Onlylife_Sanders:recuperercategorievehicule', function(source, cb)
        local catevehi = {}
    
        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
    
            table.insert(catevehi, {
                name = "motorcycles",
                label = "Moto"
            })
    
            table.insert(catevehi, {
                name = "velo",
                label = "Vélo"
            })
    
            cb(catevehi)
        end)
    end)
    

ESX.RegisterServerCallback('Onlylife_Sanders:recupererlistevehicule', function(source, cb, categorievehi)
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

ESX.RegisterServerCallback('Onlylife_Sanders:verifierplaquedispo', function(source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        cb(result[1] ~= nil)
    end)
end)

RegisterNetEvent('Onlylife_Sanders:vendrevoiturejoueur')
AddEventHandler('Onlylife_Sanders:vendrevoiturejoueur', function(playerId, vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local levendeur = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function (account)
            account.removeMoney(prix)
    end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChanged)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Tu as reçu la voiture ~g~" .. nom ..
            "~s~ immatriculé ~g~" .. vehicleProps.plate)
    end)
end)

RegisterNetEvent('shop:vehicule')
AddEventHandler('shop:vehicule', function(vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function(account)
        account.removeMoney(prix)
    end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
        TriggerClientEvent('esx:showNotification', xPlayer,
            "Tu as reçu la voiture ~g~" .. json.encode(vehicleProps) .. "~s~ immatriculé ~g~" .. vehicleProps.plate)
    end)
end)

ESX.RegisterServerCallback('Onlylife_Sanders:GetPlayerIsMoney', function(source, cb, prixvoiture)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function(account)
        if account.money >= prixvoiture then
            cb(true)
        else
            cb(false)
        end
    end)
end)



RegisterServerEvent('hSanders:Ouvert')
AddEventHandler('hSanders:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sanders Motor', '~r~Ouverture', 'Votre concession Sanders est ouverte', 'SANDERS', 2)
	
	end
end)

RegisterServerEvent('hSanders:Fermer')
AddEventHandler('hSanders:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sanders Motor', '~r~Fermeture', 'Votre concession Sanders est fermée', 'SANDERS', 2)
	
	end
end)


ESX.RegisterServerCallback('Sanders:getPlayerInventoryBlack', function(source, cb)
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(_source)
	local blackMoney = xPlayer.getAccount('black_money').money
  
	cb({
	  blackMoney = blackMoney
	})
  end)

  ESX.RegisterServerCallback('Sanders:getBlackMoneySociety', function(source, cb)
    local _source = source
    local xPlayer    = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)


  ESX.RegisterServerCallback('hSanders:Paye', function(source, cb, paye, pay2)

	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function(account)
		account.addMoney(pay2)
	end)
	xPlayer.addMoney(paye)
	TriggerClientEvent('esx:showNotification', source, "Tu as reçu " .. paye .. "$\nTa société a touché " .. pay2 .. "$")
	cb(true)
	
end)

