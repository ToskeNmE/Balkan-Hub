local carlog = ''
local setjoblog = ''
local grupalog = ''
local bringlog = ''
local gotolog = ''
local killlog = ''
local unfreezelog = ''

ESX.RegisterCommand('tp', 'developer', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', {'developer'}, function(xPlayer, args, showError)
	if args.playerId ~= nil then
		if ESX.DoesJobExist(args.job, args.grade) then
			args.playerId.setJob(args.job, args.grade)
			Core.SavePlayer(args.playerId)
			if setjoblog ~= '' or setjoblog ~= nil then
				saljilog(setjoblog, '**SETOVANJE POSLA**', GetPlayerName(xPlayer.source) .. ' je setovao job : '.. args.job .. ' | grade : ' .. args.grade .. ' igracu ' .. GetPlayerName(args.playerId.source))
			end
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras upisati ID', 2)
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		xPlayer.triggerEvent('esx:spawnVehicle', args.car)
		if carlog ~= '' or carlog ~= nil then
			saljilog(carlog, '**SPAWN VOZILA**', GetPlayerName(xPlayer.source) .. ' je spawnovao vozilo : '.. args.car)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		if not args.radius then args.radius = 4 end
		xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

--ESX.RegisterCommand('setaccountmoney', 'developer', function(xPlayer, args, showError)
--	if args.playerId.getAccount(args.account) then
--		args.playerId.setAccountMoney(args.account, args.amount)
--	end
--end, true, {help = _U('command_setaccountmoney'), validate = true, arguments = {
--	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
--	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
--	{name = 'amount', help = _U('command_setaccountmoney_amount'), type = 'number'}
--}})

--ESX.RegisterCommand('giveaccountmoney', 'developer', function(xPlayer, args, showError)
--	if args.playerId.getAccount(args.account) then
--		args.playerId.addAccountMoney(args.account, args.amount)
--		if givemoneylog ~= '' or givemoneylog ~= nil then
--			saljilog(givemoneylog, '**SETOVANJE NOVCA**', GetPlayerName(xPlayer.source) .. ' je dao igracu : ' .. GetPlayerName(args.playerId.source) .. ' ' .. args.amount .. ' na ' .. args.account)
--		end
--	end
--end, true, {help = _U('command_giveaccountmoney'), validate = true, arguments = {
--	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
--	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
--	{name = 'amount', help = _U('command_giveaccountmoney_amount'), type = 'number'}
--}})

if not Config.OxInventory then
	ESX.RegisterCommand('giveitem', 'admin', function(xPlayer, args, showError)
		args.playerId.addInventoryItem(args.item, args.count)
	end, true, {help = _U('command_giveitem'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
		{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
	}})

	ESX.RegisterCommand('giveweapon', 'developer', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weapon) then
			showError(_U('command_giveweapon_hasalready'))
		else
			args.playerId.addWeapon(args.weapon, args.ammo)
		end
	end, true, {help = _U('command_giveweapon'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weapon', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'ammo', help = _U('command_giveweapon_ammo'), type = 'number'}
	}})

	ESX.RegisterCommand('giveweaponcomponent', 'developer', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weaponName) then
			local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

			if component then
				if args.playerId.hasWeaponComponent(args.weaponName, args.componentName) then
					
				else
					args.playerId.addWeaponComponent(args.weaponName, args.componentName)
				end
			end
		end
	end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
	}})
end

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, {'developer'}, function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

if not Config.OxInventory then
	ESX.RegisterCommand('clearinventory', {'developer'}, function(xPlayer, args, showError)
		for k,v in ipairs(args.playerId.inventory) do
			if v.count > 0 then
				args.playerId.setInventoryItem(v.name, 0)
			end
		end
	end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})

	ESX.RegisterCommand('clearloadout', {'developer'}, function(xPlayer, args, showError)
		for i=#args.playerId.loadout, 1, -1 do
			args.playerId.removeWeapon(args.playerId.loadout[i].name)
		end
	end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})
end

