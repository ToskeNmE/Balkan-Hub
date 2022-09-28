local display = false

RegisterCommand("kordinate", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local x = string.sub(playerCoords.x, 0, 8) 
    local y = string.sub(playerCoords.y, 0, 8)
    local z = string.sub(playerCoords.z, 0, 6)
    igorCoords('igor', 'x = ' .. x .. ', y = ' .. y .. ', z = ' .. z)
    igorcoordsNormal('normal', x .. ', ' .. y .. ', ' .. z)
    igorcoordsVector3('vector3', 'vector3(' .. x .. ', ' .. y .. ', ' .. z .. ')')
    SetDisplay(not display)
end)

function igorCoords(type, text)
	SendNUIMessage({
        type = type,
		text = text
	})
end

function igorcoordsNormal(type, text)
    SendNUIMessage({
        type = type,
		text = text
	})
end

function igorcoordsVector3(type, text)
    SendNUIMessage({
        type = type,
		text = text
	})
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("igorcloseButton", function(data)
    SetNuiFocus(false, false)
    SetDisplay(false)
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)

-- Lokacija

local coordsVisible = false

function DrawGenericText(text)
  SetTextColour(186, 186, 186, 255)
  SetTextFont(7)
  SetTextScale(0.378, 0.378)
  SetTextWrap(0.0, 1.0)
  SetTextCentre(false)
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 205)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.40, 0.20)
end

Citizen.CreateThread(function()
    while true do 
    local sleepThread = 250
    
    if coordsVisible then
      sleepThread = 5

      local playerPed = PlayerPedId()
      local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
      local playerH = GetEntityHeading(playerPed)

      DrawGenericText(("~b~X~w~: %s ~b~Y~w~: %s ~b~Z~w~: %s ~b~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
    end

    Citizen.Wait(sleepThread)
  end
end)

FormatCoord = function(coord)
  if coord == nil then
    return "unknown"
  end

  return tonumber(string.format("%.2f", coord))
end

ToggleCoords = function()
  coordsVisible = not coordsVisible
end

RegisterCommand("coords", function(target)
    ToggleCoords()
end)