local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentGarage           = nil
local CurrentGarage2           = nil
local PlayerData              = {}
local CurrentAction           = nil
local IsInShopMenu            = false
local pCoords 				  = nil
ESX                           = nil
GUI.Time                      = 0
local otvoreno = false
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

-- Create Blips
Citizen.CreateThread(function()
	for i=1, #Config.Garages do
		if Config.Garages[i].Blip == true then
			local blip = AddBlipForCoord(Config.Garages[i].Marker)
			SetBlipSprite (blip, 357)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.85)
			SetBlipColour (blip, 3)
			SetBlipAsShortRange(blip, true)		
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('garage_blip'))
			EndTextCommandSetBlipName(blip)
		end
	end

end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		pCoords = GetEntityCoords(playerPed)
		Citizen.Wait(400)
	end
end)

local objekat = {}
local impped = {}

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    local isInMarker  = false
    local currentZone = nil
	local playerPed = GetPlayerPed(-1)
	sleep = true
    for i=1, #Config.Garages, 1 do
		if(GetDistanceBetweenCoords(pCoords, Config.Garages[i].Marker, true) < Config.DrawDistance) then
			if Config.Garages[i].Visible[1] == nil then
				if IsPedInAnyVehicle(playerPed) then
					isInMarker  = true
					currentZone = 'park_car'
					CurrentGarage2 = Config.Garages[i].Marker
					CurrentGarage = Config.Garages[i].Marker
				elseif not IsPedInAnyVehicle(playerPed) then
					isInMarker = true
					currentZone = 'pullout_car'
					CurrentGarage2 = Config.Garages[i].PullOut
					CurrentGarage = Config.Garages[i].PullOut
				end
			else
				for j=1, #Config.Garages[i].Visible, 1 do
					if PlayerData.job.name == Config.Garages[i].Visible[j] then
						if IsPedInAnyVehicle(playerPed) then
							isInMarker  = true
							currentZone = 'park_car'
							CurrentGarage2 = 			Config.Garages[i].Marker
							CurrentGarage = Config.Garages[i].Marker
						elseif not IsPedInAnyVehicle(playerPed) then
							isInMarker = true
							currentZone = 'pullout_car'
							CurrentGarage2 = 			Config.Garages[i].Marker
							CurrentGarage = Config.Garages[i].Marker
						end
					end
				end
			end
		end
    end
	for i=1, #Config.Impound, 1 do
		if(GetDistanceBetweenCoords(pCoords, Config.Impound[i].coords, true) < Config.DrawDistance) then
			isInMarker  = true
			currentZone = 'impound_veh'
			CurrentGarage = Config.Impound[i]
		end
    end
    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
		HasAlreadyEnteredMarker = true
		LastZone = currentZone
		TriggerEvent('flux_garages:hasEnteredMarker', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
		HasAlreadyEnteredMarker = false
		TriggerEvent('flux_garages:hasExitedMarker', LastZone)
    end

		Citizen.Wait(1)
		sleep = true
		for i=1, #Config.Garages, 1 do
			if(GetDistanceBetweenCoords(pCoords, Config.Garages[i].Marker, true) < Config.DrawDistance) then
				if Config.Garages[i].Visible[1] == nil then
					sleep = false
					if not DoesEntityExist(objekat[i]) then
						ESX.Game.SpawnLocalObject('prop_parkingpay', Config.Garages[i].Marker, function(obj)
						   objekat[i] = obj
						   FreezeEntityPosition(objekat[i], true)
						   PlaceObjectOnGroundProperly(objekat[i])
						end)
					end
				else
					for j=1, #Config.Garages[i].Visible, 1 do
						if PlayerData.job.name == Config.Garages[i].Visible[j] then
							sleep = false
							if not DoesEntityExist(objekat[i]) then
								ESX.Game.SpawnLocalObject('prop_parkingpay', Config.Garages[i].Marker, function(obj)
								   objekat[i] = obj
								   FreezeEntityPosition(objekat[i], true)
								   PlaceObjectOnGroundProperly(objekat[i])
								end)
							end
						end
					end
				end
			else
				if DoesEntityExist(objekat[i]) then
					ESX.Game.DeleteObject(objekat[i])
				end
			end
		end
		for i=1, #Config.Impound, 1 do
			if(GetDistanceBetweenCoords(pCoords, Config.Impound[i].coords, true) < Config.DrawDistance) then
				sleep = false
				if not DoesEntityExist(impped[i]) then
					impped[i] = exports['hCore']:NapraviPed(GetHashKey('u_m_m_edtoh'), Config.Impound[i].coords, Config.Impound[i].heading)
				end
				if GetDistanceBetweenCoords(pCoords, Config.Impound[i].coords, true) < 5 and DoesEntityExist(impped[i]) then
					  sleep = false
					  exports['hCore']:Draw3DText(Config.Impound[i].coords.x, Config.Impound[i].coords.y,Config.Impound[i].coords.z + 2, "~s~Da bi pristupio impoundu ~o~ALT~s~ na mene")
				end
			else
				--exports.qtarget:RemoveTargetModel('u_m_m_edtoh', {
				--	'Impound'
				-- })
				if DoesEntityExist(impped[i]) then
					DeletePed(impped[i])
				end
			end	
		end

		local playerPed = PlayerPedId()
		pCoords = GetEntityCoords(playerPed)
		if sleep then
			Citizen.Wait(500)
		end
  end
end)

