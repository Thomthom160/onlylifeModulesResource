local NumberCharset = {}
local Charset = {}
for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Wait(0)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
		else
			generatedPlate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))
		end
		ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)
		if doBreak then
			break
		end
	end
	return generatedPlate
end

function GenerateSocietyPlate(societyPlate)
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(societyPlate .. GetRandomNumber(4))
		ESX.TriggerServerCallback('Onlylife_Conces:verifierplaquedispo', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)
		if doBreak then
			break
		end
	end
	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'
	ESX.TriggerServerCallback('Onlylife_Conces:verifierplaquedispo', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)
	while type(callback) == 'string' do
		Citizen.Wait(0)
	end
	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
