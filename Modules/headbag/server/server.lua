ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('headbag', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('atlantisHeadbag:checkplayers', _source)
end)

--RegisterServerEvent('atlantisHeadbag:setbagon')
exports["WaveShield"]:AddEventHandler('atlantisHeadbag:setbagon', function(source, target, idkurwy)
	local _target = target
	local _idkurwy = idkurwy
	local xPlayer = ESX.GetPlayerFromId(_idkurwy)
	local xTarget = ESX.GetPlayerFromId(_target)
		TriggerClientEvent('atlantisHeadbag:setbag', _target, _idkurwy)

end)

--RegisterServerEvent('atlantisHeadbag:check')
exports["WaveShield"]:AddEventHandler('atlantisHeadbag:check', function(source, target, idkurwy)
	local _target = target
	local _idkurwy = idkurwy
		TriggerClientEvent('atlantisHeadbag:checkthiskurwe', _target, _idkurwy)
end)

--RegisterServerEvent('atlantisHeadbag:itemhuj')
exports["WaveShield"]:AddEventHandler('atlantisHeadbag:itemhuj', function(source, idkurwy, gowno)
	local idhuj = idkurwy
	local _gowno = gowno
		TriggerClientEvent('atlantisHeadbag:kurwodajitem', idhuj, _gowno)
end)

--RegisterServerEvent('atlantisHeadbag:item')
exports["WaveShield"]:AddEventHandler('atlantisHeadbag:item', function(source, what)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _what = what
	local limitworkowbotypersiesprul = xPlayer.getInventoryItem('headbag').count
		if _what == 'remove' then
			xPlayer.removeInventoryItem('headbag', 1)
		elseif _what == 'give' then
			if limitworkowbotypersiesprul < 8 then
				xPlayer.addInventoryItem('headbag', 1)
			else
				TriggerClientEvent('esx:showNotification', _source, "~g~Vos poches sont pleines")
				--TriggerClientEvent("pNotify:SendNotification", _source, {text = "Poches pleines : (", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})	
			end	
		end
end)

--RegisterServerEvent('atlantisHeadbag:woreknaleb')
exports["WaveShield"]:AddEventHandler('atlantisHeadbag:woreknaleb', function(source, idkurwy, onglowa)
	local _source = source
	local _idkurwy = idkurwy
	local xPlayer = ESX.GetPlayerFromId(_idkurwy)
	local xTarget = ESX.GetPlayerFromId(_source)
	if onglowa == 0 then
		TriggerClientEvent('esx:showNotification', "Vous avez un sac sur la tête")
		--TriggerEvent('esx:woreknaleb', xPlayer.name..' il a téléchargé '..xTarget.name..' sac avec une tête')
	elseif onglowa == 1 then
		TriggerClientEvent('esx:showNotification', _idkurwy, "~g~Vous avez mis un sac sur la tête") -- moi
	--	TriggerEvent('esx:woreknaleb', xPlayer.name..' fondé '..xTarget.name..' le sac est au-dessus de sa tête et les bombes martèlent d\'en bas')
	end
end)