local defaultScale = 0.5 -- Text scale
local color = { r = 227, g = 146, b = 17, a = 255 } -- Text color
local distToDraw = 250 -- Min. distance to draw 

local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    --if onScreen then

        -- Format the text
        SetTextColour(color.r, color.g, color.b, color.a)
        SetTextScale(0.0, defaultScale * scale)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextDropShadow()
        SetTextCentre(true)

        -- Diplay the text
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        SetDrawOrigin(coords, 0)
        EndTextCommandDisplayText(0.0, 0.0)
        ClearDrawOrigin()

    --end
end

local function DisplayExit(pedCoords, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local dist = #(playerCoords - pedCoords)

    if dist <= distToDraw then

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(45000)
            display = false
        end)

        -- Display
        local offset = 1
        while display do
            local x, y, z = table.unpack(pedCoords)
            z = z + offset
            DrawText3D(vector3(x, y, z), text)
            Wait(0)
        end
    end
end

RegisterNetEvent('3dme:shareDisplayExit')
AddEventHandler('3dme:shareDisplayExit', function(text, pedCoords)
    DisplayExit(pedCoords, text)
end)