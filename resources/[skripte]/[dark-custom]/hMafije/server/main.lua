ESX = nil
local nmafija,Pretrazivan = 0, {}
Vozila = {
	Izvucena = {}
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

teleportujSeDoBaze = function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not Config.Mafije[xPlayer.job.name] then TriggerClientEvent('esx:showNotification', source, ('Nemate setanu mafiju!')) return end
	for mafijoze=1, #Config.Mafije[xPlayer.job.name]['BossActions'], 1 do
		local lokacija = Config.Mafije[xPlayer.job.name]['BossActions'][mafijoze].coords
		SetEntityCoords(GetPlayerPed(source), lokacija)
		TriggerClientEvent('esx:showNotification', source, ('Teleportani ste do baze od - ' .. xPlayer.job.label))
	end
end

RegisterCommand('tpdobaze', function(source)
	local kod = source
	local xPlayer = ESX.GetPlayerFromId(kod)
	if xPlayer.getGroup() == 'vlasnik' or xPlayer.getGroup() == 'skripter' then
		teleportujSeDoBaze(kod)
	else
		TriggerClientEvent('esx:showNotification', kod, ('Ne mozes koristiti ovu komandu, nisi admin!'))
	end
end)

vlasnici = {
    'steam:1100001110e84dc', -- Musica
	'steam:11000013de6b0e4', -- DarkBoy
	'steam:11000010ce2f43f', -- Cope
	'steam:11000013ef82194', -- pedja
}


function DaLiMoze(player)
	local allowed = false
	for i,id in ipairs(vlasnici) do
		for x,pid in ipairs(GetPlayerIdentifiers(player)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end
	return allowed
end

RegisterCommand('dajvozilo', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if DaLiMoze(source) then
			TriggerClientEvent('dajvozilo:igracu2', args[1], args[2])
		end
	end
end)

ESX.RegisterServerCallback('dark-autosalon:dajownera2', function(source, cb, vehprops)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
	  MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (?, ?, ?, 1) ', {xPlayer.identifier, vehprops.plate, json.encode(vehprops)}, function(id)
		cb(true)
	  end)
	end
  end)

ESX.RegisterServerCallback("dark-mafije:dajpoenemafiji", function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and Config.Mafije[xPlayer.job.name] then
		MySQL.update('UPDATE `dark-org` SET poeni = poeni + 1 WHERE org = ?', {xPlayer.job.name}, function(affectedRows)
			if affectedRows then
				xPlayer.triggerEvent('Tvoja mafija je dobila 1 poen, jer si igrao 1h na serveru', 1)
			end
		end)
	end
end)

for k,v in pairs(Config.Mafije) do
	exports.ox_inventory:RegisterStash('society_' .. k, 'society_' .. k, 50, 200000)
	nmafija = nmafija + 1
end
exports.ox_inventory:RegisterStash('society_cigani2', 'society_cigani2', 150, 2000000)

print('[^1hMafije^0]:Ucitano ^4' .. nmafija .. '^0 mafija')

function sendToDiscord3 (name,message)
local embeds = {{
	["title"]=message,
	["type"]="rich",
	["color"] =2061822,
	["footer"]=  {
	["text"]= "HUB MAFIJE",
},}}

if message == nil or message == '' then return FALSE end PerformHttpRequest(Config.Webhuk, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' }) end

RegisterNetEvent('hMafije:vezivanje')
AddEventHandler('hMafije:vezivanje', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('hMafije:vezivanje', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :) Protected by ESX-BALKAN Mafije')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da zaveze osobu preko cheata!'):format(xPlayer.identifier))
end)

RegisterNetEvent('hMafije:vuci')
AddEventHandler('hMafije:vuci', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if src ~= target then
				TriggerClientEvent('hMafije:vuci', target, src)
				TriggerClientEvent('hMafije:nesto', src, target)
				return
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da vuce osobu preko cheata!'):format(xPlayer.identifier))
end)

RegisterNetEvent('hMafije:vuci2')
AddEventHandler('hMafije:vuci2', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if src ~= target then
				TriggerClientEvent('hMafije:vuci', target, src)
				return
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da vuce osobu preko cheata!'):format(xPlayer.identifier))
end)

