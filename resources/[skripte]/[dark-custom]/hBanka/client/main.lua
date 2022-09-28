local peds = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        sleep = true
        for i = 1, #Config.Banka do
            local distanca = #(GetEntityCoords(PlayerPedId()) - Config.Banka[i].coords)
            if distanca < 25.0 then
                if(not DoesEntityExist(peds[i])) then
                    sleep = false
                    peds[i] = exports['hCore']:NapraviPed(GetHashKey(Config.Banka[i].hash), Config.Banka[i].coords, Config.Banka[i].heading)
                end
            else
                if(DoesEntityExist(peds[i])) then
                    sleep = true
                    DeletePed(peds[i])
                end
            end
        end
        if sleep then
            Citizen.Wait(2500)
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i = 1, #Config.Banka do
            DeletePed(peds[i])
        end
    end
end)

exports.qtarget:AddTargetModel(Config.AtmProps, {
	options = {
		{
			event = "hub-banka:otvori",
			icon = "fa-solid fa-dollar-sign",
			label = "Bankomat"
		},
	},
	distance = 2
})


exports.qtarget:AddTargetModel('cs_bankman', {
	options = {
		{
			event = "hub-banka:otvori",
			icon = "fa-solid fa-dollar-sign",
			label = "Banka"
		},
	},
	distance = 2
})

RegisterNetEvent("hub-banka:otvori")
AddEventHandler("hub-banka:otvori", function()
    ESX.TriggerServerCallback('hub-banka:getajstvari', function(data)
        SendNUIMessage({ type = "openbank", ime = data.ime, banka = data.banka, kartica = data.kartica, cvdkod = data.cvd, pin = data.pin, kazne = data.kazne })
        SetNuiFocus(true, true)
    end)
end)

Citizen.CreateThread(function()
    for i=1, #Config.Banka, 1 do
        blip = AddBlipForCoord(Config.Banka[i].coords)
        SetBlipSprite(blip, 500)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Banka')
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent("hub-banka:update:kartica")
AddEventHandler("hub-banka:update:kartica", function(kartica, cvd)
    SendNUIMessage({ type = "updatecardnumber", cardnumber = kartica, cvd = cvd })
end)

RegisterNetEvent("hub-banka:update:pin")
AddEventHandler("hub-banka:update:pin", function(pin)
    SendNUIMessage({ type = "updatepin", pin = pin })
end)

RegisterNetEvent("hub-banka:update:balance")
AddEventHandler("hub-banka:update:balance", function(balance)
    SendNUIMessage({ type = "updatebalance", balance = balance })
end)

RegisterNetEvent("hub-banka:update:kazne")
AddEventHandler("hub-banka:update:kazne", function(type)
    if type == 'remove' then
        SendNUIMessage({ type = "removekazne" })
    elseif type == 'add' then
        ESX.TriggerServerCallback('hub-banka:getajkazne', function(kazne)
            for k,v in pairs(kazne) do
                SendNUIMessage({ type = "napravikazne", data = v })
            end 
        end)
    end
end)

RegisterNetEvent("hub-banka:error-notify")
AddEventHandler("hub-banka:error-notify", function(notify)
    SendNUIMessage({ type = "errornotify", text = notify })
end)

RegisterNetEvent("hub-banka:success-notify")
AddEventHandler("hub-banka:success-notify", function(notify)
    SendNUIMessage({ type = "successnotify", text = notify })
end)

RegisterNUICallback('action', function(data, cb)
    if data.type == "close" then
        SetNuiFocus(false, false)
        inmenu = false
    elseif data.type == "createcard" then
        ESX.TriggerServerCallback('hub-banka:getajcard', function(moze)
            if moze then
                ESX.TriggerServerCallback('hub-banka:getajcvd', function(moze2)
                    if moze2 then
                        ESX.TriggerServerCallback('hub-banka:napravikarticu', function() end, data.cardnumber, data.cvd)
                    else
                        TriggerEvent('hub-banka:error-notify', "CVD vec postoji")
                    end
                end, data.cvd)
            else
                TriggerEvent('hub-banka:error-notify', "Kartica vec postoji")
            end
        end, data.cardnumber)
    elseif data.type == "createpin" then
        ESX.TriggerServerCallback('hub-banka:getajpin', function(moze)
            if moze then
                ESX.TriggerServerCallback('hub-banka:napravipin', function() end, data.pin)
            else
                TriggerEvent('hub-banka:error-notify', "Pin vec postoji")
            end
        end, data.pin)
    elseif data.type == "deposit" then
        ESX.TriggerServerCallback('hub-banka:getajkarticu', function(kartica)
            if kartica ~= "**** **** ****" then
                if kartica == data.kartica then
                    ESX.TriggerServerCallback('hub-banka:deposit', function() end, data.iznos)
                else
                    SendNUIMessage({ type = "errornotify", text = 'Morate upisati vasu karticu' })
                end
            else
                SendNUIMessage({ type = "errornotify", text = 'Morate generisati karticu' })
            end
        end)
    elseif data.type == "withdraw" then
        ESX.TriggerServerCallback('hub-banka:getajkarticu', function(kartica)
            if kartica ~= "**** **** ****" then
                if kartica == data.kartica then
                    ESX.TriggerServerCallback('hub-banka:withdraw', function() end, data.iznos)
                else
                    SendNUIMessage({ type = "errornotify", text = 'Morate upisati vasu karticu' })
                end
            else
                SendNUIMessage({ type = "errornotify", text = 'Morate generisati karticu' })
            end
        end)
    elseif data.type == "transfer" then
        ESX.TriggerServerCallback('hub-banka:getajkarticu', function(kartica)
            if kartica ~= data.kartica then
                ESX.TriggerServerCallback('hub-banka:transfer', function() end, data.iznos, data.kartica)
            else
                SendNUIMessage({ type = "errornotify", text = 'Ne mozes slati pare sebi' })
            end
        end)
    elseif data.type == "napravikazne" then
        ESX.TriggerServerCallback('hub-banka:getajkazne', function(kazne)
            for k,v in pairs(kazne) do
                SendNUIMessage({ type = "napravikazne", data = v })
            end 
        end)
    elseif data.type == 'platikaznu' then
        ESX.TriggerServerCallback('hub-banka:proveriprotekcija', function(imali)
            if imali then
                ESX.TriggerServerCallback('hub-banka:platiracune', function() end, data.id, data.cena)
            else
                print('cemu')
            end
        end, data.id)
    end
end)
