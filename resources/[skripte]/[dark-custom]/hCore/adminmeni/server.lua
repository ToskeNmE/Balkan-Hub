ESX.RegisterServerCallback('dark-adminmeni:obrisivozilazasve', function(source, cb)
    TriggerClientEvent("dark-adminmeni:obrisivozila", -1)
    TriggerClientEvent("dark:client:notify", -1, "Sva vozila su obrisana od strane " .. GetPlayerName(source) .. '!')
end)

ESX.RegisterServerCallback('dark-adminmenu:proverigrupu', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if Dark.GrupaZaAdminMeni[xPlayer.getGroup()] and xPlayer.proveriDuznost() then
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)
