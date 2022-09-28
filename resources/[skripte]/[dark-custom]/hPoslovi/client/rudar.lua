local objekatrudar = {}
local spawnaorudar = {}
local kopa = false

Citizen.CreateThread(function()
  uzmiposao2()
  rudar = AddBlipForCoord(Dark.Rudar.Presvlacenje.coords)
  SetBlipSprite(rudar, 617)
  SetBlipDisplay(rudar, 4)
  SetBlipScale(rudar, 0.65)
  SetBlipColour(rudar, 5) 
  SetBlipAsShortRange(rudar, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('Rudar')
  EndTextCommandSetBlipName(rudar)
  rudarprodaja = AddBlipForCoord(Dark.Rudar.Prodaja.coords)
  SetBlipSprite(rudarprodaja, 617)
  SetBlipDisplay(rudarprodaja, 4)
  SetBlipScale(rudarprodaja, 0.65)
  SetBlipColour(rudarprodaja, 5) 
  SetBlipAsShortRange(rudarprodaja, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString('Rudar Prodaja')
  EndTextCommandSetBlipName(rudarprodaja)
  while true do
    Citizen.Wait(0)
    sleep = true
    if zapoceorudara then
      for i=1, #Dark.Rudar.LokacijeKamenja, 1 do
        local distancarudar = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Rudar.LokacijeKamenja[i])
        if distancarudar < 100.0 then
          if not DoesEntityExist(objekatrudar[i]) and not spawnaorudar[i] then
            ESX.Game.SpawnLocalObject(Dark.Rudar.KamenProp, Dark.Rudar.LokacijeKamenja[i], function(obj)
               objekatrudar[i] = obj
               FreezeEntityPosition(objekatrudar[i], true)
               PlaceObjectOnGroundProperly(objekatrudar[i])
            end)
            spawnaorudar[i] = true
          end
        else
          if DoesEntityExist(objekatrudar[i]) then
              ESX.Game.DeleteObject(objekatrudar[i])
              spawnaorudar[i] = false
          end
        end
        if DoesEntityExist(objekatrudar[i]) and spawnaorudar[i] then
          local distancarudar2 = #(GetEntityCoords(ESX.PlayerData.ped) - GetEntityCoords(objekatrudar[i]))
          if distancarudar2 < 5 then
              sleep = false
              exports['hCore']:Draw3DText(GetEntityCoords(objekatrudar[i]).x, GetEntityCoords(objekatrudar[i]).y, GetEntityCoords(objekatrudar[i]).z + 2, "~s~Da bi kopao kamen drzzi ~o~ALT~s~ na njega\n~r~AKO TI TREBA POMOC KUCAJ /RUDARHELP")
          end
          if distancarudar2 < 2.5 then
            exports.qtarget:AddTargetModel(Dark.Rudar.KamenProp, {
               options = {
                   {
                     icon = "fas fa-gem",
                     label = "Kompaj kamen",
                     num = 1,
                     canInteract = function (entity)
                      local coords = GetEntityCoords(ESX.PlayerData.ped)
                      for i=1, #Dark.Rudar.LokacijeKamenja, 1 do
                        if GetDistanceBetweenCoords(coords, GetEntityCoords(objekatrudar[i]), false) < 1.5 then
                          if objekatrudar[i] == entity then
                            return true
                          else
                            return false
                          end
                        end
                      end
                    end,
                     action = function(entity)
                      if not kopa then
                        kopa = true
                        freezan = true
                        item = Dark.Rudar.Itemi[math.random(1, #Dark.Rudar.Itemi)]
                        amount = math.random(1, 3)
                        ESX.TriggerServerCallback('dark-poslovi:proveridalimozedanosi', function(moze)
                          if moze then
                              if lib.progressCircle({
                                duration = 7500,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                anim = {
                                  clip = "ground_attack_on_spot",
                                  dict = "melee@large_wpn@streamed_core",
                                },
                                prop = {
                                  model = `prop_tool_pickaxe`,
                                  pos = vec3(0.08, -0.1, -0.03),
                                  rot = vec3(-75.0, 0.0, 10.0),
                              },
                              }) then
                                kopa = false
                                ESX.Game.DeleteObject(entity)
                                ESX.TriggerServerCallback('dark-poslovi:iskopajkamen', function() end, item, amount)
                                freezan = false
                                Citizen.Wait(20000)
                                spawnaorudar[i] = false
                              else
                                exports['hNotifikacije']:Notifikacije('Prekinuo si kopmannje kamena', 2)
                                kopa = false
                                freezan = false
                              end
                          else
                            kopa = false
                            freezan = false
                          end
                        end, item, amount)
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
    local distanncaprodaja2 = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Rudar.Prodaja.coords)
    if distanncaprodaja2 < 25.0 then
      sleep = false
      if not DoesEntityExist(prodajapedrudar) then
        prodajapedrudar = exports['hCore']:NapraviPed(GetHashKey(Dark.Rudar.PedProdaja), Dark.Rudar.Prodaja.coords, Dark.Rudar.Prodaja.heading)
        exports.qtarget:AddTargetModel(Dark.Rudar.PedProdaja, {
        	options = {
        		{
        			icon = "fas fa-dollar-sign",
        			label = "Prodaj tresnje",
        			num = 1,
              action = function(entity)
                lib.registerContext({
                    id = 'prodaj_menu',
                    title = 'Prodaj rudi',
                    options = {
                        ['Kamen'] = {
                            metadata = {
                                ['Cena'] = Dark.Rudar.Cena.stone
                            },
                            event = 'dark-poslovi:prodajrudu',
                            args = {cena = Dark.Rudar.Cena.stone, item = 'stone'}
                        },
                        ['Metal'] = {
                          metadata = {
                              ['Cena'] = Dark.Rudar.Cena.iron
                          },
                          event = 'dark-poslovi:prodajrudu',
                          args = {cena = Dark.Rudar.Cena.iron, item = 'iron'}
                        },
                        ['Zlato'] = {
                          metadata = {
                              ['Cena'] = Dark.Rudar.Cena.gold
                          },
                          event = 'dark-poslovi:prodajrudu',
                          args = {cena = Dark.Rudar.Cena.gold, item = 'gold'}
                        }
                    }
                })
                lib.showContext('prodaj_menu')
              end,
        		},
        	},
        	distance = 2
        })
      end
      if distanncaprodaja2 < 5 and DoesEntityExist(prodajapedrudar) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Rudar.Prodaja.coords.x, Dark.Rudar.Prodaja.coords.y, Dark.Rudar.Prodaja.coords.z + 2, "~s~Da bi prodao rude drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /RUDARHELP")
      end
    else
      if DoesEntityExist(prodajapedrudar) then
        DeletePed(prodajapedrudar)
      end
    end
    local presvlacenjedisc2 = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Rudar.Presvlacenje.coords)
    if presvlacenjedisc2 < 25.0 then
      if not DoesEntityExist(rudarped) then
        sleep = false
        rudarped = exports['hCore']:NapraviPed(GetHashKey(Dark.Rudar.PedRudar), Dark.Rudar.Presvlacenje.coords, Dark.Rudar.Presvlacenje.heading)
      end
      if presvlacenjedisc2 < 5 and DoesEntityExist(rudarped) then
          sleep = false
          exports['hCore']:Draw3DText(Dark.Rudar.Presvlacenje.coords.x, Dark.Rudar.Presvlacenje.coords.y, Dark.Rudar.Presvlacenje.coords.z + 2, "~s~Da bi zapoceo/prekinuo posao drzi ~o~ALT~s~ na mene\n~r~AKO TI TREBA POMOC KUCAJ /RUDARHELP")
      end
    else
      if DoesEntityExist(rudarped) then
        DeletePed(rudarped)
      end
    end
    if IsEntityDead(ESX.PlayerData.ped) and zapoceorudara then
      for i=1, #Dark.Rudar.LokacijeKamenja, 1 do
        ESX.Game.DeleteObject(objekatrudar[i])
        spawnaorudar[i] = false
      end
      zapoceorudara = false
      exports.qtarget:RemoveTargetModel(Dark.Rudar.PedRudar, {
         'Prekini posao'
      })
      uzmiposao2()
    end
    if freezan then
      sleep = false
      FreezeEntityPosition(ESX.PlayerData.ped, true)
    end
    if sleep then Citizen.Wait(1000) end
  end
end)

AddEventHandler('dark-poslovi:prodajrudu', function (data)
    ESX.TriggerServerCallback('dark-poslovi:prodajrude', function() end, data.cena, data.item)
end)

function uzmiposao2()
exports.qtarget:AddTargetModel(Dark.Rudar.PedRudar, {
	options = {
		{
			icon = "fas fa-gem",
			label = "Uzmi posao",
			num = 1,
      action = function(entity)
        exports.qtarget:RemoveTargetModel(Dark.Rudar.PedRudar, {
	         'Uzmi posao'
        })
        prekiniposaso2()
        zapoceorudara = true
        exports['hNotifikacije']:Notifikacije('Zapoceo si posao', 3)
      end,
		},
	},
	distance = 2
})
end

function prekiniposaso2()
  exports.qtarget:AddTargetModel(Dark.Rudar.PedRudar, {
  	options = {
  		{
  			icon = "fas fa-gem",
  			label = "Prekini posao",
  			num = 1,
        action = function(entity)
          exports.qtarget:RemoveTargetModel(Dark.Rudar.PedRudar, {
  	         'Prekini posao'
          })
          uzmiposao2()
          DeleteWaypoint()
          zapoceorudara = false
          exports['hNotifikacije']:Notifikacije('Prekinuo si posao', 2)
          for i=1, #Dark.Rudar.LokacijeKamenja, 1 do
            ESX.Game.DeleteObject(objekatrudar[i])
            spawnaorudar[i] = false
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
  DeletePed(rudarped)
  exports.qtarget:RemoveTargetModel(Dark.Rudar.PedRudar, {
     'Prekini posao', 'Uzmi posao'
  })
  for i=1, #Dark.Rudar.LokacijeKamenja, 1 do
    ESX.Game.DeleteObject(objekatrudar[i])
  end
  if DoesEntityExist(prodajapedrudar) then
    DeletePed(prodajapedrudar)
  end
end)
