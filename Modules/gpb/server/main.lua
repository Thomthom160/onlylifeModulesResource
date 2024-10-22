ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('gpb_illegal:GiveGPBVide')
AddEventHandler('gpb_illegal:GiveGPBVide', function()
	exports.ox_inventory:AddItem(source, 'gpb_illegal_vide', 1)
end)

RegisterNetEvent('gpb_illegal:GiveGPB')
AddEventHandler('gpb_illegal:GiveGPB', function()
	local playerArmour = GetPedArmour(GetPlayerPed(source))
	exports.ox_inventory:AddItem(source, 'gpb_illegal', 1, {gpbdurability = playerArmour})
end)