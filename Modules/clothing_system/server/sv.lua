local oxinv = exports.ox_inventory

RegisterServerEvent('Huid_ClotheShop:EditWeight')
AddEventHandler('Huid_ClotheShop:EditWeight', function(bags)
	if bags then
		oxinv:SetMaxWeight(source, 48000)
	else
		oxinv:SetMaxWeight(source, 30000)
	end
end)

RegisterServerEvent('Huid_ClotheShop:Admin')
AddEventHandler('Huid_ClotheShop:Admin', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	local playerGroup = xPlayer.getGroup()
	if playerGroup == "admin" or playerGroup == "god" or playerGroup == "smod" then
		oxinv:SetMaxWeight(source, 1000000000)
	end
end)

RegisterServerEvent('clothshop:server:buyClothingItem')
AddEventHandler('clothshop:server:buyClothingItem', function(data)
	--print('clothshop:server:buyClothingItem triggered')
	--print(json.encode(data))
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end
	if oxinv:GetItemCount(source, "money") < (data.price * data.amount) then
		xPlayer.showNotification('Tu n\'a pas assez d\'argent sur toi !')
		return
	end
	oxinv:RemoveItem(source, "money", (data.price * data.amount))
	if data.type == 'all' then
		if oxinv:CanCarryItem(source, 'allclothe', data.amount) then
			local metadata = {
				arms = data.components[4].drawable,
				arms2 = data.components[4].texture,
				pant1 = data.components[5].drawable,
				pant2 = data.components[5].texture,
				shoes1 = data.components[7].drawable,
				shoes2 = data.components[7].texture,
				chain1 = data.components[8].drawable,
				chain2 = data.components[8].texture,
				shirt1 = data.components[9].drawable,
				shirt2 = data.components[9].texture,
				bproof1 = data.components[10].drawable,
				bproof2 = data.components[10].texture,
				decals1 = data.components[11].drawable,
				decals2 = data.components[11].texture,
				torso1 = data.components[12].drawable,
				torso2 = data.components[12].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'allclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'tshirt' then
		if oxinv:CanCarryItem(source, 'topclothe', data.amount) then
			local metadata = {
				arms = data.components[4].drawable,
				arms2 = data.components[4].texture,
				chain1 = data.components[8].drawable,
				chain2 = data.components[8].texture,
				shirt1 = data.components[9].drawable,
				shirt2 = data.components[9].texture,
				bproof1 = data.components[10].drawable,
				bproof2 = data.components[10].texture,
				decals1 = data.components[11].drawable,
				decals2 = data.components[11].texture,
				torso1 = data.components[12].drawable,
				torso2 = data.components[12].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'topclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'pant' then
		if oxinv:CanCarryItem(source, 'pantclothe', data.amount) then
			local metadata = {
				pant1 = data.components[5].drawable,
				pant2 = data.components[5].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'pantclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'shoes' then
		if oxinv:CanCarryItem(source, 'shoesclothe', data.amount) then
			local metadata = {
				shoes1 = data.components[7].drawable,
				shoes2 = data.components[7].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'shoesclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'bags' then
		if oxinv:CanCarryItem(source, 'bagclothe', data.amount) then
			local metadata = {
				bag1 = data.components[6].drawable,
				bag2 = data.components[6].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'bagclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'mask' then
		if oxinv:CanCarryItem(source, 'maskclothe', data.amount) then
			local metadata = {
				mask1 = data.components[2].drawable,
				mask2 = data.components[2].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'maskclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'bracelet' then
		if oxinv:CanCarryItem(source, 'braceletclothe', data.amount) then
			local metadata = {
				bracelet1 = data.components[5].drawable,
				bracelet2 = data.components[5].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'braceletclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'ears' then
		if oxinv:CanCarryItem(source, 'earsclothe', data.amount) then
			local metadata = {
				ears1 = data.components[3].drawable,
				ears2 = data.components[3].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'earsclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'watche' then
		if oxinv:CanCarryItem(source, 'watcheclothe', data.amount) then
			local metadata = {
				watche1 = data.components[4].drawable,
				watche2 = data.components[4].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'watcheclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'glasse' then
		if oxinv:CanCarryItem(source, 'glasseclothe', data.amount) then
			local metadata = {
				glasse1 = data.components[2].drawable,
				glasse2 = data.components[2].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'glasseclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	elseif data.type == 'cap' then
		if oxinv:CanCarryItem(source, 'capclothe', data.amount) then
			local metadata = {
				helmet1 = data.components[1].drawable,
				helmet2 = data.components[1].texture,
			}
			if data.label ~= nil or data.label ~= '' or data.label ~= ' ' then
				metadata['label'] = data.label
			end
			oxinv:AddItem(source, 'capclothe', data.amount, metadata)
		else
			xPlayer.showNotification('Tu n\'a pas assez de place sur toi !')
		end
	end
end)
