ESX.RegisterServerCallback('esx_illegal:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)

ESX.RegisterServerCallback('esx_illegal:have', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getInventoryItem(item).count)
end)

ESX.RegisterServerCallback('esx_illegal:pickedUpCocaLeaf', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem('list_koke', 1) then
		xPlayer.addInventoryItem('list_koke', 1)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da nosis', 2)
	end
end)

ESX.RegisterServerCallback('esx_illegal:proccesscoke', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('list_koke').count >= 3 and xPlayer.getInventoryItem('glukoza').count >= 1 then
		xPlayer.removeInventoryItem('list_koke', 3)
        xPlayer.removeInventoryItem('glukoza', 1)
        xPlayer.addInventoryItem('blok_koke', 1)
        cb(true)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da nosis', 2)
	end
end)

ESX.RegisterServerCallback('esx_illegal:giveblock', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('blok_koke').count > 0 and xPlayer.getInventoryItem('kesica').count >= 5 then
		xPlayer.removeInventoryItem('blok_koke', 1)
        xPlayer.removeInventoryItem('kesica', 5)
        xPlayer.addInventoryItem('kesica_koke', 10)
        cb(true)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da nosis', 2)
	end
end)