ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('hub_autoskola:loadLicenses', source, licenses)
	end)
end)


RegisterNetEvent('hub_autoskola:addLicense')
AddEventHandler('hub_autoskola:addLicense', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('hub_autoskola:loadLicenses', _source, licenses)
			if xPlayer.getInventoryItem('vozacka').count == 0 then
				xPlayer.addInventoryItem('vozacka', 1)
			end
		end)
	end)
end)

RegisterNetEvent('hub_autoskola:pay')
AddEventHandler('hub_autoskola:pay', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
end)
