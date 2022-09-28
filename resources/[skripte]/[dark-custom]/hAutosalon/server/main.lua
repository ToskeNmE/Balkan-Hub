ESX.RegisterServerCallback('dark-autosalon:proverinovac', function(source, cb, novac)
  print(tablica)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if xPlayer.getMoney() >= tonumber(novac) then
      cb(true)
      xPlayer.removeMoney(novac)
    else
      cb(false)
    end
  end
end)

ESX.RegisterServerCallback('dark-autosalon:log', function(source, cb, novac, label, tablica)
  autosalon('**Auto Salon**', GetPlayerName(source).. ' je kupio vozilo ' .. label .. ' sa tablicama ' .. tablica .. ' za ' .. novac .. '$')
end)

ESX.RegisterServerCallback('dark-autosalon:dajownera', function(source, cb, vehprops)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (?, ?, ?, 0) ', {xPlayer.identifier, vehprops.plate, json.encode(vehprops)}, function(id)
      cb(true)
    end)
  end
end)

function autosalon(name, message)
  local vrijeme = os.date('*t')  
  local poruka = {
        {
            ["color"] = 16711680,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "Vreme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
            },
        }
      }
    PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark AutoSalon 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end