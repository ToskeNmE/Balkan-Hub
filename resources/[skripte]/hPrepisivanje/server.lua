ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = ''

RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)

						TriggerClientEvent("hub_notifikacije:obavestenje", _source, "Uspesno ste prodali vozilo " .. model .. "<br>sa tablicama " .. plate, 5000)
						TriggerClientEvent("hub_notifikacije:obavestenje", target, "Uspesno si kupio vozilo " .. model .. "<br>sa tablicama " .. plate, 5000)

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent("hub_notifikacije:obavestenje", _source, target_name .. " nema dovoljno novca da kupi vozilo", 5000)
				TriggerClientEvent("hub_notifikacije:obavestenje", target, "Nemas dovoljno novca da <br>kupis vozilo koje pripada " .. source_name, 5000)
			end
		else
			TriggerClientEvent("hub_notifikacije:obavestenje", _source, "Vozilo sa tablicama " .. plate .. "<br>nije tvoje", 5000)
			TriggerClientEvent("hub_notifikacije:obavestenje", target, source_name .. " ti je pokusao prodati ukradeno vozilo", 5000)
		end
	else
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
				['@owner'] = xPlayer.identifier,
				['@target'] = tPlayer.identifier,
				['@plate'] = plate
			}, function (result2)
				if result2 ~= 0 then
					TriggerClientEvent("hub_notifikacije:obavestenje", _source, "Uspesno ste prodali vozilo " .. model .. "<br>sa tablicama " .. plate, 5000)
					TriggerClientEvent("hub_notifikacije:obavestenje", target, "Uspesno si kupio vozilo " .. model .. "<br>sa tablicama " .. plate, 5000)

					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			TriggerClientEvent("hub_notifikacije:obavestenje", _source, "Vozilo sa tablicama " .. plate .. "<br>nije tvoje", 5000)
			TriggerClientEvent("hub_notifikacije:obavestenje", target, source_name .. " ti je pokusao prodati ukradeno vozilo", 5000)
		end
	end
end)

ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.getName()

	cb(targetname)
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.getName(), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('okokContract:startContractAnimation', data.targetID)
end)

RegisterCommand('prepisiauto', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	--local levelIgraca = xPlayer.get("rank")
	--if levelIgraca >= 3 then
		TriggerClientEvent('okokContract:OpenContractInfo', _source)
		TriggerClientEvent('okokContract:startContractAnimation', _source)
	--else
	--	TriggerClientEvent('hub_notifikacije:Alert', source, "GRESKA", "Morate biti level 3 ili veci da bi prepisali vozilo", 5000, 'error')
	--end

end)

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logovi',
			},
			["title"] = 'PREPIS VOZILA',
			["description"] = '**Vozilo: **'..data.model..'**\nTablice: **'..data.plate..'**\nIme Kupca: **'..data.target_name..'**\nIme Prodavaca: **'..data.source_name..'**\nCena: **'..data.vehicle_price..'€',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end