ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local grupe = {
	['user'] = false,
	['vlasnik'] = true,
	['suvlasnik'] = true,
	['skripter'] = true,
	['asistent'] = true,
	['direktor']= true,
	['menadzer']= true,
	['headstaff'] = true,
	['vodja'] = true,
	['vodjaorg'] = true,
	['vodjapromotera'] = true,
	['premiumadmin'] = true,
	['roleplayadmin'] = true,
	['superadmin'] = true,
	['admin3'] = true,
	['admin2'] = false,
	['admin'] = false,
	['logoviadmin'] = false,
	['helper'] = false,
}

RegisterCommand('dajmarkere', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(args[1])
	if xPlayer then
		if grupe[xPlayer.getGroup()] then
			if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
				if xTarget then
					TriggerEvent('esx_communityservice:sendToCommunityService', tonumber(args[1]), tonumber(args[2]))
					markeri("**MARKERI**", GetPlayerName(source) .. ' je stavio coveka ' .. GetPlayerName(args[1]) .. ' na ' .. args[2] .. ' markera')
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id_or_actions') } } )
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvolu za ovu komandu', 2)
		end
	end
end)

RegisterCommand('skinimarkere', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(args[1])
	if xPlayer then
		if grupe[xPlayer.getGroup()] then
			if args[1] ~= nil then
				if xTarget then
					TriggerEvent('esx_communityservice:endCommunityServiceCommand', tonumber(args[1]))
					markeri("**MARKERI**", GetPlayerName(source) .. ' je skinuo coveka ' .. GetPlayerName(args[1]) .. ' sa markera')
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id_or_actions') } } )
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvolu za ovu komandu', 2)
		end
	end
end)

function markeri(name, message)
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
      PerformHttpRequest("https://discord.com/api/webhooks/987777859168919593/Qd0mvPwcXOG9ffKbnmaJ7eFmFI1I-R-KwGJ6Yq1aBaxZooIJ0ptN_OEilXnVX5MUT1NI", function(err, text, headers) end, 'POST', json.encode({username = "Dark AutoSalon 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end

RegisterServerEvent('esx_communityservice:endCommunityServiceCommand')
AddEventHandler('esx_communityservice:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function()
	local identifier = ESX.GetPlayerFromId(source).identifier
	MySQL.single('SELECT * FROM markeri WHERE identifier = ?', {identifier}, function(result)
		if result then
			MySQL.update('UPDATE markeri SET actions_remaining = actions_remaining - 1 WHERE identifier = ?', {identifier}, function(affectedRows) end)
		else
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:extendService')
AddEventHandler('esx_communityservice:extendService', function()
	local identifier = ESX.GetPlayerFromId(source).identifier

	MySQL.single('SELECT * FROM markeri WHERE identifier = ?', {identifier}, function(result)
		if result then
			MySQL.update('UPDATE markeri SET actions_remaining = actions_remaining + ? WHERE identifier = ?', {Config.ServiceExtensionOnEscape, identifier}, function(affectedRows) end)
		else
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(target, actions_count)
	local identifier = ESX.GetPlayerFromId(target).identifier
	MySQL.single('SELECT * FROM markeri WHERE identifier = ?', {identifier}, function(result)
		if result then
			MySQL.update('UPDATE markeri SET actions_remaining = ? WHERE identifier = ?', {actions_count, identifier}, function(affectedRows) end)
		else
			MySQL.insert('INSERT INTO markeri (identifier, actions_remaining) VALUES (?, ?)', {identifier, actions_count}, function(id) end)
		end
	end)
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('comserv_msg', GetPlayerName(target), actions_count) }, color = { 147, 196, 109 } })
	TriggerClientEvent('esx_communityservice:inCommunityService', target, actions_count)
end)

RegisterServerEvent('esx_communityservice:checkIfSentenced')
AddEventHandler('esx_communityservice:checkIfSentenced', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local identifier = xPlayer.identifier

		MySQL.single('SELECT * FROM markeri WHERE identifier = ?', {identifier}, function(result)
			if result ~= nil and result.actions_remaining > 0 then
				TriggerClientEvent('esx_communityservice:inCommunityService', source, tonumber(result[1].actions_remaining))
			end
		end)
	end
end)

function releaseFromCommunityService(target)

	local identifier = ESX.GetPlayerFromId(target).identifier
	MySQL.single('SELECT * FROM markeri WHERE identifier = ?', {identifier}, function(result)
		if result then
			exports.oxmysql:execute('DELETE FROM markeri WHERE identifier = ?', {identifier})
		end
	end)

	TriggerClientEvent('esx_communityservice:finishCommunityService', target)
end