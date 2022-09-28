ESX.RegisterServerCallback('dark-bakica:checkmoneyfromnigger', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local balance = xPlayer.getAccount(Dark.Account).money
        if balance >= tonumber(Dark.Price) then
            cb(true)
        else
            cb(false)   
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('dark-bakica:removemoneyfromniggers', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local balance = xPlayer.getAccount(Dark.Account).money
        if balance >= tonumber(Dark.Price) then
            xPlayer.removeAccountMoney(Dark.Account, tonumber(Dark.Price))
            xPlayer.triggerEvent('esx_ambulancejob:revive')
            bakica('**Bakica**', GetPlayerName(source) .. ' se oziveo kod bakice!')
        end
    end
end)

function bakica(name, message)
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