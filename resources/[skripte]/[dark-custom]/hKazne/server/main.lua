ESX.RegisterServerCallback("dark-kazne:napravikaznu", function(source, cb, razlog, cena, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer then
        if xTarget then
            MySQL.insert('INSERT INTO `dark-racuni` (identifier, razlog, cena) VALUES (?, ?, ?)', {xTarget.identifier, razlog, cena}, function(id)
                xPlayer.triggerEvent('dark:client:notify', 'Poslao si kaznu koja iznosi ' .. cena .. '$ ' .. xTarget.name, 1)
                xTarget.triggerEvent('dark:client:notify', 'Dobio si kaznu koja iznosi ' .. cena .. '$', 1)
                kazne('**Kazne**', GetPlayerName(source) .. ' je napisao kaznu ' .. GetPlayerName(target) .. ' RAZLOG : ' .. razlog .. ' | CENA : ' .. tonumber(cena) .. '$')
            end)
        end
    end
end)

ESX.RegisterServerCallback("dark-kazne:getajkazne", function (source,cb, identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then
        MySQL.query('SELECT * FROM `dark-racuni` WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result then
                local kazne = {}
                for _, v in pairs(result) do
                    table.insert(kazne, {
                        razlog = v.razlog,
                        cena = v.cena 
                    })
                end
                cb(kazne or {})
            end
        end)
    end
end)

function kazne(name, message)
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
      PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Kazne 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end