ESX.RegisterServerCallback('dark-poslovi:iskopajkamen', function(source, cb, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
      if xPlayer.canCarryItem(item, amount) then
        xPlayer.addInventoryItem(item, amount)
      end
    end
end)

ESX.RegisterServerCallback('dark-poslovi:prodajrude', function(source, cb, cena, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
      local item = xPlayer.getInventoryItem(itemname).count
      if item > 0 then
        xPlayer.addMoney(item * cena)
        xPlayer.removeInventoryItem(itemname, item)
        xPlayer.triggerEvent('dark:client:notify', 'Prodao si ' .. item .. 'x ' .. xPlayer.getInventoryItem(itemname).label .. ' za ' .. (item * cena) .. '$', 3)
      else
        xPlayer.triggerEvent('dark:client:notify', 'Nemad dovoljno ' .. xPlayer.getInventoryItem(itemname).label .. ' da bi prodao!', 2)
      end
    end
  end)