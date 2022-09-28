local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	   Citizen.Wait(200)
	end
end)

local Active = false
local test = nil
local test1 = nil
local spam = true

local isDead = false


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)	

RegisterNetEvent('dark:npc:pozovi')
AddEventHandler('dark:npc:pozovi', function ()
	ESX.TriggerServerCallback('dark:doktro:proverinovac', function(imali) 
		if imali then
			if isDead then
				SpawnVehicle(GetEntityCoords(PlayerPedId()))
				exports['hNotifikacije']:Notifikacije('Bolnicar dolazi po tebe da te izleci', 1)
			else	
				exports['hNotifikacije']:Notifikacije('Nisi mrtav', 2)
			end
		else
			exports['hNotifikacije']:Notifikacije('Nemas dovoljno novca', 2)
		end
	end)
end)

function SpawnVehicle(loc)  
	spam = false                                                
	RequestModel('s_m_m_doctor_01')
	while not HasModelLoaded('s_m_m_doctor_01') do
		Wait(1)
	end
	local spawnRadius = 100                                                
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(loc.x + math.random(-spawnRadius, spawnRadius), loc.y + math.random(-spawnRadius, spawnRadius), loc.z, 0, 3, 0)

	if not DoesEntityExist(mechVeh) then
		mechPed = CreatePed(26, GetHashKey('s_m_m_doctor_01'), spawnPos + vec3(0,0,2), false, false)    
		SetEntityInvincible(mechPed, true)
		ESX.Game.SpawnLocalVehicle('ambulance', spawnPos, spawnHeading, function(vehicle)
			print(spawnPos)
			mechVeh = vehicle
			TaskWarpPedIntoVehicle(mechPed, mechVeh, -1)          
			ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);  
			SetVehicleOnGroundProperly(mechVeh)
			SetVehicleNumberPlateText(mechVeh, "HITNA")
			SetEntityAsMissionEntity(mechVeh, true, true)
			SetVehicleEngineOn(mechVeh, true, true, false)
		end)	
        
        mechBlip = AddBlipForEntity(mechVeh)                                                        	
        SetBlipFlashes(mechBlip, true)  
        SetBlipColour(mechBlip, 5)


		PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
		Wait(2000)
		TaskVehicleDriveToCoord(mechPed, mechVeh, loc.x, loc.y, loc.z, 20.0, 0, GetEntityModel(mechVeh), 524863, 2.0)
		test = mechVeh
		test1 = mechPed
		Active = true
    end
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)
        if Active then
            local loc = GetEntityCoords(GetPlayerPed(-1))
			local lc = GetEntityCoords(test)
			local ld = GetEntityCoords(test1)
            local dist = Vdist(loc.x, loc.y, loc.z, lc.x, lc.y, lc.z)
			local dist1 = Vdist(loc.x, loc.y, loc.z, ld.x, ld.y, ld.z)
            if dist <= 10 then
				if Active then
					TaskGoToCoordAnyMeans(test1, loc.x, loc.y, loc.z, 1.0, 0, 0, 786603, 0xbf800000)
				end
				if dist1 <= 1 then 
					Active = false
					ClearPedTasksImmediately(test1)
					DoctorNPC()
				end
            end
        end
    end
end)


function DoctorNPC()
	RequestAnimDict("mini@cpr@char_a@cpr_str")
	while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
		Citizen.Wait(1000)
	end

	TaskPlayAnim(test1, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
	if lib.progressCircle({
		duration = Config.ReviveTime,
		position = 'bottom',
		useWhileDead = true,
	}) then 
		ClearPedTasks(test1)
		Citizen.Wait(500)
		TriggerEvent('esx_ambulancejob:revive')
		StopScreenEffect('DeathFailOut')
		exports['hNotifikacije']:Notifikacije('Ovo ce te kostati ' .. Config.Price .. '$', 1)
		RemovePedElegantly(test1)
		DeleteEntity(test)
		DeletePed(test1)
		spam = true
		ESX.TriggerServerCallback('dark:doktro:remove', function()  end)
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	DeletePed(test1)
	DeleteEntity(test)
  end)