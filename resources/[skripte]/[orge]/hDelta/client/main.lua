local PlayerData, CurrentActionData, handcuffTimer, DragStatus, currentTask, blipsCops = {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isHandcuffed = false, false
local blipsCops = {}
local hasAlreadyJoined = {}
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
DragStatus.draganim = false
DragStatus.IsDragged = false
ESX = nil

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

function setUniform(job, playerPed)
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
	
function ObrisiVozilo()
    if PlayerData.job and PlayerData.job.name == 'deltaforce' then
		ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
		ESX.ShowNotification("Uspešno ste parkirali ~b~vozilo~s~ u garažu.")
    else
    	ESX.ShowNotification("Potreban vam je posao ~b~policajac~s~ da biste vratili vozilo.")
    end
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		{label = 'Pancir | 🛡️', value = 'pancir'}
	}
    
    if PlayerData.job.grade_name == 'policajac' then
        table.insert(elements, {label = 'Policijska Uniforma | 👮', value = 'saobracajac' })
	elseif PlayerData.job.grade_name == 'oficir' then
    	table.insert(elements, { label = 'Policijska Uniforma | 👮', value = 'oficir' })
	elseif PlayerData.job.grade_name == 'narednik' or PlayerData.job.grade_name == 'porucnik' then
    	table.insert(elements, { label = 'Policijska Uniforma | 👮', value = 'inspektor' })
	elseif PlayerData.job.grade_name == 'inspektor' or PlayerData.job.grade_name == 'interventa' then
    	table.insert(elements, { label = 'Policijska Uniforma | 👮', value = 'interventa' })
	elseif PlayerData.job.grade_name == 'kobra' then
    	table.insert(elements, { label = 'Policijska Uniforma | 👮', value = 'narednik' })
	elseif PlayerData.job.grade_name == 'zamenik' or PlayerData.job.grade_name == 'boss' then
    	table.insert(elements, { label = 'Policijska Uniforma | 👮', value = 'nacelnik' })
    end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		css      = 'policija',
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
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
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		if data.current.value == 'pancir' then
      		local ped = GetPlayerPed(PlayerId())
      		SetPedArmour(
				ped, 
				100
			)
      	end

		if
			data.current.value == 'saobracajac' or
			data.current.value == 'oficir' or
			data.current.value == 'inspektor' or
			data.current.value == 'interventa' or
			data.current.value == 'nacelnik' or
			data.current.value == 'narednik' or
			data.current.value == 'gilet_wear'
		then
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
          		setUniform(data.current.value, playerPed)
        	end)
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

		--CurrentAction     = 'menu_cloakroom'
		--CurrentActionMsg  = _U('open_cloackroom')
		--CurrentActionData = {}
	end)
end

exports.qtarget:AddTargetModel(Config.Ped.Oruzarnica, {
	options = {
		{
			icon = "fas fa-box",
			label = "Sef",
			num = 1,
			job = {['deltaforce'] = -1},
			action = function(entity)
				exports.ox_inventory:openInventory('stash', 'Sef Delta')
			end,
		},
		{
			icon = "fas fa-box",
			label = "Oruzije",
			num = 2,
			job = {['deltaforce'] = -1},
			action = function(entity)
				lib.registerContext({
					id = 'oruzije_menu',
					title = 'Oruzije',
					options = {
						{
							title = 'Taser',
							event = 'davanjeoruzija',
							args = {oruzije = 'WEAPON_STUNGUN'},
						},
						{
							title = 'Glock',
							event = 'davanjeoruzija',
							args = {oruzije = 'WEAPON_GLOCK'},
						},
						{
							title = 'Metkovi 9mm 16x',
							event = 'davanjeoruzija',
							args = {oruzije = 'ammo-9', kolicina = 16},
						}
					},
				})
				lib.showContext('oruzije_menu')
			end,
		},
	},
	distance = 2
})

RegisterNetEvent('davanjeoruzija3', function(data)
	if data.kolicina == nil then
		data.kolicina = 1
	else
		data.kolicina = data.kolicina
	end

    ESX.TriggerServerCallback('esx_deltaforcejob:dajoruzije', function() end, data.oruzije, data.kolicina)
end)

