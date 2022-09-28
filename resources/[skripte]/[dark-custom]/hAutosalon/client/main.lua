Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        sleep = true
            local distanca = #(GetEntityCoords(PlayerPedId()) - Dark.Lokacije.AutoSalon.coords)
            if distanca < 25.0 then
                if(not DoesEntityExist(peds)) then
                    sleep = false
                    peds = exports['hCore']:NapraviPed(GetHashKey(Dark.Lokacije.AutoSalon.model), Dark.Lokacije.AutoSalon.coords, Dark.Lokacije.AutoSalon.heading)
                end
            else
                if(DoesEntityExist(peds)) then
                    sleep = true
                    DeletePed(peds)
                end
            end
        if sleep then
            Citizen.Wait(2500)
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeletePed(peds)
    end
end)

exports.qtarget:AddTargetModel(Dark.Lokacije.AutoSalon.model, {
	options = {
		{
			icon = "fas fa-car",
			label = "Salon Vozila",
      action = function(entity)
        for i=1, #Dark.Vozila, 1 do
            SendNUIMessage({ type = 'openvehshop', data = Dark.Vozila[i], maxspeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(Dark.Vozila[i].spawnkod)*3.9650553) })
        end
        SetNuiFocus(true, true)
      end,
		},
	},
	distance = 2
})

RegisterNUICallback('action', function (data,cb)
    if data.type == 'close' then
        SetNuiFocus(false, false)
    elseif data.type == "preview" then
      cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1259.47, -3370.08, 14.440, 312.2, -15.0, 0.0, 60.00, false, 0)
      PointCamAtCoord(cam,  Dark.Lokacije.Preview.coords)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1, true, true)
      SetFocusPosAndVel(Dark.Lokacije.Preview.coords, 0.0, 0.0, 0.0)
      if not HasModelLoaded(GetHashKey(data.spawnkod)) then
          RequestModel(GetHashKey(data.spawnkod))
          while not HasModelLoaded(GetHashKey(data.spawnkod)) do
              Citizen.Wait(10)
          end
      end
      lastvehselected = CreateVehicle(GetHashKey(data.spawnkod), Dark.Lokacije.Preview.coords, Dark.Lokacije.Preview.heading, false, false)
      local props = { color1 = Dark.Boje[data.primcolor], color2 = Dark.Boje[data.seccolor], }
      ESX.Game.SetVehicleProperties(lastvehselected, props)
      SetVehicleDirtLevel(lastvehselected, 0)
      SetVehicleNumberPlateText(lastvehselected, 'DARK GOD')
      SetEntityHeading(lastvehselected, Dark.Lokacije.Preview.heading)
    elseif data.type == "closepreview" then
        if DoesEntityExist(lastvehselected) then
          DeleteEntity(lastvehselected)
        end
        inpreview = false
        lastvehselected = nil
        RenderScriptCams(false)
        DestroyAllCams(true)
        ClearFocus()
    elseif data.type == "rotacijavozila" then
      if data.rotacija == "leva" then
        rotation(0.5)
      elseif data.rotacija == "desna" then
        rotation(-0.5)
      end
    elseif data.type == "kupivozilo" then
      local tablice
      ESX.TriggerServerCallback('dark-autosalon:proverinovac', function(moze)
        if moze then
          ESX.Game.SpawnVehicle(data.spawnkod, Dark.Lokacije.SpawnLokacija.coords, Dark.Lokacije.SpawnLokacija.heading, function(vehicle)
            TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
            local props = { color1 = Dark.Boje[data.primarnaboja], color2 = Dark.Boje[data.sekundarnaboja], }
            ESX.Game.SetVehicleProperties(vehicle, props)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleFuelLevel(vehicle, 100.0)
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            ESX.TriggerServerCallback('dark-autosalon:dajownera', function() end, vehicleProps)
            ESX.TriggerServerCallback('dark-autosalon:log', function() end, data.cena, data.label, vehicleProps.plate )
            exports['hNotifikacije']:Notifikacije('Kupio si vozilo ' .. data.label .. ' sa tablicama ' .. vehicleProps.plate  .. ' za ' .. data.cena .. "$", 3)
          end)
        else
          exports['hNotifikacije']:Notifikacije('Nemas dovoljno novca', 2)
        end
      end, data.cena)
    end
end)


Citizen.CreateThread(function()
  blip = AddBlipForCoord(Dark.Lokacije.AutoSalon.coords)
  SetBlipSprite(blip, 669)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.6)
  SetBlipColour(blip, 17)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Salon Vozila')
  EndTextCommandSetBlipName(blip)
end)

function rotation(dir)
    local entityRot = GetEntityHeading(lastvehselected) + dir
    SetEntityHeading(lastvehselected, entityRot % 360)
end
