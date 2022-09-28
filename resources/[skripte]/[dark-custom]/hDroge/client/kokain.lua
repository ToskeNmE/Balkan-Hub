local spawnedCocaLeaf = 0
local CocaPlants = {}
local sto = {}
local bere = false
local preraduje = false


Citizen.CreateThread(function()
	skupljanjekokaina = AddBlipForCoord(Dark.Kokain.lokacija)
	SetBlipSprite(skupljanjekokaina, 501)
	SetBlipDisplay(skupljanjekokaina, 4)
	SetBlipScale(skupljanjekokaina, 0.65)	
	SetBlipColour(skupljanjekokaina, 2)
	SetBlipAsShortRange(skupljanjekokaina, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Sakupljanje kokaina')
	EndTextCommandSetBlipName(skupljanjekokaina)
	for i=1, #Dark.Kokain.sto, 1 do
		preradakokaina = AddBlipForCoord(Dark.Kokain.sto[i])
		SetBlipSprite(preradakokaina, 501)
		SetBlipDisplay(preradakokaina, 4)
		SetBlipScale(preradakokaina, 0.65)	
		SetBlipColour(preradakokaina, 2)
		SetBlipAsShortRange(preradakokaina, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Prerada kokaina')
		EndTextCommandSetBlipName(preradakokaina)
	end
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(ESX.PlayerData.ped)
		if GetDistanceBetweenCoords(coords, Dark.Kokain.lokacija, true) < 50 then
			SpawnCocaPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(1500)
		end
		for i=1, #Dark.Kokain.sto, 1 do
			local distance = #(GetEntityCoords(ESX.PlayerData.ped) - Dark.Kokain.sto[i])
			if distance < 50.0 then
				if not DoesEntityExist(sto[i]) then
					ESX.Game.SpawnLocalObject('v_ret_ml_tablea', Dark.Kokain.sto[i], function(obj)
						sto[i] = obj
						PlaceObjectOnGroundProperly(obj)
						FreezeEntityPosition(obj, true)
					end)
				end
			else
				if DoesEntityExist(sto[i]) then
					ESX.Game.DeleteObject(sto[i])
				end
				Citizen.Wait(1500)
			end
		end
	end
end)

exports.qtarget:AddTargetModel('v_ret_ml_tablea', {
	options = {
		{
			icon = "fas fa-box",
			label = "Preradi kokain",
			canInteract = function (entity)
				local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #Dark.Kokain.sto, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(sto[i]), false) < 1.5 then
						if sto[i] == entity then
							return true
						else
							return false
						end
					end
				end
			end,
			action = function (entity)
				if not preraduje then
					preraduje = true
					ESX.TriggerServerCallback('esx_illegal:have', function (count)
						if count >= 5 then
							ESX.TriggerServerCallback('esx_illegal:have', function (count)
								if count >= 1 then
									if lib.progressCircle({
										duration = 10000,
										position = 'bottom',
										useWhileDead = false,
										canCancel = true,
										anim = {
											scenario = 'PROP_HUMAN_BUM_BIN'
										},
									}) then 
										ESX.TriggerServerCallback('esx_illegal:proccesscoke', function () preraduje = false end)
									end
								else
									preraduje = false
									exports['hNotifikacije']:Notifikacije('Nemas dovoljno glukoze', 2)
								end
							end, 'glukoza')
						else
							preraduje = false
							exports['hNotifikacije']:Notifikacije('Nemas dovoljno listova kokaina', 2)
						end
					end, 'list_koke')
				end
			end
		},
		{
			icon = "fas fa-box",
			label = "Razbij blok",
			canInteract = function (entity)
				local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #Dark.Kokain.sto, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(sto[i]), false) < 1.5 then
						if sto[i] == entity then
							return true
						else
							return false
						end
					end
				end
			end,
			action = function (entity)
				if not preraduje then
					preraduje = true
					ESX.TriggerServerCallback('esx_illegal:have', function (count)
						if count > 0 then
							ESX.TriggerServerCallback('esx_illegal:have', function (count)
								if count >= 5 then
									if lib.progressCircle({
										duration = 10000,
										position = 'bottom',
										useWhileDead = false,
										canCancel = true,
										anim = {
											scenario = 'PROP_HUMAN_BUM_BIN'
										},
									}) then 
										ESX.TriggerServerCallback('esx_illegal:giveblock', function () preraduje = false end)
									end
								else 
									preraduje = false
								end
							end, 'kesica')
						else
							exports['hNotifikacije']:Notifikacije('Nemas dovoljno listova kokaina', 2)
							preraduje = false
						end
					end, 'blok_koke')
				end
			end
		},
	},
	distance = 1.5
})


exports.qtarget:AddTargetModel('prop_plant_01a', {
	options = {
		{
			icon = "fas fa-leaf",
			label = "Uberi biljku kokaina",
			canInteract = function (entity)
				local coords = GetEntityCoords(ESX.PlayerData.ped)
				for i=1, #CocaPlants, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 1.5 then
						if CocaPlants[i] == entity then
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
				for i=1, #CocaPlants, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 1.5 then
						nearbyObject, nearbyID = CocaPlants[i], i
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
						
							table.remove(CocaPlants, nearbyID)
							spawnedCocaLeaf = spawnedCocaLeaf - 1
						
							ESX.TriggerServerCallback('esx_illegal:pickedUpCocaLeaf', function () end)
							bere = false
						else
							exports['hNotifikacije']:Notifikacije('Ne mozes da nosis vise', 2)
							bere = false
						end

					end, 'list_koke')
				end
			end
		},
	},
	distance = 1.5
})

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			ESX.Game.DeleteObject(v)
		end
		for i=1, #Dark.Kokain.sto, 1 do
			ESX.Game.DeleteObject(sto[i])
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCocaLeaf < 10 do
		Citizen.Wait(0)
		local weedCoords = GenerateCocaLeafCoords()

		ESX.Game.SpawnLocalObject('prop_plant_01a', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(CocaPlants, obj)
			spawnedCocaLeaf = spawnedCocaLeaf + 1
		end)
	end
end

function ValidateCocaLeafCoord(plantCoord)
	if spawnedCocaLeaf > 0 then
		local validate = true

		for k, v in pairs(CocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Dark.Kokain.lokacija, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaLeafCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)

		weedCoordX = Dark.Kokain.lokacija.x + modX
		weedCoordY = Dark.Kokain.lokacija.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZCoke(x, y)
	local groundCheckHeights = { 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end