local dragStatus = {}, {}
local isHandcuffed = false, false
dragStatus.isDragged = false
local tinkykralj = TriggerServerEvent

CreateThread(function()
	while ESX.GetPlayerData().job == nil do Wait(250) end
	ESX.PlayerData = ESX.GetPlayerData()
end)


---MEMORY USAGE FIX, SMANJIT CE MEMORY-U RAM USAGE, NE DIRATI KOD!!
Citizen.CreateThread(function()
	while true do
		Wait(60000)
		collectgarbage("collect")
	end
end)

RegisterCommand("baza", function ()
	if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name] then
		for mafijoze=1, #Config.Mafije[ESX.PlayerData.job.name]['BossActions'], 1 do
			local lokacija = Config.Mafije[ESX.PlayerData.job.name]['BossActions'][mafijoze].coords
			SetNewWaypoint(lokacija)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3600000)
		ESX.TriggerServerCallback('dark-mafije:dajpoenemafiji', function() end)
	end
end)

------------------------------------------------------------------

local forloadarrmory, forloadvehicle, forloadbossaction = true, true, true

RegisterNetEvent('dajvozilo:igracu2')
AddEventHandler('dajvozilo:igracu2', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			ESX.TriggerServerCallback('dark-autosalon:dajownera2', function() end, vehicleProps)
			exports['hNotifikacije']:Notifikacije('Vozilo ' .. model .. ' sa tablicama ' .. vehicleProps.plate .. ' sada pripada vama', 1)
			ESX.Game.DeleteVehicle(vehicle)			
		end		
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name] then
		setupqtarget()
	else
		deleteqtarget()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name] then
		setupqtarget()
	else
		deleteqtarget()
	end
end)

function setupqtarget()
	exports.qtarget:AddTargetModel(Config.Propovi.Arrmory, {
		options = {
			{
				icon = "fas fa-archive",
				label = "Sef",
				action = function(entity)
					exports.ox_inventory:openInventory('stash', {id= 'society_' .. ESX.PlayerData.job.name})
				end,
				canInteract = function(entity)
					local coords = GetEntityCoords(ESX.PlayerData.ped)
					if GetDistanceBetweenCoords(coords, GetEntityCoords(arrmoryobject), false) < 2.5 then
						if arrmoryobject == entity then
							return true
						else
							return false
						end
					end
				end
			},
			{
				icon = "fas fa-archive",
				label = "Sef 2",
				action = function(entity)
					exports.ox_inventory:openInventory('stash', {id= 'society_cigani2'})
				end,
				canInteract = function(entity)
					local coords = GetEntityCoords(ESX.PlayerData.ped)
					if GetDistanceBetweenCoords(coords, GetEntityCoords(arrmoryobject), false) < 2.5 then
						if arrmoryobject == entity and ESX.PlayerData.job and ESX.PlayerData.job.name == 'cigani' then
							return true
						else
							return false
						end
					end
					return false
				end
			},
		},
		distance = 2
	})
	forloadarrmory = true
	exports.qtarget:AddTargetModel(Config.Propovi.Vozila, {
		options = {
			{
				icon = "fas fa-car",
				label = "Vadjenje vozila",
				action = function(entity)
					openvehicle(ESX.PlayerData.job.name)
				end,
				--canInteract = function(entity)
				--	local coords = GetEntityCoords(ESX.PlayerData.ped)
				--	if GetDistanceBetweenCoords(coords, GetEntityCoords(vehicleobject), false) < 1.5 then
				--		if vehicleobject == entity then
				--			return true
				--		else
				--			return false
				--		end
				--	end
				--end
			},
		},
		distance = 2
	})
	forloadvehicle = true
	exports.qtarget:AddTargetModel(Config.Propovi.BossMenu, {
		options = {
			{
				icon = "fas fa-briefcase",
				label = "Boss Meni",
				action = function(entity)
					openbossmenu()
				end,
				--canInteract = function(entity)
				--	local coords = GetEntityCoords(ESX.PlayerData.ped)
				--	if GetDistanceBetweenCoords(coords, GetEntityCoords(bossactionobject), false) < 1.5 then
				--		if bossactionobject == entity then
				--			return true
				--		else
				--			return false
				--		end
				--	end
				--end
			},
		},
		distance = 2
	})
	forloadbossaction = true
