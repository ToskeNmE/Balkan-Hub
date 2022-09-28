ESX = nil

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)

RegisterNetEvent("dark:goto:vip:posaljireq")
AddEventHandler("dark:goto:vip:posaljireq", function(imevipa)
    pozvan = true
    exports['hNotifikacije']:Notifikacije('Dobio si zahtev za tp od ' .. imevipa .. '<br> /prihvati ili /odbij', 1)
end)

RegisterCommand("prihvati", function()
    if pozvan then
       pozvan = false
       ESX.TriggerServerCallback('dark:goto:vip:tpajvipa', function() end)
    else
        exports['hNotifikacije']:Notifikacije('Nemas ni jedan zahtev za goto', 2)
    end
end)

RegisterCommand("odbij", function()
    if pozvan then
       pozvan = false
       exports['hNotifikacije']:Notifikacije('Odbio si zahtev za tp', 1)
       ESX.TriggerServerCallback('dark:goto:vip:odbiotp', function() end)
    else
        exports['hNotifikacije']:Notifikacije('Nemas ni jedan zahtev za goto', 2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(sleep)
        sleep = 800
        if pozvan then
            sleep = 0
            Wait(60000)
            pozvan = false
            --ESX.TriggerServerCallback('dark:goto:vip:istekaotp', function() end)
            exports['hNotifikacije']:Notifikacije('Zahtev za goto je istekao', 2)
        end
    end
end)