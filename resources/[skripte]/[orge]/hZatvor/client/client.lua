local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

PlayerData = {}

local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	if jailTime == 0 then
 
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(10000)
	FreezeEntityPosition(GetPlayerPed(-1), false)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then
			
 
			jailTime = newJailTime

			JailLogin()
		end
	end)

end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	Cutscene()
	SendNUIMessage({action = 'vremeujail', value = jailTime})
end)

RegisterNetEvent("esx-qalle-jail:zatvoriprekomenija")
AddEventHandler("esx-qalle-jail:zatvoriprekomenija", function(newJailTime)
	jailTime = newJailTime
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	ZatvorPrekoMenija()
	SendNUIMessage({action = 'vremeujail', value = jailTime})
end)
RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0
	SendNUIMessage({
		type = "ui",
		status = false,
	})
	UnJail()
end)

function JailLogin()
	local JailPosition = Zconfig.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	InJail()
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Zconfig.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	TriggerServerEvent("skini")
	exports['hNotifikacije']:Notifikacije('Slobodan si', 3)
end

function InJail()

	--Jail Timer--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			local distance = #(GetEntityCoords(PlayerPedId()) -  vector3(1757.338, 2490.132, 45.844))
		
			ESX.TriggerServerCallback("esx-qalle-jail:getajDali", function(dali)
	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail and dali  then
			if distance > 30  then
				SetEntityCoords(PlayerPedId(), 1757.338, 2490.132, 45.844, false, false, false, true)
				exports['hNotifikacije']:Notifikacije('Ne mozes pobeci iz zatvora"', 3)
			end
		end
	end)
	end)
	
			jailTime = jailTime - 1

			vreme = jailTime + 1

			display = true
			SetNuiFocus(false, false)
			SendNUIMessage({
				type = "ui",
				status = true,
			})
			src = source
					SendNUIMessage({action = 'vremeujail', value = jailTime + 1})
					SendNUIMessage({action = 'rpime', value = GetPlayerName(PlayerId())})
			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime + 1)

			if jailTime == 0 then
				UnJail()
				SetNuiFocus(false, false)
			SendNUIMessage({
				type = "ui",
				status = false,
			})
				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			ESX.UI.Menu.CloseAll()
			local sleepThread = 500

			local Packages = Zconfig.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Uzmi Paket"

					if not v["state"] then
						PackageText = "Vec Uzeto"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 1.0)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								exports['hNotifikacije']:Notifikacije('Već si uzeo ovaj paket', 2)
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end
	end)

	--Prison Work--

end

function PackPackage(packageId)
	local Package = Zconfig.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Pakovanje... " .. math.ceil(tonumber(PackPercent)) .. "%", 1.0)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Zconfig.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Ostavi Paket", 1.0)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx-qalle-jail:prisonWorkReward")
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Zatvor Meni",
			align    = 'center',
			elements = {
				{ label = "Zatvori najblizu osobu", value = "jail_closest_player" },
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Vreme Zatvora (u minutama)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
					exports['hNotifikacije']:Notifikacije('Vreme mora biti u minutama', 2)
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
						exports['hNotifikacije']:Notifikacije('Nema igrača u blizini', 2)
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Razlog Zatvora"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								exports['hNotifikacije']:Notifikacije('Polje za razlog ne sme biti prazno', 2)
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
									exports['hNotifikacije']:Notifikacije('Nema igrača u blizini', 2)
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					exports['hNotifikacije']:Notifikacije('Zatvor je prazan', 2)
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Zatvorenik: " .. playerArray[i].name .. " | Vreme: " .. playerArray[i].jailTime .. "minuta", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Oslobodi Igraca",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

