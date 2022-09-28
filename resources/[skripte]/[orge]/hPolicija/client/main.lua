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
    if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'deltaforce' then
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
			job = { ['police'] = 4, ['deltaforce'] = 4, ['sheriff'] = 4 },
			action = function(entity)
				if PlayerData.job.name == 'police' then
					exports.ox_inventory:openInventory('stash', 'Sef Policija')
				elseif PlayerData.job.name == 'sheriff' then
					exports.ox_inventory:openInventory('stash', 'Sef Sheriff')
				elseif PlayerData.job.name == 'deltaforce' then
					exports.ox_inventory:openInventory('stash', 'Sef Delta')
				end
			end,
		},
		{
			icon = "fas fa-box",
			label = "Sef 2",
			num = 2,
			job = { ['police'] = 4, ['sheriff'] = 4, ['deltaforce'] = 4 },
			action = function(entity)
				if PlayerData.job.name == 'police' then
					exports.ox_inventory:openInventory('stash', 'Policija Sef')
				elseif PlayerData.job.name == 'sheriff' then
					exports.ox_inventory:openInventory('stash', 'Sheriff Sef')
				elseif PlayerData.job.name == 'deltaforce' then
					exports.ox_inventory:openInventory('stash', 'Deltaforce Sef')
				end
			end,
		},
		{
			icon = "fas fa-box",
			label = "Sef 3",
			num = 3,
			job = { ['police'] = 4, ['sheriff'] = 4, ['deltaforce'] = 4 },
			action = function(entity)
				if PlayerData.job.name == 'police' then
					exports.ox_inventory:openInventory('stash', 'Policija Sef 2')
				elseif PlayerData.job.name == 'sheriff' then
					exports.ox_inventory:openInventory('stash', 'Sheriff Sef 2')
				elseif PlayerData.job.name == 'deltaforce' then
					exports.ox_inventory:openInventory('stash', 'Deltaforce Sef 2')
				end
			end,
		},
		{
			icon = "fas fa-box",
			label = "Sef 4",
			num = 4,
			job = { ['police'] = 4, ['sheriff'] = 4, ['deltaforce'] = 4 },
			action = function(entity)
				if PlayerData.job.name == 'police' then
					exports.ox_inventory:openInventory('stash', 'Policija Sef 3')
				elseif PlayerData.job.name == 'sheriff' then
					exports.ox_inventory:openInventory('stash', 'Sheriff Sef 3')
				elseif PlayerData.job.name == 'deltaforce' then
					exports.ox_inventory:openInventory('stash', 'Deltaforce Sef 3')
				end
			end,
		},
		{
			icon = "fas fa-box",
			label = "Sef 5",
			num = 5,
			job = { ['police'] = 4, ['sheriff'] = 4, ['deltaforce'] = 4 },
			action = function(entity)
				if PlayerData.job.name == 'police' then
					exports.ox_inventory:openInventory('stash', 'Policija Sef 4')
				elseif PlayerData.job.name == 'sheriff' then
					exports.ox_inventory:openInventory('stash', 'Sheriff Sef 4')
				elseif PlayerData.job.name == 'deltaforce' then
					exports.ox_inventory:openInventory('stash', 'Deltaforce Sef 4')
				end
			end,
		},
		{
			icon = "fas fa-box",
			label = "Oruzije",
			num = 6,
			job = { ['police'] = -1, ['deltaforce'] = -1, ['sheriff'] = -1 },
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
							title = 'Metkovi 9mm 64x',
							event = 'davanjeoruzija',
							args = {oruzije = 'ammo-9', kolicina = 64},
						},
						{
							title = 'Pancir',
							event = 'davanjeoruzija',
							args = {oruzije = 'armour', kolicina = 1},
						},
						{
							title = 'M4 Puska',
							event = 'davanjeoruzija',
							args = {oruzije = 'WEAPON_M4', kolicina = 1},
						},
						{
							title = 'Metkovi 5.56 64x',
							event = 'davanjeoruzija',
							args = {oruzije = 'ammo-rifle', kolicina = 64},
						}
					},
				})
				lib.showContext('oruzije_menu')
			end,
		},
	},
	distance = 2
})

RegisterNetEvent('davanjeoruzija', function(data)
	if data.kolicina == nil then
		data.kolicina = 1
	else
		data.kolicina = data.kolicina
	end

    ESX.TriggerServerCallback('esx_policejob:dajoruzije', function() end, data.oruzije, data.kolicina)
end)

