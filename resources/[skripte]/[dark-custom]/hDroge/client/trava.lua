local spawnedWeedLeaf = 0
local WeedPlants = {}
local susenje = {}
local bere = false
local susi = false

Citizen.CreateThread(function()
	skupljanjetrave = AddBlipForCoord(Dark.Trave.lokacija)
	SetBlipSprite(skupljanjetrave, 140)
	SetBlipDisplay(skupljanjetrave, 4)
	SetBlipScale(skupljanjetrave, 0.65)	
	SetBlipColour(skupljanjetrave, 2)
	SetBlipAsShortRange(skupljanjetrave, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Sakupljanje trave')
	EndTextCommandSetBlipName(skupljanjetrave)
	for i=1, #Dark.Trave.susenje do
		preradatrave = AddBlipForCoord(Dark.Trave.susenje[i].coords)
		SetBlipSprite(preradatrave, 140)
		SetBlipDisplay(preradatrave, 4)
		SetBlipScale(preradatrave, 0.65)
		SetBlipColour(preradatrave, 2)
		SetBlipAsShortRange(preradatrave, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Susenjne trave')
		EndTextCommandSetBlipName(preradatrave)
	end
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(ESX.PlayerData.ped)
		if GetDistanceBetweenCoords(coords, Dark.Trave.lokacija, true) < 50 then
			SpawnWeedPlants()
			Citizen.Wait(500)
		else
			sleep = true
		end

        for i=1, #Dark.Trave.susenje do
            local distanca = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Trave.susenje[i].coords)
            if distanca < 25.0 then
                if(not DoesEntityExist(susenje[i])) then
                    sleep = false
                    susenje[i] = exports['hCore']:NapraviPed(GetHashKey('a_f_m_eastsa_01'), Dark.Trave.susenje[i].coords, Dark.Trave.susenje[i].heading)
                end
                if distanca < 5 and DoesEntityExist(susenje[i]) then
                    sleep = false
                    exports['hCore']:Draw3DText(Dark.Trave.susenje[i].coords.x, Dark.Trave.susenje[i].coords.y, Dark.Trave.susenje[i].coords.z + 2, "~s~Da bi osusio biljku drzi ~o~ALT~s~ na mene")
                end
            else
                if(DoesEntityExist(susenje[i])) then
                    sleep = true
                    DeletePed(susenje[i])
                end
            end
        end
        if sleep then Citizen.Wait(1500) end
	end
end)

exports.qtarget:AddTargetModel('prop_weed_02', {
	options = {
		{
			icon = "fas fa-leaf",
			label = "Uberi biljku travu",
			canInteract = function (entity)
				local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #WeedPlants, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(WeedPlants[i]), false) < 1.5 then
						if WeedPlants[i] == entity then
							return true
						else
							return false
						end
					end
				end
			end,
			action = function (entity)
				local coords = GetEntityCoords(ESX.PlayerData.ped)
				local nearbyObject, nearbyID
				for i=1, #WeedPlants, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(WeedPlants[i]), false) < 1.5 then
						nearbyObject, nearbyID = WeedPlants[i], i
					end
				end
				if not bere then
					bere = true
					ESX.TriggerServerCallback('esx_illegal:canPickUp', function(canPickUp)

						if canPickUp then
							TaskStartScenarioInPlace(ESX.PlayerData.ped, 'world_human_gardener_plant', 0, false)

							Citizen.Wait(2000)
							ClearPedTasks(ESX.PlayerData.ped)
							Citizen.Wait(1500)
						
							ESX.Game.DeleteObject(nearbyObject)
						
							table.remove(WeedPlants, nearbyID)
							spawnedWeedLeaf = spawnedWeedLeaf - 1
						
							ESX.TriggerServerCallback('esx_illegal:pickedUpWeedLeaf', function () end)
							bere = false
						else
							exports['hNotifikacije']:Notifikacije('Ne mozes da nosis vise', 2)
							bere = false
						end

					end, 'list_trave')
				end
			end
		},
	},
	distance = 1.5
})

exports.qtarget:AddTargetModel('a_f_m_eastsa_01', {
	options = {
		{
			icon = "fas fa-leaf",
			label = "Osusi biljku",
			action = function (entity)
				if not susi then
					susi = true
                	ESX.TriggerServerCallback('esx_illegal:have', function(have)
                	    if have > 0 then
                	        ESX.TriggerServerCallback('esx_illegal:canPickUp', function(canPickUp)
                	            if canPickUp then
                	                ESX.TriggerServerCallback('esx_illegal:dryweed', function () end)
									susi = false
								else
									susi = false
                	            end
                	        end, 'list_trave2')
						else
							susi = false
                	    end
                	end, 'list_trave')
				end
			end
		},
	},
	distance = 1.5
})

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(WeedPlants) do
			ESX.Game.DeleteObject(v)
		end
        for i=1, #Dark.Trave.susenje do
            DeletePed(susenje[i])
        end
	end
end)

AddEventHandler('dark-droge:napravijoint', function()
	ESX.TriggerServerCallback('esx_illegal:have', function(have)
		if have >= 5 then
			ESX.TriggerServerCallback('esx_illegal:have', function(have)
				if have > 0 then
					ESX.TriggerServerCallback('esx_illegal:makejoint', function() end)
				else
					exports['hNotifikacije']:Notifikacije('Treba ti 1 rizla', 2)
				end
			end, 'rizle')
		else
			exports['hNotifikacije']:Notifikacije('Treba ti 5g trave', 2)
		end
	end, 'list_trave2')
end)

function SpawnWeedPlants()
	while spawnedWeedLeaf < 10 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedLeafCoords()

		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(WeedPlants, obj)
			spawnedWeedLeaf = spawnedWeedLeaf + 1
		end)
	end
end

function ValidateWeedLeafCoord(plantCoord)
	if spawnedWeedLeaf > 0 then
		local validate = true

		for k, v in pairs(WeedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Dark.Trave.lokacija, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedLeafCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)

		weedCoordX = Dark.Trave.lokacija.x + modX
		weedCoordY = Dark.Trave.lokacija.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end