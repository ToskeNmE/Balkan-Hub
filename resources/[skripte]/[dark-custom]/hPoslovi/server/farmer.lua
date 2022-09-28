ESX.RegisterServerCallback('dark-poslovi:lootajzbun', function(source, cb, amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.canCarryItem('tresnje', amount) then
        xPlayer.addInventoryItem('tresnje', amount)
        xPlayer.triggerEvent('dark:client:notify', 'Ubradio si ' .. amount .. ' tresanja', 3)
    end
  end
end)

ESX.RegisterServerCallback('dark-poslovi:prodajtresnje', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    local item = xPlayer.getInventoryItem('tresnje').count
    if item > 0 then
      xPlayer.addMoney(item * Dark.Farmer.Amount)
      xPlayer.removeInventoryItem('tresnje', item)
      xPlayer.triggerEvent('dark:client:notify', 'Prodao si ' .. item .. ' tresanja za ' .. (item * Dark.Farmer.Amount) .. '$', 3)
    end
  end
end)
