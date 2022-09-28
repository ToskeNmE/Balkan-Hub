local objekat = {}
local spawnao = {}
local sece = false
local preradjuje = false
local prodaje = false

Citizen.CreateThread(function()
  uzmiposao()
  drvoseca = AddBlipForCoord(Dark.Drvoseca.Presvlacenje.coords)
  SetBlipSprite(drvoseca, 538)
  SetBlipDisplay(drvoseca, 4)
  SetBlipScale(drvoseca, 0.65)
  SetBlipColour(drvoseca, 5)
  SetBlipAsShortRange(drvoseca, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('Drvoseca')
  EndTextCommandSetBlipName(drvoseca)

  drvosecaprodaja = AddBlipForCoord(Dark.Drvoseca.Prodaja.coords)
  SetBlipSprite(drvosecaprodaja, 538)
  SetBlipDisplay(drvosecaprodaja, 4)
  SetBlipScale(drvosecaprodaja, 0.65)
  SetBlipColour(drvosecaprodaja, 5)
  SetBlipAsShortRange(drvosecaprodaja, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('Prodaja Drva')
  EndTextCommandSetBlipName(drvosecaprodaja)

  drvosecaprerada = AddBlipForCoord(Dark.Drvoseca.Prerada.coords)
  SetBlipSprite(drvosecaprerada, 538)
  SetBlipDisplay(drvosecaprerada, 4)
  SetBlipScale(drvosecaprerada, 0.65)
  SetBlipColour(drvosecaprerada, 5)
  SetBlipAsShortRange(drvosecaprerada, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('Prerada Drveta')
  EndTextCommandSetBlipName(drvosecaprerada)
  while true do
    Citizen.Wait(0)
    sleep = true
    if zapoceodrvosecu then
      for i=1, #Dark.Drvoseca.LokacijeDrveta, 1 do
        local distancadrveta = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Drvoseca.LokacijeDrveta[i])
        if distancadrveta < 100.0 then
          if not DoesEntityExist(objekat[i]) and not spawnao[i] then
            ESX.Game.SpawnLocalObject(Dark.Drvoseca.DrvoProp, Dark.Drvoseca.LokacijeDrveta[i], function(obj)
               objekat[i] = obj
               FreezeEntityPosition(objekat[i], true)
               PlaceObjectOnGroundProperly(objekat[i])
            end)
            spawnao[i] = true
          end
        else
          if DoesEntityExist(objekat[i]) then
              ESX.Game.DeleteObject(objekat[i])
              spawnao[i] = false
          end
        end
        if DoesEntityExist(objekat[i]) and spawnao[i] then
          local distancadrveta2 = #(GetEntityCoords(ESX.PlayerData.ped) - GetEntityCoords(objekat[i]))
          if distancadrveta2 < 5 then
              sleep = false
              exports['hCore']:Draw3DText(GetEntityCoords(objekat[i]).x, GetEntityCoords(objekat[i]).y, GetEntityCoords(objekat[i]).z + 2, "~s~Da bi isekao drvo drzi ~o~ALT~s~ na njega\n~r~AKO TI TREBA POMOC KUCAJ /DRVOSECAHELP")
          end
          if distancadrveta2 < 2.5 then
            exports.qtarget:AddTargetModel(Dark.Drvoseca.DrvoProp, {
               options = {
                   {
                     icon = "fas fa-tree",
                     label = "Cepaj drvo",
                     num = 1,
                     canInteract = function (entity)
                      local coords = GetEntityCoords(ESX.PlayerData.ped)
                      for i=1, #Dark.Drvoseca.LokacijeDrveta, 1 do
                        if GetDistanceBetweenCoords(coords, GetEntityCoords(objekat[i]), false) < 1.5 then
                          if objekat[i] == entity then
                            return true
                          else
                            return false
                          end
                        end
                      end
                    end,
                     action = function(entity)
                      if not sece then
                        sece = true
                          ESX.TriggerServerCallback('dark-poslovi:proveridalimozedanosi', function(moze)
                            if moze then
                              freezan = true
                              GiveWeaponToPed(ESX.PlayerData.ped, GetHashKey("WEAPON_HATCHET"),0, true, true)
                              SetCurrentPedWeapon(ESX.PlayerData.ped, GetHashKey("WEAPON_HATCHET"), false)
                              drvosecaanimacija()
                              Wait(2000)
                              drvosecaanimacija()
                              Wait(2000)
                              drvosecaanimacija()
                              Wait(2000)
                              drvosecaanimacija()
                              Wait(2000)
                              DeleteObject(entity)
                              objekat[i] = nil
                              FreezeEntityPosition(ESX.PlayerData.ped, false)
                              RemoveWeaponFromPed(ESX.PlayerData.ped, GetHashKey("WEAPON_HATCHET"), true, true)
                              freezan = false
                              ESX.TriggerServerCallback('dark-poslovi:dajdrvo', function() end)
                              Citizen.Wait(7500)
                              spawnao[i] = false
                              sece = false
                          else
                              sece = false
                          end
                        end, 'ndrvo', 1)
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
    local distancaprerade = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Drvoseca.Prerada.coords)
    if distancaprerade < 35.0 then
      if not DoesEntityExist(preradaobj) then
        ESX.Game.SpawnLocalObject(Dark.Drvoseca.PreradaProp, Dark.Drvoseca.Prerada.coords, function(obj)
           preradaobj = obj
           FreezeEntityPosition(preradaobj, true)
           SetEntityHeading(preradaobj, Dark.Drvoseca.Prerada.heading)
           PlaceObjectOnGroundProperly(preradaobj)
        end)
        exports.qtarget:AddTargetModel(Dark.Drvoseca.PreradaProp, {
          options = {
            {
              icon = "fas fa-tree",
              label = "Preradi drvo",
              num = 1,
              action = function(entity)
                ESX.TriggerServerCallback('dark-poslovi:getajitemcount', function(count)
                  if count > 0 then
                    if not preradjuje then
                      preradjuje = true
                      if lib.progressCircle({
                        duration = 15000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                          scenario = 'PROP_HUMAN_BUM_BIN'
                        },
                      }) then
                        ESX.TriggerServerCallback('dark-poslovi:dajpreradjenodrvo', function() end)
                        preradjuje = false
                      else
                        exports['hNotifikacije']:Notifikacije('Prekinuo si preradu', 2)
                        preradjuje = false
                      end
                  end
                else
                  exports['hNotifikacije']:Notifikacije('Nemas dovoljno nepreradjenog drveta', 2)
                 end
                end, 'ndrvo')
              end,
            },
          },
          distance = 2
        })
      end
      if distancaprerade < 5 and DoesEntityExist(preradaobj) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Drvoseca.Prerada.coords.x, Dark.Drvoseca.Prerada.coords.y, Dark.Drvoseca.Prerada.coords.z + 1, "~s~Da bi preradio drvo drzi ~o~ALT~s~ na masinu\n~r~AKO TI TREBA POMOC KUCAJ /DRVOSECAHELP")
      end
    else
      if DoesEntityExist(preradaobj) then
          ESX.Game.DeleteObject(preradaobj)
      end
    end
    local presvlacenjedisc = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Drvoseca.Presvlacenje.coords)
    if presvlacenjedisc < 25.0 then
      sleep = false
      if not DoesEntityExist(ped) then
        ped = exports['hCore']:NapraviPed(GetHashKey(Dark.Drvoseca.PedDrvoseca), Dark.Drvoseca.Presvlacenje.coords, Dark.Drvoseca.Presvlacenje.heading)
      end
      if presvlacenjedisc < 5 and DoesEntityExist(ped) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Drvoseca.Presvlacenje.coords.x, Dark.Drvoseca.Presvlacenje.coords.y, Dark.Drvoseca.Presvlacenje.coords.z + 2, "~s~Da bi zapoceo/prekinuo posao drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /DRVOSECAHELP")
      end
    else
      if DoesEntityExist(ped) then
        DeletePed(ped)
      end
    end
    local prodajadisc = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Drvoseca.Prodaja.coords)
    if prodajadisc < 25.0 then
      sleep = false
      if not DoesEntityExist(pedprodaja) then
        pedprodaja = exports['hCore']:NapraviPed(GetHashKey(Dark.Drvoseca.ProdajaPed), Dark.Drvoseca.Prodaja.coords, Dark.Drvoseca.Prodaja.heading)
        exports.qtarget:AddTargetModel(Dark.Drvoseca.ProdajaPed, {
          options = {
            {
              icon = "fas fa-tree",
              label = "Prodaj drvo",
              num = 1,
              action = function(entity)
                ESX.TriggerServerCallback('dark-poslovi:getajitemcount', function(count)
                  if count > 0 then
                    if not prodaje then
                      TaskStartScenarioInPlace(pedprodaja, 'PROP_HUMAN_BUM_BIN', 0, true)
                      prodaje = true
                      if lib.progressCircle({
                        duration = 10000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                          scenario = 'PROP_HUMAN_BUM_BIN'
                        },
                      }) then
                        ESX.TriggerServerCallback('dark-poslovi:prodajdrvo', function() end)
                        prodaje = false
                        ClearPedTasksImmediately(pedprodaja)
                      else
                        exports['hNotifikacije']:Notifikacije('Prekinuo si prodaju', 2)
                        prodaje = false
                      end
                  end
                else
                  exports['hNotifikacije']:Notifikacije('Nemas dovoljno preradjenog drveta', 2)
                 end
               end, 'pdrvo')
              end,
            },
          },
          distance = 2
        })
      end
      if prodajadisc < 5 and DoesEntityExist(pedprodaja) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Drvoseca.Prodaja.coords.x, Dark.Drvoseca.Prodaja.coords.y, Dark.Drvoseca.Prodaja.coords.z + 2, "~s~Da bi prodao drvo drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /DRVOSECAHELP")
      end
    else
      if DoesEntityExist(pedprodaja) then
        DeletePed(pedprodaja)
      end
    end
    if IsEntityDead(ESX.PlayerData.ped) and zapoceodrvosecu then
      for i=1, #Dark.Drvoseca.LokacijeDrveta, 1 do
        ESX.Game.DeleteObject(objekat[i])
        spawnao[i] = false
      end
      zapoceodrvosecu = false
      exports.qtarget:RemoveTargetModel(Dark.Drvoseca.PedDrvoseca, {
         'Prekini posao'
      })
      uzmiposao()
    end
    if freezan then
      sleep = false
      FreezeEntityPosition(ESX.PlayerData.ped, true)
    end
    if sleep then Citizen.Wait(1000) end
  end
