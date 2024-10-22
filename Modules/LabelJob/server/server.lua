ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'label', 'label', 'society_label', 'society_label', 'society_label', 'society_mechanic_label', {type = 'public'})
--Annonces
--RegisterServerEvent('Ouvre:label')
exports["WaveShield"]:AddEventHandler('Ouvre:label', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Life Is Good Label', '~y~Annonce', 'Le label est désormais ~g~Ouvert~s~ !', 'label', 8)
	end
end)

--RegisterServerEvent('Ferme:label')
exports["WaveShield"]:AddEventHandler('Ferme:label', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Life Is Good Label', '~y~Annonce', 'Le label est désormais ~r~Fermer~s~ !', 'label', 8)
	end
end)

--Webhook pour l'accueil
ConfigWebhookRendezVous = "https://discord.com/api/webhooks/1121414943720341534/mWhIlq5t-Fpk287IfiwGXrXJdm27jQ9lzvwKTkW8JVN605Uaz4ytsJxoBY2KhTn5P6Q2"

