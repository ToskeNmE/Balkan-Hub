AddEventHandler('playerDropped', function (reason)
	local player = source
    local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)
	TriggerClientEvent('3dme:shareDisplayExit', -1, "Igrac " .. GetPlayerName(player) .. " (" .. player .. ") je napustio grad\n RAZLOG : " .. reason, playerCoords)
end)