ESX.RegisterCommand('grupa', 'developer', function(xPlayer, args, showError)
	if not args.playerId then args.playerId = xPlayer.source end
	args.playerId.setGroup(args.group)
	if grupalog ~= '' or grupalog ~= nil then
		saljilog(grupalog, '**SETOVANJE GRUPE**', GetPlayerName(xPlayer.source) .. ' je dao igracu : ' .. GetPlayerName(args.playerId.source) .. ' grupu : ' .. args.group)
	end
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'developer', function(xPlayer, args, showError)
	Core.SavePlayer(args.playerId)
	print("[^2Info^0] Saved Player!")
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'developer', function(xPlayer, args, showError)
	Core.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('coords', "admin", function(xPlayer, args, showError)
	local coords = GetEntityCoords(GetPlayerPed(xPlayer.source), false)
  local heading = GetEntityHeading(GetPlayerPed(xPlayer.source))
	print("Coords - Vector3: ^5".. vector3(coords.x,coords.y,coords.z).. "^0")
	print("Coords - Vector4: ^5".. vector4(coords.x, coords.y, coords.z, heading) .. "^0")
end, true)



ESX.RegisterCommand('tpm', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		xPlayer.triggerEvent("esx:tpm")
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true)

ESX.RegisterCommand('goto', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		if args.playerId ~= nil then
			local targetCoords = args.playerId.getCoords()
			xPlayer.setCoords(targetCoords)
			if gotolog ~= '' or gotolog ~= nil then
				saljilog(gotolog, '**GOTO**', GetPlayerName(xPlayer.source) .. ' je se gotovao do igraca : ' .. GetPlayerName(args.playerId.source))
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Moras upisati ID', 2)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true, {help = _U('goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		if args.playerId ~= nil then
			local playerCoords = xPlayer.getCoords()
			args.playerId.setCoords(playerCoords)
			if bringlog ~= '' or bringlog ~= nil then
				saljilog(bringlog, '**BRING**', GetPlayerName(xPlayer.source) .. ' je bringovao igraca : ' .. GetPlayerName(args.playerId.source) .. ' do sebe')
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Moras upisati ID', 2)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true, {help = _U('bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		if args.playerId ~= nil then
			args.playerId.triggerEvent("esx:killPlayer")
			if killlog ~= '' or killlog ~= nil then
				saljilog(killlog, '**Kill**', GetPlayerName(xPlayer.source) .. ' je ubio igraca : ' .. GetPlayerName(args.playerId.source))
			end
		else
			xPlayer.triggerEvent('dark:client:notify', 'Moras upisati ID', 2)
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('freeze', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		args.playerId.triggerEvent('esx:freezePlayer', "freeze")
		if unfreezelog ~= '' or unfreezelog ~= nil then
			saljilog(unfreezelog, '**FREEZE**', GetPlayerName(xPlayer.source) .. ' je freezovao igraca : ' .. GetPlayerName(args.playerId.source))
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('unfreeze', {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		args.playerId.triggerEvent('esx:freezePlayer', "unfreeze")
		if unfreezelog ~= '' or unfreezelog ~= nil then
			saljilog(unfreezelog, '**FREEZE**', GetPlayerName(xPlayer.source) .. ' je unfreezovao igraca : ' .. GetPlayerName(args.playerId.source))
		end
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand("noclip", {'developer'}, function(xPlayer, args, showError)
	if xPlayer.proveriDuznost() == true then
		xPlayer.triggerEvent('esx:noclip')
	else
		xPlayer.triggerEvent('dark:client:notify', 'Moras biti na duznosti', 2)
	end
end, false)

--[[ESX.RegisterCommand('players', "admin", function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
	print("^5"..#xPlayers.." ^2online player(s)^0")
	for _, xPlayer in pairs(xPlayers) do
		print("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Name : ^5"..xPlayer.getName().." ^0 | ^2Group : ^5"..xPlayer.getGroup().." ^0 | ^2Identifier : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)--]]

function saljilog(weebhook, name, message)
	local vrijeme = os.date('*t')  
	local poruka = {
		  {
			  ["color"] = 16711680,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = "Dark Development Logovi\nVreme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			  },
		  }
		}
	  PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({username = "Dark Development 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end