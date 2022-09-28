ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'deltaforce', _U('alert_deltaforce'), true, true)
TriggerEvent('esx_society:registerSociety', 'deltaforce', 'deltaforce', 'society_deltaforce', 'society_deltaforce', 'society_deltaforce', {type = 'public'})

exports.ox_inventory:RegisterStash('Sef deltaforce', 'Sef Delta',  50, 200000)

exports.ox_inventory:RegisterStash('Deltaforce Sef', 'Deltaforce Sef', 500, 200000)
exports.ox_inventory:RegisterStash('Deltaforce Sef 2', 'Deltaforce Sef 2', 500, 200000)
exports.ox_inventory:RegisterStash('Deltaforce Sef 3', 'Deltaforce Sef 3', 500, 200000)
exports.ox_inventory:RegisterStash('Deltaforce Sef 4', 'Deltaforces Sef 4', 500, 200000)

RegisterServerEvent('esx_deltaforcejob:confiscatePlayerItem')
AddEventHandler('esx_deltaforcejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'deltaforce' then
		print(('esx_deltaforcejob: %s attempted to confiscate!'):format(xPlayer.identifier))
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
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('esx_deltaforcejob:handcuff')
AddEventHandler('esx_deltaforcejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'deltaforce' then
		TriggerClientEvent('esx_deltaforcejob:handcuff', target)
	else
		print(('esx_deltaforcejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_deltaforcejob:drag')
AddEventHandler('esx_deltaforcejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'deltaforce' then
		TriggerClientEvent('esx_deltaforcejob:drag', target, source)
	else
		print(('esx_deltaforcejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_deltaforcejob:putInVehicle')
AddEventHandler('esx_deltaforcejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'deltaforce' then
		TriggerClientEvent('esx_deltaforcejob:putInVehicle', target)
	else
		print(('esx_deltaforcejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_deltaforcejob:OutVehicle')
AddEventHandler('esx_deltaforcejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'deltaforce' then
		TriggerClientEvent('esx_deltaforcejob:OutVehicle', target)
	else
		print(('esx_deltaforcejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_deltaforcejob:getStockItem')
AddEventHandler('esx_deltaforcejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_deltaforce', function(inventory)
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

RegisterServerEvent('esx_deltaforcejob:putStockItems')
AddEventHandler('esx_deltaforcejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
end)

ESX.RegisterServerCallback('esx_deltaforcejob:getOtherPlayerData', function(source, cb, target)
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

RegisterServerEvent('esx_billing:posaljikaznu')
AddEventHandler('esx_billing:posaljikaznu', function(playerId, sharedAccountName, label, amount)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local xTarget = ESX.GetPlayerFromId(playerId)
  amount = ESX.Math.Round(amount)

  if amount > 0 then
      if xTarget ~= nil then
          if xTarget.getAccount("bank")["money"] >= amount then
            xTarget.removeAccountMoney("bank", amount)
           -- local sefnovac = math.floor((amount / 100) * 20)

            TriggerEvent('sogolisica_sefovi:racunSef', 'mechanic', 'item_account' , amount, 'money')
            --print(sefnovac)

            TriggerClientEvent("pNotify:SendNotification", xTarget.source, {text = "Platili ste račun u iznosu od " .. ESX.Math.GroupDigits(amount) .. "€!", type = "success", queue = "success", timeout = 2000, layout = "center"})
            TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Naplatili ste račun od " .. ESX.Math.GroupDigits(amount) .. "€ " .. xTarget.getName(), type = "success", queue = "success", timeout = 2000, layout = "center"})
          else
            TriggerClientEvent("pNotify:SendNotification", xTarget.source, {text = "Nemate dovoljno novca da platite račun!", type = "success", queue = "success", timeout = 2000, layout = "center"})
            TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Klijent nema dovoljno novca, Stanje: " .. xTarget.getAccount("bank")["money"], type = "success", queue = "success", timeout = 2000, layout = "center"})
          end
        end
  else
    TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "Račun mora imati veću vrednost od 1€!", type = "success", queue = "success", timeout = 2000, layout = "center"})
  end

end)	


ESX.RegisterServerCallback('esx_deltaforcejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_deltaforcejob:dajoruzije', function(source, cb, gun, kolicina)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.job.name == 'deltaforce' then
			xPlayer.addInventoryItem(gun, kolicina)
		end
	end
end)

ESX.RegisterServerCallback('esx_deltaforcejob:getVehicleInfos', function(source, cb, plate)

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

ESX.RegisterServerCallback('esx_deltaforcejob:getVehicleFromPlate', function(source, cb, plate)
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

ESX.RegisterServerCallback('esx_deltaforcejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_deltaforce', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_deltaforcejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_deltaforce', function(store)
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

ESX.RegisterServerCallback('esx_deltaforcejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_deltaforce', function(store)

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

ESX.RegisterServerCallback('esx_deltaforcejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_deltaforcejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
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
				print(('esx_deltaforcejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_deltaforcejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_deltaforce', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_deltaforcejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('esx_deltaforcejob:message')
AddEventHandler('esx_deltaforcejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('balkankings_policija:znacka')
AddEventHandler('balkankings_policija:znacka', function(player, target)
	xPlayer = ESX.GetPlayerFromId(player)
	if xPlayer.job.name == 'deltaforce' then
	TriggerClientEvent("balkankings_policija:znackaAnim", player)
    TriggerClientEvent("pNotify:SendNotification2", target, {
        text = "<font style='font-size: 22px'><div style='min-width: 514px; min-height: 274px; background-image: url(file:///C:/Users/admin/Desktop/hS2H5mY.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 110px; left: 58px; color:#000000'><B>Ime:</b> <BR>" ..xPlayer.getName().." <BR><BR><B>Čin:</B> ".. xPlayer.job.grade_label .. "<BR></div>",
        type = "info",
        queue = "global",
        timeout = 6000,
        layout = "centerLeft2"
    })
    end
end)

RegisterServerEvent('esx_deltaforcejob:requestarrest')
AddEventHandler('esx_deltaforcejob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == 'deltaforce' then
    TriggerClientEvent('esx_deltaforcejob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_deltaforcejob:doarrested', _source)
    end
end)

RegisterServerEvent('esx_deltaforcejob:requestrelease')
AddEventHandler('esx_deltaforcejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name == 'deltaforce' then
    TriggerClientEvent('esx_deltaforcejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_deltaforcejob:douncuffing', _source)
    end
end)

RegisterServerEvent('esx_deltaforcejob:sc')
AddEventHandler('esx_deltaforcejob:sc', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == 'deltaforce' then
    TriggerClientEvent('esx_deltaforcejob:loose', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_deltaforcejob:douncuffing', _source)
    end
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local playerId = source

	-- Did the player ever join?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is it worth telling all clients to refresh?
		if xPlayer and xPlayer.job.name == 'deltaforce' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_deltaforcejob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_deltaforcejob:spawned')
AddEventHandler('esx_deltaforcejob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'deltaforce' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_deltaforcejob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_deltaforcejob:forceBlip')
AddEventHandler('esx_deltaforcejob:forceBlip', function()
	TriggerClientEvent('esx_deltaforcejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_deltaforcejob:updateBlip', -1)
	end
end)

-- Lecenje

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('drp-policija:payBill')
AddEventHandler('drp-policija:payBill', function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	--change price here for revive
	xPlayer.removeMoney(1)
    TriggerClientEvent('esx:showNotification', src, '~w~Platio si ~b~$1~w~ za lecenje.')
end)