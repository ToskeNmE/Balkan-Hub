ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local grupe = {
	['user'] = false,
	['vlasnik'] = true,
	['suvlasnik'] = true,
	['skripter'] = true,
	['asistent'] = true,
	['direktor']= true,
	['ultimatum']= true,
	['menadzer']= true,
	['headstaff'] = true,
	['vodjaadmina']= true,
	['vodja'] = true,
	['vodjaorg'] = true,
	['vodjapromotera'] = true,
	['premiumadmin'] = true,
	['roleplayadmin'] = true,
	['superadmin'] = true,
	['admin3'] = true,
	['admin2'] = true,
	['admin'] = true,
	['logoviadmin'] = true,
	['helper'] = false,
}

RegisterCommand("dajmarkere", function(source, args, raw)

	local xPlayer = ESX.GetPlayerFromId(source)

	if grupe[xPlayer.getGroup()] then
		if xPlayer.proveriDuznost() == true then
		if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
			if tonumber(args[2]) <= tonumber(200) then
				ESX.TriggerServerCallback('hub_markerigrandson:provera', function()  end, tonumber(args[1]), tonumber(args[2]))
				saljimarkerikomandu("Markeri", GetPlayerName(source) .. " je stavio igraca " .. GetPlayerName(args[1]) .. " na " .. tonumber(args[2]) .. " markera.")
			else
				TriggerClientEvent('hub_notifikacije:Alert', source, "GRESKA", "Maksimalan broj markera za tvoj rank je 200.", 5000, 'error')
			end
		else
		    TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Ukucajte: /dajmarkere ID[igraca] BROJ MARKERA (200)", type = "success", queue = "success", timeout = 5000, layout = "center"})
		end
	else
		TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Niste na admin duznosti", type = "success", queue = "success", timeout = 5000, layout = "center"})
	end
	else
		TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Morate biti admin!", type = "success", queue = "success", timeout = 5000, layout = "center"})
	end
end)

RegisterCommand("skinimarkere", function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

	if grupe[xPlayer.getGroup()] then
		if xPlayer.proveriDuznost () == true then
		if args[1] then
			if GetPlayerName(args[1]) ~= nil then
				ESX.TriggerServerCallback('hub_markerigrandson:endCommunityServiceCommand', function()  end, tonumber(args[1]))
				saljiskinimarkerekomandu("Markeri", GetPlayerName(source) .. " je skinuo " .. GetPlayerName(args[1]) .. " sa markera.")
			else
			    TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Niste uneli validan ID!", type = "success", queue = "success", timeout = 4000, layout = "center"})
			end
		else
			TriggerEvent('hub_skidanjesamarkera:endCommunityServiceCommand', source)
	    end
	else
		TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Niste na admin duznosti", type = "success", queue = "success", timeout = 5000, layout = "center"})
	end
	else
		TriggerClientEvent("hub_notifikacije:SendNotification", source, {text = "Morate biti admin!", type = "success", queue = "success", timeout = 5000, layout = "center"})
	end
end)

ESX.RegisterServerCallback('hub_markerigrandson:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

RegisterServerEvent('hub_markerigrandson:finishCommunityService')
AddEventHandler('hub_markerigrandson:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('hub_markerigrandson:completeService')
AddEventHandler('hub_markerigrandson:completeService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining - 1 WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
		end
	end)
end)

RegisterServerEvent('hub_markerigrandson:extendService')
AddEventHandler('hub_markerigrandson:extendService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining + @extension_value WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@extension_value'] = Config.ServiceExtensionOnEscape
			})
		end
	end)
end)

ESX.RegisterServerCallback('hub_markerigrandson:provera', function(target, actions_count)
	local identifier = GetPlayerIdentifiers(target)[1]
	--local xPlayer = ESX.GetPlayerFromId(source)
	--if  xPlayer.getGroup() == "helper" or xPlayer.getGroup() == "premiumadmin" or xPlayer.getGroup() == "vodjahelpera" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "headstaff" or xPlayer.getGroup() == "admin2" or xPlayer.getGroup() == "admin3" or xPlayer.getGroup() == "suvlasnik" or xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "vodjaorg" or xPlayer.getGroup() == "vodja" or xPlayer.getGroup() == "menadzer" then
	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = @actions_remaining WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@actions_remaining'] = actions_count
			})
		else
			MySQL.Async.execute('INSERT INTO communityservice (identifier, actions_remaining) VALUES (@identifier, @actions_remaining)', {
				['@identifier'] = identifier,
				['@actions_remaining'] = actions_count
			})
		end
	end)

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('comserv_msg', GetPlayerName(target), actions_count) }, color = { 0, 234, 255 } })
	TriggerClientEvent('esx_policijajob:requestrelease', target)
	TriggerClientEvent('hub_markerigrandson:inCommunityService', target, actions_count)
	--else
	--CancelEvent()
	--DropPlayer(source, "DarkBoy AC : Ne mozes citovati ovde ! :)")
	--end
end)

RegisterServerEvent('hub_markerigrandson:checkIfSentenced')
AddEventHandler('hub_markerigrandson:checkIfSentenced', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] ~= nil and result[1].actions_remaining > 0 then
			--TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('jailed_msg', GetPlayerName(_source), ESX.Math.Round(result[1].jail_time / 60)) }, color = { 147, 196, 109 } })
			TriggerClientEvent('hub_markerigrandson:inCommunityService', _source, tonumber(result[1].actions_remaining))
		end
	end)
end)

function releaseFromCommunityService(target)

	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE from communityservice WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
			
		end
	end)

	TriggerClientEvent('hub_markerigrandson:finishCommunityService', target)
end

function saljimarkerikomandu(name, message)
	local vrijeme = os.date('*t')  
	local poruka = {
		  {
			  ["color"] = 16711680,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = "HUB Logovi\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			  },
		  }
		}
	  PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "HUB Markeri 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end

function saljiskinimarkerekomandu(name, message)
	local vrijeme = os.date('*t')  
	local poruka = {
		  {
			  ["color"] = 16711680,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = "HUB Logovi\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			  },
		  }
		}
	  PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "HUB Markeri 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end