exports.qtarget:AddTargetModel(Config.Ped.Vehicle, {
	options = {
		{
			icon = "fas fa-car",
			label = "Izvadi vozilo",
			job = { ['police'] = -1, ['sheriff'] = -1, ['deltaforce'] = -1 },
			num = 1,
			action = function(entity)
				local options2 = {}
				local event = nil
				if PlayerData.job.name == 'police' then
					event = 'dark:izvadivozilo'
				elseif PlayerData.job.name == 'sheriff' then
					event = 'dark:izvadivozilo2'
				elseif PlayerData.job.name == 'deltaforce' then
					event = 'dark:izvadivozilo3'
				end
				for i = 1, #Config.Vozila[PlayerData.job.name] do
					options2[i] = {
						title = Config.Vozila[PlayerData.job.name][i].label,
						event = event,
						args = {
							name = Config.Vozila[PlayerData.job.name][i].carname,
						}
					}
				end

				lib.registerContext({
					id = 'policija:garaza',
					title = 'Policija garaza',
					options = options2
				})
			
				lib.showContext('policija:garaza')
			end,
		},
		{
			icon = "fas fa-car",
			label = "Ostavi vozilo",
			num = 2,
			job = { ['police'] = -1, ['sheriff'] = -1, ['deltaforce'] = -1 },
			action = function(entity)
				ObrisiVozilo()
			end,
		},
		{
			icon = "fas fa-car",
			label = "Popravi vozilo",
			job = { ['police'] = -1, ['sheriff'] = -1, ['deltaforce'] = -1 },
			num = 3,
			action = function(entity)
				Popravi()
			end,
		},
		{
			icon = "fas fa-car",
			label = "Ocisti vozilo",
			num = 4,
			job = { ['police'] = -1, ['sheriff'] = -1, ['deltaforce'] = -1 },
			action = function(entity)
				Ocisti()
			end,
		},
	},
	distance = 3
})

AddEventHandler('dark:izvadivozilo', function (data)
	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
	ESX.Game.SpawnVehicle(data.name, spawnPoint.coords, spawnPoint.heading, function(vehicle)
		TaskWarpPedIntoVehicle(ESX.PlayerData.ped,  vehicle,  -1)
		SetVehicleMaxMods(vehicle)
	end)
	local vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
	SetVehicleDirtLevel(vehicle, 0.0)
end)


exports.qtarget:AddBoxZone("BossMenu3", vector3(470.83, -1004.29, 31.54), 1.0, 2, {
	name="BossMenu3",
	heading= 0.0,
	debugPoly=false,
	minZ = 27.14,
	maxZ = 31.14
	}, {
		options = {
			{
				icon = "fas fa-bars",
				label = "Boss Meni",
				job = {['police'] = 13},
				action = function(entity)
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						ESX.UI.Menu.CloseAll()
					end, {wash = false})
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Presvlacinje3", vector3(474.4, -987.62, 25.73), 0.8, 5, {
	name="Presvlacinje3",
	heading = 270,
	debugPoly=false,
	minZ = 22.93,
	maxZ = 26.93
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Presvlacenje",
				job = {['police'] = -1},
				action = function(entity)
					OpenCloakroomMenu()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Presvlacinje2", vector3(469.81, -987.65, 25.73), 1.4, 5, {
	name="Presvlacinje2",
	heading = 270,
	debugPoly=false,
	minZ = 22.73,
	maxZ = 26.73
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Presvlacenje",
				job = {['police'] = -1},
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
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)
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

function GetAvailableVehicleSpawnPoint(station, part, partNum)
	local spawnPoints = Config.PoliceStations[station][part][partNum].SpawnPoints
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

function FastTravel(coords, heading)
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

function Lift()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'helikopteri_meni',
        {
        	css      = 'saj',
            title    = 'Izaberi Sprat | ✈',
            elements = {
            	{label = '-1 Celije / Garaza | ✈', value = '-1sprat'},
            	{label = '-2 Zaplena | ✈', value = '-2sprat'},
            	{label = '-3 Svlacionica / Garaza | ✈', value = '-3sprat'},
            	{label = '1 Cekaonica / Ulaz | ✈', value = '1sprat'},
            	{label = '2 CaffeBar | ✈', value = '2sprat'},
            	{label = '3 Sala za Sastanke | ✈', value = '3sprat'},
            	{label = '4 Operativni Centar | ✈', value = '4sprat'},
            	{label = '5 Nacelnik | ✈', value = '5sprat'},
            	{label = '6 Heliodrom | ✈', value = '6sprat'},
            }
        },
        function(data, menu)
            if data.current.value == '-1sprat' then
            	ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.01, -850.67, 3.88), 35.56)
		    elseif data.current.value == '-2sprat' then
		    	ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1066.01, -833.79, 10.04), 35.56)
			elseif data.current.value == '-3sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.12, -850.42, 12.69), 35.56)
			elseif data.current.value == '1sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1066.0, -833.81, 18.04), 35.56)
            elseif data.current.value == '2sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.03, -850.55, 22.09), 35.56)
            elseif data.current.value == '3sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.0, -850.42, 25.90), 35.56)
            elseif data.current.value == '4sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.13, -850.29, 29.83), 35.56)
            elseif data.current.value == '5sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.09, -850.41, 33.42), 35.56)
            elseif data.current.value == '6sprat' then
				ESX.UI.Menu.CloseAll()
                FastTravel(vector3(-1096.08, -850.41, 37.30), 35.56)
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end