--exports.qtarget:AddTargetModel(Config.Ped.Vehicle, {
--	options = {
--		{
--			icon = "fas fa-car",
--			label = "Izvadi vozilo",
--			job = {['deltaforce'] = -1},
--			num = 1,
--			action = function(entity)
--				local options2 = {}
--
--				for i = 1, #Config.Vozila do
--					options2[i] = {
--						title = Config.Vozila[i].label,
--						event = 'dark:izvadivozilo3',
--						args = {
--							name = Config.Vozila[i].carname,
--						}
--					}
--				end
--
--				lib.registerContext({
--					id = 'policija:garaza',
--					title = 'Policija garaza',
--					options = options2
--				})
--			
--				lib.showContext('policija:garaza')
--			end,
--		},
--		{
--			icon = "fas fa-car",
--			label = "Ostavi vozilo",
--			num = 2,
--			job = {['deltaforce'] = -1},
--			action = function(entity)
--				ObrisiVozilo()
--			end,
--		},
--		{
--			icon = "fas fa-car",
--			label = "Popravi vozilo",
--			job = {['deltaforce'] = -1},
--			num = 3,
--			action = function(entity)
--				Popravi()
--			end,
--		},
--		{
--			icon = "fas fa-car",
--			label = "Ocisti vozilo",
--			num = 4,
--			job = {['deltaforce'] = -1},
--			action = function(entity)
--				Ocisti()
--			end,
--		},
--	},
--	distance = 3
--})

