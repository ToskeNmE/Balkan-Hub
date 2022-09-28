ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

local kordeigraca = nil
local target = nil

RegisterCommand("gotov", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args[1])
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
	    	['@identifier'] = xPlayer.identifier
	    }, function(vip)
	    	if vip == 1 then
                if args[1] ~= nil then
                    if xTarget then
                        if xPlayer.source ~= xTarget.source then
                            target = ESX.GetPlayerFromId(source)
                            TriggerClientEvent("dark:goto:vip:posaljireq", args[1], GetPlayerName(source))
                            target.triggerEvent('dark:client:notify', 'Poslao si zahtev ' .. GetPlayerName(args[1]), 3)
                            viplogovi("VIP GOTO", GetPlayerName(source) .. " je poslao zathev za vip goto " .. GetPlayerName(args[1]))
                            kordeigraca = xTarget.getCoords()
                        else
                            xPlayer.triggerEvent('dark:client:notify', 'Ne mozes sebi da saljes', 2)
                        end
                    else
                        xPlayer.triggerEvent('dark:client:notify', 'Igrac nije na serveru', 2)
                    end
                else
                    xPlayer.triggerEvent('dark:client:notify', 'Moras upisati id igraca', 2)
                end
            else
                xPlayer.triggerEvent('dark:client:notify', 'Nemas dozvolu za ovo', 2)
	    	end
	    end)
    end
end)

ESX.RegisterServerCallback('dark:goto:vip:tpajvipa', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        target.setCoords(kordeigraca)
        viplogovi("VIP GOTO", GetPlayerName(source) .. " je prihvatio vip goto od " .. GetPlayerName(target.source))
        kordeigraca = nil
        target = nil
    end
end)

ESX.RegisterServerCallback('dark:goto:vip:odbiotp', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        target.triggerEvent('dark:client:notify', 'Vas zahtev za goto je odbijen', 2)
        target = nil
    end
end)

ESX.RegisterServerCallback('dark:goto:vip:odbiotp', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        target.triggerEvent('dark:client:notify', 'Zahtev za tp je istekao', 2)
        target = nil
    end
end)

function viplogovi(name, message)
    local vrijeme = os.date('*t')  
    local poruka = {
          {
              ["color"] = 16711680,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
              ["text"] = "Dark Direktor\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
              },
          }
        }
      PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({username = "Dark Direktor 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end