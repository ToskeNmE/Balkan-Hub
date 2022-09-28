ESX = nil
local Vehicles = {}
local PlayerData = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}
local clothin = false

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local blipovi = {
    {title="Zuta Mehanicarska", colour= 5, id= 72, x = -1614.57, y = -818.301, z = 9.4574},
	{title="Plava Mehanicarska", colour= 3, id= 72, x = -206.615, y = -1306.95, z = 30.692}
}

Citizen.CreateThread(function()

    for _, grandson in pairs(blipovi) do
      grandson.blip = AddBlipForCoord(grandson.x, grandson.y, grandson.z)
      SetBlipSprite(grandson.blip, grandson.id)
      SetBlipDisplay(grandson.blip, 4)
      SetBlipScale(grandson.blip, 0.80)
      SetBlipColour(grandson.blip, grandson.colour)
      SetBlipAsShortRange(grandson.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(grandson.title)
      EndTextCommandSetBlipName(grandson.blip)
    end
end)

function akcijesefa2()
	TriggerEvent('esx_society:openBossMenu', 'mehanicar', function(data, menu)
		ESX.UI.Menu.CloseAll()
	end, {wash = true})
end

function odeca()
	if clothin == true then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local isMale = skin.sex == 0
	
			startAnim("clothingtie", "try_tie_negative_a")
			exports.hub_progg:Start("Menjanje odece", 2500)
			TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx:restoreLoadout')
					clothin = false
					ClearPedTasksImmediately(PlayerPedId())
				end)
			end)
	
		end)
	elseif clothin == false then
		startAnim("clothingtie", "try_tie_negative_a")
		exports.hub_progg:Start("Menjanje odece", 2500)
		setUniform("pocetnik", PlayerPedId())
		ClearPedTasksImmediately(PlayerPedId())
		clothin = true
	end
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

		else
			print("No outfit")
		end
	end)
end

exports.qtarget:AddBoxZone("bossmeni_meha", vector3(-1607.75, -844.17, 10.1), 2.4, 1, {
	name = "bossmeni_meha",
	heading = 50,
	minZ = 9.1,
	maxZ = 11.3
	}, {
		options = {
			{
				icon = "fas fa-briefcase",
				label = "Boss meni",
				job = "zmehanicar",
				action = function (entity)
					TriggerEvent('esx_society:openBossMenu', 'zmehanicar', function(data, menu)
						menu.close()
					end, { wash = false })
				end
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("bossmeni_meha2", vector3(-199.32, -1333.38, 34.9), 2.6, 1, {
	name = "bossmeni_meha2",
	heading = 0,
	--debugPoly = true
	minZ = 33.9,
	maxZ = 16.9
	}, {
		options = {
			{
				icon = "fas fa-briefcase",
				label = "Boss meni",
				job = "pmehanicar",
				action = function (entity)
					TriggerEvent('esx_society:openBossMenu', 'pmehanicar', function(data, menu)
						menu.close()
					end, { wash = false })
				end
			},
		},
		distance = 3.5
})

local uniforma = false

exports.qtarget:AddBoxZone("odeca_meha", vector3(-1608.82, -840.86, 10.1), 0.5, 1, {
	name = "odeca_meha",
	heading = 50,
	minZ = 9.1,
	maxZ = 11.3
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Ormaric",
				job = "zmehanicar",
				action = function (entity)
					if not uniforma then
						setUniform()
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							uniforma = false
						end)
					end
				end
			},
		},
	distance = 3.5
})
  
exports.qtarget:AddBoxZone("odeca_meha2", vector3(-224.24, -1319.36, 30.89), 3.1, 1, {
	name = "odeca_meha2",
	heading = 270,
	--debugPoly = true,
	minZ = 29.89,
	maxZ = 32.69
	}, {
		options = {
			{
				icon = "fas fa-tshirt",
				label = "Ormaric",
				job = "pmehanicar",
				action = function (entity)
					if not uniforma then
						setUniform()
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							uniforma = false
						end)
					end
				end
			},
		},
	distance = 3.5
})

exports.qtarget:AddBoxZone("sef_meha", vector3(-1614.37, -838.06, 10.13), 3.8, 1, {
	name = "sef_meha",
	heading = 0,
  	minZ = 9.13,
  	maxZ = 11.33
	}, {
		options = {
			{
				icon = "fas fa-box",
				label = "Sef",
				job = "zmehanicar",
				action = function (entity)
					exports.ox_inventory:openInventory('stash', {id='zmehanicar'})
				end
			},
			{
				icon = "fas fa-box",
				label = "Sef",
				job = "pmehanicar",
				action = function (entity)
					exports.ox_inventory:openInventory('stash', {id='pmehanicar'})
				end
			},
		},
	distance = 3.5
})

exports.qtarget:AddBoxZone("sef_meha2", vector3(-242.74, -1338.21, 30.9), 3.7, 1, {
	name = "sef_meha2",
	heading = 0,
	--debugPoly = true,
	minZ = 29.9,
	maxZ = 32.3
	}, {
		options = {
			{
				icon = "fas fa-box",
				label = "Sef",
				job = "pmehanicar",
				action = function (entity)
					exports.ox_inventory:openInventory('stash', {id='pmehanicar'})
				end
			},
		},
	distance = 3.5
})
  
  
function setUniform()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Odeca[PlayerData.job.name]
		else
			uniformObject = Config.Odeca[PlayerData.job.name]
		end
		print(uniformObject)
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)	
			uniforma = true
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end