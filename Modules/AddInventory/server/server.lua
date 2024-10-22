ESX = exports["es_extended"]:getSharedObject()


ESX.RegisterUsableItem('idcard', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('Huid_AddInventory:idcard', source)
end)

ESX.RegisterUsableItem('cayoid', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('Huid_AddInventory:idcayocard', source)
end)

ESX.RegisterUsableItem('permitdriver', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('Huid_AddInventory:permitdriver', source)
end)

ESX.RegisterUsableItem('permitfire', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('Huid_AddInventory:permitfire', source)
end)

ESX.RegisterUsableItem('permithunt', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('Huid_AddInventory:permithunt', source)
end)