exports.qtarget:AddTargetModel('u_m_m_edtoh', {
	options = {
	  {
		icon = "fas fa-car",
		label = "Impound",
		num = 1,
		action = function(entity)
			SendNUIMessage({
				clearimp = true
			})
			ESX.TriggerServerCallback('flux_garages:getVehiclesToTow', function(vehicles)
				for i=1, #vehicles, 1 do
					SendNUIMessage({
						impcar = true,
						number = i,
						model = vehicles[i].plate,
						name = "<font color=#AAAAAA>" .. vehicles[i].plate .. "</font>&emsp;" ..  GetDisplayNameFromVehicleModel(vehicles[i].model)
					})
				end
			end)
			openGui('Impound')
		end,
	  },
	},
	distance = 2
})
exports.qtarget:AddTargetModel('prop_parkingpay', {
	options = {
	  {
		icon = "fas fa-car",
		label = "Izvuci vozilo",
		num = 1,
		action = function(entity)
			SendNUIMessage({
				clearme = true
			})
			ESX.TriggerServerCallback('flux_garages:getVehiclesInGarage', function(vehicles)
				for i=1, #vehicles, 1 do
					SendNUIMessage({
						addcar = true,
						number = i,
						model = vehicles[i].plate,
						name = "<font color=#AAAAAA>" .. vehicles[i].plate .. "</font>&emsp;" ..  GetDisplayNameFromVehicleModel(vehicles[i].model)
					})
				end
			end)
			openGui('Garaza')
		end,
	  },
	  {
		icon = "fas fa-car",
		label = "Ostavi vozilo",
		num = 2,
		action = function(entity)
			local playerPed = GetPlayerPed(-1)
			local vehicle       = GetVehiclePedIsIn(playerPed)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local name          = GetDisplayNameFromVehicleModel(vehicleProps.model)
			local plate         = vehicleProps.plate
			local health		= GetVehicleEngineHealth(vehicle)
			if health > Config.MinimumHealth then
				ESX.TriggerServerCallback('flux_garages:checkIfVehicleIsOwned', function (owned)
					if owned ~= nil then                    
						TriggerServerEvent("flux_garages:updateOwnedVehicle", vehicleProps)
						TaskLeaveVehicle(playerPed, vehicle, 16)
						ESX.Game.DeleteVehicle(vehicle)
					else
						TriggerEvent("hub_notifikacije:obavestenje", _U('not_owner'), 5000)
					end
				end, vehicleProps.plate)
			else
				TriggerEvent("hub_notifikacije:obavestenje", _U('repair'), 5000)
			end
		end,
	},
	},
	distance = 5
})

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	exports.qtarget:RemoveTargetModel('prop_parkingpay', {
	   'Izvuci vozilo', 'Ostavi vozilo'
	})
	exports.qtarget:RemoveTargetModel('u_m_m_edtoh', {
		'Impound'
	 })
	for i=1, #Config.Garages, 1 do
	  ESX.Game.DeleteObject(objekat[i])
	end
	for i=1, #Config.Impound, 1 do
		DeletePed(impped[i])
	  end
  end)
  

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function SpawnImpoundedVehicle(plate)
	TriggerServerEvent('flux_garages:updateState', plate)
