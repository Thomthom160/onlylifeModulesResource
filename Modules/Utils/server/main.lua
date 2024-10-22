ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('setMatricule', function(source, args)
	if args[1] ~= nil then
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer == nil then return end
		xPlayer.setMeta('Matricule', args[1])
		xPlayer.showNotification(string.format('Tu à mis à jour ton matricule, il est à présent %s', xPlayer.getMeta('Matricule')))
	end
end, false)

RegisterCommand('getMatricule', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	local matricule = xPlayer.getMeta('Matricule')
	print(matricule)
	xPlayer.showNotification(string.format('Ton matricule est le %s', matricule))
end, false)

ESX.RegisterCommand('isPlyMuted', 'smod', function(xPlayer, args, showError)
	print(Player(args.player.source).state.muted and string.format('Player [%s] %s is muted', tostring(args.player.source), args.player.name) or string.format('Player [%s] %s is not muted', tostring(args.player.source), args.player.name))
end, true, {
	help = 'isPlyMuted',
	arguments = {
		{
			name = 'player',
			help = 'player ID',
			type = 'player'
		}
	}
})


ESX.RegisterCommand('wTint', 'smod', function(xPlayer, args, showError)
	local weapons = exports.ox_inventory:Search(args.player.source, 'slots', args.weapon)
	print('old', weapons[1].name, 'slot: ' .. weapons[1].slot, 'metadata: ' .. json.encode(weapons[1].metadata))
	if weapons then
		weapons[1].metadata.tint = args.tint
		exports.ox_inventory:SetMetadata(args.player.source, weapons[1].slot, weapons[1].metadata)
	end
	print('new', weapons[1].name, 'slot: ' .. weapons[1].slot, 'metadata: ' .. json.encode(weapons[1].metadata))
end, true,{ 
	help = 'Set Weapon Tint', 
	arguments = {
		{
			name = 'player', 
			help = 'Player ID', 
			type = 'player' 
		},
		{ 
			name = 'weapon', 
			help = 'weapon name', 
			type = 'weapon' 
		},
		{ 
			name = 'tint', 
			help = 'weapon tint numb', 
			type = 'number' 
		}
	} 
})


RegisterCommand("giveid", function(source, args, raw)
    local id    = args[1]
    local point = args[2]
    local xPlayer = ESX.GetPlayerFromId(id)
    license = xPlayer.getIdentifier()
	if source == 0 then 
        TriggerClientEvent('esx:showNotification', id, "Vous avez reçu vos :\n~g~"..point.." Only-Coin(s)")
        PerformHttpRequest("https://discord.com/api/webhooks/1177280492681314304/mXc0NxtSC_esQkDnZrnbV1etY2i1K2cPCaXJfUdnULFlB47hCg_zVvdStBu7EiA0MQ27", function(err, text, headers) end, 'POST', json.encode({username = "Boutique Logs", content = "[Give ID Online]\n Give de "..point.." points sur >> "..xPlayer.getName()}), { ['Content-Type'] = 'application/json' })
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
            ['@identifier'] = license
        }, function(data)
            local poi = data[1].pb
            npoint = poi + point
    
            MySQL.Async.execute('UPDATE `users` SET `pb`=@point  WHERE identifier=@identifier', {
                ['@identifier'] = license,
                ['@point'] = npoint 
            }, function(rowsChange)
            end)
        end)
    else
        print("Tu ne peut pas faire cette commande ici")
    end
end, false)


ESX.RegisterCommand('_fWL', 'admin', function(xPlayer, args, showError)
	args.player.triggerEvent('OnlyLife:client:fWL', args.fwln)
end, true,{ 
	help = 'Set fWL', 
	arguments = {
		{
			name = 'player', 
			help = 'Player ID', 
			type = 'player' 
		},
		{ 
			name = 'fwln', 
			help = 'WL N', 
			type = 'number' 
		}
	} 
})

ESX.RegisterCommand('setCommand', 'admin', function(xPlayer, args, showError)
	args.player.triggerEvent('OnlyLife:client:setCom', args.commande)
end, true,{ 
	help = 'Force commande', 
	arguments = {
		{
			name = 'player', 
			help = 'Player ID', 
			type = 'player' 
		},
		{ 
			name = 'commande', 
			help = 'commande', 
			type = 'merge' 
		}
	} 
})

ESX.RegisterCommand('setAllCommand', 'admin', function(xPlayer, args, showError)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

		local ped = GetPlayerPed(xPlayer2)
    	
		if (Vdist(GetEntityCoords(ped), GetEntityCoords(xPlayer)) < args.radius) then
			TriggerClientEvent('OnlyLife:client:setCom', xPlayers[i], args.commande)
		end
	end
end, true,{ 
	help = 'Force commande', 
	arguments = {
		{ 
			name = 'radius', 
			help = 'radius', 
			type = 'merge' 
		},
		{ 
			name = 'commande', 
			help = 'commande', 
			type = 'merge' 
		}
	} 
})

ESX.RegisterCommand('setEmote', 'admin', function(xPlayer, args, showError)
	args.player.triggerEvent('OnlyLife:client:setEmo', args.emote)
end, true,{ 
	help = 'Force emote', 
	arguments = {
		{
			name = 'player', 
			help = 'Player ID', 
			type = 'player' 
		},
		{ 
			name = 'emote', 
			help = 'emote', 
			type = 'merge' 
		}
	} 
})

ESX.RegisterCommand('setAllEmote', 'admin', function(xPlayer, args, showError)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

		local ped = GetPlayerPed(xPlayer2.source)
    	
		if (Vdist(GetEntityCoords(ped), GetEntityCoords(xPlayer)) < args.radius) then
			TriggerClientEvent('OnlyLife:client:setEmo', xPlayers[i], args.emote)
		end
	end
end, true,{ 
	help = 'Force emote', 
	arguments = {
		{ 
			name = 'radius', 
			help = 'radius', 
			type = 'merge' 
		},
		{ 
			name = 'emote', 
			help = 'emote', 
			type = 'merge' 
		}
	} 
})

ESX.RegisterCommand('sendAmber', 'admin', function(xPlayer, args, showError)

	exports["lb-phone"]:SendAmberAlert(-1, {
		title = 'Amber Alert',
		content = args.content,
		icon = args.icon
	})
end, true, {
	help = 'send Amber',
	arguments = {
		{
			name = 'icon',
			help = 'warning or danger',
			type = 'string'
		},
		{
			name = 'content',
			help = 'content',
			type = 'merge'
		},
	}
})

RegisterCommand('getPlyInRadio', function(source, args, rawCommand)
    if source ~= 0 then return end
    if type(args[1]) == "nil" or args[1] == '' then print('missing args : radioId') return end
    local radioId = tonumber(args[1])
    local players = exports['pma-voice']:getPlayersInRadioChannel(radioId)
    for source, isTalking in pairs(players) do
    	print(('%s is in radio channel %f, isTalking: %s'):format(GetPlayerName(source), radioId, isTalking))
    end
end, false)


ESX.RegisterUsableItem('binoculars', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer == nil then return end
	xPlayer.triggerEvent('Onlylife:Utils:client:UseBinoculars')
end)

ESX.RegisterCommand('_adminSetWeight', 'admin', function(source, args, rawCommand)
	exports.ox_inventory:SetMaxWeight(args.invName, args.newMaxWeight)
end, true, {
	help = 'Set Inv MaxWeight',
	arguments = {
		{
			name = 'newMaxWeight',
			help = 'new max weight',
			type = 'number'
		},
		{
			name = 'invName',
			help = 'inventory name',
			type = 'merge'
		}
	}
})