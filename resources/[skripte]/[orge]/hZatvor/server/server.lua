ESX                = nil

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
	['vodjaadmina'] = true,
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
	['helper'] = true,
}

RegisterCommand("zatvori", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if grupe[xPlayer.getGroup()] then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then
			local xPlayerce = ESX.GetPlayerFromId(tonumber(jailPlayer))
			if jailTime ~= nil then
				if jailReason then
					JailPlayer2(jailPlayer, jailTime)
					MySQL.Async.execute(
						"UPDATE users SET odkoga = @newJailTime WHERE identifier = @identifier",
						{
							['@identifier'] = xPlayerce.identifier,
							['@newJailTime'] = "admin"
						}
					)
					xPlayer.triggerEvent('dark:client:notify', GetPlayerName(jailPlayer) .. "Zatvoren na<br>" .. jailTime .. "minuta", 1)
					saljizatvor("Slanje U Zatvor", "Ime Admina: **" .. GetPlayerName(src) .. "**\nIme igraca: **" .. GetPlayerName(args[1]) .. "**\nVreme: **" .. jailTime .. " minuta**\nRazlog: **" .. jailReason .. "**" )
					
					if jailReason ~= nil then
						GetRPName(jailPlayer, function(Firstname, Lastname)
							TriggerClientEvent('chat:addMessage', -1, { args = { Firstname .. " " .. Lastname .. " je sada u zatvoru zbog: " .. jailReason }, color = { 0, 128, 255 } })
						end)
					end
				else
					xPlayer.triggerEvent('dark:client:notify', 'Moraš uneti razlog', 2)
				end
			else
				xPlayer.triggerEvent('dark:client:notify', 'Vreme nije važeće', 2)
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Ovaj ID nije na serveru', 2)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Nisi sluzbenik', 2)
	end

end)

RegisterCommand("oslobodi", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if grupe[xPlayer.getGroup()] then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
			saljizatvor("Oslobođenje Iz Zatvora", "Ime Admina: **" .. GetPlayerName(src) .. "**\nIme igraca: **" .. GetPlayerName(args[1]) .. "**" )
		else
			xPlayer.triggerEvent('dark:client:notify', 'Ovaj ID nije na serveru', 2)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Nisi sluzbenik', 2)
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason, target)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.job.name == "police" or grupe[xPlayer.getGroup()] then 

		JailPlayer(targetSrc, jailTime)
		TriggerClientEvent('esx_policijajob:requestrelease', target)
	
		GetRPName(targetSrc, function(Firstname, Lastname)
		end)
	xPlayer.triggerEvent('dark:client:notify', GetPlayerName(targetSrc) .. "Zatvoren na<br>" .. jailTime .. "minuta", 1)
	else
		CancelEvent()
		DropPlayer(source, "Pokusao si da cheatujes :P")
		anticheat("Zatvor", GetPlayerName(source) .. " je pokusao da stavi ljude u zatvor preko cheata :P")
	end
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	
	end
	xPlayer.triggerEvent('dark:client:notify', 'Pusten si', 3)
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))
	xPlayer.triggerEvent('dark:client:notify', 'Hvala, dobio si malo novca za hranu', 2)
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)
	ExecuteCommand("clearloadout", jailPlayer)
	EditJailTime(jailPlayer, jailTime)
end
function JailPlayer2(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:zatvoriprekomenija", jailPlayer, jailTime)
	ExecuteCommand("clearloadout")
	ExecuteCommand("clearloadout", jailPlayer)
end
function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)
	MySQL.Async.execute(
		"UPDATE users SET odkoga = @newJailTime WHERE identifier = @identifier",
		{
			['@identifier'] = GetPlayerIdentifier(jailPlayer),
			['@newJailTime'] = "nije"
		}
	)
	EditJailTime(jailPlayer, 0)
end
RegisterNetEvent("skiniodkoga")
AddEventHandler("skiniodkoga", function(jailPlayer)

	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute(
		"UPDATE users SET odkoga = @newJailTime WHERE identifier = @identifier",
		{
			['@identifier'] = xPlayer.identifier,
			['@newJailTime'] = "nije"
		}
	)

end)

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)
ESX.RegisterServerCallback("esx-qalle-jail:getajDali", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT odkoga FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = result[1].odkoga

		if JailTime == "admin" then

			cb(true)
		else
			cb(false)
		end

	end)
end)
function saljizatvor(name, message)
	local vrijeme = os.date('*t')  
	local poruka = {
		  {
			  ["color"] = 16711680,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = "Vreme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			  },
		  }
		}
	  PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Balkan HUB | Zatvor" , embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end