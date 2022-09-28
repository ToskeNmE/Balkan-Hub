ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('dark:doktro:remove', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.getMoney()>= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			if xPlayer.getAccount('bank').money >= Config.Price then
				xPlayer.removeAccountMoney('bank', Config.Price)
				cb(true)
			else
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('dark:doktro:proverinovac', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.getMoney()>= Config.Price then
			cb(true)
		else
			if xPlayer.getAccount('bank').money >= Config.Price then
				cb(true)
			else
				cb(false)
			end
		end
	end
end)