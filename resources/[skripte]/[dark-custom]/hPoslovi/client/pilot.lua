local jobvehicle = nil
local lokacija = nil
local parkiranjebox = nil

Citizen.CreateThread(function()
  uzmipilota()
  pilot = AddBlipForCoord(Dark.Pilot.Presvlacenje.coords)
  SetBlipSprite(pilot, 16)
  SetBlipDisplay(pilot, 4)
  SetBlipScale(pilot, 0.8)
  SetBlipColour(pilot, 3)
  SetBlipAsShortRange(pilot, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Pilot')
  EndTextCommandSetBlipName(pilot)
    exports.qtarget:Vehicle({
        options = {
            {
                label = 'Parkiraj avion',
                icon = "fa-solid fa-plane",
                canInteract = function(entity)
                  if parkiranjebox ~= nil then
                    if parkiranjebox:isPointInside(GetEntityCoords(entity)) and entity == jobvehicle and zapoceopilota then
                        return true
                    end
                  end
                end,
                action = function (entity)
                    if DoesEntityExist(jobvehicle) then
                        ESX.Game.DeleteVehicle(jobvehicle)
                    end
                    if istovario then
                        ESX.TriggerServerCallback('dark-poslovi:platipilot', function(moze) if moze then istovario = false end end)
                    end
                end
            },
            {
                label = 'Utovari kutije',
                icon = "fa-solid fa-box",
                canInteract = function(entity)
                  if parkiranjebox ~= nil then
                    if parkiranjebox:isPointInside(GetEntityCoords(entity)) and entity == jobvehicle and zapoceopilota and not upakovao then
                        return true
                    end
                  end
                end,
                action = function (entity)
                    exports['hNotifikacije']:Notifikacije('Utovar je zapoceo', 1)
                    if lib.progressCircle({
                        duration = 15000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                        },
                    }) then upakovao = true exports['hNotifikacije']:Notifikacije('Utovar je gotov', 1) else upakovao = false exports['hNotifikacije']:Notifikacije('Utovar je prekinut', 2) end
                end
            },
            {
                label = 'Istovari kutije',
                icon = "fa-solid fa-box",
                canInteract = function(entity)
                    if lokacija ~= nil then
                        if lokacija:isPointInside(GetEntityCoords(entity)) and entity == jobvehicle and zapoceopilota and upakovao and not istovario then
                            return true
                        end
                    else
                        return false
                    end
                end,
                action = function (entity)
                    exports['hNotifikacije']:Notifikacije('Istovar je zapoceo', 1)
                    if lib.progressCircle({
                        duration = 15000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                        },
                    }) then 
                      istovario = true 
                      exports['hNotifikacije']:Notifikacije('Istovar je gotov, vrati se nazad u hangar da bi dobio pare', 1)
                      SetNewWaypoint(-980.31, -2995.69) 
                    else 
                      istovario = false 
                      exports['hNotifikacije']:Notifikacije('Istovar je prekinut', 2) 
                    end
                end
            },
        }
    })

  while true do
    Citizen.Wait(0)
    if zapoceopilota then
        local avion = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInAnyPlane(PlayerPedId()) and avion == jobvehicle then
            if not setcurrentpoint and upakovao then
                setuptour()
            end
        end
    end
    local presvlacenjepilotdisc = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Pilot.Presvlacenje.coords)
    if presvlacenjepilotdisc < 25.0 then
      sleep = false
      if not DoesEntityExist(pilotped) then
        pilotped = exports['hCore']:NapraviPed(GetHashKey(Dark.Pilot.PilotPed), Dark.Pilot.Presvlacenje.coords, Dark.Pilot.Presvlacenje.heading)
      end
    else
      if DoesEntityExist(pilotped) then
        DeletePed(pilotped)
      end
    end
    if sleep then Citizen.Wait(1000) end
  end
end)

function setuptour()
    local randombroj = 1 --math.random(1,4)
    if randombroj == 1 then
        setcurrentpoint = true
        lokacija = BoxZone:Create(vector3(1701.13, 3250.47, 41.0), 38.8, 25, {
            name = "micko",
            heading = 285,
            --debugPoly = true,
            minZ = 39.4,
            maxZ = 47.6
        })
        SetNewWaypoint(1701.13, 3250.47)
    end
end

function uzmipilota()
exports.qtarget:AddTargetModel(Dark.Pilot.PilotPed, {
	options = {
		{
			icon = "fa-solid fa-plane",
			label = "Uzmi posao",
			num = 1,
            action = function(entity)
              if ESX.Game.IsSpawnPointClear(Dark.Pilot.SpawnLokacija.coords, 20) then
                  exports.qtarget:RemoveTargetModel(Dark.Pilot.PilotPed, {
	                   'Uzmi posao'
                  })
                  prekinipilota()
                  zapoceopilota = true
                  setcurrentpoint = false
                  ESX.Game.SpawnVehicle('luxor', Dark.Pilot.SpawnLokacija.coords, Dark.Pilot.SpawnLokacija.heading, function(vehicle) jobvehicle = vehicle end)
                  exports['hNotifikacije']:Notifikacije('Zapoceo si posao, idi utovari pakete', 3)
                  SetNewWaypoint(Dark.Pilot.SpawnLokacija.coords)
                  parkiranjebox = BoxZone:Create(vector3(-980.31, -2995.69, 13.95), 41.8, 25, {
                        name = 'parkiranje',
                        heading = 240,
                        debugPoly = false,
                        minZ = 11.95,
                        maxZ = 16.95,
                  })
                  upakovao = false
              else
                  exports['hNotifikacije']:Notifikacije('Mesto za spawn je zauzeto, reci ljudima da pomere avion', 2)
              end
            end,
		},
	},
	distance = 2
})
end

function prekinipilota()
  exports.qtarget:AddTargetModel(Dark.Pilot.PilotPed, {
  	options = {
  		{
  		  icon = "fa-solid fa-plane",
  		  label = "Prekini posao",
  		  num = 1,
          action = function(entity)
          exports.qtarget:RemoveTargetModel(Dark.Pilot.PilotPed, {
  	         'Prekini posao'
          })
          if DoesEntityExist(jobvehicle) then
            ESX.Game.DeleteVehicle(jobvehicle)
          end
          setcurrentpoint = false
          uzmipilota()
          DeleteWaypoint()
          parkiranjebox:destroy()
          lokacija:destroy()
          zapoceopilota = false
          upakovao = false
          exports['hNotifikacije']:Notifikacije('Prekinuo si posao', 2)
        end,
  		},
  	},
  	distance = 2
  })
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DeletePed(pilotped)
  exports.qtarget:RemoveTargetModel(Dark.Pilot.PilotPed, {
     'Prekini posao', 'Uzmi posao'
  })
  if DoesEntityExist(jobvehicle) then
    ESX.Game.DeleteVehicle(jobvehicle)
  end
  if parkiranjebox ~= nil then
    parkiranjebox:destroy()
  end
  if lokacija ~= nil then
    lokacija:destroy()
  end
end)
