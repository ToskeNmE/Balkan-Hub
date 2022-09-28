RegisterNUICallback("blockerNUI", function(data, cb)
	print("otvorio konzolu")
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  ESX.TriggerServerCallback('dark-vip:proverivipa', function(isVIP)
    if isVIP then
      TriggerServerEvent("dark:poruka:vip", "3j3182hy3h","^3V.I.P " .. GetPlayerName(PlayerId()) .. "^3 je usao na server")
    end
  end, GetPlayerServerId(PlayerId()), '1')
  ESX.TriggerServerCallback('dark-doktor:getajdonatorgrupu', function(grupa)
    if grupa ~= "Nista" then
      TriggerServerEvent("dark:poruka:vip", "3j3182hy3h", "^3" .. grupa .." Donator " .. GetPlayerName(PlayerId()) .. "^3 je usao na server")
    end
  end)
end)

--================ Blokiranje kupljenja oruzja i pickupova sa poda! =====================

Citizen.CreateThread(function()
    local pickupList = {
		`PICKUP_AMMO_BULLET_MP`,`PICKUP_AMMO_FIREWORK`,`PICKUP_AMMO_FLAREGUN`,`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,`PICKUP_AMMO_HOMINGLAUNCHER`,`PICKUP_AMMO_MG`,`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,`PICKUP_AMMO_PISTOL`,`PICKUP_AMMO_RIFLE`,`PICKUP_AMMO_RPG`,`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,`PICKUP_AMMO_SNIPER`,`PICKUP_ARMOUR_STANDARD`,`PICKUP_CAMERA`,`PICKUP_CUSTOM_SCRIPT`,`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,`PICKUP_HEALTH_STANDARD`,`PICKUP_MONEY_CASE`,`PICKUP_MONEY_DEP_BAG`,`PICKUP_MONEY_MED_BAG`,`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,`PICKUP_MONEY_SECURITY_CASE`,`PICKUP_MONEY_VARIABLE`,`PICKUP_MONEY_WALLET`,`PICKUP_PARACHUTE`,`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,`PICKUP_PORTABLE_PACKAGE`,`PICKUP_SUBMARINE`,`PICKUP_VEHICLE_ARMOUR_STANDARD`,`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,`PICKUP_VEHICLE_HEALTH_STANDARD`,`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,`PICKUP_VEHICLE_MONEY_VARIABLE`,`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,`PICKUP_VEHICLE_WEAPON_GRENADE`,`PICKUP_VEHICLE_WEAPON_MICROSMG`,`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,`PICKUP_VEHICLE_WEAPON_PISTOL50`,`PICKUP_VEHICLE_WEAPON_SAWNOFF`,`PICKUP_VEHICLE_WEAPON_SMG`,`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_ADVANCEDRIFLE`,`PICKUP_WEAPON_APPISTOL`,`PICKUP_WEAPON_ASSAULTRIFLE`,`PICKUP_WEAPON_ASSAULTSHOTGUN`,`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,`PICKUP_WEAPON_BAT`,`PICKUP_WEAPON_BATTLEAXE`,`PICKUP_WEAPON_BOTTLE`,`PICKUP_WEAPON_BULLPUPRIFLE`,`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,`PICKUP_WEAPON_COMBATMG`,`PICKUP_WEAPON_COMBATPDW`,`PICKUP_WEAPON_COMBATPISTOL`,`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,`PICKUP_WEAPON_CROWBAR`,`PICKUP_WEAPON_DAGGER`,`PICKUP_WEAPON_DBSHOTGUN`,`PICKUP_WEAPON_FIREWORK`,`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,`PICKUP_WEAPON_GRENADE`,`PICKUP_WEAPON_GRENADELAUNCHER`,`PICKUP_WEAPON_GUSENBERG`,`PICKUP_WEAPON_GOLFCLUB`,`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,`PICKUP_WEAPON_HEAVYPISTOL`,`PICKUP_WEAPON_HEAVYSHOTGUN`,`PICKUP_WEAPON_HEAVYSNIPER`,`PICKUP_WEAPON_HOMINGLAUNCHER`,`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,`PICKUP_WEAPON_MACHETE`,`PICKUP_WEAPON_MACHINEPISTOL`,`PICKUP_WEAPON_MARKSMANPISTOL`,`PICKUP_WEAPON_MARKSMANRIFLE`,`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,`PICKUP_WEAPON_MINIGUN`,`PICKUP_WEAPON_MINISMG`,`PICKUP_WEAPON_MOLOTOV`,`PICKUP_WEAPON_MUSKET`,`PICKUP_WEAPON_NIGHTSTICK`,`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,`PICKUP_WEAPON_PISTOL`,`PICKUP_WEAPON_PISTOL50`,`PICKUP_WEAPON_POOLCUE`,`PICKUP_WEAPON_PROXMINE`,`PICKUP_WEAPON_PUMPSHOTGUN`,`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,`PICKUP_WEAPON_RPG`,`PICKUP_WEAPON_SAWNOFFSHOTGUN`,`PICKUP_WEAPON_SMG`,`PICKUP_WEAPON_SMOKEGRENADE`,`PICKUP_WEAPON_SNIPERRIFLE`,`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SPECIALCARBINE`,`PICKUP_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_STUNGUN`,`PICKUP_WEAPON_SWITCHBLADE`,`PICKUP_WEAPON_VINTAGEPISTOL`,`PICKUP_WEAPON_WRENCH`, `PICKUP_WEAPON_RAYCARBINE`
	}

	local pID = PlayerId()
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(pID, pickupList[a], false)
    end
end)

local textovi = {
	{ loc = vector3(442.51, -979.67, 30.69), text = "Drzi ~g~ALT ~s~ da kupis licnu kartu"}
}

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		sleep = true
		for i=1, #textovi, 1 do
			local distance = #(GetEntityCoords(ESX.PlayerData.ped) - textovi[i].loc)
			if distance < 5.0 then
				sleep = false
				Draw3DText(textovi[i].loc.x, textovi[i].loc.y, textovi[i].loc.z, textovi[i].text)
			end
		end
		if sleep then Citizen.Wait(1500) end
	end
end)

--=========================== Pokazivanje Prstom

local mp_pointing = false
local keyPressed = false

local function startPointing()
	local ped =  PlayerPedId()
	RequestAnimDict("anim@mp_point")
	while not HasAnimDictLoaded("anim@mp_point") do
		Wait(0)
	end
	SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
	SetPedConfigFlag(ped, 36, 1)
	Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
	RemoveAnimDict("anim@mp_point")
	mp_pointing = true
end

local function stopPointing()
	local ped = PlayerPedId()
	Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
	if not IsPedInjured(ped) then
		ClearPedSecondaryTask(ped)
	end
	if not IsPedInAnyVehicle(ped, 1) then
		SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
	end
	SetPedConfigFlag(ped, 36, 0)
	ClearPedSecondaryTask(PlayerPedId())
	mp_pointing = false
end

RegisterKeyMapping('pokazujprstom', 'Pokazivanje prstom', 'keyboard', 'b')
RegisterCommand("pokazujprstom", function()
	if IsPedInAnyVehicle(PlayerPedId(), false) or LocalPlayer.state.BlokirajSve then
		return
	end

	if mp_pointing then
		stopPointing()
	else
		startPointing()

		Citizen.CreateThread(function()
			while mp_pointing do
				Wait(20)
				local ped = PlayerPedId()

				if IsTaskMoveNetworkActive(ped) and not mp_pointing then
					stopPointing()
				end
				if IsTaskMoveNetworkActive(ped) then
					if not IsPedOnFoot(ped) then
						stopPointing()
					else
						local camPitch = GetGameplayCamRelativePitch()
						if camPitch < -70.0 then
							camPitch = -70.0
						elseif camPitch > 42.0 then
							camPitch = 42.0
						end
						camPitch = (camPitch + 70.0) / 112.0

						local camHeading = GetGameplayCamRelativeHeading()
						local cosCamHeading = Cos(camHeading)
						local sinCamHeading = Sin(camHeading)
						if camHeading < -180.0 then
							camHeading = -180.0
						elseif camHeading > 180.0 then
							camHeading = 180.0
						end
						camHeading = (camHeading + 180.0) / 360.0

						local blocked = 0
						local nn = 0

						local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
						local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
						nn,blocked,coords,coords = GetRaycastResult(ray)

						SetTaskMoveNetworkSignalFloat( ped, "Pitch", camPitch)
						SetTaskMoveNetworkSignalFloat( ped, "Heading", camHeading * -1.0 + 1.0)
						SetTaskMoveNetworkSignalBool( ped, "isBlocked", blocked)
						SetTaskMoveNetworkSignalBool( ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

					end
				end
			end
		end)

	end
end)

--=========================== Ruke u vis

local handsUp = false
RegisterKeyMapping('rukeuvis', 'Dizanje ruku u vis', 'keyboard', 'x')
RegisterCommand('rukeuvis', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) or LocalPlayer.state.BlokirajSve then
		return
	end

	if not handsUp then

		ClearPedSecondaryTask(PlayerPedId())
		ClearPedTasks(PlayerPedId())

		if mp_pointing then mp_pointing = false end

		RequestAnimDict("missminuteman_1ig_2")
		while not HasAnimDictLoaded("missminuteman_1ig_2") do
			Wait(100)
		end

		local pPed = PlayerPedId()
		handsUp = true
		TaskPlayAnim(pPed, "missminuteman_1ig_2", "handsup_base", 2.0, 2.0, -1, 51, 0, false, false, false)

		while handsUp do
			Citizen.Wait(1000)
			if not IsEntityPlayingAnim(pPed, "missminuteman_1ig_2", "handsup_base", 3) then
				handsUp = false
			end
		end

	else
		handsUp = false
		ClearPedSecondaryTask(PlayerPedId())
	end

end, false)

--=========================== Cucanje

local crouched = false
RegisterKeyMapping('Cucanje', 'Cucanje', 'keyboard', 'C')
RegisterCommand("Cucanje", function()

	if IsPedInAnyVehicle(PlayerPedId(), false) or LocalPlayer.state.BlokirajSve then
		return
	end

	local lPed = PlayerPedId()

	RequestAnimSet("move_ped_crouched")
    while ( not HasAnimSetLoaded("move_ped_crouched")) do
        Citizen.Wait(100)
    end

    if not crouched then
        crouched = true
        SetPedMovementClipset(lPed, "move_ped_crouched", 0.85)
    else
        crouched = false
        ResetPedMovementClipset(lPed, 0)
		TriggerServerEvent('assynu_animacje:stylchodzeniaserver', 'get')
    end
end, false)


Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(976425634832207912)
		SetDiscordRichPresenceAsset('hub')
        SetDiscordRichPresenceAssetText("Steam Ime - " .. GetPlayerName(PlayerId()).. " | ID : " .. GetPlayerServerId(PlayerId()))
        --SetDiscordRichPresenceAssetSmall('hub')
        --SetDiscordRichPresenceAssetSmallText('Sezona X')
		ESX.TriggerServerCallback('dark:getajigrace', function(brojigraca)
			SetRichPresence('Broj igraca na serveru ' .. brojigraca .. '/164')
		end)
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/PS8xBF7CKj")
        --SetDiscordRichPresenceAction(1, "Second Button!", "fivem://connect/localhost:30120")
		Citizen.Wait(60000)
	end
end)

RegisterCommand('mojid', function()
	exports['hNotifikacije']:Notifikacije('Vas ID je ' .. GetPlayerServerId(PlayerId()), 1)
end)

local darkdoktor = TriggerServerEvent
local vezan = false

orge = {
	["police"] = -1, 
	["deltaforce"] = -1,
	["sheriff"] = -1,  
	["scarface"] = -1,
	["ludisrbi"] = -1,
	["cosanostra"] = -1,
	["kavacki"] = -1,
	["crips"] = -1,
	["camorra"] = -1,
	["cleanbois"] = -1,
	["komiti"] = -1,
	["amigos"] = -1,
	["gsf"] = -1,
	["grobari"] = -1,
	["pinkpanter"] = -1,
	["elchapo"] = -1,
	["delije"] = -1,
	["automafija"] = -1,
	["ruska"] = -1,
	["yakuza"] = -1,
	["hellangels"] = -1,
	["zemunski"] = -1,
	["italijani"] = -1,
	["ballas"] = -1,
	["bahama"] = -1,
	["favela"] = -1,
	["josamsedamgang"] = -1,
	["sud"] = -1,
	["garda"] = -1,
	["narcos"] = -1,
	["cigani"] = -1,
}

exports.qtarget:Player({
	options = {
		{
			icon = "fa-solid fa-id-card",
			label = "Pokazi licnu kartu",
			action = function(entity)
				ESX.TriggerServerCallback('esx_illegal:have', function(moze)
					if moze then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
					end
				end, 'licna')
            end,
			num = 1,
		},
		{
			icon = "fa-solid fa-id-card",
			label = "Pokazi vozacku dozvolu",
			action = function(entity)
				ESX.TriggerServerCallback('esx_illegal:have', function(moze)
					if moze then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)), 'driver')
					end
				end, 'vozacka')
            end,
			num = 2,
		},
		{
			icon = "fa-solid fa-id-card",
			label = "Pokazi dozvolu za oruzije",
			action = function(entity)
			   ESX.TriggerServerCallback('esx_illegal:have', function(moze)
				if moze then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)), 'weapon')
				end
			end, 'oruzije')
            end,
			num = 3,
		},
		{
			icon = "fas fa-people-carry",
			label = "Nosi",
			action = function(entity)
               TriggerEvent('CarryPeople:carry-aj', NetworkGetPlayerIndexFromPed(entity))
            end,
			num = 4,
		},
		{
			icon = "fa-solid fa-magnifying-glass",
			label = "Pretrazivanje",
			job = orge,
			action = function(entity)
			   exports.ox_inventory:openInventory('player', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
            end,
			num = 5,
		},
		{
			icon = "fa-solid fa-handcuffs",
			label = "Vezivanje",
			job = orge,
			action = function(entity)
				darkdoktor('hMafije:vezivanje', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
            end,
			num = 6,
		},
				{
			icon = "fa-solid fa-hand",
			label = "Vuci",
			job = orge,
			action = function(entity)
				darkdoktor('hMafije:vuci', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
            end,
			num = 7,
		},
		{
			icon = "fa-solid fa-file-invoice",
			label = "Napisi kaznu",
			job = {["police"] = -1},
			action = function(entity)
			   TriggerEvent('dark-kazne:otvoridialog')
            end,
			num = 8,
		},
		{
			icon = "fas fa-heart",
			label = "Ozivi coveka",
			job = {["ambulance"] = -1},
			action = function(entity)
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(NetworkGetPlayerIndexFromPed(entity))
			
						if IsPedDeadOrDying(closestPlayerPed, 1) then
							local playerPed = PlayerPedId()
							local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
			
							for i=1, 15 do
								Wait(900)
			
								ESX.Streaming.RequestAnimDict(lib, function()
									TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
									RemoveAnimDict(lib)
								end)
							end
			
							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
						else
							exports['hNotifikacije']:Notifikacije('Covek nije mrtav', 2)
						end
					else
						exports['hNotifikacije']:Notifikacije('Nemas medikit', 2)
					end
				end, 'medikit')
            end,
			num = 5,
		},
		{
			icon = "fas fa-plus",
			label = "Izleci male rane",
			job = {["ambulance"] = -1},
			action = function(entity)
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(NetworkGetPlayerIndexFromPed(entity))
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)), 'small')
							ESX.ShowNotification('Healovao si coveka ' .. GetPlayerName(NetworkGetPlayerIndexFromPed(entity)))
						else
							exports['hNotifikacije']:Notifikacije('Igrac nije povredjen', 2)
						end
					else
						exports['hNotifikacije']:Notifikacije('Nemas zavoja', 2)
					end
				end, 'bandage')
            end,
			num = 6,
		},
		{
			icon = "fas fa-plus",
			label = "Izleci velike rane",
			job = {["ambulance"] = -1},
			action = function(entity)
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(NetworkGetPlayerIndexFromPed(entity))
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)), 'big')
							ESX.ShowNotification('Healovao si coveka ' .. GetPlayerName(NetworkGetPlayerIndexFromPed(entity)))
						else
							exports['hNotifikacije']:Notifikacije('Igrac nije povredjen', 2)
						end
					else
						exports['hNotifikacije']:Notifikacije('Nemas medikit', 2)
					end
				end, 'medikit')
            end,
			num = 7,
		},
	},
	distance = 2
})

-- Particles

local particleEffects = {}

local particleList = {
    ["vehExhaust"] = {["dic"] = "core",["name"] = "veh_exhaust_truck_rig",["loopAmount"] = 25,["timeCheck"] = 12000, ["scale"] = 1.0},
    ["lavaPour"] = {["dic"] = "core",["name"] = "ent_amb_foundry_molten_pour",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 1.0},
    ["lavaSteam"] = {["dic"] = "core",["name"] = "ent_amb_steam_pipe_hvy",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 1.0},
    ["spark"] = {["dic"] = "core",["name"] = "ent_amb_sparking_wires",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 1.0},
    ["smoke"] = {["dic"] = "core",["name"] = "exp_grd_grenade_smoke",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 1.0},
    ["grill_fire"] = {["dic"] = "core",["name"] = "fire_ped_smoulder",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 0.3},
    ["grill_fire_intense"] = {["dic"] = "core",["name"] = "ent_amb_int_fireplace_sml",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 0.5},
    ["test"] = {["dic"] = "core",["name"] = "ent_amb_steam_pipe_hvy",["loopAmount"] = 1,["timeCheck"] = 12000, ["scale"] = 1.0}
}

RegisterNetEvent("particle:StartClientParticle")
AddEventHandler("particle:StartClientParticle", function(x,y,z,particleId,allocatedID,rX,rY,rZ)
  if #(vector3(x,y,z) - GetEntityCoords(PlayerPedId())) < 100 then

    local particleDictionary = particleList[particleId].dic
    local particleName = particleList[particleId].name
    local scale = particleList[particleId].scale
    local loopAmount = particleList[particleId].loopAmount

   if not HasNamedPtfxAssetLoaded(particleDictionary) then
        RequestNamedPtfxAsset(particleDictionary)
        while not HasNamedPtfxAssetLoaded(particleDictionary) do
            Wait(1)
        end
    end

    for i=0,loopAmount do
        --UseParticleFxAssetNextCall(particleDictionary)
        SetPtfxAssetNextCall(particleDictionary)
       local particle =  StartParticleFxLoopedAtCoord(particleName, x, y, z, rX, rY, rZ, scale, false, false, false, false)

        local object = {["particle"] = particle,["id"] = allocatedID}
        particleEffects[#particleEffects+1]=object
        Citizen.Wait(0)
    end

  end
end)

RegisterNetEvent("particle:StopParticleClient")
AddEventHandler("particle:StopParticleClient", function(allocatedID)
   for j,particle in pairs(particleEffects) do
        if allocatedID == particle.id then
            RemoveParticleFx(particle.particle, true)
        end
    end
end)

-----Anti Drive-by

function PetrisAdvancedDriveBy()
    local ped = PlayerPedId()
    local inveh = IsPedSittingInAnyVehicle(ped)
    local veh = GetVehiclePedIsUsing(ped)
    local vehspeed = GetEntitySpeed(veh) * 3.6
    if inveh then
        if vehspeed >= 20 then ---- do koliko km/h moze da puca iz auta
          SetPlayerCanDoDriveBy(PlayerId(), false)
        else
          SetPlayerCanDoDriveBy(PlayerId(), true)
        end
    end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1500)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        PetrisAdvancedDriveBy()
    end
  end
end)


-- Termalna kamera

local fov_max = 80.0
local fov_min = 10.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 2.0 -- camera zoom speed
local speed_lr = 3.0 -- speed by which the camera pans left-right
local speed_ud = 3.0 -- speed by which the camera pans up-down
local toggle_helicam = 51 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_vision = 25 -- control id to toggle vision mode. Default: INPUT_AIM (Right mouse btn)
local toggle_rappel = 154 -- control id to rappel out of the heli. Default: INPUT_DUCK (X)
local toggle_spotlight = 183 -- control id to toggle the front spotlight Default: INPUT_PhoneCameraGrid (G)
local toggle_lock_on = 22 -- control id to lock onto a vehicle with the camera. Default is INPUT_SPRINT (spacebar)

-- Script starts here
local helicam = false
local polmav_hash = GetHashKey("polmav")
local fov = (fov_max+fov_min)*0.5
local vision_state = 0 -- 0 is normal, 1 is nightmode, 2 is thermal vision
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		if IsPlayerInPolmav() then
			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)

			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = true
				end

				if IsControlJustPressed(0, toggle_rappel) then -- Initiate rappel
					Citizen.Trace("try to rappel")
					if GetPedInVehicleSeat(heli, 1) == lPed or GetPedInVehicleSeat(heli, 2) == lPed then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						TaskRappelFromHeli(GetPlayerPed(-1), 1)
					else
						SetNotificationTextEntry( "STRING" )
						AddTextComponentString("~r~Can't rappel from this seat")
						DrawNotification(false, false )
						PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
					end
				end
			end

			if IsControlJustPressed(0, toggle_spotlight)  and GetPedInVehicleSeat(heli, -1) == lPed then
				spotlight_state = not spotlight_state
				TriggerServerEvent("heli:spotlight", spotlight_state)
				PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
			end

		end

		if helicam then
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end
			local lPed = GetPlayerPed(-1)
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
			AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(1) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()
			local locked_on_vehicle = nil
			while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0, toggle_helicam) then -- Toggle Helicam
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					helicam = false
				end
				if IsControlJustPressed(0, toggle_vision) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ChangeVision()
				end

				if locked_on_vehicle then
					if DoesEntityExist(locked_on_vehicle) then
						PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
						RenderVehicleInfo(locked_on_vehicle)
						if IsControlJustPressed(0, toggle_lock_on) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = nil
							local rot = GetCamRot(cam, 2) -- All this because I can't seem to get the camera unlocked from the entity
							local fov = GetCamFov(cam)
							local old cam = cam
							DestroyCam(old_cam, false)
							cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
							AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
							SetCamRot(cam, rot, 2)
							SetCamFov(cam, fov)
							RenderScriptCams(true, false, 0, 1, 0)
						end
					else
						locked_on_vehicle = nil -- Cam will auto unlock when entity doesn't exist anyway
					end
				else
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
					local vehicle_detected = GetVehicleInView(cam)
					if DoesEntityExist(vehicle_detected) then
						RenderVehicleInfo(vehicle_detected)
						if IsControlJustPressed(0, toggle_lock_on) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							locked_on_vehicle = vehicle_detected
						end
					end
				end
				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(0)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5 -- reset to starting zoom level
			RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
			SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

RegisterNetEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(serverID, state)
	local heli = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
	SetVehicleSearchlight(heli, state, false)
	Citizen.Trace("Set heli light state to "..tostring(state).." for serverID: "..serverID)
end)

function IsPlayerInPolmav()
	local lPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle, polmav_hash)
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function ChangeVision()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RenderVehicleInfo(vehicle)
	local model = GetEntityModel(vehicle)
	local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
	local licenseplate = GetVehicleNumberPlateText(vehicle)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.55)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("Model: "..vehname.."\nPlate: "..licenseplate)
	DrawText(0.45, 0.9)
end

-- function HandleSpotlight(cam)
-- if IsControlJustPressed(0, toggle_spotlight) then
	-- PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
	-- spotlight_state = not spotlight_state
-- end
-- if spotlight_state then
	-- local rotation = GetCamRot(cam, 2)
	-- local forward_vector = RotAnglesToVec(rotation)
	-- local camcoords = GetCamCoord(cam)
	-- DrawSpotLight(camcoords, forward_vector, 255, 255, 255, 300.0, 10.0, 0.0, 2.0, 1.0)
-- end
-- end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end



----SAFE ZONA


local zones = {
	{ ['x'] = -351.380, ['y'] = -818.862, ['z'] = 31.526}, 
	{ ['x'] = -41.8915, ['y'] = -1102.04, ['z'] = 26.422},
	{ ['x'] = 2020.43, ['y'] = 4974.47, ['z'] = 41.22}, -- Farmer 1
	{ ['x'] = 2044.84, ['y'] = 4946.58, ['z'] = 40.97}, -- Farmer 2
	{ ['x'] = 1194.76, ['y'] = 1820.0, ['z'] = 78.84}, -- Drvoseca 1
	{ ['x'] = 2045.11, ['y'] = 4948.92, ['z'] = 40.97}, -- Farmer 3
	{ ['x'] = -1978.56, ['y'] = 2587.198, ['z'] = 3.2798}, -- Kokain
	{ ['x'] = 1596.036, ['y'] = 2198.427, ['z'] = 78.859},
	{ ['x'] = 222.3818, ['y'] = -801.931, ['z'] =  30.674}
}


local notifIn = false
local notifOut = false
local closestZone = 1


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)
		sleep = true
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

		if dist <= 100.0 then
		sleep = false
			if not notifIn then
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				exports['hNotifikacije']:Notifikacije("Usao si u Safe Zonu", 1)
				N_0x4757f00bc6323cfe(-1553120962, 0.0)

				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				notifOut = true
				notifIn = false
				exports['hNotifikacije']:Notifikacije("Izasao si iz Safe Zone", 1)
				N_0x4757f00bc6323cfe(-1553120962, 10.0)

			end
		end
		if notifIn then
		DisableControlAction(2, 37, true)
		DisablePlayerFiring(player,true)
      	DisableControlAction(0, 106, true)
			if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)

			end
			if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
			end
		end
		if sleep then
			Citizen.Wait(1500)
		end
	end
end)

-- NERF PESNICE I PENDREK

Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1)
    	Wait(0)
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.1)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.1)
    	Wait(0)
    end
end)

local models = {
   `bmx`,
   `cruiser`,
   `scorcher`,
   `fixter`,
   `tribike`,
   `tribike2`,
   `tribike3`,
}

exports['qtarget']:AddTargetModel(models, {
    options = {
        {
            type = "event",
            event = "pickup:bike",
            icon = "fas fa-bicycle",
            label = "Uzmi bicikl",
        },
    },
    distance = 2.0
})

RegisterNetEvent('pickup:bike')
AddEventHandler('pickup:bike', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
    local bone = GetPedBoneIndex(playerPed, 0xE5F3)
    local bike = false

    AttachEntityToEntity(vehicle, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)


    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
    bike = true
		exports['hNotifikacije']:Notifikacije('Pritisni G da bacis bicikl', 1)

    RegisterCommand('bacibicikl', function()
        if IsEntityAttached(vehicle) then
        DetachEntity(vehicle, nil, nil)
        SetVehicleOnGroundProperly(vehicle)
        ClearPedTasksImmediately(playerPed)
        bike = false
        end
    end, false)

        RegisterKeyMapping('bacibicikl', 'Baci bicikl', 'keyboard', 'g')

                Citizen.CreateThread(function()
                while true do
                Citizen.Wait(0)
                if bike and IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) ~= 1 then
                    RequestAnimDict("anim@heists@box_carry@")
                    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
                    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
                    if not IsEntityAttachedToEntity(playerPed, vehicle) then
                        bike = false
                        ClearPedTasksImmediately(playerPed)
                    end
                end
								if IsPedJumping(PlayerPedId()) and bike then
									DetachEntity(vehicle, nil, nil)
				        	SetVehicleOnGroundProperly(vehicle)
				        	ClearPedTasks(PlayerPedId())
				        	bike = false
							 end
							 if IsPedFalling(PlayerPedId()) and bike then
							 	DetachEntity(vehicle, nil, nil)
							 	SetVehicleOnGroundProperly(vehicle)
							 	ClearPedTasks(PlayerPedId())
							 	bike = false
							 end
            end
        end)
end)

-- BLIPOVI --

local blips = {
	{title="Sudnica", colour = 60, id = 475, x = 233.1724, y = -418.328, z = 48.095},
	{title="Nocni klub", colour = 28, id = 93, x = -375.313, y = 205.1226, z = 77.472},
	{title="Zatvor", colour = 39, id = 285, x = 1841.049, y = 2588.014, z = 45.887},
	{title="Auto plac", colour = 46, id = 225, x = -46.2148, y = -1681.67, z = 29.427},
	{title="Predsednistvo", colour = 2, id = 176, x = -552.004, y = -195.066, z = 38.219},
	{title="Volkswagen Group", colour = 39, id = 225, x = 130.7205, y = -149.138, z = 54.860},
}
	  
Citizen.CreateThread(function()
   
	for _, info in pairs(blips) do
	  info.blip = AddBlipForCoord(info.x, info.y, info.z)
	  SetBlipSprite(info.blip, info.id)
	  SetBlipDisplay(info.blip, 4)
	  SetBlipScale(info.blip, 0.65)
	  SetBlipColour(info.blip, info.colour)
	  SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(info.title)
	  EndTextCommandSetBlipName(info.blip)
	end
end)

-- VREME -- 

CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)


RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
           local ped = PlayerPedId()
      Citizen.Wait(0)
      if IsPedArmed(ped, 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
      else
        Citizen.Wait(500)
      end
      if lastWeather ~= CurrentWeather then
        lastWeather = CurrentWeather
        SetWeatherTypeOverTime(CurrentWeather, 15.0)
        Citizen.Wait(15000)
    end
    Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
    SetBlackout(blackout)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(lastWeather)
    SetWeatherTypeNow(lastWeather)
    SetWeatherTypeNowPersist(lastWeather)
    if lastWeather == 'XMAS' then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
    
    end
end)
Citizen.CreateThread(function()
  while true do
    local ped = PlayerPedId()
      Citizen.Wait(0)
      if IsPedArmed(ped, 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
      else
        Citizen.Wait(500)
      end
  end
end)
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode.')
end)