end

function SubownerVehicle()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'subowner_player',
		{
			title = _U('veh_reg'),
			align = 'center'
		},
		function(data, menu)
			local plate = string.upper(tostring(data.value))
			if string.len(plate) < 8 or string.len(plate) > 8 then
				TriggerEvent("hub_notifikacije:obavestenje", _U('no_veh'), 5000)
			else
				ESX.TriggerServerCallback('flux_garages:checkIfPlayerIsOwner', function(isOwner)
					if isOwner then
						menu.close()
						ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'subowner_menu',
							{
								title = _U('owner_menu', plate),
								align = 'center',
								elements	= {
									{label = _U('set_sub'), value = 'give_sub'},
									{label = _U('manage_sub'), value = 'manage_sub'},
								}
							},
							function(data2, menu2)
								if data2.current.value == 'give_sub' then
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer ~= -1 and closestDistance <= 3.0 then
										TriggerServerEvent('flux_garages:setSubowner', plate, GetPlayerServerId(closestPlayer))
									else
										TriggerEvent("hub_notifikacije:obavestenje", _U('no_players'), 5000)
									end
								elseif data2.current.value == 'manage_sub' then
									ESX.TriggerServerCallback('flux_garages:getSubowners', function(subowners)
										if #subowners > 0 then
											ESX.UI.Menu.Open(
												'default', GetCurrentResourceName(), 'subowners',
												{
													title = _U('deleting_sub', plate),
													align = 'center',
													elements = subowners
												},
												function(data3, menu3)
													local subowner = data3.current.value
													ESX.UI.Menu.Open(
														'default', GetCurrentResourceName(), 'yesorno',
														{
															title = _U('sure_delete'),
															align = 'center',
															elements = {
																{label = _U('no'), value = 'no'},
																{label = _U('yes'), value = 'yes'}
															}
														},
														function(data4, menu4)
															if data4.current.value == 'yes' then
																TriggerServerEvent('flux_garages:deleteSubowner', plate, subowner)
																menu4.close()
																menu3.close()
																menu2.close()
															elseif data4.current.value == 'no' then
																menu4.close()
															end
														end,
														function(data4, menu4)
															menu4.close()
														end
													)													
												end,
												function(data3, menu3)
													menu3.close()
												end
											)
										else
											TriggerEvent("hub_notifikacije:obavestenje",_U('no_subs'), 5000)
										end
									end, plate)
								end
							end,
							function(data2,menu2)
								menu2.close()
							end
						)
					else
						TriggerEvent("hub_notifikacije:obavestenje",_U('not_owner'), 5000)
					end
				end, plate)
			end
		end,
		function(data,menu)
			menu.close()
		end
	)
