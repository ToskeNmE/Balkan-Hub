local bakica = {}
local kliknuo = false

Citizen.CreateThread(function ()
    for i=1, #Dark.Lokacije, 1 do
        babica = AddBlipForCoord(Dark.Lokacije[i].coords)
	    SetBlipSprite(babica, 205)
	    SetBlipDisplay(babica, 4)
	    SetBlipScale(babica, 0.65)	
	    SetBlipColour(babica, 7)
	    SetBlipAsShortRange(babica, true)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString('Babica')
	    EndTextCommandSetBlipName(babica)
    end
    while true do
        Citizen.Wait(0)
        sleep = true
        for i=1, #Dark.Lokacije, 1 do
            local distanca = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Lokacije[i].coords)
            if distanca < 50.0 then
                sleep = false
                if not DoesEntityExist(bakica[i]) then
                    bakica[i] = exports['hCore']:NapraviPed(GetHashKey(Dark.Model), Dark.Lokacije[i].coords, Dark.Lokacije[i].heading)
                end
                if distanca < 5 and DoesEntityExist(bakica[i]) then
                    exports['hCore']:Draw3DText(Dark.Lokacije[i].coords.x, Dark.Lokacije[i].coords.y, Dark.Lokacije[i].coords.z + 2, "~s~Pritisni ~r~E~s~ da se ozivis")
                    if IsControlJustReleased(0, 38) and not kliknuo then
                        kliknuo = true
                        ESX.TriggerServerCallback('dark-bakica:checkmoneyfromnigger', function(can) 
                            if can then
                                if IsEntityDead(ESX.PlayerData.ped) then
                                    if lib.progressCircle({
                                        duration = Dark.Time,
                                        position = 'bottom',
                                        useWhileDead = true,
                                        canCancel = true,
                                    }) then ESX.TriggerServerCallback('dark-bakica:removemoneyfromniggers', function() kliknuo = false end) else kliknuo = false end
                                else
                                    kliknuo = false
                                    exports['hNotifikacije']:Notifikacije('Nisi mrtav', 2)
                                end
                            else
                                kliknuo = false
                                exports['hNotifikacije']:Notifikacije('Nemas dovoljno novca', 2)
                            end
                        end)
                    end
                end
            else
                if DoesEntityExist(bakica[i]) then
                    DeletePed(bakica[i])
                    sleep = true
                end
            end
        end
        if sleep then Citizen.Wait(1500) end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i=1, #Dark.Lokacije, 1 do
            DeletePed(bakica[i])
        end
    end
end)