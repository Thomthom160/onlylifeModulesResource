ESX = exports["es_extended"]:getSharedObject()



local money = 100



--RegisterNetEvent('huid_kart:cobro')
exports["WaveShield"]:AddEventHandler('huid_kart:cobro', function(source)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= money then

		xPlayer.removeMoney(money)

	elseif xPlayer.getAccount('bank').money >= money then

		xPlayer.removeAccountMoney('bank', money)

	else

		ESX.ShowNotification("You don't have money to pay")

	end

end)