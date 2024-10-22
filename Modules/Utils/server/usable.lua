ESX.RegisterUsableItem('rose', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    
	TriggerClientEvent('OnlyLife:client:UsableItemToEmote', xPlayer.source, "e rose")
    
end)

ESX.RegisterUsableItem('bouquet', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
	TriggerClientEvent('OnlyLife:client:UsableItemToEmote', xPlayer.source, "e bouquet")
    
end)