local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		spavaj = true
		if open then
			spavaj = false
			if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
				SendNUIMessage({
					action = "close"
				})
				open = false
			end
		end
		if spavaj then Citizen.Wait(550) end
	end
end)
