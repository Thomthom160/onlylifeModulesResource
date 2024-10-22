ESX.RegisterUsableItem('giftbox1', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodacola', 2) and xPlayer.canCarryItem('beefburger', 2) then
        xPlayer.removeInventoryItem('giftbox1', 1)
        xPlayer.addInventoryItem('sodacola', 2)
        xPlayer.addInventoryItem('beefburger', 2)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
    
end)

ESX.RegisterUsableItem('giftbox2', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	    xPlayer.removeInventoryItem('giftbox2', 1)
        xPlayer.addInventoryItem('money', 3500)
    
end)

ESX.RegisterUsableItem('giftbox3', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodacola', 3) and xPlayer.canCarryItem('chickenburger', 3) then
        xPlayer.removeInventoryItem('giftbox3', 1)
        xPlayer.addInventoryItem('sodacola', 3)
        xPlayer.addInventoryItem('chickenburger', 3)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
    
end)

ESX.RegisterUsableItem('giftbox4', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodasprite', 1) and xPlayer.canCarryItem('chickenburger', 1) then
        xPlayer.removeInventoryItem('giftbox4', 1)
        xPlayer.addInventoryItem('sodasprite', 1)
        xPlayer.addInventoryItem('chickenburger', 1)
	    xPlayer.addInventoryItem('money', 850)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
    
end)

ESX.RegisterUsableItem('giftbox5', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	    xPlayer.removeInventoryItem('giftbox5', 1)
        xPlayer.addInventoryItem('money', 3500)
    
end)

ESX.RegisterUsableItem('giftbox6', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('watergun', 1) then
        xPlayer.removeInventoryItem('giftbox6', 1)
        xPlayer.addInventoryItem('watergun', 1)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox7', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodasprite', 6) and xPlayer.canCarryItem('beefburger', 4) then
        xPlayer.removeInventoryItem('giftbox7', 1)
        xPlayer.addInventoryItem('sodasprite', 6)
        xPlayer.addInventoryItem('beefburger', 4)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox8', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('giftbox8', 1)
        xPlayer.addInventoryItem('money', 4000)
    
end)

ESX.RegisterUsableItem('giftbox9', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokeveggie', 3) and xPlayer.canCarryItem('ramuner', 5) then
        xPlayer.removeInventoryItem('giftbox9', 1)
        xPlayer.addInventoryItem('pokeveggie', 3)
        xPlayer.addInventoryItem('ramuner', 5)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox10', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokepoulet', 4) and xPlayer.canCarryItem('ramunef', 6) then
        xPlayer.removeInventoryItem('giftbox10', 1)
        xPlayer.addInventoryItem('pokepoulet', 4)
        xPlayer.addInventoryItem('ramunef', 6)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox11', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('boombox', 2) then
        xPlayer.removeInventoryItem('giftbox11', 1)
        xPlayer.addInventoryItem('money', 3500)
        xPlayer.addInventoryItem('boombox', 2)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox12', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokepoulet', 2) and xPlayer.canCarryItem('ramunef', 2) then
        xPlayer.removeInventoryItem('giftbox12', 1)
        xPlayer.addInventoryItem('money', 1350)
        xPlayer.addInventoryItem('pokepoulet', 6)
        xPlayer.addInventoryItem('ramunef', 6)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox12', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokepoulet', 2) and xPlayer.canCarryItem('ramunef', 2) then
        xPlayer.removeInventoryItem('giftbox12', 1)
        xPlayer.addInventoryItem('money', 1350)
        xPlayer.addInventoryItem('pokepoulet', 2)
        xPlayer.addInventoryItem('ramunef', 2)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox13', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodacola', 10) then
        xPlayer.removeInventoryItem('giftbox13', 1)
        xPlayer.addInventoryItem('money', 1550)
        xPlayer.addInventoryItem('sodacola', 10)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox14', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('weapon_acidpackage', 15) then
        xPlayer.removeInventoryItem('giftbox14', 1)
        xPlayer.addInventoryItem('weapon_acidpackage', 15)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox15', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('weapon_flare', 5) then
        xPlayer.removeInventoryItem('giftbox15', 1)
        xPlayer.addInventoryItem('weapon_flare', 5)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox15', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokepoulet', 2) and xPlayer.canCarryItem('ramunef', 2) then
        xPlayer.removeInventoryItem('giftbox15', 1)
        xPlayer.addInventoryItem('money', 1350)
        xPlayer.addInventoryItem('pokepoulet', 2)
        xPlayer.addInventoryItem('ramunef', 2)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox16', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokeveggie', 3) and xPlayer.canCarryItem('ramuner', 5) then
        xPlayer.removeInventoryItem('giftbox16', 1)
        xPlayer.addInventoryItem('pokeveggie', 3)
        xPlayer.addInventoryItem('ramuner', 5)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end
end)

ESX.RegisterUsableItem('giftbox17', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('giftbox17', 1)

    TriggerClientEvent('esx_giveownedcar:spawnVehicle', source, source, "bimx", "ton garage", 'player', 'car')

    ESX.ShowNotification("Tu viens d'avoir un BMX 2 places")
end)

ESX.RegisterUsableItem('giftbox18', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('pokepoulet', 2) and xPlayer.canCarryItem('ramunef', 2) then
        xPlayer.removeInventoryItem('giftbox18', 1)
        xPlayer.addInventoryItem('money', 1350)
        xPlayer.addInventoryItem('pokepoulet', 2)
        xPlayer.addInventoryItem('ramunef', 2)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox19', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('weapon_candycane', 1) then
        xPlayer.removeInventoryItem('giftbox19', 1)
        xPlayer.addInventoryItem('weapon_candycane', 1)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox20', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('boombox', 4) and xPlayer.canCarryItem('phone', 1) then
        xPlayer.removeInventoryItem('giftbox20', 1)
        xPlayer.addInventoryItem('boombox', 3)
        xPlayer.addInventoryItem('phone', 1)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox21', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('sodasprite', 4) and xPlayer.canCarryItem('chickenburger', 4) then
        xPlayer.removeInventoryItem('giftbox21', 1)
        xPlayer.addInventoryItem('sodasprite', 4)
        xPlayer.addInventoryItem('chickenburger', 4)
	    xPlayer.addInventoryItem('money', 2850)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox22', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('ramuney', 4) and xPlayer.canCarryItem('pokepoulet', 4) then
        xPlayer.removeInventoryItem('giftbox22', 1)
        xPlayer.addInventoryItem('ramuney', 4)
        xPlayer.addInventoryItem('pokepoulet', 4)
	    xPlayer.addInventoryItem('money', 3850)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox23', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem('weapon_flare', 10) then
        xPlayer.removeInventoryItem('giftbox23', 1)
        xPlayer.addInventoryItem('money', 4500)
        xPlayer.addInventoryItem('weapon_flare', 10)
    else
        ESX.ShowNotification("Tu n'as pas assez de place pour ouvrir le cadeau")
    end

end)

ESX.RegisterUsableItem('giftbox24', function(source)
	
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('giftbox24', 1)
        TriggerClientEvent('esx_giveownedcar:spawnVehicle', source, source, "dynasty", "ton garage", 'player', 'car')

    ESX.ShowNotification("Tu viens d'avoir une dynasty, prépare là pour un évenement !")

end)
