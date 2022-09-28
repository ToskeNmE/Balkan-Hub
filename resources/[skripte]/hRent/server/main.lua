ESX = nil
VehiclesRented = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("hub_rentanje:rent")
AddEventHandler("hub_rentanje:rent", function(k, v, plate, store)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if player.getAccount("bank").money >= 100 or  player.getMoney() >= 100 then
        if VehiclesRented[identifier] == nil then
            VehiclesRented[identifier] = {
                plate = plate,
                time = os.time(),
                max_time = v.max_time * 60 * 60 * 1000,
                price = v.price,
                store = store
            }
            TriggerClientEvent("hub_rentanje:spawnVehicle", source, k, v, plate)
            TriggerEvent("hub_rentanje:startCounter", player)
            player.triggerEvent('dark:client:notify', 'Uspesno ste iznajmili vozilo', 2)
        else
            player.triggerEvent('dark:client:notify', 'Vec imate iznajmljeni automobil, prvo ga vratite!', 2)
        end
    else
        player.triggerEvent('dark:client:notify', 'Nemas para', 2)
    end
end)

RegisterServerEvent("hub_rentanje:giveback")
AddEventHandler("hub_rentanje:giveback", function(health)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("hub_rentanje:delete", source, VehiclesRented[identifier].vehicle)
        if health < 1000 then
            player.removeMoney(Config.Porez * (1000 - health)/100)
        elseif os.time() - VehiclesRented[identifier].time > VehiclesRented[identifier].max_time then
            player.removeMoney(Config.Porez * max_time)
        end
        VehiclesRented[identifier] = nil
    end
end)

RegisterServerEvent("hub_rentanje:update")
AddEventHandler("hub_rentanje:update", function(vehicle, bool)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if bool then
        VehiclesRented[identifier] = nil
        return
    end
    VehiclesRented[identifier].vehicle = vehicle    
end)

RegisterServerEvent("hub_rentanje:getVehicle")
AddEventHandler("hub_rentanje:getVehicle", function()
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("hub_rentanje:client:getVehicle", source, VehiclesRented[identifier].vehicle)
    end
end)

RegisterServerEvent("hub_rentanje:startCounter")
AddEventHandler("hub_rentanje:startCounter", function(player)
    local identifier = player.identifier
    Citizen.CreateThread(function()
        while true do
            if VehiclesRented[identifier] ~= nil then
                if player then
                    local cash = player.getMoney()
                    local bank = player.getAccount("bank").money
                    if bank >= VehiclesRented[identifier].price then
                        player.removeAccountMoney("bank", VehiclesRented[identifier].price)
                    elseif cash >= VehiclesRented[identifier].price then
                        player.removeMoney(VehiclesRented[identifier].price)
                    else
                        if Config.ESXBilling then
                            TriggerEvent("esx_billing:sendBill", source, VehiclesRented[identifier].store, VehiclesRented[identifier].plate.. " iznajmljivanje automobila registarskih tablica ", VehiclesRented[identifier].price)
                            TriggerEvent("notification", source, "Naknadu koju niste mogli da priustite za ovu stetu ce biti naplacena kao faktura!")
                        end
                    end
                end
            else
                break
            end
            Citizen.Wait(60*60*1000)
        end
    end)
end)
