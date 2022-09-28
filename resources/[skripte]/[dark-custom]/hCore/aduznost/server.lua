ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local duty = ''

RegisterCommand(Dark.Komande[3].imecmd, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if Dark.Komande[3].permisije[xPlayer.getGroup()] then
            if xPlayer.proveriDuznost() == false then
                xPlayer.staviDuznost(true)
                TriggerClientEvent("dark:client:notify", -1, GetPlayerName(source) .. " je na duznosti", 1)
                TriggerClientEvent('dark-id:toggle', source, true)
                TriggerClientEvent('relisoft_grandsonvolizeneupaligatag', source)
                saljilog(duty, "**ADUZNOST**", GetPlayerName(source) .. ' je usao na admin duznost')
            else
                xPlayer.staviDuznost(false)
                TriggerClientEvent("dark:client:notify", -1, GetPlayerName(source) .. " je izasao sa duznosti", 1)
                TriggerClientEvent('dark-id:toggle', source, false)
                TriggerClientEvent('relisoft_grandsonvolizeneugasitag', source)
                saljilog(duty, "**ADUZNOST**", GetPlayerName(source) .. ' je izasao sa admin duznosti')
            end
        else
            TriggerClientEvent("dark:client:notify", source, "Nemas dozvolu za ovu komandu", 2)
        end
    end
end)

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