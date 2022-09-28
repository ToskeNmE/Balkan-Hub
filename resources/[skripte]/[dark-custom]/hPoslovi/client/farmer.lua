local zbunje = {}
local spawnaofarmer = {}
local bere = false
local preradjuje = false
local prodaje = false

Citizen.CreateThread(function()
  uzmifarmera()
  farmer = AddBlipForCoord(Dark.Farmer.Presvlacenje.coords)
  SetBlipSprite(farmer, 540)
  SetBlipDisplay(farmer, 4)
  SetBlipScale(farmer, 0.6)
  SetBlipColour(farmer, 7)
  SetBlipAsShortRange(farmer, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Farmer')
  EndTextCommandSetBlipName(farmer)
  farmerprodaja = AddBlipForCoord(Dark.Farmer.Prodaja.coords)
  SetBlipSprite(farmerprodaja, 540)
  SetBlipDisplay(farmerprodaja, 4)
  SetBlipScale(farmerprodaja, 0.6)
  SetBlipColour(farmerprodaja, 7)
  SetBlipAsShortRange(farmerprodaja, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Prodaja tresanja')
  EndTextCommandSetBlipName(farmerprodaja)
  while true do
    Citizen.Wait(0)
    if zapoceofarmera then
      for i=1, #Dark.Farmer.LokacijeZbunja, 1 do
        local distanczbunja = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Farmer.LokacijeZbunja[i])
        if distanczbunja < 100.0 then
          if not DoesEntityExist(zbunje[i]) and not spawnaofarmer[i] then
            ESX.Game.SpawnLocalObject(Dark.Farmer.ZbunjeProp, Dark.Farmer.LokacijeZbunja[i], function(obj)
               zbunje[i] = obj
               FreezeEntityPosition(zbunje[i], true)
               PlaceObjectOnGroundProperly(zbunje[i])
            end)
            spawnaofarmer[i] = true
          end
        else
          if DoesEntityExist(zbunje[i]) then
              ESX.Game.DeleteObject(zbunje[i])
              spawnaofarmer[i] = false
          end
        end
        if DoesEntityExist(zbunje[i]) and spawnaofarmer[i] then
          local distanczbunja2 = #(GetEntityCoords(ESX.PlayerData.ped) - GetEntityCoords(zbunje[i]))
          if distanczbunja2 < 5 then
              sleep = false
              exports['hCore']:Draw3DText(GetEntityCoords(zbunje[i]).x, GetEntityCoords(zbunje[i]).y, GetEntityCoords(zbunje[i]).z + 2, "~s~Da bi ubrao tresnju drzi ~o~ALT~s~ na njega\n~r~AKO TI TREBA POMOC KUCAJ /FARMERHELP")
          end
          if distanczbunja2 < 2.5 then
            exports.qtarget:AddTargetModel(Dark.Farmer.ZbunjeProp, {
               options = {
                   {
                     icon = "fas fa-leaf",
                     label = "Uzmi tresnje",
                     num = 1,
                     canInteract = function (entity)
                      local coords = GetEntityCoords(ESX.PlayerData.ped)
                      for i=1, #Dark.Farmer.LokacijeZbunja, 1 do
                        if GetDistanceBetweenCoords(coords, GetEntityCoords(zbunje[i]), false) < 1.5 then
                          if zbunje[i] == entity then
                            return true
                          else
                            return false
                          end
                        end
                      end
                    end,
                     action = function(entity)
                      if not bere then
                        amount = math.random(5, 15)
                        bere = true
                        ESX.TriggerServerCallback('dark-poslovi:proveridalimozedanosi', function(moze)
                          if moze then
                              if lib.progressCircle({
                                duration = 5000,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                anim = {
                                  scenario = 'world_human_gardener_plant'
                                },
                              }) then
                                bere = false
                                ESX.Game.DeleteObject(entity)
                                ESX.TriggerServerCallback('dark-poslovi:lootajzbun', function() end, amount)
                                Citizen.Wait(15000)
                                spawnaofarmer[i] = false
                              else
                                exports['hNotifikacije']:Notifikacije('Prekinuo si branje', 2)
                                bere = false
                              end
                          else
                            bere = false
                          end
                        end, 'tresnje', amount)
                      end
                end,
              },
            },
            distance = 1.5
          })
          end
        end
      end
    end

    local distanncaprodaja = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Farmer.Prodaja.coords)
    if distanncaprodaja < 25.0 then
      sleep = false
      if not DoesEntityExist(prodajapedfarmer) then
        prodajapedfarmer = exports['hCore']:NapraviPed(GetHashKey(Dark.Farmer.PedProdaja), Dark.Farmer.Prodaja.coords, Dark.Farmer.Prodaja.heading)
        exports.qtarget:AddTargetModel(Dark.Farmer.PedProdaja, {
        	options = {
        		{
        			icon = "fas fa-dollar-sign",
        			label = "Prodaj tresnje",
        			num = 1,
              action = function(entity)
                ESX.TriggerServerCallback('dark-poslovi:getajitemcount', function(count)
                  if count > 0 then
                    if not prodajetresnji then
                      TaskStartScenarioInPlace(prodajapedfarmer, 'PROP_HUMAN_BUM_BIN', 0, true)
                      prodajetresnji = true
                      if lib.progressCircle({
                        duration = 10000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                          scenario = 'PROP_HUMAN_BUM_BIN'
                        },
                      }) then
                        ESX.TriggerServerCallback('dark-poslovi:prodajtresnje', function() end)
                        prodajetresnji = false
                        ClearPedTasksImmediately(prodajapedfarmer)
                      else
                        exports['hNotifikacije']:Notifikacije('Prekinuo si prodaju', 2)
                        prodajetresnji = false
                      end
                  end
                else
                  exports['hNotifikacije']:Notifikacije('Nemas dovoljno tresanja za prodaju', 2)
                 end
               end, 'tresnje')
              end,
        		},
        	},
        	distance = 2
        })
      end
      if distanncaprodaja < 5 and DoesEntityExist(prodajapedfarmer) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Farmer.Prodaja.coords.x, Dark.Farmer.Prodaja.coords.y, Dark.Farmer.Prodaja.coords.z + 2, "~s~Da bi prodao tresnje drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /FARMERHELP")
      end
    else
      if DoesEntityExist(prodajapedfarmer) then
        DeletePed(prodajapedfarmer)
      end
    end

    local presvlacenjefarmerdisc = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Farmer.Presvlacenje.coords)
    if presvlacenjefarmerdisc < 25.0 then
      sleep = false
      if not DoesEntityExist(farmerped) then
        farmerped = exports['hCore']:NapraviPed(GetHashKey(Dark.Farmer.PedFarmer), Dark.Farmer.Presvlacenje.coords, Dark.Farmer.Presvlacenje.heading)
      end
      if presvlacenjefarmerdisc < 5 and DoesEntityExist(farmerped) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Farmer.Presvlacenje.coords.x, Dark.Farmer.Presvlacenje.coords.y, Dark.Farmer.Presvlacenje.coords.z + 2, "~s~Da bi zapoceo/prekinuo posao drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /FARMERHELP")
      end
    else
      if DoesEntityExist(farmerped) then
        DeletePed(farmerped)
      end
    end
    if sleep then Citizen.Wait(1000) end
  end
