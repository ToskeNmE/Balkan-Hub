ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'vlada', 'vlada', true, true)
TriggerEvent('esx_society:registerSociety', 'vlada', 'vlada', 'society_vlada', 'society_vlada', 'society_vlada', {type = 'public'})

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:confiscatePlayerItem')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'vlada' then
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
				TriggerEvent('hub_baze:pretrazivanjeLog', sourceXPlayer.getName(), targetXPlayer.getName(), sourceItem.label, amount)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		TriggerEvent('hub_baze:pretrazivanjeLog', sourceXPlayer.getName(), targetXPlayer.getName(), itemName, amount)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)
		TriggerClientEvent("esx:removeWeapon", target)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		TriggerEvent('hub_baze:pretrazivanjeLog', sourceXPlayer.getName(), targetXPlayer.getName(), ESX.GetWeaponLabel(itemName), amount)
	end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vlada' then
		TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff', target)
	else
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:drag')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vlada' then
		TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:drag', target, source)
	else
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vlada' then
		TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle', target)
	else
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vlada' then
		TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle', target)
	else
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:getStockItem')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vlada', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:putStockItems')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vlada', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.label))
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	local data = {
		name      = GetPlayerName(target),
		job       = xPlayer.job,
		inventory = xPlayer.inventory,
		accounts  = xPlayer.accounts,
		weapons   = xPlayer.loadout
	}

	cb(data)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)
				retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)
				cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_vlada', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_vlada', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_vlada', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('grandsonvolizenenajvise213vladagradonacelnik: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vlada', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:message')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:znacka')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:znacka', function(player, target)
	xPlayer = ESX.GetPlayerFromId(player)
	if xPlayer.job.name == 'vlada' then
	TriggerClientEvent("grandsonvolizenenajvise213vladagradonacelnik:znackaAnim", player)
    TriggerClientEvent("hub_notifikacije:SendNotification2", target, {
        text = "<font style='font-size: 12px'><div style='min-width: 700px; min-height: 200px; background-image: url(https://cdn.discordapp.com/attachments/668123952488644622/821477030494339112/state.png); background-size: contain; background-position: left;  background-repeat: no-repeat;'><div style='position: absolute; top: 130px; left: 20px; color:#000000'><B>Ime:</b> <BR>" ..xPlayer.getName().." <BR><BR><B>cin:</B> ".. xPlayer.job.grade_label .. "<BR></div>",
        type = "info",
        queue = "global",
        timeout = 6000,
        layout = "center"
    })
    end
end)

RegisterServerEvent('skillbar:otvori')
AddEventHandler('skillbar:otvori', function(target)

	TriggerClientEvent("grandsonvolizenenajvise213vladagradonacelnik:skillbar", target)

end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:requestarrest')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == 'vlada' then
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:doarrested', _source)
    end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:requestrelease')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name == 'vlada' then
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:douncuffing', _source)
    end
end)

RegisterServerEvent('grandsonvolizenenajvise213vladagradonacelnik:sc')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:sc', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == 'vlada' then
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:loose', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('grandsonvolizenenajvise213vladagradonacelnik:douncuffing', _source)
    end
end)


function vlada(name, message)
    local poruka = {
        {
            ["color"] = 16711680,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "HUB | vlada 👮",
            },
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/909888988817539142/55KZQcyf_Y0-B18bSxNqqO9B_qjrXw4t65Ae3Eo1O3uhQfQbiQzT4GNdVxjF73lxAF_y", function(err, text, headers) end, 'POST', json.encode({username = "HUB | vlada Logovi 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end