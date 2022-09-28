ESX = nil 
Citizen.CreateThread(function() 
while ESX == nil do 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
Citizen.Wait(0) 
end 
end)
-- menu
RegisterServerEvent('xSpectateMenu')
AddEventHandler('xSpectateMenu', function()
	local igrac = ESX.GetPlayerFromId(source)
	if igrac.getGroup() ~= 'user' then
		local nplayers = 0
		local player_ids = {}
		local player_names = {}
		for _, playerId in ipairs(GetPlayers()) do
			nplayers = nplayers + 1
			player_ids[nplayers] = playerId
			player_names[nplayers] = GetPlayerName(playerId)
		end
		TriggerClientEvent('xSpectate:menu', source, nplayers, player_ids, player_names)
	end
end)
-- spectate
RegisterServerEvent('xSpectate')
AddEventHandler('xSpectate', function(playerId)
	local igrac = ESX.GetPlayerFromId(source)
	if igrac.getGroup() ~= 'user' and playerId then
		if GetPlayerName(playerId) then
			local coords = GetEntityCoords(GetPlayerPed(playerId))
			if coords.x ~= 0 and coords.y ~= 0 and coords.z ~= 0 then
				TriggerClientEvent('xSpectate:main', source, coords, playerId)
			end
		end
	end
end)
-- resource name
Citizen.CreateThread(function()
	while true do
		if GetCurrentResourceName() ~= 'hSpectate' then
			print('Promeni ime skripte ' .. GetCurrentResourceName() .. ' u hSpectate')
		end
		Citizen.Wait(60000)
	end
end)
