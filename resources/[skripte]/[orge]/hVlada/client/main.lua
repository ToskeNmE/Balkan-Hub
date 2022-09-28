local PlayerData, CurrentActionData, handcuffTimer, DragStatus, currentTask , blipsCops= {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isHandcuffed = false, false
local Pretrazivan = false
local blipsCops = {}
local hasAlreadyJoined = {}
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
DragStatus.draganim = false
DragStatus.IsDragged = false
local pokusao = false
ESX = nil
cine = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform2(job, playerPed)
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
			SetPedArmour(playerPed, 100)
		end
	end)
end

function ObrisiVozilo2()
	local playerPed = PlayerPedId()
    local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
    if PlayerData.job and PlayerData.job.name == 'vlada' then
		ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
		ESX.ShowNotification("Uspesno ste parkirali ~o~vozilo~s~ u garazu.")
    else
    	ESX.ShowNotification("Potreban vam je posao ~o~vlada~s~ da biste vratili vozilo.")
    end
end

function OpenCloakroomMenu2()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
	}
    
    if PlayerData.job.grade_name == 'security' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
    elseif PlayerData.job.grade_name == 'poslanik' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
    elseif PlayerData.job.grade_name == 'sekretar' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
	elseif PlayerData.job.grade_name == 'kabinet' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
	elseif PlayerData.job.grade_name == 'premijer' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
    elseif PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = 'Security | 👮', value = 'nizioficir' })
		table.insert(elements, {label = 'Pancir | 🛡️', value = 'pancir' })
    end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		css      = 'navyseals',
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		if
			data.current.value == 'nizioficir' or
			data.current.value == 'pancir' 
		then
			setUniform2(data.current.value, playerPed)
		end

		if data.current.value == 'pancir' then
			SetPedArmour(playerPed, 100)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end