end

local vozila = {}

openheli = function(posao)
	for k,v in pairs(Config.Mafije[posao].MeniHelia) do
		SendNUIMessage({ type = 'openvehicle', primer = 'heli', carname = k, carlabel = v})
	end
	SetNuiFocus(true, true)
end

openvehicle = function(posao)
	for k,v in pairs(Config.Mafije[posao].MeniVozila) do
		SendNUIMessage({ type = 'openvehicle', primer = 'vozila', carname = k, carlabel = v})
	end
	ESX.TriggerServerCallback('dark-mafije:getajvozila', function (test)
        for i=1, #test, 1 do
			SendNUIMessage({ type = 'openvehicle', carname = string.lower(GetDisplayNameFromVehicleModel(test[i].model)), carlabel = GetDisplayNameFromVehicleModel(test[i].model), vehplate = test[i].plate})
        end
	end)
	SetNuiFocus(true, true)
end

openbossmenu = function()
	ESX.TriggerServerCallback('dark-mafije:getajpoene', function (poeni)
		ESX.TriggerServerCallback('dark-mafije:getajlevel', function (level)
			SendNUIMessage({ type = 'openboss', poeni = poeni, level = Config.Level[level].label, lvlbr = level })
			SetNuiFocus(true, true)
		end)
	end)
end

function deleteqtarget()
	exports.qtarget:RemoveTargetModel(Config.Propovi.Arrmory, {
		'Sef'
	})
	exports.qtarget:RemoveTargetModel(Config.Propovi.Vozila, {
		'Vadjenje vozila', 'Parkiraj vozilo'
	})
	exports.qtarget:RemoveTargetModel(Config.Propovi.BossMenu, {
		'Boss Meni'
	})
	DeleteObject(arrmoryobject)
	forloadarrmory = false
	DeleteObject(vehicleobject)
	forloadvehicle = false
	DeleteObject(bossactionobject)
	forloadbossaction = false
end

ocistiIgraca = function(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

StvoriVozilo = function(vozilo, plate)
	local ped = PlayerPedId()
	ESX.Game.SpawnVehicle(vozilo, Config.Mafije[ESX.PlayerData.job.name]["SpawnLocation"], GetEntityHeading(ped), function(veh)
		SetVehicleFuelLevel(veh, 100.0)
		SetVehicleOilLevel(veh, 10.0)
		NetworkFadeInEntity(veh, true, true)
		SetVehicleEngineOn(veh, true, true, false)
		SetModelAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(ped, veh, -1)
		DecorSetFloat(veh, "_FUEL_LEVEL", GetVehicleFuelLevel(veh))
		local voziloID = NetworkGetNetworkIdFromEntity(vozilo)
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Boja'] then -- Boja vozila, imate u config.lua!
			local props = {
				color1 = Config.Mafije[ESX.PlayerData.job.name]['Boja'],
				color2 = Config.Mafije[ESX.PlayerData.job.name]['Boja'],
			}
			ESX.Game.SetVehicleProperties(veh, props)
		end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Zatamni'] then Zatamni(veh) end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Nabudzi'] then Nabudzi(veh) end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Tablice'] then Tablice(veh, Config.Mafije[ESX.PlayerData.job.name]['Tablice']) end
	end)
end