end)

function uzmiposao()
exports.qtarget:AddTargetModel(Dark.Drvoseca.PedDrvoseca, {
	options = {
		{
			icon = "fas fa-tree",
			label = "Uzmi posao",
			num = 1,
      action = function(entity)
        exports.qtarget:RemoveTargetModel(Dark.Drvoseca.PedDrvoseca, {
	         'Uzmi posao'
        })
        prekiniposaso()
        zapoceodrvosecu = true
        exports['hNotifikacije']:Notifikacije('Zapoceo si posao', 3)
        SetNewWaypoint(1334.090, 1895.066)
      end,
		},
	},
	distance = 2
})
end

function prekiniposaso()
  exports.qtarget:AddTargetModel(Dark.Drvoseca.PedDrvoseca, {
  	options = {
  		{
  			icon = "fas fa-tree",
  			label = "Prekini posao",
  			num = 1,
        action = function(entity)
          exports.qtarget:RemoveTargetModel(Dark.Drvoseca.PedDrvoseca, {
  	         'Prekini posao'
          })
          uzmiposao()
          DeleteWaypoint()
          zapoceodrvosecu = false
          exports['hNotifikacije']:Notifikacije('Prekinuo si posao', 2)
          for i=1, #Dark.Drvoseca.LokacijeDrveta, 1 do
            ESX.Game.DeleteObject(objekat[i])
            spawnao[i] = false
          end
        end,
  		},
  	},
  	distance = 2
  })
end

function drvosecaanimacija()

	RequestAnimDict("melee@hatchet@streamed_core")
	while (not HasAnimDictLoaded("melee@hatchet@streamed_core")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ESX.PlayerData.ped, "melee@hatchet@streamed_core", "plyr_front_takedown", 8.0, -8.0, -1, 0, 0, false, false, false)
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DeletePed(ped)
  DeletePed(pedprodaja)
  exports.qtarget:RemoveTargetModel(Dark.Drvoseca.PedDrvoseca, {
     'Prekini posao', 'Uzmi posao'
  })
  for i=1, #Dark.Drvoseca.LokacijeDrveta, 1 do
    ESX.Game.DeleteObject(objekat[i])
  end
  ESX.Game.DeleteObject(preradaobj)
end)
