local PranjePara = {}

Citizen.CreateThread(function ()
    --[[for i=1, #Dark.PranjePara, 1 do
		PranjeParadroge = AddBlipForCoord(Dark.PranjePara[i].coords)
		SetBlipSprite(PranjeParadroge, 197)
		SetBlipDisplay(PranjeParadroge, 4)
		SetBlipScale(PranjeParadroge, 0.65)	
		SetBlipColour(PranjeParadroge, 0)
		SetBlipAsShortRange(PranjeParadroge, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Pranje para')
		EndTextCommandSetBlipName(PranjeParadroge)
	end--]]
    while true do
        Citizen.Wait(0)
        for i=1, #Dark.PranjePara, 1 do
            local distance = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.PranjePara[i].coords)    
            if distance < 50.0 then
				if not DoesEntityExist(PranjePara[i]) then
                    PranjePara[i] = exports['hCore']:NapraviPed(GetHashKey('a_m_m_soucent_01'), Dark.PranjePara[i].coords, Dark.PranjePara[i].heading)
                else
                    Citizen.Wait(1500)
				end
			else
				if DoesEntityExist(PranjePara[i]) then
					DeleteEntity(PranjePara[i])
				end
				Citizen.Wait(1500)
			end
        end
    end
end)

exports.qtarget:AddTargetModel('a_m_m_soucent_01', {
	options = {
		{
			icon = "fas fa-sack-dollar",
			label = "Operi pare",
			num = 1,
            canInteract = function (entity)
                local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #PranjePara, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(PranjePara[i]), false) < 1.5 then
						if PranjePara[i] == entity then
							return true
						else
							return false
						end
					end
				end
            end,
            action = function (entity)
                local input = lib.inputDialog('Pranje Para', {'Iznos'})

                if input then
                    local iznos = tonumber(input[1])
                
                    ESX.TriggerServerCallback('dark-pranjepara:operipare', function () end, iznos)
                end
            end
		},
	},
	distance = 2
})

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for i=1, #Dark.PranjePara, 1 do
        if DoesEntityExist(PranjePara[i]) then
            DeleteEntity(PranjePara[i])
        end
    end
end)
