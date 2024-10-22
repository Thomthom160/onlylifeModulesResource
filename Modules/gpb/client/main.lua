ESX = exports["es_extended"]:getSharedObject()
local ox_inventory = exports.ox_inventory

exports('gpb_illegal', function(data, slot)
	if GetPedArmour(PlayerPedId()) >= 40 then
		ESX.ShowNotification('Tu n\'en à pas besoin')
	else
		ox_inventory:useItem(data, function(data)
			if not data then return end
			if data.metadata.gpbdurability == nil or data.metadata.gpbdurability < 0 then
				SetPedArmour(PlayerPedId(), 50)
			else
				SetPedArmour(PlayerPedId(), data.metadata.gpbdurability)
			end
			TriggerServerEvent('gpb_illegal:GiveGPBVide')
		end)
	end
end)

exports('gpb_illegal_vide', function(data, slot)
	if GetPedArmour(PlayerPedId()) <= 10 then
		ESX.ShowNotification('Tu n\'en à pas besoin')
	else
		ox_inventory:useItem(data, function(data)
			if not data then return end
			SetPedArmour(PlayerPedId(), 0)
			TriggerServerEvent('gpb_illegal:GiveGPB')
		end)
	end
end)


ox_inventory:displayMetadata('gpbdurability', 'Durabilité')