AddEventHandler('dark:izvadivozilo3', function (data)
	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint3(CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
	ESX.Game.SpawnVehicle(data.name, spawnPoint.coords, spawnPoint.heading, function(vehicle)
		TaskWarpPedIntoVehicle(ESX.PlayerData.ped,  vehicle,  -1)
		SetVehicleMaxMods(vehicle)
	end)
	local vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
	SetVehicleDirtLevel(vehicle, 0.0)
end)


exports.qtarget:AddBoxZone("das", vector3(1862.05, 3690.51, 34.27), 2.2, 1, {
	name = "das",
	heading = 300,
	--debugPoly = true,
	minZ = 31.27,
	maxZ = 35.27
	}, {
		options = {
			{
				icon = "fas fa-bars",
				label = "Boss Meni",
				job = {['deltaforce'] = 4},
				action = function(entity)
					TriggerEvent('esx_society:openBossMenu', 'deltaforce', function(data, menu)
						ESX.UI.Menu.CloseAll()
					end, {wash = false})
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Presvlacinje2", vector3(2523.13, -332.54, 94.09), 3.2, 1, {
	name = "Presvlacinje2",
	heading = 315,
	--debugPoly = true,
	minZ = 93.09,
	maxZ = 95.69
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Presvlacenje",
				job = {['deltaforce'] = -1},
				action = function(entity)
					OpenCloakroomMenu()
				end,
			},
		},
		distance = 3.5
})

-- BUDŽENJE

function Popravi()
    local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(PlayerPedId()) then
		FreezeEntityPosition(veh, true)
		if lib.progressCircle({
			duration = 2000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
		}) then
			FreezeEntityPosition(veh, false)
			SetVehicleFixed(veh) 
			exports['hNotifikacije']:Notifikacije('Uspesno si popravio vozilo', 3)
		else
			FreezeEntityPosition(veh, false) 
			exports['hNotifikacije']:Notifikacije('Prekinuo si popravku vozila', 2)
		end
	else
		exports['hNotifikacije']:Notifikacije('Nisi u vozilu', 2)
	end
end

function Ocisti()
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(PlayerPedId()) then
		FreezeEntityPosition(veh, true)
		if lib.progressCircle({
			duration = 2000,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
		}) then
			SetVehicleDirtLevel(veh, 0.0)
			FreezeEntityPosition(veh, false)
			exports['hNotifikacije']:Notifikacije('Uspesno si ocistio vozilo', 3)
		else
			FreezeEntityPosition(veh, false) 
			exports['hNotifikacije']:Notifikacije('Prekinuo si ciscenje vozila', 2)
		end
	else
		exports['hNotifikacije']:Notifikacije('Nisi u vozilu', 2)
	end
end

function OpenExtraMenu()
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

function OpenLiveryMenu()
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

function OpenMainMenu()
	local elements = {
		{label = 'Glavna Boja | 🎨', value = 'primary'},
		{label = 'Sporedna Boja | 🎨', value = 'secondary'},
		{label = 'Dodaci | ⚙️',value = 'extra'},
		{label = 'Stilovi | 😎',value = 'livery'},
		{label = 'Popravljanje | ‍🔧',value = 'popravi'},
		{label = 'Čiščenje | 🧹',value = 'ocisti'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = 'Budženje | ⚙️',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'extra' then
			OpenExtraMenu()
		elseif data.current.value == 'livery' then
			OpenLiveryMenu()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu('secondary')
		elseif data.current.value == 'popravi' then
			Popravi()
		elseif data.current.value == 'ocisti' then
			Ocisti()
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

-- Police Color Main Menu:
function OpenMainColorMenu(colortype)
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
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenColorMenu(type, value, colortype)
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

--

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


function OpenVehicleSpawnerMenu(type, station, part, partNum)
	local elements = {}

	if PlayerData.job.grade_name == 'pocetnik' then
	    table.insert(elements, {label = 'Patrola Blista | 🚓', value = 'blista'})
	end

    if PlayerData.job.grade_name == 'officer1' or PlayerData.job.grade_name == 'officer2' or PlayerData.job.grade_name == 'officer3' then
		table.insert(elements, {label = 'Patrola Blista | 🚓', value = 'blista'})
    end

    if PlayerData.job.grade_name == 'detective' or PlayerData.job.grade_name == 'sdetective' or PlayerData.job.grade_name == 'ldetective' then   	
	    table.insert(elements, {label = 'Patrola Dodge | 🚓', value = 'blista'})
    end

    if PlayerData.job.grade_name == 'sergeant' or PlayerData.job.grade_name == 'sfc' then
	    table.insert(elements, {label = 'Patrola Dodge | 🚓', value = 'blista'})
    end

    if PlayerData.job.grade_name == 'lieutenant' or PlayerData.job.grade_name == 'captain' or PlayerData.job.grade_name == 'commander' then
	    table.insert(elements, {label = 'Patrola Dodge | 🚓', value = 'blista'})
    end

	if PlayerData.job.grade_name == 'zamenik' or PlayerData.job.grade_name == 'boss' then
	    table.insert(elements, {label = 'Patrola Dodge | 🚓', value = 'blista'})
    end

	local playerPed = GetPlayerPed(-1)

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vozila_meni',
        {
        	css      = 'policija',
            title    = 'Izaberi Vozilo | 🚓',
            elements = elements
        },
        function(data, menu)

            if data.current.value == 'blista' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint3(station, part, partNum)
				ESX.Game.SpawnVehicle("blista", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(0)
				local playerPed = GetPlayerPed(-1)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)

				ESX.UI.Menu.CloseAll()


            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function GetAvailableVehicleSpawnPoint3(station, part, partNum)
	local spawnPoints = Config.deltaforceStations[station][part][partNum].SpawnPoints
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

function Helikopteri()
	ESX.Game.SpawnVehicle("polmav", vector3(2482.268, -450.335, 92.992), 41.16, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
		SetVehicleMaxMods(vehicle)
	end)
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	SetVehicleDirtLevel(vehicle, 0.0)

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_deltaforcejob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_deltaforce'),
		number     = 'deltaforce',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx_deltaforcejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionData = {}
	--[[elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}--]]
	elseif part == 'Budzenje' then
		CurrentAction     = 'budzenje'
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionData = {}
	elseif part == 'ParkirajAuto' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'ParkirajAuto'
			CurrentActionData = { vehicle = vehicle }
		end
	elseif part == 'ParkirajHelikopter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		CurrentAction     = 'ParkirajHelikopter'
		CurrentActionData = { vehicle = vehicle }
	end
end)

AddEventHandler('esx_deltaforcejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_deltaforcejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'deltaforce' and IsPedOnFoot(playerPed) then
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

AddEventHandler('esx_deltaforcejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

local oruzarnicaped = {}
local vozilaped = {}

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'deltaforce' then

			local playerPed = PlayerPedId()
			local voziloProvera = IsPedInAnyVehicle(playerPed, true)
			local coords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.deltaforceStations) do

				--for i=1, #v.Cloakrooms, 1 do
				--	local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

				--	if distance < Config.DrawDistance then
				--		DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				--		letSleep = false
				--	end

				--	if distance < Config.MarkerSize.x then
				--		isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
				--	end
				--end
			if PlayerData.job and PlayerData.job.name == 'deltaforce' and PlayerData.job.grade_name == 'boss' then
				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i].coords, true)

					if distance < Config.DrawDistance then
						if(not DoesEntityExist(oruzarnicaped[i])) then
							letSleep = false
							oruzarnicaped[i] = exports['hCore']:NapraviPed(GetHashKey(Config.Ped.Oruzarnica), v.Armories[i].coords, v.Armories[i].heading)
						end
						if distance < 5 and DoesEntityExist(oruzarnicaped[i]) then
							letSleep = false
							exports['hCore']:Draw3DText(v.Armories[i].coords.x, v.Armories[i].coords.y, v.Armories[i].coords.z + 2, "~s~Da bi pristupio oruzarnici drzi ~o~ALT~s~ na mene")
						end
					else
						if DoesEntityExist(oruzarnicaped[i]) then
							DeletePed(oruzarnicaped[i])
						end
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					end
				end
			end
				--for i=1, #v.ParkirajAuto, 1 do
				--	local distance = GetDistanceBetweenCoords(coords, v.ParkirajAuto[i], true)