RegisterNetEvent('hMafije:staviUVozilo')
AddEventHandler('hMafije:staviUVozilo', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('hMafije:staviUVozilo', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da stavi osobu preko cheata!'):format(xPlayer.identifier))
end)

RegisterNetEvent('hMafije:staviVanVozila')
AddEventHandler('hMafije:staviVanVozila', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('hMafije:staviVanVozila', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da izbaci osobu preko cheata!'):format(xPlayer.identifier))
end)

RegisterNetEvent('hMafije:poruka')
AddEventHandler('hMafije:poruka', function(target, msg)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if src ~= target then
				TriggerClientEvent('esx:showNotification', target, msg)
				return
			end
		end
	end

	DropPlayer(src, 'Zasto pokusavas da citujes. Nije lepo to :)')
	print(('[hMafije] [^3UPOZORENJE^7] %s ^1je pokusao da posalje svakome poruku preko cheata!'):format(xPlayer.identifier))
end)

ESX.RegisterServerCallback("WaveShield:GetInfinityPlayerList", function(source,cb)
    local playerlist = {}
    for _,v in pairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
		local xIgrac = ESX.GetPlayerFromId(source)
		if xPlayer then
			if xPlayer.job.name ~= xIgrac.job.name then
        		ime = GetPlayerName(v)
        		id = v
        		table.insert(playerlist, {
        		    ime = ime,
        		    id = id
        		})
			end
		end
    end
    cb(playerlist or {})
end)

ESX.RegisterServerCallback("dark-mafije:setajjob", function(source,cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(id)
	if xPlayer then
		if xTarget then
			xTarget.setJob(xPlayer.job.name, 0)
			xPlayer.triggerEvent('dark:client:notify', "Zaposlio si igraca " .. GetPlayerName(id) .. " u svoju mafiju", 3)
			xTarget.triggerEvent('dark:client:notify', "Zaposlen si kao " .. xPlayer.job.label .. " od strane " .. GetPlayerName(source), 3)
			MySQL.update('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {xPlayer.job.name, 0, xTarget.identifier}, function(affectedRows)
				if affectedRows then
					cb(true)
				end
			end)
			cb(true)
		end
	end
end)

local Jobs = {}

MySQL.ready(function()
	local result = MySQL.query.await('SELECT * FROM jobs', {})

	for i = 1, #result, 1 do
		Jobs[result[i].name] = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.query.await('SELECT * FROM job_grades', {})

	for i = 1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end	


	for k,v in pairs(Config.Mafije) do
		MySQL.scalar('SELECT * FROM `dark-org` WHERE org = ?', {k}, function(test)
			if test == nil then
				MySQL.insert('INSERT INTO `dark-org` (org, poeni, level) VALUES (?, ?, ?)', {k, 0, 0}, function(id) end)	
			end
		end)
	end
end)

ESX.RegisterServerCallback("dark:mafije:getajsve", function(source,cb, job)
	MySQL.query('SELECT * FROM users WHERE job = ?', {job}, function(result)
		local zaposleni = {}
		for i = 1, #result, 1 do
			table.insert(zaposleni, {
				ime = result[i].firstname .. ' ' .. result[i].lastname,
				identifier = result[i].identifier,
				grade = result[i].job_grade,
				grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label
			})
		end
		cb(zaposleni)
	end)
end)

ESX.RegisterServerCallback("dark-mafije:rankup", function(source,cb, identity, grade)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(identity)
	local IsBoss = xPlayer.job.grade_name == "boss"
	if xPlayer then
		if IsBoss then
			if xTarget then
				xTarget.setJob(xPlayer.job.name, grade)
				xPlayer.triggerEvent('dark:client:notify', "Unapredio si clana mafije " .. xTarget.name, 3)
				xTarget.triggerEvent('dark:client:notify', "Unapredjen si od strane " ..  xPlayer.name, 3)
			end
			MySQL.update('UPDATE users SET job_grade = ? WHERE identifier = ?', {grade, identity}, function(affectedRows)
				if affectedRows then
					cb(true)
				end
			end)
		end
	end	
end)	


ESX.RegisterServerCallback("dark-mafije:rankdown", function(source,cb, identity, grade)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(identity)
	local IsBoss = xPlayer.job.grade_name == "boss"
	if xPlayer then
		if IsBoss then
			if xTarget then
				xTarget.setJob(xPlayer.job.name, grade)
				xPlayer.triggerEvent('dark:client:notify', "Degradirao si clana mafije " .. xTarget.name, 1)
				xTarget.triggerEvent('dark:client:notify', "Degradiran si od strane " ..  xPlayer.name, 1)
			end
			MySQL.update('UPDATE users SET job_grade = ? WHERE identifier = ?', {grade, identity}, function(affectedRows)
				if affectedRows then
					cb(true)
				end
			end)
		end
	end	
end)

ESX.RegisterServerCallback("dark-mafije:otkaz", function(source,cb, identity)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(identity)
	local IsBoss = xPlayer.job.grade_name == "boss"
	if xPlayer then
		if IsBoss then
			if xTarget then
				xTarget.setJob('unemployed', 0)
				xPlayer.triggerEvent('dark:client:notify', "Dao si otkaz clanu " .. xTarget.name, 1)
				xTarget.triggerEvent('dark:client:notify', "Dobio si otkaz od strane " ..  xPlayer.name, 1)
			end
			MySQL.update('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {'unemployed', 0, identity}, function(affectedRows)
				if affectedRows then
					cb(true)
				end
			end)
		end
	end	
end)


ESX.RegisterServerCallback("dark-mafije:getajpoene", function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.scalar('SELECT poeni FROM `dark-org` WHERE org = ?', {xPlayer.job.name}, function(test)
			cb(test)
		end)
	end	
end)

ESX.RegisterServerCallback("dark-mafije:getajlevel", function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.scalar('SELECT level FROM `dark-org` WHERE org = ?', {xPlayer.job.name}, function(level)
			cb(level)
		end)
	end	
end)

ESX.RegisterServerCallback("dark-mafije:kupivozilo", function(source,cb, vehicleprops, cena)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.scalar('SELECT poeni FROM `dark-org` WHERE org = ?', {xPlayer.job.name}, function(test)
			if tonumber(test) >= cena then
				MySQL.insert('INSERT INTO `dark-org-vozila` (org, vehprops, tablice) VALUES (?, ?, ?)', {xPlayer.job.name, json.encode(vehicleprops), vehicleprops.plate}, function(affectedRows)
					if affectedRows then
						local novip = tonumber(test) - cena
						MySQL.update('UPDATE `dark-org` SET poeni = ? WHERE org = ?', {novip, xPlayer.job.name}, function(affectedRows)
							if affectedRows then
								cb(true)
							end
						end)
					end
				end)
			else
				xPlayer.triggerEvent('dark:client:notify', "Nemas dovoljno poena u orgi", 2)
			end
		end)
	end	
end)

ESX.RegisterServerCallback("dark-mafije:setlevel", function(source,cb, level, cena)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.update('UPDATE `dark-org` SET level = ? WHERE org = ?', {level, xPlayer.job.name}, function(affectedRows)
			if affectedRows then
				MySQL.update('UPDATE `dark-org` SET poeni = ? WHERE org = ?', {cena, xPlayer.job.name}, function(affectedRows)
					if affectedRows then
						cb(true)
						print(affectedRows)
					end
				end)
			end
		end)
	end	
end)

ESX.RegisterServerCallback("dark-mafije:getajvozila", function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.query(
			'SELECT * FROM `dark-org-vozila` WHERE org = ?',
		{
			xPlayer.job.name
		},
		function(result2)
			local vehicles = {}
			for i=1, #result2, 1 do
				local vehicleData = json.decode(result2[i].vehprops)
				table.insert(vehicles, vehicleData)
			end
			cb(vehicles)
		end)
	end
end)

ESX.RegisterServerCallback("dark-mafije:getajvozilo", function(source,cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		MySQL.scalar('SELECT vehprops FROM `dark-org-vozila` WHERE tablice = ?', {plate}, function(test)
			cb(test)
		end)
	end
end)


ESX.RegisterServerCallback("dark-mafije:sacuvaj", function(source,cb, vehprops)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local vehpropovi =  vehprops.plate
		MySQL.update('UPDATE `dark-org-vozila` SET vehprops = ? WHERE tablice = ?', {json.encode(vehprops), json.encode(vehpropovi)}, function(affectedRows)
			if affectedRows then
			end
		end)
	end
end)