StvoriHeli = function(vozilo, plate)
	local ped = PlayerPedId()
	ESX.Game.SpawnVehicle(vozilo, Config.Mafije[ESX.PlayerData.job.name]["SpawnHelija"], GetEntityHeading(ped), function(veh)
		SetVehicleFuelLevel(veh, 100.0)
		SetVehicleOilLevel(veh, 10.0)
		NetworkFadeInEntity(veh, true, true)
		SetVehicleEngineOn(veh, true, true, false)
		SetModelAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(ped, veh, -1)
		DecorSetFloat(veh, "_FUEL_LEVEL", GetVehicleFuelLevel(veh))
		local voziloID = NetworkGetNetworkIdFromEntity(vozilo)
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Boja'] then -- Boja vozila, imate u config.lua!
			local props = {
				color1 = Config.Mafije[ESX.PlayerData.job.name]['Boja'],
				color2 = Config.Mafije[ESX.PlayerData.job.name]['Boja'],
			}
			ESX.Game.SetVehicleProperties(veh, props)
		end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Zatamni'] then Zatamni(veh) end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Nabudzi'] then Nabudzi(veh) end
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name]['Tablice'] then Tablice(veh, Config.Mafije[ESX.PlayerData.job.name]['Tablice']) end
	end)
end

function Zatamni(vozilo)
    local props = {
    	windowTint = 1,
      	wheelColor = 0,
      	plateIndex = 1
    }
    ESX.Game.SetVehicleProperties(vozilo, props)
end

function Nabudzi(vozilo)
    local props = {
      modArmor = 4,
      modXenon = true,
      modEngine = 3,
      modBrakes = 2,
      modTransmission = 2,
      modSuspension = 3,
      modTurbo = true,
    }
    ESX.Game.SetVehicleProperties(vozilo, props)
end

function Tablice(vozilo, tablice)
    local props = {
		plate = tablice,
    }
    ESX.Game.SetVehicleProperties(vozilo, props)
end


ObrisiVozilo = function()
	local playerPed = PlayerPedId()
	local vozilo =GetVehiclePedIsIn(playerPed,false)
	local vehicleProps = ESX.Game.GetVehicleProperties(vozilo)
	local vehicleSpeed = math.floor((GetEntitySpeed(GetVehiclePedIsIn(playerPed, false))*3.6))
	if (vehicleSpeed > 45) then FreezeEntityPosition(vozilo, true) end
	TaskLeaveVehicle(playerPed, vozilo, 0)
	while IsPedInVehicle(playerPed, vozilo, true) do Wait(0) end
	Citizen.Wait(500)
	NetworkFadeOutEntity(vozilo, true, true)
	Citizen.Wait(100)
	ESX.Game.DeleteVehicle(vozilo)
	ESX.ShowNotification("Uspiješno si parkirao ~b~vozilo~s~ u garažu.")
	ESX.TriggerServerCallback("dark-mafije:sacuvaj", function () end, vehicleProps)
end

OtvoriHeliSpawnMenu = function(type, station, part, partNum)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vozila_meni',{
        css      = 'vagos',
        title    = 'Izaberi Vozilo | 🚗',
        elements = {
        {label = 'Heli | 🚗', value = 'fxho'},
		{label = 'Heli2 | 🚗', value = 'seashark'},
            }},function(data, menu)
            local playerPed = PlayerPedId()
            if data.current.value == 'fxho' then
				ESX.Game.SpawnVehicle("supervolito2", vector3(-2320.86, -658.25, 13.48), 266.92, function(vehicle) -- 
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleEngineOn(vehicle, true, true, false)
				end)
				Wait(200)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
               	SetVehicleFuelLevel(vehicle, 100.0)
				DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))

				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'seashark' then
				ESX.Game.SpawnVehicle("seasparrow", vector3(-2320.86, -658.25, 13.48), 266.92, function(vehicle) -- 
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleEngineOn(vehicle, true, true, false)
				end)
				Wait(200)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
                SetVehicleFuelLevel(vehicle, 100.0)
				DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
			menu.close()
			CurrentAction = nil
		end
	)
end

