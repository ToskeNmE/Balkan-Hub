RegisterNetEvent('dark-kazne:otvoridialog')
AddEventHandler('dark-kazne:otvoridialog', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2 then		
        local dialog = exports['hDialog']:DialogInput({
            header = "Kazne", 
            rows = {
                {
                    id = 0, 
                    txt = "Razlog"
                },
                {
                    id = 1, 
                    txt = "Cena ($)"
                },
            }
        })

        if dialog ~= nil then
            if dialog[1].input == nil or dialog[2].input == nil then
                ESX.ShowNotification('Nisi upisao nista u poljima za kaznu')
            else
                ESX.TriggerServerCallback("dark-kazne:napravikaznu", function() end, dialog[1].input, dialog[2].input, GetPlayerServerId(closestPlayer))
            end
        end
    else
        ESX.ShowNotification('Nema nikoga u blizini')
    end
end, false)