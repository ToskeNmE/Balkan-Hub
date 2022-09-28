-- Converted script from ESX to QBCore by RafaEl.Zgz (https://www.rab-devs.com) - Also has some improvements

Config = {}

--------------------------------
-- [Discord Logs]

Config.EnableDiscordLogs = true

Config.IconURL = ""

Config.ServerName = ""

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.WebhookColor = "16741888"

Config.WebhookURL = ""

--------------------------------
-- [Staff Groups]

Config.Grupe = {
	['user'] = false,
	['vlasnik'] = true,
	['suvlasnik'] = true,
	['skripter'] = true,
	['asistent'] = true,
	['direktor']= true,
	['menadzer']= true,
	['ultimatum']= true,
	['headstaff'] = true,
	['vodjaadmina'] = true,
	['vodja'] = true,
	['vodjaorg'] = true,
	['vodjapromotera'] = true,
	['premiumadmin'] = true,
	['roleplayadmin'] = true,
	['superadmin'] = true,
	['admin3'] = true,
	['admin2'] = true,
	['admin'] = true,
	['logoviadmin'] = true,
	['helper'] = true,
}


--------------------------------
-- [General]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

Config.EnableHideChat = false

Config.HideChatCommand = 'hide'

Config.ShowIDOnMessage = true -- Shows the player ID on every message that is sent

Config.ShowIDOnMessageForEveryone = false -- true: shows the player ID for everyone | false: shows it only for staffs

Config.ClearChatMessageTitle = 'SISTEM'

Config.ClearChatMessage = 'Chat je ociscen!'

-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

--------------------------------
-- [Time Out]

Config.TimeOutPlayers = true

Config.TimeOutCommand = "mute"

Config.RemoveTimeOutCommand = "unmute"

Config.ShowTimeOutMessageForEveryone = true

Config.TimeOutIcon = 'fas fa-gavel'

Config.MessageTitle = 'SERVER'

Config.TimeOutMessages = {
	['muted_for'] = '<b>{3}</b> je mutiran na <b>{1}</b> minuta',
	['you_muted_for'] = 'Ti si mutiran za <b>{3}</b> na <b>{1}</b> minuta',
	['been_muted_for'] = 'Mutiran si na <b>{0}</b> minuta',

	['you_unmuted'] = 'Unmutiran si <b>{2}</b>',
	['been_unmuted'] = 'Unmutiran si',

	['muted_message'] = 'Mutiran si zbog <b>{0}</b>',
	['seconds'] = ' sekundi',
	['minutes'] = ' minuta',
	['hours'] = ' sati',
}

--------------------------------
-- [Me/Do/Try]

Config.Distance = 150

Config.Duration = 5000 -- Text duration (in ms)

Config.TextFont = 0 -- https://wiki.rage.mp/index.php?title=Fonts_and_Colors#DrawText_Fonts

Config.TextScale = 0.5

--------------------------------
-- [Me]

Config.EnableMe = true

Config.MeCommand = 'me'

Config.MeTextColor = { r = 100, g = 100, b = 230, a = 255 }

--------------------------------
-- [Do]

Config.EnableDo = true

Config.DoCommand = 'do'

Config.DoTextColor = { r = 100, g = 230, b = 100, a = 255 }

--------------------------------
-- [Try]

Config.EnableTry = true

Config.TryCommand = 'try'

Config.TryTextColor = { r = 230, g = 100, b = 100, a = 255 }

--------------------------------
-- [Job]

Config.JobChat = true

Config.JobCommand = 'f'

Config.JobIcon = 'fas fa-briefcase'

--------------------------------
-- [Private Message]

Config.EnablePM = true

Config.PMCommand = 'pm'

Config.PMIcon = 'fas fa-comment'

Config.PMMessageTitle = "PM"

--------------------------------
-- [OOC]

Config.EnableOOC = false

Config.OOCCommand = 'ooc'

Config.OOCDistance = 20.0

Config.OOCIcon = 'fas fa-door-open'

Config.OOCMessageTitle = 'OOC'

Config.OOCMessageWithoutCommand = false -- true: sends OOC message without command (/ooc) | false: doesn't send any message without it being a command

--------------------------------
-- [Staff]

Config.EnableStaffCommand = false

Config.StaffCommand = 'staff'

Config.StaffMessageTitle = 'STAFF'

Config.StaffIcon = 'fas fa-shield-alt'

Config.AllowStaffsToClearEveryonesChat = false

Config.ClearEveryonesChatCommand = 'clearall'

Config.StaffSteamName = true

Config.ShowStaffMessageWhenHidden = true

-- [Staff Only]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'a'

Config.StaffOnlyMessageTitle = 'ADMIN CHAT'

Config.StaffOnlyIcon = 'fas fa-eye-slash'

Config.StaffOnlySteamName = true

-- [Server Announcement]

Config.EnableServerAnnouncement = false

Config.ServerAnnouncementCommand = 'obavestenje'

Config.AnnouncementIcon = 'fas fa-exclamation-circle'

Config.AnnouncementMessageTitle = 'SERVER OBAVESTENJE'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = false

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 1000

Config.AdvertisementCooldown = 5 -- in minutes

Config.AdvertisementIcon = 'fas fa-ad'

--------------------------------
-- [Anonymous/Dark]

Config.EnableAnonymousCommand = false

Config.AnonymousCommand = 'anon'

Config.AnonymousPrice = 1000

Config.AnonymousCooldown = 5 -- in minutes

Config.WhatJobsCantSeeAnonymousChat = {
	'police',
	'ambulance',
}

Config.AnonymousIcon = 'fas fa-mask'

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = false

Config.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.TwitchIcon = 'fab fa-twitch'

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = false

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.YoutubeIcon = 'fab fa-youtube'

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = false

Config.TwitterCommand = 'twitter'

Config.TwitterIcon = 'fab fa-twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'pdobavestenje'

Config.PoliceJobName = 'police'

Config.PoliceIcon = 'fas fa-bullhorn'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = false

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

Config.AmbulanceIcon = 'fas fa-ambulance'

--------------------------------
-- [Auto Message]

Config.EnableAutoMessage = false

Config.AutoMessageTime = 30 -- (in minutes) will send messages every x minutes 

Config.AutoMessages = {
	"Molimo vas da postujete pravila servera. Hvala!",
	"Uzivajte na serveru!",
}

--------------------------------
-- [Notifications]

Config.NotificationsText = {
	['disable_chat'] = { title = 'SYSTEM', message = 'You disabled the chat', time = 5000, type = 'info'},
	['enable_chat'] = { title = 'SYSTEM', message = 'You enabled the chat', time = 5000, type = 'info'},
	['ad_success'] = { title = 'ADVERTISEMENT', message = 'Advertisement successfully made for ${price}€', time = 5000, type = 'success'},
	['ad_no_money'] = { title = 'ADVERTISEMENT', message = "You don't have enough money to make an advertisement", time = 5000, type = 'error'},
	['ad_too_quick'] = { title = 'ADVERTISEMENT', message = "You can't advertise so quickly", time = 5000, type = 'info'},
	['mute_not_adm'] = { title = 'SYSTEM', message = 'You are not an admin', time = 5000, type = 'error'},
	['mute_id_inv'] = { title = 'SYSTEM', message = 'The id is invalid', time = 5000, type = 'error'},
	['mute_time_inv'] = { title = 'SYSTEM', message = 'The mute time is invalid', time = 5000, type = 'error'},
	['alr_muted'] = { title = 'SYSTEM', message = 'This person is already muted', time = 5000, type = 'error'},
	['alr_unmuted'] = { title = 'SYSTEM', message = 'This person is already unmuted', time = 5000, type = 'error'},
	['an_success'] = { title = 'ANONYMOUS', message = 'Advertisement successfully made for price€', time = 5000, type = 'success'},
	['an_no_money'] = { title = 'ANONYMOUS', message = "You don't have enough money to make an advertisement", time = 5000, type = 'error'},
	['an_too_quick'] = { title = 'ANONYMOUS', message = "You can't advertise so quickly", time = 5000, type = 'error'},
	['an_not_allowed'] = { title = 'ANONYMOUS', message = "You are not allowed to send messages in the anonymous chat", time = 5000, type = 'error'},
	['is_muted'] = { title = 'ANONYMOUS', message = "This player is muted", time = 5000, type = 'error'},
}

Config.WebhookText = {
	['clear_all'] = 'Ocistio chat',
	['staff_msg'] = 'Staff poruka',
	['staff_chat_msg'] = 'Staff chat poruka',
	['sv_an'] = 'Server obavestenje',
	['ad'] = 'Advertisement',
	['twitch'] = 'Twitch',
	['youtube'] = 'Youtube',
	['twitter'] = 'Twitter',
	['police'] = 'Policija',
	['ambulance'] = 'Ambulance',
	['job_chat'] = 'Chat organizacije [${job}]',
	['pm_chat'] = 'Privatna poruka namenjena ${name} [${id}]',
	['ooc'] = 'OOC',
	['muted'] = 'Mutirao [${id}]',
	['muted_for'] = 'Na ${muteTime} minuta',
	['unmuted'] = 'Unmutirao [${id}]',
	['p_unmuted'] = 'Igrac je unmutiran',
	['anon'] = 'Anonymous',
}