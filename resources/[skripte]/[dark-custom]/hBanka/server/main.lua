ESX.RegisterServerCallback('hub-banka:getajstvari', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local ime
        local banka
        local kartica
        local cvd
        exports.oxmysql:scalar('SELECT cardnumber FROM users WHERE identifier = ?', {xPlayer.identifier}, function(card)
            if card == nil then
                kartica = card
            else
                kartica = card
            end
        end)
        exports.oxmysql:query('SELECT * FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result then
                for _,v in pairs(result) do
                    if result[1].cardnumber ~= nil then
                        kartica = result[1].cardnumber
                    else
                        kartica = "**** **** ****"
                    end
                    if result[1].cvd ~= nil then
                        cvd = result[1].cvd
                    else
                        cvd = "***"
                    end
                    if result[1].pin ~= nil then
                        pin = result[1].pin
                    else
                        pin = "****"
                    end
                end
                cb({ ime = xPlayer.name, banka = xPlayer.getAccount('bank').money, kartica = kartica, cvd = cvd, pin = pin, kazne = kazne or {} })
            end
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:getajkazne', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local kazne = {}
        exports.oxmysql:query('SELECT * FROM `dark-racuni` WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result then
                for i = 1, #result, 1 do
                    table.insert(kazne, {
                        id = result[i].id,
                        identifier = result[i].identifier,
                        label = result[i].razlog,
                        cena = result[i].cena
                    })
                end
                cb(kazne or {})
            end
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:proveriprotekcija', function(source, cb, id) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:query('SELECT * FROM `dark-racuni` WHERE id = ?', {id}, function(result)
            if result ~= nil then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:platiracune', function(source, cb, id, cena) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getAccounts('black_money').money >= tonumber(cena) then
            xPlayer.triggerEvent('hub-banka:update:kazne', 'remove')
            exports.oxmysql:execute('DELETE FROM `dark-racuni` WHERE id = ?', {id})
            xPlayer.removeAccountMoney('bank', tonumber(cena))
            xPlayer.triggerEvent('hub-banka:success-notify', 'Platio si kaznu koja iznosi ' .. tonumber(cena) .. '$')
            xPlayer.triggerEvent('hub-banka:update:balance', xPlayer.getAccount('bank').money)
            xPlayer.triggerEvent('hub-banka:update:kazne', 'add')
        else
            xPlayer.triggerEvent('hub-banka:error-notify', 'Nemas dovoljno novca')
        end
    end
end)

ESX.RegisterServerCallback('hub-banka:getajkazne', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local kazne = {}
        exports.oxmysql:query('SELECT * FROM `dark-racuni` WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result then
                for i = 1, #result, 1 do
                    table.insert(kazne, {
                        id = result[i].id,
                        identifier = result[i].identifier,
                        label = result[i].razlog,
                        cena = result[i].cena
                    })
                end
                cb(kazne or {})
            end
        end)
    end
end)


ESX.RegisterServerCallback('hub-banka:napravikarticu', function(source, cb, kartica, cvd2) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:scalar('SELECT cardnumber FROM users WHERE identifier = ?', {xPlayer.identifier}, function(card)
            if card == "**** **** ****" then
                exports.oxmysql:scalar('SELECT cvd FROM users WHERE identifier = ?', {xPlayer.identifier}, function(cvd)
                    if cvd == "***" then
                        MySQL.prepare('UPDATE `users` SET `cardnumber` = ?, `cvd` = ? WHERE `identifier` = ?', {
                            kartica,
                            cvd2,
                            xPlayer.identifier
                        }, function(affectedRows)
                            xPlayer.triggerEvent('hub-banka:update:kartica', kartica, cvd2)
                            xPlayer.triggerEvent('hub-banka:success-notify', 'Uspesno si generisao karticu')
                        end)
                    end
                end)    
            end
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:deposit', function(source, cb, amount) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local novacnaruci = xPlayer.getAccount('money').money
        if novacnaruci >= tonumber(amount) then
            xPlayer.removeMoney(tonumber(amount))
            xPlayer.addAccountMoney('bank', tonumber(amount))
            xPlayer.triggerEvent('hub-banka:update:balance', xPlayer.getAccount('bank').money)
            xPlayer.triggerEvent('hub-banka:success-notify', 'Uspesno si ostavio ' .. tonumber(amount) .. "$")
            banka("**BANKA**", GetPlayerName(source) .. ' je ostavio ' .. tonumber(amount) .. '$')
        else
            xPlayer.triggerEvent('hub-banka:error-notify', 'Nemas dovoljno novca')
        end
    end
end)


ESX.RegisterServerCallback('hub-banka:withdraw', function(source, cb, amount) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local novacubanci = xPlayer.getAccount('bank').money
        if novacubanci >= tonumber(amount) then
            xPlayer.removeAccountMoney('bank', tonumber(amount))
            xPlayer.addMoney(tonumber(amount))
            xPlayer.triggerEvent('hub-banka:update:balance', xPlayer.getAccount('bank').money)
            xPlayer.triggerEvent('hub-banka:success-notify', 'Uspesno si podigao ' .. tonumber(amount) .. "$")
            banka("**BANKA**", GetPlayerName(source) .. ' je podigao ' .. tonumber(amount) .. '$')
        else
            xPlayer.triggerEvent('hub-banka:error-notify', 'Nemas dovoljno novca')
        end
    end
end)

local accounti = {}

ESX.RegisterServerCallback('hub-banka:transfer', function(source, cb, amount, cardnumber) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:single('SELECT * FROM users WHERE cardnumber = ?', {cardnumber}, function(result)
            if result then
                local accounts = json.decode(result.accounts)
                for account,money in pairs(accounts) do
                    accounti[account] = money
                end
                accounti['bank'] = ESX.Math.Round(accounti['bank'] + amount)
                
                local parenaracuni = xPlayer.getAccount('bank').money
                if parenaracuni >= tonumber(amount) then
                    exports.oxmysql:update('UPDATE users SET accounts = ? WHERE cardnumber = ? ', {json.encode(accounti), cardnumber}, function(affectedRows)
                        if affectedRows then
                            xPlayer.removeAccountMoney('bank', tonumber(amount))
                            accounti = {}
                            xPlayer.triggerEvent('hub-banka:success-notify', 'Poslao si ' .. tonumber(amount) .. "$ " .. result.firstname .. ' ' .. result.lastname)
                            xPlayer.triggerEvent('hub-banka:update:balance', xPlayer.getAccount('bank').money)
                            banka("**BANKA**", GetPlayerName(source) .. ' je poslao ' .. tonumber(amount) .. '$ na karticu ' .. cardnumber)
                        end
                    end)
                else
                    xPlayer.triggerEvent('hub-banka:error-notify', 'Nemas dovoljno novca u banci')
                end
            else
                xPlayer.triggerEvent('hub-banka:error-notify', 'Broj kartice ne postoji')
            end
        end)
    end
end)


ESX.RegisterServerCallback('hub-banka:getajkarticu', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:scalar('SELECT cardnumber FROM users WHERE identifier = ?', {xPlayer.identifier}, function(card)
            cb(card)
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:napravipin', function(source, cb, pin) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:scalar('SELECT pin FROM users WHERE identifier = ?', {xPlayer.identifier}, function(pin2)
            if pin2 == '****' then
                MySQL.prepare('UPDATE `users` SET `pin` = ? WHERE `identifier` = ?', {
                    pin,
                    xPlayer.identifier
                }, function(affectedRows)
                    xPlayer.triggerEvent('hub-banka:update:pin', pin)
                    xPlayer.triggerEvent('hub-banka:success-notify', 'Uspesno si generisao PIN')
                end)  
            end
        end)
    end
end)

ESX.RegisterServerCallback('hub-banka:getajcard', function(source, cb, card)
    local kartica = MySQL.scalar.await('SELECT cardnumber FROM users WHERE cardnumber = ?', {card})
    if (kartica ~= "**** **** ****") then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('hub-banka:getajcvd', function(source, cb, cvd2)
    local cvdkod = MySQL.scalar.await('SELECT cvd FROM users WHERE cvd = ?', {cvd2})
    if (cvdkod ~= '***') then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('hub-banka:getajpin', function(source, cb, pin2)
    local pinkod = MySQL.scalar.await('SELECT pin FROM users WHERE pin = ?', {pin2})
    if (pinkod ~= '****') then
        cb(true)
    else
        cb(false)
    end
end)

function banka(name, message)
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
      PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Banka 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end