ESX.RegisterServerCallback('esx_illegal:pickedUpWeedLeaf', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem('list_trave', 1) then
		xPlayer.addInventoryItem('list_trave', 1)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da nosis', 2)
	end
end)

ESX.RegisterServerCallback('esx_illegal:dryweed', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('list_trave').count > 0 and xPlayer.canCarryItem('list_trave2', 1) then
        xPlayer.removeInventoryItem('list_trave', 1)
        xPlayer.addInventoryItem('list_trave2', math.random(10, 20))
    end
end)


ESX.RegisterServerCallback('esx_illegal:makejoint', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local rc = xPlayer.getInventoryItem('rizle').count
		local tc = xPlayer.getInventoryItem('list_trave2').count
		if rc > 0 then
			if tc >= 5 then
				xPlayer.removeInventoryItem('rizle', 1)
				xPlayer.removeInventoryItem('list_trave2', 5)
				xPlayer.addInventoryItem('joint', 1)
			end
		end
	end
end)