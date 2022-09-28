-- Converted script from ESX to QBCore by RafaEl.Zgz (https://www.rab-devs.com) - Also has some improvements

local players = {}

function MeDrawText3D(coords, text)
	local camCoords = GetGameplayCamCoord()
	local dist = #(coords - camCoords)
	
	local scale = 200 / (GetGameplayCamFov() * dist)

	SetTextColour(Config.MeTextColor.r, Config.MeTextColor.g, Config.MeTextColor.b, Config.MeTextColor.a)
	SetTextScale(0.0, Config.TextScale * scale)
	SetTextFont(Config.TextFont)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function DoDrawText3D(coords, text)
	local camCoords = GetGameplayCamCoord()
	local dist = #(coords - camCoords)
	
	local scale = 200 / (GetGameplayCamFov() * dist)

	SetTextColour(Config.DoTextColor.r, Config.DoTextColor.g, Config.DoTextColor.b, Config.DoTextColor.a)
	SetTextScale(0.0, Config.TextScale * scale)
	SetTextFont(Config.TextFont)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function TryDrawText3D(coords, text)
	local camCoords = GetGameplayCamCoord()
	local dist = #(coords - camCoords)
	
	local scale = 200 / (GetGameplayCamFov() * dist)

	SetTextColour(Config.TryTextColor.r, Config.TryTextColor.g, Config.TryTextColor.b, Config.TryTextColor.a)
	SetTextScale(0.0, Config.TextScale * scale)
	SetTextFont(Config.TextFont)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

local function Display(message, serverId, type)
	local player = GetPlayerFromServerId(serverId)

	if player ~= -1 then
		local ped = GetPlayerPed(player)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local pedCoords = GetEntityCoords(ped)
		local dist = #(playerCoords - pedCoords)

		if dist > Config.Distance then return end
		players[ped] = (players[ped] or 1) + 1
		local display = true

		Citizen.CreateThread(function()
			Citizen.Wait(Config.Duration)
			display = false
		end)

		local offset = 0.8 + players[ped] * 0.1
		
		while display do
			if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
				local x, y, z = table.unpack(GetEntityCoords(ped))
				z = z + offset
				if type == "me" then MeDrawText3D(vector3(x, y, z), message) end
				if type == "do" then DoDrawText3D(vector3(x, y, z), message) end
				if type == "try" then TryDrawText3D(vector3(x, y, z), message) end
			end
			Citizen.Wait(0)
		end

		players[ped] = players[ped] - 1

	end
end

RegisterNetEvent("chat:3D")
AddEventHandler("chat:3D", function(message, target, type)
	Display(message, target, type)
end)

exports('Message', function(background, color, icon, title, playername, message, target, image)
	TriggerServerEvent('okokChat:ServerMessage', background, color, icon, title, playername, message, target, image)
end)

RegisterNetEvent("okokChat:checkDeathStatus")
AddEventHandler("okokChat:checkDeathStatus", function()
	local ped = GetPlayerPed(-1)
	TriggerServerEvent('okokChat:deathStatus', IsEntityDead(ped))
end)

RegisterNetEvent("okokChat:Notification")
AddEventHandler("okokChat:Notification", function(info, text)
	exports['okokNotify']:Alert(info.title, text, info.time, info.type)
end)

Citizen.CreateThread(function()

	if Config.JobChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.JobCommand, 'JOB message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableOOC then
		TriggerEvent('chat:addSuggestion', '/'..Config.OOCCommand, 'OOC message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowPlayersToClearTheirChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearChatCommand, 'Clear chat', {})
	end

	if Config.EnableHideChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.HideChatCommand, 'Hide chat', {})
	end

	if Config.EnableStaffCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffCommand, 'Send a message as staff', {
			{ name="message", help="message to send" },
		})
	end

	if Config.AllowStaffsToClearEveryonesChat then
		TriggerEvent('chat:addSuggestion', '/'..Config.ClearEveryonesChatCommand, "Clear everyone's chat", {})
	end

	if Config.EnableStaffOnlyCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.StaffOnlyCommand, 'Staff only chat', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAdvertisementCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AdvertisementCommand, 'Make an advertisement', {
			{ name="ad", help="advertisement message" },
		})
	end

	if Config.EnableAnonymousCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AnonymousCommand, 'Send an anonymous message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitchCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitchCommand, 'Twitch message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableYoutubeCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.YoutubeCommand, 'YouTube message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableTwitterCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.TwitterCommand, 'Twitter message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnablePoliceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.PoliceCommand, 'Police message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.EnableAmbulanceCommand then
		TriggerEvent('chat:addSuggestion', '/'..Config.AmbulanceCommand, 'Ambulance message', {
			{ name="message", help="message to send" },
		})
	end

	if Config.TimeOutPlayers then
		TriggerEvent('chat:addSuggestion', '/'..Config.TimeOutCommand, 'Mute player', {
			{ name="id", help="id of the player to mute" },
			{ name="time", help="time in minutes" }
		})

		TriggerEvent('chat:addSuggestion', '/'..Config.RemoveTimeOutCommand, 'Unmute player', {
			{ name="id", help="id of the player to unmute" }
		})
	end

	if Config.EnableMe then
		TriggerEvent('chat:addSuggestion', '/'..Config.MeCommand, 'Send a me message', {
			{ name="action", help="me action" }
		})
	end
end)