function Helikopteri(type, station, part, partNum)
    ESX.UI.Menu.CloseAll()

	local playerPed = GetPlayerPed(-1)

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'helikopteri_meni',
        {
        	css      = 'policija',
            title    = 'Izaberi Helikopter | 🚁',
            elements = {
            	{label = 'Helikopter za kopno | 🚁', value = 'polmav'},
            	{label = 'Helikopter za vodu | 🚁', value = 'seasparrow' }
            }
        },
        function(data, menu)
            if data.current.value == 'polmav' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)
				ESX.Game.SpawnVehicle("polmav", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(0)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
                exports["balkankings_gorivo"]:SetFuel(vehicle, 100)

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'seasparrow' then
            	local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)
				ESX.Game.SpawnVehicle("seasparrow", spawnPoint.coords, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					SetVehicleMaxMods(vehicle)
				end)
				Wait(0)
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDirtLevel(vehicle, 0.0)
                exports["balkankings_gorivo"]:SetFuel(vehicle, 100)

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

RegisterNetEvent("balkankings_policija:znackaAnim")
AddEventHandler("balkankings_policija:znackaAnim", function()

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

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		css      = 'policija',
		title    = 'Policijski Meni | 👮',
		align    = 'top-left',
		elements = {	
			--{label = "Dosije", value = "dosije"},													
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			{label = _U('object_spawner'), value = 'object_spawner'}
	}}, function(data, menu)

		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('search'), value = 'pretrazi'},
				{label = 'Značka | 📛', value = 'znacka'},
				{label = 'Zaveži | ⛓️', value = 'zavezi'},
				{label = 'Odveži | ⛓️', value = 'odvezi'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
				{label = _U('fine'), value = 'fine'},
				{label = ('Zatvor | 🔒'), value = 'jail_menu'},
				{label = _U('unpaid_bills'), value = 'unpaid_bills'}
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				css      = 'policija',
				title    = _U('citizen_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'pretrazi' then
						TriggerEvent('pretrazivanje')
					elseif action == 'znacka' then
						TriggerServerEvent('balkankings_policija:znacka', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
					elseif data2.current.value == 'zavezi' then
                    	local igrac, distance = ESX.Game.GetClosestPlayer()
						igracHeading = GetEntityHeading(GetPlayerPed(-1))
						igracLokacija = GetEntityForwardVector(PlayerPedId())
						igracKoordinate = GetEntityCoords(GetPlayerPed(-1))
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'cuff', 1.0)
						TriggerServerEvent('esx_policejob:requestarrest', GetPlayerServerId(igrac), igracHeading, igracKoordinate, igracLokacija)
				    elseif action == 'odvezi' then
				    	local igrac, distance = ESX.Game.GetClosestPlayer()
						igracHeading = GetEntityHeading(GetPlayerPed(-1))
						igracLokacija = GetEntityForwardVector(PlayerPedId())
						igracKoordinate = GetEntityCoords(GetPlayerPed(-1))
						TriggerServerEvent('esx_policejob:requestrelease', GetPlayerServerId(igrac), igracHeading, igracKoordinate, igracLokacija)
						Citizen.Wait(1200)
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'uncuff', 0.5)
					elseif action == 'drag' then
                    	TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
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
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'jail_menu' then
						TriggerEvent("bloodlife_zatvor:openJailMenu")
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
				css      = 'policija',
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
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

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
				css      = 'policija',
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					--{label = _U('box'), model = 'prop_boxpile_07d'},
					--{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
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
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
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
			css      = 'policija',
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		css      = 'policija',
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			css      = 'policija',
			title    = _U('fine'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:posaljikaznu', GetPlayerServerId(player), 'society_police', _U('fine_total', data.current.fineLabel), data.current.amount)
				TriggerServerEvent('esx:kazna', GetPlayerServerId(player))
			else
				TriggerServerEvent('esx_billing:posaljikaznu', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
				TriggerServerEvent('esx:kazna', GetPlayerServerId(player))
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end



function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
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

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			css      = 'policija',
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			css      = 'policija',
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
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

			ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
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

		ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css      = 'policija',
			title    = _U('police_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

					Citizen.Wait(0)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
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
			css      = 'policija',
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

					Citizen.Wait(0)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
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

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'ParkirajHelikopter'
			CurrentActionData = { vehicle = vehicle }
		end	
	end
end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
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

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
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


RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
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

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
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
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
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

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
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

RegisterNetEvent('esx_policejob:getarrested')
AddEventHandler('esx_policejob:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	IsShackles = false
	TriggerEvent('esx_policejob:handcuff')
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)


RegisterNetEvent('esx_policejob:doarrested')
AddEventHandler('esx_policejob:doarrested', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 


RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	IsShackles = false
	TriggerEvent('esx_policejob:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)


RegisterNetEvent('esx_policejob:loose')
AddEventHandler('esx_policejob:loose', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = true
	IsShackles = false
	TriggerEvent('esx_policejob:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
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
-- Create blips
Citizen.CreateThread(function()


	for k,v in pairs(Config.PoliceStations) do
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
end)

local oruzarnicaped = {}
local vozilaped = {}

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'police' then

			local playerPed = PlayerPedId()
			local voziloProvera = IsPedInAnyVehicle(playerPed, true)
			local coords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do

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
			if PlayerData.job and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then
				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i].coords, true)

					if distance < Config.DrawDistance then
						if(not DoesEntityExist(oruzarnicaped[i])) then
							letSleep = false
							oruzarnicaped[i] = exports['hCore']:NapraviPed(GetHashKey(Config.Ped.Oruzarnica), v.Armories[i].coords, v.Armories[i].heading)
						end
						--if distance < 5 and DoesEntityExist(oruzarnicaped[i]) then
						--	letSleep = false
						--	exports['hCore']:Draw3DText(v.Armories[i].coords.x, v.Armories[i].coords.y, v.Armories[i].coords.z + 2, "~s~Da bi pristupio oruzarnici drzi ~o~ALT~s~ na mene")
						--end
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

					if distance < Config.DrawDistance then
						DrawMarker(1, v.ParkirajHelikopter[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 2.5, 255, 0, 0, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerHelikopter.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'ParkirajHelikopter', i
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
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
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
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)


--[[RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()

	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	blipsCops = {}

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
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
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(0)
--
--		if CurrentAction then
--			ESX.ShowHelpNotification(CurrentActionMsg)
--
--			if IsControlJustReleased(0, 38) and PlayerData.job and PlayerData.job.name == 'police' then
--
--				if CurrentAction == 'menu_cloakroom' then
--					OpenCloakroomMenu()
--				elseif CurrentAction == 'budzenje' then
--					OpenMainMenu()
--				elseif CurrentAction == 'lift' then
--					Lift()
--				elseif CurrentAction == 'menu_vehicle_spawner' then
--					OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
--				elseif CurrentAction == 'Helicopters' then
--					Helikopteri('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
--				elseif CurrentAction == 'ParkirajAuto' then
--					ObrisiVozilo()
--				elseif CurrentAction == 'ParkirajHelikopter' then
--					ObrisiVozilo()
--				elseif CurrentAction == 'menu_boss_actions' then
--					ESX.UI.Menu.CloseAll()
--					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
--						menu.close()
--
--						CurrentAction     = 'menu_boss_actions'
--						CurrentActionMsg  = _U('open_bossmenu')
--						CurrentActionData = {}
--					end, { wash = true })
--				elseif CurrentAction == 'remove_entity' then
--					DeleteEntity(CurrentActionData.entity)
--				end
--
--				CurrentAction = nil
--			end
--		end -- CurrentAction end
--
--		if IsControlJustReleased(0, 167) and PlayerData.job and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
--			OpenPoliceActionsMenu()
--		end
--
--		if IsControlJustReleased(0, 38) and currentTask.busy then
--			ESX.ShowNotification(_U('impound_canceled'))
--			ESX.ClearTimeout(currentTask.task)
--			ClearPedTasks(PlayerPedId())
--
--			currentTask.busy = false
--		end
--	end
--end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		for k,v in pairs(Config.PoliceStations) do
			for i=1, #v.Armories, 1 do
				DeletePed(oruzarnicaped[i])
			end
			for i=1, #v.Vehicles, 1 do
				DeletePed(vozilaped[i])
			end
		end
	end
end)

function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end

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

RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job and PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' or players[i].job.name == 'saj'  then
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
				if players[i].job.name == 'saj' or players[i].job.name == 'police'  then
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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

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


