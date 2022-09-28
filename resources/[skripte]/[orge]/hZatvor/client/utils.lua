ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand("zatvormeni", function(source, args)
	
	local coords = GetEntityCoords(PlayerPedId())
	local distance = Vdist(coords, vector3(1758.741, 2489.503, 45.844))
	if distance <= 30 then
		if PlayerData.job.name == "police" then
			OpenJailMenu()
		else
		end
	else
		exports['hNotifikacije']:Notifikacije('Da bi zatvorio igrača moraš biti u zatvorskim ćelijama', 2)
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene()

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			local clothesSkin = {
				['ear_accessories'] = -1, ['ear_accessories_color'] = 0,
				['bag'] = 0,		['bag_color'] = 0,
				['glasses_1'] = 0,	['glasses_2'] = 0,
				['bproof_1'] = 0,	['bproof_2'] = 0,
				['mask_1'] = 0,		['mask_2'] = 0,
				['decals_1'] = 0,	['decals_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['tshirt_1'] = 15, 	['tshirt_2'] = 0,
				['torso_1']  = 97, ['torso_2']  = 1,
				['arms']     = 0,   ['pants_1']  = 47,
				['pants_2']  = 1,  ['shoes_1']  = 12,
				['shoes_2']  = 12,  ['chain_1']  = 0,
				['chain_2']  = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else
			local clothesSkin = {
				['ear_accessories'] = -1, ['ear_accessories_color'] = 0,
				['bag'] = 0,		['bag_color'] = 0,
				['glasses_1'] = 0,	['glasses_2'] = 0,
				['bproof_1'] = 0,	['bproof_2'] = 0,
				['mask_1'] = 0,		['mask_2'] = 0,
				['decals_1'] = 0,	['decals_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['tshirt_1'] = 15, 	['tshirt_2'] = 0,
				['torso_1']  = 34, ['torso_2']  = 0,
				['arms']     = 0,   ['pants_1']  = 47,
				['pants_2']  = 1,  ['shoes_1']  = 12,
				['shoes_2']  = 12,  ['chain_1']  = 0,
				['chain_2']  = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)


	local PlayerPed = PlayerPedId()
	local JailPosition = Zconfig.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	FreezeEntityPosition(PlayerPed, false)
	InJail()
end

function ZatvorPrekoMenija()

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			local clothesSkin = {
				['ear_accessories'] = -1, ['ear_accessories_color'] = 0,
				['bag'] = 0,		['bag_color'] = 0,
				['glasses_1'] = 0,	['glasses_2'] = 0,
				['bproof_1'] = 0,	['bproof_2'] = 0,
				['mask_1'] = 0,		['mask_2'] = 0,
				['decals_1'] = 0,	['decals_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['tshirt_1'] = 15,  	['tshirt_2'] = 0,
				['torso_1']  = 97, 	['torso_2']  = 0,
				['arms']     = 0,   ['pants_1']  = 47,
				['pants_2']  = 1,  ['shoes_1']  = 66,
				['shoes_2']  = 5,  	['chain_1']  = 0,
				['chain_2']  = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else
			local clothesSkin = {
				['ear_accessories'] = -1, ['ear_accessories_color'] = 0,
				['bag'] = 0,		['bag_color'] = 0,
				['glasses_1'] = 0,	['glasses_2'] = 0,
				['bproof_1'] = 0,	['bproof_2'] = 0,
				['mask_1'] = 0,		['mask_2'] = 0,
				['decals_1'] = 0,	['decals_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['tshirt_1'] = 15,  	['tshirt_2'] = 0,
				['torso_1']  = 73, 	['torso_2']  = 0,
				['arms']     = 0,   ['pants_1']  = 47,
				['pants_2']  = 1,  ['shoes_1']  = 66,
				['shoes_2']  = 5,  	['chain_1']  = 0,
				['chain_2']  = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)


	local PlayerPosition = Zconfig.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	local JailPosition = Zconfig.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	FreezeEntityPosition(PlayerPed, false)
	InJail()
end

function Cam()
	local CamOptions = Zconfig.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local Values = pos
	local PlayerData = PlayerPedId()
	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
					end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Izaberi poziciju",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Zconfig.Teleports[action]

			if action == "Boiling Broke" or action == "Security" then

				if PlayerData.job.name ~= "police" then
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)
			Citizen.Wait(250)
			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)

			Citizen.Wait(250)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Zconfig.Teleports[Values["goal"][1]]
		DoScreenFadeOut(100)
		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end