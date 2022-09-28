ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Termalna kamera
RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

ESX.RegisterServerCallback('dark:getajigrace', function(source, cb)
	cb(GetNumPlayerIndices())
end)

RegisterCommand("kick", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "developer" or xPlayer.getGroup() == "vodja" or xPlayer.getGroup() == "vodjaadmina" then

	if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
		local igrac = tonumber(args[1])
		local target = ESX.GetPlayerFromId(igrac)
		local razlog = args
	  table.remove(razlog, 1)
		if (#razlog == 0) then
		  razlog = "Razlog nije naveden!"
		else
		  razlog = table.concat(razlog, ' ')
		end
		xPlayer.triggerEvent('dark:client:notify', "Izbacili ste " .. GetPlayerName(target.source) .. " zbog: (" .. razlog .. ")", 3)
		saljikick("Kick Komanda", GetPlayerName(xPlayer.source) .. " je kickovao igraca " .. GetPlayerName(target.source) .. ". Razlog : **" .. razlog .. "**")
		DropPlayer(igrac, razlog)
	  else
		xPlayer.triggerEvent('dark:client:notify', 'Koristite /kick ID RAZLOG', 2)
	  end
	else
	 xPlayer.triggerEvent('dark:client:notify', 'Nemate dozvolu za ovu komandu/niste na admin duznosti', 2)
	end
  end)

local vrijeme = 0
local provjera = {}
local cekanje = 60

RegisterCommand(Dark.Komande[5].imecmd, function(source, args, rawCommand)
    if (not provjera[source] or provjera[source] <= os.time() - cekanje) then
        provjera[source] = os.time()
        TriggerClientEvent('chat:addMessage', source, {
          args = {"^2Vas report je poslan svim online adminima."}
        })
           vrijeme = 60*1000
        local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if Dark.Komande[5].permisije[xPlayer.getGroup()] and xPlayer.proveriDuznost() then
					local time = os.date('%H:%M')
					TriggerClientEvent('chat:addMessage', xPlayer.source, {
						template = '<div class="chat-message server-msg"><i class="fas fa-question" style="vertical-align: middle; color: #e69138"></i> <span style="vertical-align: middle;"><b><span style="color: #e69138;">[POMOC]</span> {2} | {3} &nbsp;<span class="time">{1}</span></b></span><div class="message">{0}</div></div>',
						args = { table.concat(args, ' '), time, GetPlayerName(source), source }
					})
				end
            end
            while vrijeme ~= 0 do
            vrijeme = vrijeme - 1000
            Wait(1000)
            end
    else
        local format = vrijeme / 1000
        TriggerClientEvent('chat:addMessage', source, {
            args = {"^7Pricekaj ^1^*60 ^7^rsekundi prije slanja sledeceg reporta."}
          })
    end 
end, false)

RegisterCommand(Dark.Komande[6].imecmd, function (source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer then
        if Dark.Komande[6].permisije[xPlayer.getGroup()] then
            if xPlayer.proveriDuznost() then
                if xTarget.getGroup() ~= 'helper' then
                    if xTarget.getGroup() == 'user' then
                        xTarget.setGroup('helper')
                        xPlayer.triggerEvent('dark:client:notify', 'Dao si helpera igracu ' .. GetPlayerName(target), 3)
                        xTarget.triggerEvent('dark:client:notify', 'Dobio si helpera od ' .. GetPlayerName(source), 3)
                        saljihelpercmd('**DAVANJE HELPERA**', GetPlayerName(source) .. ' je dao helpera ' .. GetPlayerName(target))
                    else
                        xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da mu das helpera jer ima vec neku poziciju', 2)
                    end
                else
                    xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da mu das helpera jer ga vec ima', 2)
                end
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nisi na duznosti', 2)
            end
        else
            xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvolu za ovu komandu', 2)
        end
    end
end)

RegisterCommand(Dark.Komande[7].imecmd, function (source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer then
        if Dark.Komande[7].permisije[xPlayer.getGroup()] then
            if xPlayer.proveriDuznost() then
                if xTarget.getGroup() ~= 'user' then
                    if xTarget.getGroup() == 'helper' then
                        xTarget.setGroup('user')
                        xPlayer.triggerEvent('dark:client:notify', 'Skinuo si helpera igracu ' .. GetPlayerName(target), 3)
                        xTarget.triggerEvent('dark:client:notify', 'Skinut si sa helpera od strane ' .. GetPlayerName(source), 3)
                        saljihelpercmd('**DAVANJE HELPERA**', GetPlayerName(source) .. ' je skinuo helpera ' .. GetPlayerName(target))
                    else
                        xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da mu skines helpera jer ima vec neku poziciju', 2)
                    end
                else
                    xPlayer.triggerEvent('dark:client:notify', 'Ne mozes da skines helpera coveku koji nema helpera', 2)
                end
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nisi na duznosti', 2)
            end
        else
            xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvolu za ovu komandu', 2)
        end
    end
end)

RegisterCommand("aodg", function(source, args)
    local poruka = table.concat(args, " ", 2)
    local igrac = tonumber(args[1])
    local xPlayer = ESX.GetPlayerFromId(source)
  
    if Dark.Komande[5].permisije[xPlayer.getGroup()] and xPlayer.proveriDuznost() then
        TriggerClientEvent('chat:addMessage', igrac, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(111,168,220, 0.8); border-radius: 10px;"><i class="far fa-envelope"></i> Odgovor admina<br> {0}</div>',
          args = { poruka }
         })
         TriggerClientEvent("chatMessage", source, "^7[^6HUB RolePlay^7]: ", {244,67,54}, "Poruka je uspesno poslata!")
    else 
        TriggerClientEvent("chatMessage", source, "^7[^6HUB RolePlay^7]: ", {244,67,54}, "Nemate permisije!")
    end
  
end)

function saljikick(name, message)
	local vrijeme = os.date('*t')
	local poruka = {
		{
			["color"] = 16711680,
			["title"] = "**".. name .."**",
			["description"] = message,
			["footer"] = {
			["text"] = "HUB \nVreme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			},
		}
		}
	PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Direktor 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end

function saljihelpercmd(name, message)
	local vrijeme = os.date('*t')
	local poruka = {
		{
			["color"] = 16711680,
			["title"] = "**".. name .."**",
			["description"] = message,
			["footer"] = {
			["text"] = "HUB Kick\nVreme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
			},
		}
		}
	PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Direktor 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end



-- VREME -- 

-- Set this to false if you don't want the weather to change automatically every 10 minutes.
DynamicWeather = true

--------------------------------------------------
debugprint = false -- don't touch this unless you know what you're doing or you're being asked by Vespura to turn this on.
--------------------------------------------------







-------------------- DON'T CHANGE THIS --------------------
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

Dark.Grupe = {
    ["vlasnik"] = true,
    ["developer"] = true,
    ["headadmin"] = true,
    ["vodjahelpera"] = false,
    ["helper"] = false,
    ["admin"] = false,
    ["user"] = false,
}

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if Dark.Grupe[xPlayer.getGroup()] then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('dark:client:notify', source, "Sat je sad zamrznuto", 1)
            else
                TriggerClientEvent('dark:client:notify', source, "Sat nije vise zamrznuto", 1)
            end
        else
            TriggerClientEvent('dark:client:notify', source, "Nemas dozvolu za ovu komandu", 2)
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Sat je zamrznuto sad")
        else
            print("Sat nije vise zamrznuto")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if Dark.Grupe[xPlayer.getGroup()] then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('dark:client:notify', source, "Dinamicna promena vremena je ugasena", 3)
            else
                TriggerClientEvent('dark:client:notify', source, "Dinamicna promena vremena je upaljeno", 3)
            end
        else
            TriggerClientEvent('dark:client:notify', source, "Nemas dozvolu za ovu komandu", 2)
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("Dinamicna promena vremena je zamrznuta")
        else
            print("Dinamicna promena vremena je odmrznuta")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Netacna sintaksa, pravilno je: /weather <weathertype> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("Vreme je promenjeno")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('vSync:requestSync')
            else
                print("Ovaj tip vremena ne postoji, prihvatljivi tipovi vremena su: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
            end
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if Dark.Grupe[xPlayer.getGroup()] then
            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Greska: ^1Netacna sintaksa, koristi ^0/weather <weatherType>')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('dark:client:notify', source, 'Vreme ce se promeniti u: ' .. string.lower(args[1]) .. ".", 3)
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('vSync:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^Ovaj tip vremena ne postoji, prihvatljivi tipovi vremena su: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
                end
            end
        else
            TriggerClientEvent('dark:client:notify', source, "Nemas dozvolu za ovu komandu", 2)
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Struja je sad ugasena")
        else
            print("Struja je sad upaljena")
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if Dark.Grupe[xPlayer.getGroup()] then
            blackout = not blackout
            if blackout then
                TriggerClientEvent('dark:client:notify', source, "Struja je sad ugasena", 1)
            else
                TriggerClientEvent('dark:client:notify', source, "Struja je sad upaljena", 1)
            end
            TriggerEvent('vSync:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if Dark.Grupe[xPlayer.getGroup()] then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('dark:client:notify', source, "Nemas dozvolu za ovu komandu", 2)
        TriggerEvent('vSync:requestSync')
    end
end)


function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("Vreme se promenilu u " .. argh .. ":" .. argm .. ".")
            TriggerEvent('vSync:requestSync')
        else
            print("Netacna sintaksa, treba biti: /time <hour> <minute> !")
        end
    elseif source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if Dark.Grupe[xPlayer.getGroup()] then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('dark:client:notify', source, 'Vreme se promenilu u: ' .. newtime .. "!", 1)
                TriggerEvent('vSync:requestSync')
            else
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, 'Netacna sintaksa, treba biti ^0/time <hour> <minute> ^1instead!')
            end
        else
            TriggerClientEvent('dark:client:notify', source, 'Nemas dozvolu za ovu komandu', 2)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
    if debugprint then
        print("[vSync] Novo nasumicno vreme je generisano i stavljeno: " .. CurrentWeather .. ".\n")
        print("[vSync] Promena timera na 10 minuta.\n")
    end
end

-- MONEY UP --

RegisterCommand('copedagapusi', function(source, args)
	local xPlayers = ESX.GetPlayers()
  local igrac = ESX.GetPlayerFromId(source)
	local amount  = tonumber(args[1])

    if igrac.getGroup() == "vlasnik" or igrac.getGroup() == "skripter" then
      for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if amount ~= nil then
          xPlayer.addAccountMoney('bank', amount)
          xPlayer.triggerEvent('dark:client:notify', "Dobili ste " ..amount .. " od Money UP-a.", 1)
          dajsvimakomanda("Daj Svima Komanda", GetPlayerName(source) .. " je dao svima " .. amount .. "$")
        end
      end	
    end
end)

function dajsvimakomanda(name, message)
  local vrijeme = os.date('*t')  
  local poruka = {
        {
            ["color"] = 16711680,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "Dark Development\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
            },
        }
      }
    PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Development 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback("dark-doktor:getajdonatorgrupu", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
      MySQL.Async.fetchScalar('SELECT donator FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
      }, function(donator)  
        cb(donator)
      end)
    end
  end)
  
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
  
    vlasnici = {
      'steam:11000013ef82194', -- Musica
      'steam:11000013de6b0e4', -- DarkBoy
    'steam:11000010ce2f43f', -- Cope
    }
  
  RegisterCommand("dajdonatora", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
      if DaLiMoze(source) then
        local drugijebeniigrac = args[1]
        if drugijebeniigrac then
          local xTarget = ESX.GetPlayerFromId(drugijebeniigrac)
          if xTarget then
            local grupa = args[2]
            if grupa == "copper" or grupa == "bronze" or grupa == "silver" or grupa == "gold" or grupa == "diamond" or grupa == "supreme" or grupa == "hub" then
              if grupa == "copper" then
                grupa = "Copper"
              elseif grupa == "bronze" then
                grupa = "Bronze"
              elseif grupa == "silver" then
                grupa = "Silver"
              elseif grupa == "gold" then
                grupa = "Gold"
              elseif grupa == "diamond" then
                grupa = "Diamond"
              elseif grupa == "supreme" then
                grupa = "Supreme"
              elseif grupa == "hub" then
                grupa = "Hub"
              end
              MySQL.Async.transaction({
                'UPDATE users SET donator = @grupa WHERE identifier = @identitet',
              },
              { ['@grupa'] = grupa, ['@identitet'] = xTarget.identifier },
              function(success)
                TriggerClientEvent("chatMessage", xPlayer.source, "^3Igracu " .. GetPlayerName(drugijebeniigrac) .. ' si dao donator grupu ' .. grupa)
              end
            )
            else
              TriggerClientEvent("chatMessage", xPlayer.source, "^2Moras uneti neke od ovih vrednosti copper, bronze, silver, gold, diamond, supreme, hub")
            end
          end
        end
      end
    end
  end)


vlasnici = {
    'steam:1100001110e84dc', -- Musica
	'steam:11000013de6b0e4', -- DarkBoy
	'steam:11000010ce2f43f', -- Cope
	'steam:11000013ef82194', -- pedja
    'steam:11000014bcdcf13', -- Muxi
    'steam:11000014b13ea7c', -- Toske
}

vlasnici2 = {
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

function DaLiMoze2(player)
	local allowed = false
	for i,id in ipairs(vlasnici2) do
		for x,pid in ipairs(GetPlayerIdentifiers(player)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end
	return allowed
end

RegisterCommand('+itemstash', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if DaLiMoze2(source) then
            exports.ox_inventory:AddItem(args[1], args[2], args[3], nil, nil)
        end
    end
end)

RegisterCommand('dvall', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if DaLiMoze(source) then
            TriggerClientEvent('dark:client:notify', -1, 'SVA VOZILA KOJA SE NE KORISTE CE BITI OBRISANA ZA 30 SEKUNDI!! UDJITE U VASA VOZILA')
	        Wait(15000)
	        TriggerClientEvent('dark:client:notify', -1, 'SVA VOZILA KOJA SE NE KORISTE CE BITI OBRISANA ZA 15 SEKUNDI!! UDJITE U VASA VOZILA')
	        Wait(5000) 
            TriggerClientEvent('dark:client:notify', -1, 'SVA VOZILA KOJA SE NE KORISTE CE BITI OBRISANA ZA 10 SEKUNDI!! UDJITE U VASA VOZILA')
            Wait(5000) 
            TriggerClientEvent('dark:client:notify', -1, 'SVA VOZILA KOJA SE NE KORISTE CE BITI OBRISANA ZA 5 SEKUNDI!! UDJITE U VASA VOZILA')
	        Wait(5000)
	        TriggerClientEvent("wld:delallveh", -1, GetAllVehicles()) 
            TriggerClientEvent('dark:client:notify', -1, 'SVA VOZILA KOJA SE NE KORISTE SU OBRISANA')
        end
    end
end)
	
RegisterCommand('entityview', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if DaLiMoze(source) then
            xPlayer.triggerEvent('dark:god')
        end
    end
end)

ESX.RegisterServerCallback('default-peder:obrisientity', function(source, cb, entity)
    TriggerClientEvent('obrisientity', -1, entity)
end)