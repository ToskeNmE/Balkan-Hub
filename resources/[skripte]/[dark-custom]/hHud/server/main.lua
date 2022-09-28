
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('hub_hud:nesto', function(source, cb)
	cb(GetNumPlayerIndices())
end)

ESX.RegisterServerCallback('hub_hud:uid', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchScalar('SELECT uid FROM users where identifier = @identifier', { ['@identifier'] = xPlayer.identifier}, function(result)
		cb(result)
	end)
end)