-- args = {}

RegisterCommand('+amenu', function()
    local myMenu = {
        {
            id = 1,
            header = 'Admin Meni',
            txt = ''
        },
        {
            id = 2,
            header = 'Noclip',
            txt = 'Upali/Ugasi noclip',
            params = {
                event = 'esx:noclip',
                isServer = false,
            }
        },
        {
            id = 3,
            header = 'Nevidljivost',
            txt = 'Upali/Ugasi nevidljivost',
            params = {
                event = 'esx:nevidljivost',
                isServer = false,
            }
        },
        {
            id = 4,
            header = 'Scoreboard',
            txt = 'Upali/Ugasi scoreboard',
            params = {
                event = 'esx:scoreboard',
                isServer = false,
            }
        },
        {
            id = 5,
            header = 'Spectate',
            txt = 'Posmatraj igrace',
            params = {
                event = 'xSpectate:menu2',
                isServer = false,
            }
        },
        {
            id = 6,
            header = 'Popravi',
            txt = 'Popravi vozilo',
            params = {
                event = 'esx:popravi',
                isServer = false,
            }
        },
        {
            id = 7,
            header = 'Ocisti',
            txt = 'Ocisti vozilo',
            params = {
                event = 'esx:ocisti',
                isServer = false,
            }
        },
        {
            id = 8,
            header = 'DV',
            txt = 'Obrisi vozilo',
            params = {
                event = 'esx:obrisivozilo',
                isServer = false,
            }
        },
        --{
        --    id = 9,
        --    header = 'DV ALL',
        --    txt = 'Obrisi sva vozila',
        --    params = {
        --        event = 'dark-adminmeni:obrisivozila2',
        --        isServer = false,
        --    }
        --},
        {
            id = 9,
            header = 'Vozilo za igrace',
            txt = 'Stvori vozilo za igrace',
            params = {
                event = 'esx:stvorivozilo',
                isServer = false,
                args = {
                  vozilo = 'blista'
                }
            }
        },
        {
            id = 10,
            header = 'Vozilo za staff',
            txt = 'Stvori vozilo za staff',
            params = {
                event = 'esx:stvorivozilo',
                isServer = false,
                args = {
                  vozilo = 'sultan'
                }
            }
        },
    }
    ESX.TriggerServerCallback('dark-adminmenu:proverigrupu', function(grupa)
      if grupa then
        exports['hMenu']:openMenu(myMenu)
      end
    end)
end, false)


RegisterKeyMapping('+amenu', "Admin Menu", 'keyboard', 'F5')


RegisterCommand('+vmenu', function()
  local myMenu = {
      {
          id = 1,
          header = 'VIP Meni',
          txt = ''
      },
      {
          id = 2,
          header = 'Scoreboard',
          txt = 'Upali/Ugasi scoreboard',
          params = {
              event = 'esx:scoreboard',
              isServer = false,
          }
      },
      {
          id = 3,
          header = 'Popravi',
          txt = 'Popravi vozilo',
          params = {
              event = 'esx:popravi',
              isServer = false,
          }
      },
      {
          id = 4,
          header = 'Ocisti',
          txt = 'Ocisti vozilo',
          params = {
              event = 'esx:ocisti',
              isServer = false,
          }
      },
      {
          id = 5,
          header = 'DV',
          txt = 'Obrisi vozilo',
          params = {
              event = 'esx:obrisivozilo',
              isServer = false,
          }
      },
      {
          id = 6,
          header = 'Vozilo za igrace',
          txt = 'Stvori vozilo za igrace',
          params = {
              event = 'esx:stvorivozilo',
              isServer = false,
              args = {
                vozilo = 'blista'
              }
          }
      },
  }
  print('test')
  ESX.TriggerServerCallback('dark-vip:proverivipa', function(imavipa)
    print(imavipa)
    if imavipa then
      exports['hMenu']:openMenu(myMenu)
    else
      exports['hNotifikacije']:Notifikacije('Nemas vipa', 2)
    end
  end)
end, false)


RegisterKeyMapping('+vmenu', "Vip Menu", 'keyboard', 'F4')

RegisterNetEvent('esx:nevidljivost')
AddEventHandler('esx:nevidljivost', function()
    if not nevidljivost then
      SetEntityVisible(ESX.PlayerData.ped, false)
      nevidljivost = true
      exports['hNotifikacije']:Notifikacije('Upalio si nevidljivost', 3)
    else
      SetEntityVisible(ESX.PlayerData.ped, true)
      nevidljivost = false
      exports['hNotifikacije']:Notifikacije('Ugasio si nevidljivost', 2)
    end
end)

RegisterNetEvent('esx:popravi')
AddEventHandler('esx:popravi', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetVehicleEngineHealth(vehicle, 1000)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleFixed(vehicle)
    DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
    exports['hNotifikacije']:Notifikacije('Vozilo je popravljeno!', 3)
  else
    exports['hNotifikacije']:Notifikacije('Niste u autu!', 2)
  end
end)

RegisterNetEvent('esx:ocisti')
AddEventHandler('esx:ocisti', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetVehicleDirtLevel(vehicle, 0)
    exports['hNotifikacije']:Notifikacije('Vozilo je ocisceno!', 3)
  else
    exports['hNotifikacije']:Notifikacije('Niste u autu!', 2)
  end
end)

RegisterNetEvent('esx:stvorivozilo')
AddEventHandler('esx:stvorivozilo', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  if DoesEntityExist(vehicle) then
    DeleteEntity(vehicle)
    ESX.Game.SpawnVehicle(data.vozilo, GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped), function(vozilo)
      TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vozilo, -1)
      exports['hNotifikacije']:Notifikacije('Stvorio si vozilo!', 3)
    end)
  else
    ESX.Game.SpawnVehicle(data.vozilo, GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped), function(vozilo)
      TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vozilo, -1)
      exports['hNotifikacije']:Notifikacije('Stvorio si vozilo!', 3)
    end)
  end
end)

RegisterNetEvent('esx:obrisivozilo')
AddEventHandler('esx:obrisivozilo', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  if IsPedSittingInAnyVehicle(ESX.PlayerData.ped) then
    DeleteEntity(vehicle)
    exports['hNotifikacije']:Notifikacije('Obrisao si vozilo!', 3)
  else
    exports['hNotifikacije']:Notifikacije('Nisi u vozilu!', 2)
  end
end)

RegisterNetEvent("dark-adminmeni:obrisivozila2")
AddEventHandler("dark-adminmeni:obrisivozila2", function ()
  ESX.TriggerServerCallback('dark-adminmeni:obrisivozilazasve', function() end)
end)

RegisterNetEvent("dark-adminmeni:obrisivozila")
AddEventHandler("dark-adminmeni:obrisivozila", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
            SetVehicleHasBeenOwnedByPlayer(vehicle, false)
            SetEntityAsMissionEntity(vehicle, false, false)
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then
                DeleteVehicle(vehicle)
            end
        end
    end
end)

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }

  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end

      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)

      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next

      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end

  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end

  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end

  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end

  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
