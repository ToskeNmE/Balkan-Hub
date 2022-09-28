RegisterNetEvent('dark:client:notify')
AddEventHandler('dark:client:notify', function(text, type)
	SendNUIMessage({
		text = text,
		color = type or 1
	})
end)

function Notifikacije(text, type)
	SendNUIMessage({
		text = text,
		color = type or 1
	})
end