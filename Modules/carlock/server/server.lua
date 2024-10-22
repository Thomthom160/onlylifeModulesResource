ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	local Data = MySQL.Sync.fetchAll('SELECT owner, faction FROM owned_vehicles WHERE plate = @plate OR fakeplate = @plate', {['@plate'] = plate})
	if Data[1] ~= nil then
		if Data[1].owner == xPlayer.identifier then
			cb(true)
			return
		elseif Data[1].faction == xPlayer.job.name then
			cb(true)
			return
		elseif Data[1].faction == xPlayer.job2.name then
			cb(true)
			return
		end
	end

	Data = MySQL.Sync.fetchAll('SELECT * FROM carkeys WHERE plate = @plate OR fakeplate = @plate', {['@plate'] = plate})
	if Data[1] ~= nil then
		if Data[1].identifier == xPlayer.identifier then
			cb(true)
			return
		end
	end
	cb(false)
end)

ESX.RegisterServerCallback('carlock:lockVehicle', function(source, cb, vehicle)
	vehicle = NetworkGetEntityFromNetworkId(vehicle)
	Wait(100)
	if not DoesEntityExist(vehicle) then print('no veh exist') return end
	if GetVehicleDoorLockStatus(vehicle) == 0 then
		SetVehicleDoorsLocked(vehicle, 2)
		cb(true)
	else
		SetVehicleDoorsLocked(vehicle, 0)
		cb(false)
	end
end)