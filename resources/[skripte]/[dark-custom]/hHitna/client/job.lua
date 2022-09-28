local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

local vozilaped = {}

-- Draw markers & Marker logic
CreateThread(function()
	while true do
		local sleep = 1500

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local isInMarker, hasExited = false, false
			local currentHospital, currentPart, currentPartNum

			for hospitalNum,hospital in pairs(Config.Hospitals) do
				-- Vehicle Spawners
				for i=1, #hospital.Vehicles, 1 do
					for k,v in ipairs(hospital.Vehicles) do
						local distance = #(GetEntityCoords(ESX.PlayerData.ped) - hospital.Vehicles[i].Spawner.coords)

						if distance < Config.DrawDistance then
							if(not DoesEntityExist(vozilaped[i])) then
								sleep = 0
								vozilaped[i] = exports['hCore']:NapraviPed(GetHashKey('s_m_m_doctor_01'),hospital.Vehicles[i].Spawner.coords, hospital.Vehicles[i].Spawner.heading)
							end
						else
							if DoesEntityExist(vozilaped[i]) then
								DeletePed(vozilaped[i])
							end
						end

						if distance < 15 then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
						end
					end
				end

				-- Helicopter Spawners
				for k,v in ipairs(hospital.Helicopters) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
						end
					end
				end
			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end
		end
		Wait(sleep)
	end
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		for k,v in pairs(Config.Hospitals) do
			for i=1, #v.Vehicles, 1 do
				DeletePed(vozilaped[i])
			end
		end
	end
end)

exports.qtarget:AddTargetModel('s_m_m_doctor_01', {
	options = {
		{
			icon = "fas fa-car",
			label = "Izvadi vozilo",
			num = 1,
			job = {['ambulance'] = 0},
			action = function(entity)
				local options2 = {}

				for i = 1, #Config.Vozila do
					options2[i] = {
						title = Config.Vozila[i].label,
						event = 'dark:izvadivozilo4',
						args = {
							name = Config.Vozila[i].carname,
						}
					}
				end

				lib.registerContext({
					id = 'hitna:garaza',
					title = 'Hitna garaza',
					options = options2
				})
			
				lib.showContext('hitna:garaza')
			end,
		},
		{
			icon = "fas fa-car",
			label = "Ostavi vozilo",
			num = 2,
			job = {['ambulance'] = 0},
			action = function(entity)
				ObrisiVozilo()
			end,
		},
	},
	distance = 3
})

function ObrisiVozilo()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
		ESX.ShowNotification("Uspešno ste parkirali ~b~vozilo~s~ u garažu.")
    else
    	ESX.ShowNotification("Potreban vam je posao ~b~policajac~s~ da biste vratili vozilo.")
    end
end

AddEventHandler('dark:izvadivozilo4', function (data)
	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(CurrentActionData.hospital, LastPart, LastPartNum)
	ESX.Game.SpawnVehicle(data.name, spawnPoint.coords, spawnPoint.heading, function(vehicle)
		TaskWarpPedIntoVehicle(ESX.PlayerData.ped,  vehicle,  -1)
		SetVehicleMaxMods(vehicle)
		SetVehicleDirtLevel(vehicle, 0.0)
	end)
end)

function SetVehicleMaxMods(vehicle)

	local props = {
	  modEngine       = 4,
	  modBrakes       = 3,
	  modTransmission = 3,
	  modSuspension   = 3,
	  modTurbo        = true,
	}
  
	ESX.Game.SetVehicleProperties(vehicle, props)
  
  end

function GetAvailableVehicleSpawnPoint(station, part, partNum)
	local spawnPoints = Config.Hospitals[station][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		exports['hNotifikacije']:Notifikacije('Spawnpoint je blokiran', 2)
		return false
	end
end

exports.qtarget:AddBoxZone("HitnaSef", vector3(304.07, -601.44, 43.28), 3.5, 0.5, {
	name="HitnaSef",
	heading = 70,
	debugPoly=false,
	minZ = 41.28,
	maxZ = 45.28
	}, {
		options = {
			{
				icon = "fas fa-box",
				label = "Sef",
				job = {['ambulance'] = 0},
				action = function(entity)
					exports.ox_inventory:openInventory('stash', 'Sef Hitna')
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("HitnaPresvlacenje", vector3(298.2, -598.1, 43.28), 3.1, 0.5, {
	name="HitnaPresvlacenje",
	heading = 340,
	debugPoly=false,
	minZ = 42.48,
	maxZ = 44.88
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Presvlacenje",
				job = {['ambulance'] = 0},
				action = function(entity)
					OpenCloakroomMenu()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("HitnaBoss", vector3(307.59, -595.62, 43.28), 2.5, 0.5, {
	name="HitnaBoss",
	heading = 340,
	debugPoly = false,
	minZ = 41.48,
	maxZ = 45.48
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Boss Meni",
				job = {['ambulance'] = 0},
				action = function(entity)
					print('test')
				end,
			},
		},
		distance = 3.5
})

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'Vehicles' then
		CurrentAction = part
		CurrentActionMsg = _U('garage_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction = part
		CurrentActionMsg = _U('helicopter_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-right',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = 'Bolnicarsko odelo', value = 'odelo'},
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false

				for playerId,v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
			end)
		end

		if data.current.value == 'odelo' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          	local model = nil

          	if skin.sex == 0 then
           		model = GetHashKey("mp_m_freemode_01")
          	else
            	model = GetHashKey("mp_f_freemode_01")
          	end

         		 RequestModel(model)
         			while not HasModelLoaded(model) do
            		RequestModel(model)
            		Citizen.Wait(1)
          		end

         		SetPlayerModel(PlayerId(), model)
         		SetModelAsNoLongerNeeded(model)

          		TriggerEvent('skinchanger:loadSkin', skin)
          		TriggerEvent('esx:restoreLoadout')
          		setUniform('hitna')
				isOnDuty = true
        	end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function setUniform(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

--[[RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	--if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	--end
end)--]]