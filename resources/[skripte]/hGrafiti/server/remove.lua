if not Config.DisableESX then
    ESX.RegisterUsableItem("spray_remover", function(playerId)
        TriggerClientEvent('rcore_spray:removeClosestSpray', playerId)
    end)
end

RegisterNetEvent('rcore_spray:remove')
AddEventHandler('rcore_spray:remove', function(pos)
    local Source = source
    if not Config.DisableESX then
        local xPlayer = ESX.GetPlayerFromId(Source)
        local item = xPlayer.getInventoryItem("spray_remover")

        if item.count > 0 then
            xPlayer.removeInventoryItem("spray_remover", 1)
            RemoveSprayAtPosition(Source, pos)
        end
    else
        RemoveSprayAtPosition(Source, pos)
    end
end)