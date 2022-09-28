ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('proveripare', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)


RegisterNetEvent('proverapara')
AddEventHandler('proverapara', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		xPlayer.removeMoney(Config.Price)
		xPlayer.triggerEvent('dark:client:notify', 'Uspesno ste oprali auto', 3)
		TriggerClientEvent('opraoauto', source)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Nemate para', 1)
	end
end)