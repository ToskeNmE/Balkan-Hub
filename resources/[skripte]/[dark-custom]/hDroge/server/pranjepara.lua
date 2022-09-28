ESX.RegisterServerCallback('dark-pranjepara:operipare', function(source, cb, iznos)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if iznos ~= nil then
            local getajnovac = xPlayer.getAccount('black_money').money
            if getajnovac >= iznos then
                xPlayer.removeAccountMoney('black_money', iznos)
                xPlayer.addAccountMoney('money', iznos)
                xPlayer.triggerEvent('dark:client:notify', 'Oprao si ' .. iznos .. '$', 3)
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nemas toliko novca da operes', 2)
            end
        end
    end
 end)