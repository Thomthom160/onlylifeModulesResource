
RegisterNetEvent('Onlylife:Location_Boat2.spawnBoat', function(vehicle, coords, heading)
    local plate = 'LOC '..tostring(math.random(9))..tostring(math.random(9))..tostring(math.random(9))
	ESX.OneSync.SpawnVehicle(vehicle, coords, heading, {plate = plate, fuelLevel = 100}, function(netId)end)
end)


ESX.RegisterServerCallback('Onlylife:Location_Boat2.checkMoney', function(source, cb, ToPay)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= ToPay then
		xPlayer.removeAccountMoney('money', ToPay)
		cb(true)
	end
	cb(false)
end)