end)

function uzmifarmera()
exports.qtarget:AddTargetModel(Dark.Farmer.PedFarmer, {
	options = {
		{
			icon = "fas fa-tree",
			label = "Uzmi posao",
			num = 1,
      action = function(entity)
        exports.qtarget:RemoveTargetModel(Dark.Farmer.PedFarmer, {
	         'Uzmi posao'
        })
        prekinifarmera()
        zapoceofarmera = true
        exports['hNotifikacije']:Notifikacije('Zapoceo si posao', 3)
        SetNewWaypoint(2046.366, 4964.763)
      end,
		},
	},
	distance = 2
})
end

function prekinifarmera()
  exports.qtarget:AddTargetModel(Dark.Farmer.PedFarmer, {
  	options = {
  		{
  			icon = "fas fa-tree",
  			label = "Prekini posao",
  			num = 1,
        action = function(entity)
          exports.qtarget:RemoveTargetModel(Dark.Farmer.PedFarmer, {
  	         'Prekini posao'
          })
          uzmifarmera()
          DeleteWaypoint()
          zapoceofarmera = false
          exports['hNotifikacije']:Notifikacije('Prekinuo si posao', 2)
          for i=1, #Dark.Farmer.LokacijeZbunja, 1 do
            ESX.Game.DeleteObject(zbunje[i])
            spawnaofarmer[i] = false
          end
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
  DeletePed(farmerped)
  exports.qtarget:RemoveTargetModel(Dark.Farmer.ZbunjeProp, {
     'Prekini posao', 'Uzmi posao'
  })
  for i=1, #Dark.Farmer.LokacijeZbunja, 1 do
    ESX.Game.DeleteObject(zbunje[i])
    spawnaofarmer[i] = false
  end
end)
