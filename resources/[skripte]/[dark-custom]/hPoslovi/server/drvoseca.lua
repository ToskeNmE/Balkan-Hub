ESX.RegisterServerCallback('dark-poslovi:proveridalimozedanosi', function(source, cb, item, count)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.canCarryItem(item, count) then
      cb(true)
    else
      cb(false)
    end
  end
end)

ESX.RegisterServerCallback('dark-poslovi:dajdrvo', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.canCarryItem('ndrvo', 1) then
      xPlayer.addInventoryItem('ndrvo', 1)
    end
  end
end)

ESX.RegisterServerCallback('dark-poslovi:getajitemcount', function(source, cb, item)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    local item = xPlayer.getInventoryItem(item)
    cb(item.count)
  end
end)

ESX.RegisterServerCallback('dark-poslovi:dajpreradjenodrvo', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    local item = xPlayer.getInventoryItem('ndrvo').count
    if item > 0 then
      xPlayer.addInventoryItem('pdrvo', 1)
      xPlayer.removeInventoryItem('ndrvo', 1)
      xPlayer.triggerEvent('dark:client:notify', 'Preradio si 1 drvo', 3)
    end
  end
end)

ESX.RegisterServerCallback('dark-poslovi:prodajdrvo', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    local item = xPlayer.getInventoryItem('pdrvo').count
    if item > 0 then
      pare = math.random(Dark.Drvoseca.MinAmount, Dark.Drvoseca.MaxAmount)
      xPlayer.addMoney(pare)
      xPlayer.removeInventoryItem('pdrvo', 1)
      xPlayer.triggerEvent('dark:client:notify', 'Prodao si 1 drvo za ' .. pare .. '$', 3)
    end
  end
end)