function OpenArmoryMenu2(station)
	local elements = {
		{label = 'Sef',     value = 'sef'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		css      = 'vlada',
		title    = _U('armory'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)


		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu2()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu2()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'sef' then
			if PlayerData.job.grade_name == 'boss' then
			TriggerServerEvent("hub_sefovi:povuciInv", PlayerData.job.name)
			end
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end

-- BUDzENJE

function Popravi2()
    local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	FreezeEntityPosition(veh, true)
	exports.hub_progg:Start('POPRAVLJANJE', 3000)
	FreezeEntityPosition(veh, false)
	SetVehicleFixed(veh)
	exports["hub_gorivo"]:SetFuel(veh, 100)
end

function Ocisti2()
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	FreezeEntityPosition(veh, true)
	exports.hub_progg:Start('CISCENJE', 3000)
	SetVehicleDirtLevel(veh, 0.0)
	FreezeEntityPosition(veh, false)
end

function OpenExtraMenu2()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Dodatak: "..id.." | "..('<span style="color:green;">%s</span>'):format("✅"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Dodatak: "..id.." | "..('<span style="color:red;">%s</span>'):format("❌"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = 'Dodaci | 🚓',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Dodatak: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("✅")
		else
			newData.label = "Dodatak: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("❌")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenLiveryMenu2()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Stil: "..i.." | "..('<span style="color:green;">%s</span>'):format("✅")
		else
			text = "Stil: "..i.." | "..('<span style="color:red;">%s</span>'):format("❌")
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {
		title    = 'Stilovi | 🚓',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Stil: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("✅")
		else
			newData.label = "Stil: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("❌")
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
		menu.close()	
	end, function(data, menu)
		menu.close()		
	end)
end

function OpenMainMenu2()
	local elements = {
		{label = 'Glavna Boja | 🎨', value = 'primary'},
		{label = 'Sporedna Boja | 🎨', value = 'secondary'},
		{label = 'Dodaci | ',value = 'extra'},
		{label = 'Stilovi | 😎',value = 'livery'},
		{label = 'Popravljanje | ‍🔧',value = 'popravi'},
		{label = 'ciscenje | 🧹',value = 'ocisti'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = 'Budzenje | ',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'extra' then
			OpenExtraMenu2()
		elseif data.current.value == 'livery' then
			OpenLiveryMenu2()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu2('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu2('secondary')
		elseif data.current.value == 'popravi' then
			Popravi2()
		elseif data.current.value == 'ocisti' then
			Ocisti2()
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

function OpenMainColorMenu2(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = 'Tip Boje | 🎨',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenColorMenu2(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenColorMenu2(type, value, colortype)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = 'Boje | 🎨',
		align    = 'top-left',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local pr,sec = GetVehicleColours(vehicle)
		if colortype == 'primary' then
			SetVehicleColours(vehicle, data.current.index, sec)
		elseif colortype == 'secondary' then
			SetVehicleColours(vehicle, pr, data.current.index)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function SetVehicleMaxMods(vehicle)

	local props = {
		modEngine       = 5,
		modBrakes       = 5,
		modTransmission = 5,
		modSuspension   = 5,
		modXenon        = true,
		modTurbo        = true,
		windowTint      = 1,
		plateIndex      = 1,
		color1          = 12,
		stickers        = 1,
		color2          = 12,
		pearlescentColor = 12,
		wheelColor      = 12
	  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function OpenVehicleSpawnerMenu2(type, station, part, partNum)
	local elements = {}

	if PlayerData.job.grade_name == 'novi' then
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end

	if PlayerData.job.grade_name == 'radnik' then
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end

	if PlayerData.job.grade_name == 'parlament' then  
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end


	if PlayerData.job.grade_name == 'kabinet' then  
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end

	if PlayerData.job.grade_name == 'premijer' then  
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end

	if PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = 'Baller | 🚓', value = 'baller6'})
	end


	local playerPed = PlayerPedId()

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vozila_meni',
        {
        	css      = 'vlada',
            title    = 'Izaberi Vozilo | 🚓',
            elements = elements
        },
        function(data, menu)

            if data.current.value == 'baller6' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("baller6", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'bmwm5' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("bmwm5", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
            elseif data.current.value == '19S650' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("19S650", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'gls600' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("gls600", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'taa8' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("taa8", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == '17magotan' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("17magotan", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end


function GetAvailableVehicleSpawnPoint2(station, part, partNum)
	local spawnPoints = Config.vladaStations[station][part][partNum].SpawnPoints
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
		TriggerEvent("hub_notifikacije:SendNotification", {text = "Spawnpoint je blokiran...", type = "success", queue = "success", timeout = 2000, layout = "center"})
		return false
	end
end

function FastTravel2(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(1500)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		Wait(1500)
		DoScreenFadeIn(1500)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

function Helikopteri2(type, station, part, partNum)
    ESX.UI.Menu.CloseAll()

	local playerPed = GetPlayerPed(-1)

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'helikopteri_meni',
        {
        	css      = 'vlada',
            title    = 'Izaberi Helikopter | 🚁',
            elements = {
            	{label = 'Helikopter | 🚁', value = 'polmav'},
            	{label = 'Buzzard | 🚁', value = 'buzzard2'},

            }
        },
        function(data, menu)
            if data.current.value == 'polmav' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
				ESX.Game.SpawnVehicle("polmav", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(200)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
                exports["hub_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'cargobob' then
					local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
					ESX.Game.SpawnVehicle("cargobob", spawnPoint.coords, spawnPoint.heading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						SetVehicleMaxMods(vehicle)
					end)
					Wait(200)
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					SetVehicleDirtLevel(vehicle, 0.0)
					exports["hub_gorivo"]:SetFuel(vehicle, 100)
	
					ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'buzzard2' then
					local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint2(station, part, partNum)
					ESX.Game.SpawnVehicle("buzzard2", spawnPoint.coords, spawnPoint.heading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						SetVehicleMaxMods(vehicle)
					end)
					Wait(200)
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					SetVehicleDirtLevel(vehicle, 0.0)
					exports["hub_gorivo"]:SetFuel(vehicle, 100)
	
					ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

local plateModel = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

RegisterNetEvent("grandsonvolizenenajvise213vladagradonacelnik:znackaAnim")
AddEventHandler("grandsonvolizenenajvise213vladagradonacelnik:znackaAnim", function()

  RequestModel(GetHashKey(plateModel))
  while not HasModelLoaded(GetHashKey(plateModel)) do
    Citizen.Wait(100)
  end

  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
  end

  local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
  local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
  Citizen.Wait(1000)
  local netid = ObjToNet(platespawned)
  SetNetworkIdExistsOnAllMachines(netid, true)
  SetNetworkIdCanMigrate(netid, false)
  TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
  TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
  Citizen.Wait(800)
  AttachEntityToEntity(platespawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
  plate_net = netid
  Citizen.Wait(3000)
  ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
  DetachEntity(NetToObj(plate_net), 1, 1)
  DeleteEntity(NetToObj(plate_net))
  plate_net = nil
end)

function OpenvladaActionsMenu2()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vlada_actions', {
		css      = 'fbi',
		title    = 'vlada Meni | 👮',
		align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			{label = _U('object_spawner'), value = 'object_spawner'},
			{label = "Stit", value = "stit"}
	}}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('search'), value = 'pretrazi'},
				{label = 'Znacka | ', value = 'znacka'},
				{label = 'Zavezi | ', value = 'zavezi'},
				{label = 'Odvezi | ', value = 'odvezi'},
				{label = 'Zatvor | ', value = 'zatvor'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'}
			}

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				css      = 'fbi',
				title    = _U('citizen_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'pretrazi' then
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
						--TriggerEvent('ev-inventory:search', (closestPlayer))
						OpenBodySearchMenu2(closestPlayer)
					elseif action == 'znacka' then
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:znacka', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
					elseif data2.current.value == 'zavezi' then
                    	local igrac, distance = ESX.Game.GetClosestPlayer()
						igracHeading = GetEntityHeading(GetPlayerPed(-1))
						igracLokacija = GetEntityForwardVector(PlayerPedId())
						igracKoordinate = GetEntityCoords(GetPlayerPed(-1))
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'cuff', 1.0)
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:requestarrest', GetPlayerServerId(igrac), igracHeading, igracKoordinate, igracLokacija)

						if pokusao == false then
							pokusao = true
							TriggerServerEvent("skillbar:otvori", GetPlayerServerId(closestPlayer))
							pokusao = false
						end

					elseif data2.current.value == 'zatvor' then
						TriggerEvent("esx-qalle-jail:openJailMenu")
				    elseif action == 'odvezi' then
				    	local igrac, distance = ESX.Game.GetClosestPlayer()
						igracHeading = GetEntityHeading(GetPlayerPed(-1))
						igracLokacija = GetEntityForwardVector(PlayerPedId())
						igracKoordinate = GetEntityCoords(GetPlayerPed(-1))
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:requestrelease', GetPlayerServerId(igrac), igracHeading, igracKoordinate, igracLokacija)
						Citizen.Wait(1200)
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'uncuff', 0.5)
					elseif action == 'drag' then
                    	TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:drag', GetPlayerServerId(closestPlayer))
						Citizen.Wait(800)
						if DragStatus.draganim then
							StopAnimTask(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
							DragStatus.draganim = false
						else
							LoadAnimDict('switch@trevor@escorted_out')
							TaskPlayAnim(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
							DragStatus.draganim = true
						end
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'), value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				css      = 'fbi',
				title    = _U('vehicle_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
						-- is the script busy?
						if currentTask.busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_fbiD', 0, true)

						currentTask.busy = true
						currentTask.task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)

						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while currentTask.busy do
								Citizen.Wait(1000)

								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and currentTask.busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(currentTask.task)
									ClearPedTasks(playerPed)
									currentTask.busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				css      = 'fbi',
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)
				
				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == "stit" then
			TriggerEvent("stavi:stit")	
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBodySearchMenu2(player)
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			css      = 'vlada',
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu2(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenFineMenu2(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		css      = 'vlada',
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu2(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu2(player, category)
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:white;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			css      = 'vlada',
			title    = _U('fine'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:posaljiRacun', GetPlayerServerId(player), 'society_vlada', _U('fine_total', data.current.fineLabel), data.current.amount)
				TriggerServerEvent('esx:kazna', GetPlayerServerId(player))
			else
				TriggerServerEvent('esx_billing:posaljiRacun', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
				TriggerServerEvent('esx:kazna', GetPlayerServerId(player))
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu2(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle2()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenUnpaidBillsMenu2(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			css      = 'vlada',
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu2(vehicleData)
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			css      = 'vlada',
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu2()
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:removeArmoryWeapon', function()
				OpenGetWeaponMenu2()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu2()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:addArmoryWeapon', function()
			OpenPutWeaponMenu2()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu2()
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].name,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('vlada_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu2()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu2()
	ESX.TriggerServerCallback('grandsonvolizenenajvise213vladagradonacelnik:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu2()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'vlada',
		number     = 'vlada',
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Budzenje' then
		CurrentAction     = 'budzenje'
		CurrentActionMsg  = 'Pritisnite ~INPUT_CONTEXT~ da otvorite meni za ~o~budzenje vozila~s~.'
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif part == 'ParkirajAuto' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'ParkirajAuto'
			CurrentActionMsg  = 'Pritisnite ~INPUT_CONTEXT~ da ~o~parkirate~s~ vozilo u garazu.'
			CurrentActionData = { vehicle = vehicle }
		end
	elseif part == 'ParkirajHelikopter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'ParkirajHelikopter'
			CurrentActionMsg  = 'Pritisnite ~INPUT_CONTEXT~ da ~o~parkirate~s~ vozilo u garazu.'
			CurrentActionData = { vehicle = vehicle }
		end	
	end
end)

AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'vlada' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
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
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:unrestrain')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:unrestrain', function()
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

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
			
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, -0.06, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:drag')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:drag', function(copId)
	if not isHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if isHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(1000)
		end
		Citizen.Wait(0)
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

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not isHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)


function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

local uspeo = false

RegisterNetEvent("uspeo")
AddEventHandler("uspeo", function(akcija)
	uspeo = akcija
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:getarrested')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	if not uspeo then
	IsHandcuffed = true
	IsShackles = false
	TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff')
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	end
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:doarrested')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:doarrested', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:douncuffing')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:douncuffing', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:getuncuffed')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	IsShackles = false
	TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('grandsonvolizenenajvise213vladagradonacelnik:loose')
AddEventHandler('grandsonvolizenenajvise213vladagradonacelnik:loose', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = true
	IsShackles = false
	TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'vlada' then

			local playerPed = PlayerPedId()
			local voziloProvera = IsPedInAnyVehicle(playerPed, true)
			local coords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.vladaStations) do

				for i=1, #v.Cloakrooms, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(21, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					end
				end

				for i=1, #v.ParkirajAuto, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.ParkirajAuto[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(1, v.ParkirajAuto[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerAuto.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ParkirajAuto', i
					end
				end

				for i=1, #v.ParkirajHelikopter, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.ParkirajHelikopter[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(1, v.ParkirajHelikopter[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 2.5, 255, 0, 0, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerHelikopter.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ParkirajHelikopter', i
					end
				end

				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end

				for i=1, #v.Budzenje, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Budzenje[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(6, v.Budzenje[i], 0.0, 0.0, 0.0, -180, 0.0, 0.0, 2.5, 2.5, 2.5, 49, 105, 235, 100, false, true, 2, false, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x and voziloProvera then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Budzenje', i
					end
				end

				for i=1, #v.Helicopters, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					end
				end

				if PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

						if distance < Config.DrawDistance then
							DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false
						end

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(1000)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(2000)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.job and PlayerData.job.name == 'vlada' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu2()
				elseif CurrentAction == 'menu_armory' then
					OpenArmoryMenu2(CurrentActionData.station)
				elseif CurrentAction == 'budzenje' then
					OpenMainMenu2()
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu2('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					Helikopteri2('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				elseif CurrentAction == 'ParkirajAuto' then
					ObrisiVozilo2()
				elseif CurrentAction == 'ParkirajHelikopter' then
					ObrisiVozilo2()
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'vlada', function(data, menu)
						ESX.UI.Menu.CloseAll()
					end, {wash = false})
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())

			currentTask.busy = false
		end
	end
end)

RegisterCommand('+vladameni', function()
	if PlayerData.job and PlayerData.job.name == 'vlada' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'vlada_actions') then
		OpenvladaActionsMenu2()
	end
end)

RegisterKeyMapping('+vladameni', 'vlada Meni', 'keyboard', 'F6')


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('grandsonvolizenenajvise213vladagradonacelnik:unrestrain')
	end
end)

function ImpoundVehicle2(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:forceBlip')
end)

-- Create blips
--[[Citizen.CreateThread(function()

	for k,v in pairs(Config.vladaStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
	
end)--]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('grandsonvolizenenajvise213vladagradonacelnik:forceBlip')
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = PlayerPedId()
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

local shieldActive = false
local shieldEntity = nil
local hadPistol = false