ESX = nil
local ped, currentStore, Vehicle = nil, nil, nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    TriggerServerEvent("hub_rentanje:getVehicle")
end)

RegisterCommand("fixim", function()
    TriggerServerEvent("hub_rentanje:getVehicle")
end)

Citizen.CreateThread(function()
    while true do
        local thread = 750
        if Vehicle ~= nil and currentStore ~= nil then
            local coords = GetEntityCoords(Vehicle)
            local distance = #(coords - Config.Lokacije[currentStore].coords.spawn)
            if distance <= 10 then
                thread = 0
                text = "Vratite automobil"
                if distance <= 2 then
                    text = "E - " ..text
                    if IsControlJustReleased(0, 46) then
                        GiveBackVehicle()
                    end
                end
               -- DrawMarker(2, Config.Lokacije[currentStore].x, Config.Lokacije[currentStore].y, Config.Lokacije[currentStore].z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
              DrawText3Ds(Config.Lokacije[currentStore].coords.spawn, text)
            end
        end
        Citizen.Wait(thread)
    end
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("rent", function(data)
    local plate = GeneratePlate()
    local data = data.data
    TriggerServerEvent("hub_rentanje:rent", data.name, data, plate, currentStore)
end)

RegisterNetEvent("hub_rentanje:spawnVehicle")
AddEventHandler("hub_rentanje:spawnVehicle", function(k, v, plate)
    local ped = PlayerPedId()
    ESX.Game.SpawnVehicle(v.name, Config.Lokacije[currentStore].coords.spawn, Config.Lokacije[currentStore].coords.Heading, function(vehicle)
        Vehicle = vehicle
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        SetEntityAsMissionEntity(vehicle, 1, 1)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(ped, true)
        TriggerServerEvent("hub_rentanje:update", vehicle)
    end)
end)

RegisterNetEvent("hub_rentanje:delete")
AddEventHandler("hub_rentanje:delete", function(vehicle)
    local ped = PlayerPedId()
    TaskLeaveVehicle(ped, vehicle, 0)
    while IsPedInVehicle(ped, vehicle, true) do
      Citizen.Wait(100)
    end
    Citizen.Wait(1000)
    DeleteEntity(vehicle)
end)

RegisterNetEvent("hub_rentanje:client:getVehicle")
AddEventHandler("hub_rentanje:client:getVehicle", function(vehicle)
    if not DoesEntityExist(vehicle) then
        TriggerServerEvent("hub_rentanje:update", vehicle, true)
        return
    end
    Vehicle = vehicle
end)

function GiveBackVehicle()
    local health = GetEntityHealth(Vehicle)
    TriggerServerEvent("hub_rentanje:giveback", health)
    Vehicle = nil
end

function OpenRentMenu(k, v)
    currentStore = k
    SendNUIMessage({ key = k, value = v })
    SetNuiFocus(true, true)
end

function DrawText3Ds(coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
	ClearDrawOrigin()
end

function GeneratePlate()
	return string.upper('fzf ' ..math.random(100,999))
end

exports.qtarget:AddTargetModel('a_f_y_business_01', {
	options = {
		{
			icon = "fas fa-car",
			label = "Rentuj vozila",
            action = function (entity)
                for k,v in pairs(Config.Lokacije) do
                    OpenRentMenu(k, v)
                end
            end
		},
	},
	distance = 2
})

Citizen.CreateThread(function()
	for i=1, 1 do

		local blip = AddBlipForCoord(vector3(-1032.45, -2734.78, 20.17))
		SetBlipSprite(blip, 225)
        SetBlipScale(blip, 0.65)
		SetBlipColour(blip, 59)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Rent')
		EndTextCommandSetBlipName(blip)
	end
end)

TabelaZaPedove = {
     {'a_f_y_business_01', -1032.45, -2734.78, 19.17, 120.69--[[HEADING]]}
  }
  
  Citizen.CreateThread(function()
    --[[vuce sve pedove iz tabele i requestuje ih]]
    for _,v in pairs(TabelaZaPedove) do
      RequestModel(GetHashKey(v[1]))
      while not HasModelLoaded(GetHashKey(v[1])) do
        Wait(1)
      end
        --[[postavlja sve pedove iz tabele]]
      PostaviPeda =  CreatePed(4, v[1],v[2],v[3],v[4],v[5], false, true)
      FreezeEntityPosition(PostaviPeda, true) -- Drzi peda na jednoj lokaciji
      SetEntityInvincible(PostaviPeda, true) -- Da ped mirno stoji 
      SetBlockingOfNonTemporaryEvents(PostaviPeda, true) -- Taakodje i ovaj native ga drzi mirno
    end
  end)

  