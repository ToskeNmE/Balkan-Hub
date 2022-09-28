ESX = nil
local display = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("izadji", function(data, cb)
    SetDisplay(false)
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        spavaj = true
        if ESX ~= nil then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            for k,v in pairs(Config.Locations) do
                local distance = #(GetEntityCoords(PlayerPedId()) - v)
                
                if(distance < 5.0 and IsPedInAnyVehicle(playerPed, true)) then
                    spavaj = false
                    DrawText3D(v.x, v.y, v.z + 2.0, 0.35, '[E] da operete auto')
                    if IsControlJustPressed(0, 38) then
                        SetDisplay(true)
                    end
                
                end
            end
        end
        if spavaj then Citizen.Wait(1500) end
    end
end)


RegisterNUICallback("operi", function(data, cb)
    local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
        TriggerServerEvent('proverapara', source)
        SetDisplay(false)
    end
end)

RegisterNetEvent('opraoauto')
AddEventHandler('opraoauto', function()
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetVehicleDirtLevel(vehicle, 0)
end)




DrawText3D = function(x, y, z, scale, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(8)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 195
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 0, 0, 0, 100)
	end
end

Citizen.CreateThread(function()
	for i=1, #Config.Locations, 1 do
		carWashLocation = Config.Locations[i]

		local blip = AddBlipForCoord(carWashLocation)
		SetBlipSprite(blip, 100)
        SetBlipScale(blip, 0.65)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Auto perionica')
		EndTextCommandSetBlipName(blip)
	end
end)