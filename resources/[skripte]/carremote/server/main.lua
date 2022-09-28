ESX          = nil
local owners = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carremote:checkOwnedVehicle', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			if result[1].plate then
				cb(true)
			else
				cb(false)
			end
		end                
	end)
end)

RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(maxDistance, soundFile, maxVolume, vehicleNetId)
	TriggerClientEvent('carremote:playSoundFromVehicle', -1, source, maxDistance, soundFile, maxVolume, vehicleNetId)
end)

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('carremote:playSound', -1, source, maxDistance, soundFile, soundVolume)
end)