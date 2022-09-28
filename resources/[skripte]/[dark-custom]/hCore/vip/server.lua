ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Dark.Komande[1].imecmd, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args[1])
    if xPlayer then
        if xTarget then
            if Dark.Komande[1].permisije[xPlayer.getGroup()] then
                exports.oxmysql:single('SELECT * FROM users WHERE identifier = ?', {xTarget.identifier}, function(result)
                    if result.vip == 0 then
                        exports.oxmysql:update('UPDATE users SET vip = 1 WHERE identifier = ? ', {xTarget.identifier}, function(proces)
                            if proces then
                                print("Admin " .. GetPlayerName(source) .. " je dao vipa igracu " .. GetPlayerName(args[1]))
                                xPlayer.triggerEvent('dark:client:notify', 'Dao si vipa igracu ' .. GetPlayerName(args[1]), 3)
                            end
                        end)
                    else
                        xPlayer.triggerEvent('dark:client:notify', 'Ovaj igrac vec ima vipa', 2)
                    end
                end)
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvole', 2)
            end
        else
            xPlayer.triggerEvent('dark:client:notify', 'Ovaj igrac ne postoji', 2)
        end
    end
end)

RegisterCommand(Dark.Komande[2].imecmd, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args[1])
    if xPlayer then
        if xTarget then
            if Dark.Komande[2].permisije[xPlayer.getGroup()] then
                exports.oxmysql:single('SELECT * FROM users WHERE identifier = ?', {xTarget.identifier}, function(result)
                    if result.vip == 1 then
                        exports.oxmysql:update('UPDATE users SET vip = 0 WHERE identifier = ? ', {xTarget.identifier}, function(proces)
                            if proces then
                                print("Admin " .. GetPlayerName(source) .. " je skinuo vipa igracu " .. GetPlayerName(args[1]))
                                xPlayer.triggerEvent('dark:client:notify', 'Skinuo si vipa igracu ' .. GetPlayerName(args[1]), 3)
                            end
                        end)
                    else
                        xPlayer.triggerEvent('dark:client:notify', 'Ovaj igrac vec ima vipa', 2)
                    end
                end)
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvole', 2)
            end
        else
            xPlayer.triggerEvent('dark:client:notify', 'Ovaj igrac ne postoji', 2)
        end
    end
end)

ESX.RegisterServerCallback("dark-vip:proverivipa", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        exports.oxmysql:single('SELECT * FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result.vip == 1 then
                cb(true)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

RegisterCommand("g", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local poruka = table.concat(args, " ", 1)
    if xPlayer then
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local vip = ESX.GetPlayerFromId(xPlayers[i])
            if vip then
                exports.oxmysql:single('SELECT * FROM users WHERE identifier = ?', {vip.identifier}, function(result)
                    if result.vip == 1 then
                        TriggerClientEvent('chat:addMessage', xPlayers[i], {
                            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(251, 163, 26, 0.8); border-radius: 10px;"><i class="fas fa-envelope"></i> VIP CHAT <br>' .. GetPlayerName(source) .. ' » {0}</div>',
                            args = { poruka }
                        })
                    end
                end)
            end
        end
    end
end)