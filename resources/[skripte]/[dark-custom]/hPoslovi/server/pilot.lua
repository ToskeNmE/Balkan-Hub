ESX.RegisterServerCallback('dark-poslovi:platipilot', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local amount = math.random(Dark.Pilot.Iznos.min, Dark.Pilot.Iznos.max)
        xPlayer.addMoney(amount)
        xPlayer.triggerEvent('dark:client:notify', 'Zaradio si ' .. amount .. '$ od ture', 3)
        cb(true)
    else
        cb(false)
    end
end)