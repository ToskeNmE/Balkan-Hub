function Show(key, message)
	SendNUIMessage({
		action = 'show',
		message = message,
		key = key
	})
end

function Hide()
	SendNUIMessage({
		action = 'hide'
	})
end