end
-- Key controls
--[[Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1)
		sleep = true
		if CurrentAction ~= nil then
			sleep = false
			if CurrentAction == 'park_car' then
				DisplayHelpText(_U('store_veh'))
			elseif CurrentAction == 'pullout_car' then
				DisplayHelpText(_U('release_veh'))
			elseif CurrentAction == 'tow_menu' then
				DisplayHelpText(_U('tow_veh'))
			end
			if IsControlPressed(0, 38) and otvoreno == true then
				closeGui()
				otvereno = false
				SetNuiFocus(true, true)
			end
			if IsControlPressed(0, 38) and (GetGameTimer() - GUI.Time) > 300 then
				if CurrentAction == 'park_car' then
					local playerPed = GetPlayerPed(-1)
					local vehicle       = GetVehiclePedIsIn(playerPed)
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local name          = GetDisplayNameFromVehicleModel(vehicleProps.model)
					local plate         = vehicleProps.plate
					local health		= GetVehicleEngineHealth(vehicle)
					if health > Config.MinimumHealth then
						ESX.TriggerServerCallback('flux_garages:checkIfVehicleIsOwned', function (owned)
							if owned ~= nil then                    
								TriggerServerEvent("flux_garages:updateOwnedVehicle", vehicleProps)
								TaskLeaveVehicle(playerPed, vehicle, 16)
								ESX.Game.DeleteVehicle(vehicle)
							else
								TriggerEvent("hub_notifikacije:obavestenje", _U('not_owner'), 5000)
							end
						end, vehicleProps.plate)
					else
						TriggerEvent("hub_notifikacije:obavestenje", _U('repair'), 5000)
					end
				elseif CurrentAction == 'pullout_car' then
					SendNUIMessage({
						clearme = true
					})
					ESX.TriggerServerCallback('flux_garages:getVehiclesInGarage', function(vehicles)
						for i=1, #vehicles, 1 do
							SendNUIMessage({
								addcar = true,
								number = i,
								model = vehicles[i].plate,
								name = "<font color=#AAAAAA>" .. vehicles[i].plate .. "</font>&emsp;" ..  GetDisplayNameFromVehicleModel(vehicles[i].model)
							})
						end
					end)
					openGui('Garaza')
				elseif CurrentAction == 'tow_menu' then
					SendNUIMessage({
						clearimp = true
					})
					ESX.TriggerServerCallback('flux_garages:getVehiclesToTow', function(vehicles)
						for i=1, #vehicles, 1 do
							SendNUIMessage({
								impcar = true,
								number = i,
								model = vehicles[i].plate,
								name = "<font color=#AAAAAA>" .. vehicles[i].plate .. "</font>&emsp;" ..  GetDisplayNameFromVehicleModel(vehicles[i].model)
							})
						end
					end)
					openGui('Impound')
				end
				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
		if sleep then
			Citizen.Wait(1500)
		end
	end
end)]]

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
end)

-- Open Gui and Focus NUI
function openGui(garaza)
	SetNuiFocus(true, true)
	SendNUIMessage({openGarage = true, text = garaza})
end

function otovriSamoViditi()
		SetNuiFocus(true, false)
		SendNUIMessage({clearimp = true})
		otvoreno = true
		SendNUIMessage({
			clearimp = true
		})
end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openGarage = false})
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
	closeGui()
	cb('ok')
end)

-- NUI Callback Methods
RegisterNUICallback('pullCar', function(data, cb)
	local playerPed  = GetPlayerPed(-1)
	ESX.TriggerServerCallback('flux_garages:checkIfVehicleIsOwned', function (owned)
		local spawnCoords  = {
			x = CurrentGarage2.x,
			y = CurrentGarage2.y,
			z = CurrentGarage2.z,
	
		}

		ESX.Game.SpawnVehicle(owned.model, spawnCoords, 91.06,function(vehicle)
			ESX.Game.SetVehicleProperties(vehicle, owned)
			local localVehPlate = string.lower(GetVehicleNumberPlateText(vehicle))
			local localVehLockStatus = GetVehicleDoorLockStatus(vehicle)
			TriggerEvent("ls:getOwnedVehicle", vehicle, localVehPlate, localVehLockStatus)
			local networkid = NetworkGetNetworkIdFromEntity(vehicle)
			TriggerServerEvent("flux_garages:removeCarFromParking", owned.plate, networkid)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		end)
	end, data.model)
	closeGui()
	cb('ok')
end)

