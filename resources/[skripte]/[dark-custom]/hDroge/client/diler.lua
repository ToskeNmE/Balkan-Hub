local diler = {}

Citizen.CreateThread(function ()
    --[[for i=1, #Dark.Diler, 1 do
		dilerdroge = AddBlipForCoord(Dark.Diler[i].coords)
		SetBlipSprite(dilerdroge, 197)
		SetBlipDisplay(dilerdroge, 4)
		SetBlipScale(dilerdroge, 0.65)	
		SetBlipColour(dilerdroge, 0)
		SetBlipAsShortRange(dilerdroge, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Diler')
		EndTextCommandSetBlipName(dilerdroge)
	end--]]
    while true do
        Citizen.Wait(0)
        for i=1, #Dark.Diler, 1 do
            local distance = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Diler[i].coords)    
            if distance < 50.0 then
				if not DoesEntityExist(diler[i]) then
                    diler[i] = exports['hCore']:NapraviPed(GetHashKey('a_f_m_salton_01'), Dark.Diler[i].coords, Dark.Diler[i].heading)
                else
                    Citizen.Wait(1500)
				end
			else
				if DoesEntityExist(diler[i]) then
					DeleteEntity(diler[i])
				end
				Citizen.Wait(1500)
			end
        end
    end
end)

exports.qtarget:AddTargetModel('a_f_m_salton_01', {
	options = {
		{
			icon = "fas fa-cannabis",
			label = "Prodaj drogu",
			num = 1,
            canInteract = function (entity)
                local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #diler, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(diler[i]), false) < 1.5 then
						if diler[i] == entity then
							return true
						else
							return false
						end
					end
				end
            end,
            action = function (entity)
                lib.registerContext({
                    id = 'prodaj_droge_menu',
                    title = 'Prodaj droge',
                    options = {
                        ['Trava'] = {
                          metadata = {
                              ['Cena'] = 250
                          },
                          event = 'dark-droge:prodajtravu',
                          args = {cena = 250, item = 'list_trave2'}
                        },
                        ['Kokain'] = {
                          metadata = {
                              ['Cena'] = 50
                          },
                          event = 'dark-droge:prodajtravu',
                          args = {cena = 50, item = 'kesica_koke'}
                        }
                    }
                })
                lib.showContext('prodaj_droge_menu')
            end
		},
	},
	distance = 2
})

AddEventHandler('dark-droge:prodajtravu', function(data)
    print(data.cena)
    ESX.TriggerServerCallback('dark-droge:prodaj', function() end, data.cena, data.item)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for i=1, #Dark.Diler, 1 do
        if DoesEntityExist(diler[i]) then
            DeleteEntity(diler[i])
        end
    end
end)