--
				--	if distance < Config.DrawDistance then
				--		DrawMarker(1, v.ParkirajAuto[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
				--		letSleep = false
				--	end
--
				--	if distance < Config.MarkerAuto.x then
				--		isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ParkirajAuto', i
				--	end
				--end
				for i=1, #v.ParkirajHelikopter, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.ParkirajHelikopter[i], true)

					if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
						if distance < Config.DrawDistance  then
							DrawMarker(1, v.ParkirajHelikopter[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 2.5, 255, 0, 0, 100, false, true, 2, true, false, false, false)
							letSleep = false
						end

						if distance < 10.0 then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ParkirajHelikopter', i
						end
					end
				end
				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.coords, true)

					if distance < Config.DrawDistance then
						if(not DoesEntityExist(vozilaped[i])) then
							letSleep = false
							vozilaped[i] = exports['hCore']:NapraviPed(GetHashKey(Config.Ped.Vehicle), v.Vehicles[i].Spawner.coords, v.Vehicles[i].Spawner.heading)
						end
					else
						if DoesEntityExist(vozilaped[i]) then
							DeletePed(vozilaped[i])
						end
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end

				--for i=1, #v.Budzenje, 1 do
				--	local distance = GetDistanceBetweenCoords(coords, v.Budzenje[i], true)
--
				--	if distance < Config.DrawDistance then
				--		DrawMarker(6, v.Budzenje[i], 0.0, 0.0, 0.0, -180, 0.0, 0.0, 2.5, 2.5, 2.5, 49, 105, 235, 100, false, true, 2, false, false, false, false)
				--		letSleep = false
				--	end
--
				--	if distance < Config.MarkerSize.x and voziloProvera then
				--		isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Budzenje', i
				--	end
				--end

				--for i=1, #v.Lift, 1 do
				--	local distance = GetDistanceBetweenCoords(coords, v.Lift[i], true)

				--	if distance < 5 then -- 3
				--		DrawMarker(6, v.Lift[i], 0.0, 0.0, 0.0, -180, 0.0, 0.0, 2.5, 2.5, 2.5, 49, 105, 235, 100, false, true, 2, false, false, false, false)
				--		letSleep = false
				--	end

				--	if distance < 1.5 then
				--		isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Lift', i
				--	end
				--end

				for i=1, #v.Helicopters, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					end
				end

				--if PlayerData.job.grade_name == 'boss' then
				--	for i=1, #v.BossActions, 1 do
				--		local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

				--		if distance < Config.DrawDistance then
				--			DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				--			letSleep = false
				--		end

				--		if distance < Config.MarkerSize.x then
				--			isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
				--		end
				--	end
				--end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_deltaforcejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_deltaforcejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_deltaforcejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent('esx_deltaforcejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_deltaforcejob:spawned')
	end
	hasAlreadyJoined = true
end)


--[[RegisterNetEvent('esx_deltaforcejob:updateBlip')
AddEventHandler('esx_deltaforcejob:updateBlip', function()

	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	blipsCops = {}

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'deltaforce' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'deltaforce' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'taxi' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'mechanic' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end
end)
--]]

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.job and PlayerData.job.name == 'deltaforce' then

				--if CurrentAction == 'menu_cloakroom' then
				--	OpenCloakroomMenu()
				--elseif CurrentAction == 'budzenje' then
				--	OpenMainMenu()
				--elseif CurrentAction == 'lift' then
				--	Lift()
				--elseif CurrentAction == 'menu_vehicle_spawner' then
				--	OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				if CurrentAction == 'Helicopters' then
					Helikopteri()
				--elseif CurrentAction == 'ParkirajAuto' then
				--	ObrisiVozilo()
				elseif CurrentAction == 'ParkirajHelikopter' then
					ObrisiVozilo()
				--elseif CurrentAction == 'menu_boss_actions' then
				--	ESX.UI.Menu.CloseAll()
				--	TriggerEvent('esx_society:openBossMenu', 'deltaforce', function(data, menu)
				--		menu.close()
--
				--		CurrentAction     = 'menu_boss_actions'
				--		CurrentActionMsg  = _U('open_bossmenu')
				--		CurrentActionData = {}
				--	end, { wash = true })
				--elseif CurrentAction == 'remove_entity' then
				--	DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		--if IsControlJustReleased(0, 167) and PlayerData.job and PlayerData.job.name == 'deltaforce' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'deltaforce_actions') then
		--	OpendeltaforceActionsMenu()
		--end

		--if IsControlJustReleased(0, 38) and currentTask.busy then
		--	ESX.ShowNotification(_U('impound_canceled'))
		--	ESX.ClearTimeout(currentTask.task)
		--	ClearPedTasks(PlayerPedId())

		--	currentTask.busy = false
		--end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(Config.deltaforceStations) do
			for i=1, #v.Armories, 1 do
				DeletePed(oruzarnicaped[i])
			end
			for i=1, #v.Vehicles, 1 do
				DeletePed(vozilaped[i])
			end
		end
	end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
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