OtvoriBrodSpawnMenu = function(type, station, part, partNum)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vozila_meni',{
		title    = 'Izaberi Vozilo | 🚗',
		elements = {
		{label = 'JetSkki | 🚗', value = 'fxho'},
		{label = 'Jahta | 🚗', value = 'seashark'},
			}},function(data, menu)
			local playerPed = PlayerPedId()
			if data.current.value == 'fxho' then
				ESX.Game.SpawnVehicle("fxho", vector3(-2273.91, -662.05, 0.5),  159.25, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleEngineOn(vehicle, true, true, false)
				end)
				Wait(200)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				SetVehicleFuelLevel(vehicle, 100.0)
				DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'seashark' then
				ESX.Game.SpawnVehicle("yacht2", vector3(-2273.91, -662.05, 0.5),  159.25, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleEngineOn(vehicle, true, true, false)
				end)
				Wait(200)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				SetVehicleFuelLevel(vehicle, 100.0)
				DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
				ESX.UI.Menu.CloseAll()
			end
		end,
		function(data, menu)
		menu.close()
		CurrentAction = nil
	end)
end

RegisterNetEvent('hMafije:vezivanje')
AddEventHandler('hMafije:vezivanje', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()
		if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do Wait(0) end
		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		--FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('hMafije:odvezivanje')
AddEventHandler('hMafije:odvezivanje', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('hMafije:vuci')
AddEventHandler('hMafije:vuci', function(copId)
	if not isHandcuffed then return end
	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed
	while true do
		Wait(10)
		if isHandcuffed then
			playerPed = PlayerPedId()
			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end
				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end
			else
				DetachEntity(playerPed, true, false)
			end
		else
			Wait(2000)
		end
	end
end)

local target2 = nil

RegisterNetEvent('hMafije:nesto')
AddEventHandler('hMafije:nesto', function(target)
	kurac = true
	target2 = nil
	target2 = target
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if kurac then
			ESX.ShowHelpNotification('~INPUT_FRONTEND_RRIGHT~ Da prekines da vuces')
			if IsControlJustReleased(0, 194) then
				tinkykralj('hMafije:vuci2', target2)
				kurac = false
			end
		else
			Wait(1500)
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1000)
		if kurac then
			exports.qtarget:Vehicle({
				options = {
					{
						icon = "fas fa-car",
						label = "Stavi u vozilo",
						action = function ()				
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 2 then				
								tinkykralj('hMafije:staviUVozilo', GetPlayerServerId(closestPlayer))
								kurac = false
								uvozilu = true
							end
						end
					},
				},
				distance = 2
			})
		else
			exports.qtarget:RemoveVehicle({
				'Stavi u vozilo'
			})
		end
		if uvozilu then
			exports.qtarget:Vehicle({
				options = {
					{
						icon = "fas fa-car",
						label = "Izvadi iz vozila",
						action = function ()				
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3 then			
								tinkykralj('hMafije:staviVanVozila', GetPlayerServerId(closestPlayer))
								uvozilu = false
							end
						end
					},
				},
				distance = 2
			})
		else
			exports.qtarget:RemoveVehicle({
				'Izvadi iz vozila'
			})
		end
	end
end)

RegisterNetEvent('hMafije:staviUVozilo')
AddEventHandler('hMafije:staviUVozilo', function()
	if isHandcuffed then
		local igrac = PlayerPedId()
		local vozilo, udaljenost = ESX.Game.GetClosestVehicle()

		if vozilo and udaljenost < 5 then
			local max, slobodno = GetVehicleMaxNumberOfPassengers(vozilo)

			for i=max - 1, 0, -1 do
				if IsVehicleSeatFree(vozilo, i) then
					slobodno = i
					break
				end
			end

			if slobodno then
				TaskWarpPedIntoVehicle(igrac, vozilo, slobodno)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('hMafije:staviVanVozila')
AddEventHandler('hMafije:staviVanVozila', function()
	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 16)
		--TriggerEvent('hMafije:odvezivanje')
	else
		ESX.ShowNotification('Osoba nije u vozilu i ne mozete je izvaditi van vozila!')
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Wait(2000)
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	deleteqtarget()
	TriggerEvent('hMafije:odvezivanje')
end)
  

function napraviobj(data, prop)
	local hash = GetHashKey(prop)
	ESX.Game.SpawnLocalObject(hash, data.coords, function(object)
		arrmoryobject = object
		FreezeEntityPosition(arrmoryobject, true)
		SetEntityHeading(arrmoryobject, data.heading)
		PlaceObjectOnGroundProperly(arrmoryobject)
	end)
end

function napraviobj2(data, prop)
	local hash = GetHashKey(prop)
	ESX.Game.SpawnLocalObject(hash, data.coords, function(object)
		vehicleobject = object
		FreezeEntityPosition(vehicleobject, true)
		SetEntityHeading(vehicleobject, data.heading)
		PlaceObjectOnGroundProperly(vehicleobject)
	end)
end

function napraviobj3(data, prop)
	local hash = GetHashKey(prop)
	ESX.Game.SpawnLocalObject(hash, data.coords, function(object)
		bossactionobject = object
		FreezeEntityPosition(bossactionobject, true)
		SetEntityHeading(bossactionobject, data.heading)
		PlaceObjectOnGroundProperly(bossactionobject)
	end)
end

Citizen.CreateThread(function()
	if ESX ~= nil and ESX.PlayerData ~= nil then
		print("Skripta je uspjesno loadovana i ucitana bez errora..")
	else print("Imate erorr ESX ili ESX.PlayerData!! Mafije nece raditi kako treba")

	end
	while true do
		Wait(wejtara)
		wejtara = 1000 -- Cope full a gang
		if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name] then
			for i=1, #Config.Mafije[ESX.PlayerData.job.name]['Armories'], 1 do
				local distance = #(GetEntityCoords(PlayerPedId()) - Config.Mafije[ESX.PlayerData.job.name]['Armories'][i].coords)
				if distance < 50.0 then
					if not DoesEntityExist(arrmoryobject) and forloadarrmory then
						napraviobj(Config.Mafije[ESX.PlayerData.job.name]['Armories'][i], Config.Propovi.Arrmory, arrmoryobject)
					end
				else
					if DoesEntityExist(arrmoryobject) then
						DeleteObject(arrmoryobject)
					end
				end
			end
			for i=1, #Config.Mafije[ESX.PlayerData.job.name]['Vehicles'], 1 do
				local distance2 = #(GetEntityCoords(PlayerPedId()) - Config.Mafije[ESX.PlayerData.job.name]['Vehicles'][i].coords)
				if distance2 < 50.0 then
					if not DoesEntityExist(vehicleobject) and forloadvehicle then
						napraviobj2(Config.Mafije[ESX.PlayerData.job.name]['Vehicles'][i], Config.Propovi.Vozila)
					end
				else
					if DoesEntityExist(vehicleobject) then
						DeleteObject(vehicleobject)
					end
				end
			end
			for i=1, #Config.Mafije[ESX.PlayerData.job.name]['BossActions'], 1 do
				local distance3 = #(GetEntityCoords(PlayerPedId()) - Config.Mafije[ESX.PlayerData.job.name]['BossActions'][i].coords)
				if distance3 < 50.0 and ESX.PlayerData.job.grade_name == "boss" then
					if not DoesEntityExist(bossactionobject) and forloadbossaction then
						napraviobj3(Config.Mafije[ESX.PlayerData.job.name]['BossActions'][i], Config.Propovi.BossMenu)
					end
				else
					if DoesEntityExist(bossactionobject) then
						DeleteObject(bossactionobject)
					end
				end
			end
			if Config.Mafije[ESX.PlayerData.job.name]['Helikopter'] ~= nil then
				for k,v in pairs(Config.Mafije[ESX.PlayerData.job.name]['Helikopter']) do
					local distance = #(GetEntityCoords(PlayerPedId()) - v)
					if distance < 10.0 then
						wejtara = 5
						DrawMarker(34, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 102, 204, 100, false, true, 2, nil, nil, false)
						if distance < 1.5 then
							if IsControlJustReleased(0, 38) then
								openheli(ESX.PlayerData.job.name)
							end
						end
					end
				end
			end
			if Config.Mafije[ESX.PlayerData.job.name]['SpawnHelija'] ~= nil then
				local distance = #(GetEntityCoords(PlayerPedId()) - Config.Mafije[ESX.PlayerData.job.name]['SpawnHelija'])
				if distance < 20.0 and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
					wejtara = 5
					DrawMarker(1, Config.Mafije[ESX.PlayerData.job.name]['SpawnHelija'] - vector3(0,0,1.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
					if distance < 10 then
						if IsControlJustReleased(0, 38) then
							ObrisiVozilo()
						end
					end
				end
			end
		else
			deleteqtarget()
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	if ESX.PlayerData.job and Config.Mafije[ESX.PlayerData.job.name] then
		setupqtarget()
	else
		deleteqtarget()
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1000)
		local vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == ESX.PlayerData.ped then
			exports.qtarget:AddTargetModel(Config.Propovi.Vozila, {
				options = {
					{
						icon = "fas fa-car",
						label = "Parkiraj vozila",
						action = function(entity)
							ObrisiVozilo()
						end,
						canInteract = function(entity)
							local coords = GetEntityCoords(ESX.PlayerData.ped)
							if GetDistanceBetweenCoords(coords, GetEntityCoords(vehicleobject), false) < 2.5 then
								if vehicleobject == entity then
									return true
								else
									return false
								end
							end
						end
					},
				},
				distance = 5
			})
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn) isDead = false end)
AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)


