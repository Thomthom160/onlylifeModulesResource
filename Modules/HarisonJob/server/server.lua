ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'harinson', 'harinson', 'society_harinson', 'society_harinson', 'society_harinson', 'society_mechanic_harinson', {type = 'public'})
--Annonces
--RegisterServerEvent('Ouvre:harinson')
exports["WaveShield"]:AddEventHandler('Ouvre:harinson', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Walker & Associés', '~y~Annonce', 'Le cabinet est désormais ~g~Ouvert~s~ !', 'HARINSON', 8)
	end
end)

--RegisterServerEvent('Ferme:harinson')
exports["WaveShield"]:AddEventHandler('Ferme:harinson', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Walker & Associés', '~y~Annonce', 'Le cabinet est désormais ~r~Fermer~s~ !', 'HARINSON', 8)
	end
end)

--Webhook pour l'accueil
ConfigWebhookRendezVous = "https://discord.com/api/webhooks/1121414943720341534/mWhIlq5t-Fpk287IfiwGXrXJdm27jQ9lzvwKTkW8JVN605Uaz4ytsJxoBY2KhTn5P6Q2"

