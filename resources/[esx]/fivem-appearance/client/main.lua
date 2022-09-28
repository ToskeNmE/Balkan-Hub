--if GetResourceState('es_extended'):find('start') then

	AddEventHandler('skinchanger:loadDefaultModel', function(male, cb)
		client.setPlayerModel(male and `mp_m_freemode_01` or `mp_f_freemode_01`)
		if cb then cb() end
	end)

	AddEventHandler('skinchanger:loadSkin', function(skin, cb)
		if not skin.model then skin.model = 'mp_m_freemode_01' end
		client.setPlayerAppearance(skin)
		if cb then cb() end
	end)

	AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
		client.startPlayerCustomization(function (appearance)
			if (appearance) then
				TriggerServerEvent('esx_skin:save', appearance)
				if submitCb then submitCb() end
			else
				if cancelCb then cancelCb() end
			end
		end, {
			ped = true,
			headBlend = true,
			faceFeatures = true,
			headOverlays = true,
			components = true,
			props = true
		})
	end)
--end

RegisterCommand("fixajskin", function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

local shops = {
	clothing = {
		vector3(72.3, -1399.1, 28.4),
		vector3(-708.71, -152.13, 36.4),
		vector3(-165.15, -302.49, 38.6),
		vector3(428.7, -800.1, 28.5),
		vector3(-829.4, -1073.7, 10.3),
		vector3(-1449.16, -238.35, 48.8),
		vector3(11.6, 6514.2, 30.9),
		vector3(122.98, -222.27, 53.5),
		vector3(1696.3, 4829.3, 41.1),
		vector3(618.1, 2759.6, 41.1),
		vector3(1190.6, 2713.4, 37.2),
		vector3(-1193.4, -772.3, 16.3),
		vector3(-3172.5, 1048.1, 19.9),
		vector3(-1108.4, 2708.9, 18.1),
	},

	barber = {
		vector3(-814.3, -183.8, 36.6),
		vector3(136.8, -1708.4, 28.3),
		vector3(-1282.6, -1116.8, 6.0),
		vector3(1931.5, 3729.7, 31.8),
		vector3(1212.8, -472.9, 65.2),
		vector3(-34.31, -154.99, 55.8),
		vector3(-278.1, 6228.5, 30.7),
	}
}

local function createBlip(name, sprite, colour, scale, location)
	if not location.w then
		local blip = AddBlipForCoord(location.x, location.y)
		SetBlipSprite(blip, sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, scale)
		SetBlipColour(blip, colour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(name)
		EndTextCommandSetBlipName(blip)
	end
end

for i = 1, #shops.clothing do
	createBlip('Butik', 73, 0, 0.65, shops.clothing[i])
end

for i = 1, #shops.barber do
	createBlip('Berbernica', 71, 44, 0.65, shops.barber[i])
end

local shopType
local config = {
	clothing = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = true,
		tattoos = false
	},

	barber = {
		ped = false,
		headBlend = true,
		faceFeatures = false,
		headOverlays = true,
		components = false,
		props = false,
		tattoos = false
	},
}


local peds = {}
local peds2 = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        sleep = true
				for i=1, #shops.clothing, 1 do
            local distanca = #(GetEntityCoords(PlayerPedId()) - shops.clothing[i])
            if distanca < 25.0 then
                if(not DoesEntityExist(peds[i])) then
                    sleep = false
                    peds[i] = exports['hCore']:NapraviPed(GetHashKey('s_m_y_clubbar_01'), shops.clothing[i], 0.0)
                end
                if distanca < 5 and DoesEntityExist(peds[i]) then
                    sleep = false
                    exports['hCore']:Draw3DText(shops.clothing[i].x, shops.clothing[i].y, shops.clothing[i].z + 2, "~s~Da bi pristupio butiku drzi ~o~ALT~s~ na mene")
                end
            else
                if(DoesEntityExist(peds[i])) then
                    sleep = true
                    DeletePed(peds[i])
                end
            end
				end

				for i=1, #shops.barber, 1 do
						local distanca = #(GetEntityCoords(PlayerPedId()) - shops.barber[i])
						if distanca < 25.0 then
								if(not DoesEntityExist(peds2[i])) then
										sleep = false
										peds2[i] = exports['hCore']:NapraviPed(GetHashKey('s_m_y_devinsec_01'), shops.barber[i], 0.0)
								end
								if distanca < 5 and DoesEntityExist(peds2[i]) then
										sleep = false
										exports['hCore']:Draw3DText(shops.barber[i].x, shops.barber[i].y, shops.barber[i].z + 2, "~s~Da bi pristupio frizeru drzi ~o~ALT~s~ na mene")
								end
						else
								if(DoesEntityExist(peds2[i])) then
										sleep = true
										DeletePed(peds2[i])
								end
						end
				end
        if sleep then
            Citizen.Wait(2500)
        end
    end
end)

exports.qtarget:AddTargetModel('s_m_y_clubbar_01', {
	options = {
		{
			icon = "fas fa-tshirt",
			label = "Presvuci se",
			action = function(entity)
				local config = {
					ped = false,
					headBlend = false,
					faceFeatures = false,
					headOverlays = false,
					components = true,
					props = true,
					tattoos = false
			  }

			  client.startPlayerCustomization(function (appearance)
			    if (appearance) then
			      TriggerServerEvent('esx_skin:save', appearance)
			    end
			  end, config)
			end,
		},
	},
	distance = 2
})

exports.qtarget:AddTargetModel('s_m_y_devinsec_01', {
	options = {
		{
			icon = "fas fa-cut",
			label = "Osisaj se",
			action = function(entity)
				local config = {
					ped = false,
					headBlend = true,
					faceFeatures = false,
					headOverlays = true,
					components = false,
					props = false,
					tattoos = false
			  }

			  client.startPlayerCustomization(function (appearance)
			    if (appearance) then
			      TriggerServerEvent('esx_skin:save', appearance)
			    end
			  end, config)
			end,
		},
	},
	distance = 2
})

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
			for i=1, #shops.clothing, 1 do
        DeletePed(peds[i])
			end
			for i=1, #shops.barber, 1 do
				DeletePed(peds2[i])
			end
    end
end)