--############################NUI##############################--

local sviIgraci = {}
local sviClanovi = {}

RegisterNUICallback("action", function (data,cb)
	if data.type == "close" then
		SetNuiFocus(false, false)
	elseif data.type == "spawnveh" then
		if data.primer == 'vozila' then
			StvoriVozilo(data.carspawn, data.vehplate)
		elseif data.primer == 'heli' then
			StvoriHeli(data.carspawn, data.vehplate)
		end
		SendNUIMessage({ type = 'closemenu'})
	elseif data.type == "getajlistu" then
		ESX.TriggerServerCallback("WaveShield:GetInfinityPlayerList", function(cb)
            sviIgraci = cb
            for k,v in pairs(sviIgraci) do
                SendNUIMessage({ type = "napraviigrace", data = v })
            end 
        end)
	elseif data.type == "setajjob" then
		if data.id ~= nil then
			ESX.TriggerServerCallback("dark-mafije:setajjob", function() end, data.id)
		end
	elseif data.type == "getajzaposljene" then
		ESX.TriggerServerCallback("dark:mafije:getajsve", function(cb)
            sviClanovi = cb
			for i = 1, #sviClanovi, 1 do
                SendNUIMessage({ type = "napraviclanove2", data = sviClanovi[i] })
            end
        end, ESX.PlayerData.job.name)
	elseif data.type == "rankup" then
		ESX.TriggerServerCallback("dark-mafije:rankup", function() end, data.identifier, data.grade)
	elseif data.type == "rankdown" then
		ESX.TriggerServerCallback("dark-mafije:rankdown", function() end, data.identifier, data.grade)
	elseif data.type == "otkaz" then
		ESX.TriggerServerCallback("dark-mafije:otkaz", function() end, data.identifier)
	elseif data.type == "getajvozilazaorgu" then
		for k,v in pairs(Config.VozilaZaProdaju) do
            SendNUIMessage({ type = "napravivozila", data = v })
		end
	elseif data.type == "kupivozilo" then
		ESX.Game.SpawnVehicle(data.ime, vector3(0,0,0), 0.0, function (vehicle)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			ESX.TriggerServerCallback("dark-mafije:kupivozilo", function() end, vehicleProps, data.cena)
			ESX.Game.DeleteVehicle(vehicle)
		end)
	elseif data.type == "levelup" then
		if tonumber(data.poeni) >= Config.Level[tostring(data.level)].cena then
			ESX.TriggerServerCallback("dark-mafije:setlevel", function(moze)
				if moze then
					SendNUIMessage({ type = "updatelevel", lvl2 = tostring(data.level), lvl = Config.Level[tostring(data.level)].label, poeni = tonumber(data.poeni) - Config.Level[tostring(data.level)].cena })
				end 
			end, data.level, (tonumber(data.poeni) - Config.Level[tostring(data.level)].cena))
		end
	end
end)