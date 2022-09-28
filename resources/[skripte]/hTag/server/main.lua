ESX = nil
AdminPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("grandsonvolizeneupaligatag")
AddEventHandler("grandsonvolizeneupaligatag", function ()
    local admin = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    AdminPlayers[source] = {source = source, group = xPlayer.getGroup(), name = GetPlayerName(source)}
    TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
end)
RegisterNetEvent("grandsonvolizeneupaligatagi")
AddEventHandler("grandsonvolizeneupaligatagi", function ()
    local admin = ESX.GetPlayerFromId(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    AdminPlayers[source] = {source = source, group = vip, name = GetPlayerName(source)}
    TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
end)



RegisterNetEvent("grandsonvolizeneugasitag")
AddEventHandler("grandsonvolizeneugasitag", function ()
    AdminPlayers[source] = nil
    TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
end)

RegisterCommand('tag', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "developer" then
        if AdminPlayers[source] == nil then
                AdminPlayers[source] = {source = source, group = xPlayer.getGroup(), name = GetPlayerName(source)}
        
                
            TriggerClientEvent("hub_notifikacije:tacna", source, "Upalio si tag", 6000)
        else
            AdminPlayers[source] = nil
            TriggerClientEvent("hub_notifikacije:netacno", source, "Ugasio si tag", 6000)
        end
        TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
    end
end)

ESX.RegisterServerCallback('relisoft_tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)


RegisterCommand('vtag', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "vlasnik" or xPlayer.getGroup() == "skripter" or xPlayer.getGroup() == "vip" then
        if AdminPlayers[source] == nil then
                AdminPlayers[source] = {source = source, group = xPlayer.getGroup(), name = GetPlayerName(source)}
        
            TriggerClientEvent('chat:addMessage',source, { args = { 'VIP', 'Upalio si tag' }, color = { 255, 50, 50 } })
        else
            AdminPlayers[source] = nil
            TriggerClientEvent('chat:addMessage',source, { args = { 'VIP', 'Ugasio si tag' }, color = { 255, 50, 50 } })
        end
        TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
    end
end)

ESX.RegisterServerCallback('relisoft_tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)