RegisterNetEvent('esx_deltaforcejob:updateBlip')
AddEventHandler('esx_deltaforcejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job and PlayerData.job.name == 'deltaforce' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'deltaforce'  then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if PlayerData.job and PlayerData.job.name == 'saj' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'saj' or players[i].job.name == 'deltaforce'  then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end




	if PlayerData.job and PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if PlayerData.job and PlayerData.job.name == 'mechanic' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'mechanic' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

	if PlayerData.job and PlayerData.job.name == 'taxi' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'taxi' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end
	if PlayerData.job and PlayerData.job.name == 'vlada' and PlayerData.job.grade == 5  then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
			end
		end)
	end

end)

-- Lecenje

-- Create Blips here if you want
--[[Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2433.91, 4965.50, 42.00)

    SetBlipSprite (blip, 357)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 59)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Grandmas House")
    EndTextCommandSetBlipName(blip)
    
end)]]--

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end
local coords = { x = 480.7718, y = -997.827, z = 33.717, h = 312.09 }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(coords.x, coords.y, coords.z) - plyCoords)
		spavanje = true

        if distance < 3 then
			spavanje = false
		    Draw3DText(coords.x, coords.y, coords.z + 0.5, '[E] - da se izlecis')
            if IsControlJustReleased(0, 38) then
				TriggerEvent('esx_ambulancejob:revive')
            end
        end
		if spavanje == true then Citizen.Wait(1500) end
	end
end)