RegisterNUICallback('towCar', function(data, cb)
	closeGui()
	cb('ok')
	ESX.TriggerServerCallback('flux_garages:towVehicle', function(id)
		if id ~= nil then
			local entity = NetworkGetEntityFromNetworkId(tonumber(id))
			TriggerEvent("hub_notifikacije:obavestenje", _U('checking_veh'), 5000)
			TriggerEvent("hub_savet:posalji", "Sledeci put parkiraj vozilo u garazu, jeftinije je", 5000)
			if entity == 0 then
				ESX.TriggerServerCallback('flux_garages:checkMoney', function(hasMoney)
					if hasMoney then
						TriggerEvent("hub_notifikacije:obavestenje", _U('checking_veh'), 5000)
						TriggerEvent("hub_savet:posalji", "Sledeci put parkiraj vozilo u garazu, jeftinije je", 5000)
						TriggerServerEvent('flux_garages:pay')
						SpawnImpoundedVehicle(data.model)
						TriggerEvent("hub_notifikacije:obavestenje", _U('veh_impounded'), 5000)
					else
						TriggerEvent("hub_notifikacije:obavestenje", _U('no_money'), 5000)
					end
				end)
			elseif entity ~= 0 and (GetVehicleNumberOfPassengers(entity) > 0 or not IsVehicleSeatFree(entity, -1)) then
				TriggerEvent("hub_notifikacije:obavestenje", _U('cant_impound'), 5000)
			else
				ESX.TriggerServerCallback('flux_garages:checkMoney', function(hasMoney)
					if hasMoney then
						TriggerServerEvent('flux_garages:pay')
						SpawnImpoundedVehicle(data.model)
						if entity ~= 0 then
							ESX.Game.DeleteVehicle(entity)
						end
						TriggerEvent("hub_notifikacije:obavestenje", _U('veh_impounded'), 5000)
					else
						TriggerEvent("hub_notifikacije:netacno", _U('no_money'), 5000)
					end
				end)
			end
		else
			ESX.TriggerServerCallback('flux_garages:checkMoney', function(hasMoney)
				if hasMoney then
					TriggerEvent("hub_notifikacije:obavestenje", _U('checking_veh'), 5000)
					TriggerEvent("hub_savet:posalji", "Sledeci put parkiraj vozilo u garazu, jeftinije je", 5000)
					TriggerServerEvent('flux_garages:pay')
					SpawnImpoundedVehicle(data.model)
					TriggerEvent("hub_notifikacije:obavestenje", _U('veh_impounded', data.model), 5000)
				else
					TriggerEvent("hub_notifikacije:netacno", _U('no_money'), 5000)
				end
			end)
		end
	end, data.model)
end)

RegisterNUICallback('impoundCar', function(data, cb)
	closeGui()
	cb('ok')
	local playerPed  = GetPlayerPed(-1)
	ESX.TriggerServerCallback('flux_garages:checkVehProps', function(veh)
		TriggerEvent("hub_notifikacije:obavestenje", _U('checking_veh'), 5000)
		TriggerEvent("hub_savet:posalji", "Sledeci put parkiraj vozilo u garazu, jeftinije je", 5000)
		local spawnCoords  = {
			x = CurrentGarage.coords.x,
			y = CurrentGarage.coords.y,
			z = CurrentGarage.coords.z,
		}
		ESX.Game.SpawnVehicle(veh.model, spawnCoords, GetEntityHeading(playerPed), function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
			ESX.Game.SetVehicleProperties(vehicle, veh)
			local networkid = NetworkGetNetworkIdFromEntity(vehicle)
			TriggerServerEvent("flux_garages:removeCarFromPoliceParking", data.model, networkid)
		end)
	end, data.model)
	
end)

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

AddEventHandler('flux_garages:hasEnteredMarker', function (zone)
	if zone == 'pullout_car' then
		CurrentAction = 'pullout_car'
	elseif zone == 'park_car' then
		CurrentAction = 'park_car'
	elseif zone == 'impound_veh' then
		CurrentAction = 'tow_menu'
	end
end)

AddEventHandler('flux_garages:hasExitedMarker', function (zone)
  if IsInShopMenu then
    IsInShopMenu = false
    CurrentGarage = nil
  end
  if not IsInShopMenu then
	ESX.UI.Menu.CloseAll()
  end
  CurrentAction = nil
end)