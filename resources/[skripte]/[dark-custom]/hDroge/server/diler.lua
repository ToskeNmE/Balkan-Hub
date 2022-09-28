ESX.RegisterServerCallback('dark-droge:prodaj', function(source, cb, cena, itemname)
	local xPlayer = ESX.GetPlayerFromId(source)
    local iznos = xPlayer.getInventoryItem(itemname).count * cena
    if xPlayer.getInventoryItem(itemname).count > 0 then
        xPlayer.removeInventoryItem(itemname, xPlayer.getInventoryItem(itemname).count)
        xPlayer.addAccountMoney('black_money', iznos)
    else
        xPlayer.triggerEvent('dark:client:notify', 'Nemas dovoljno ' .. xPlayer.getInventoryItem(itemname).label .. ' da prodas!', 2)
    end
end)