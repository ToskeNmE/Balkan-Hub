Config = {}

Config.Item = {
    Require = true,
    name = "radio"
}

Config.KeyMappings = {
    Enabled = false, 
    Key = "UP"
}

Config.ClientNotification = function(msg, type)
    ------------------------------------------------------------------------------------------
    -- Insert your Notification System here. (script uses types ("success", "inform", "error"))
    -------------------------------------------------------------------------------------------
  
    ----- T-Notify -----
    -- if type == "inform" then type = "info" end
    -- exports['t-notify']:Alert({style = type,  message = msg})
    ----------------------
  
    --------- mythic_notify ------
    --exports["mythic_notify"]:DoHudText(type, msg)
    --------------------------------
    exports['hNotifikacije']:Notifikacije(msg, 1)
  end
  
  Config.ServerNotification = function(msg, type, player)
    ------------------------------------------------------------------------------------------
    -- Insert your Notification System here. (script uses types ("success", "inform", "error"))
    -------------------------------------------------------------------------------------------
  
    --------- mythic_notify ------
    -- TriggerClientEvent("mythic_notify:client:SendAlert", player, {type = type, text = msg}) 
    --------------------------------
  
    ----- T-Notify ---------------
    --  if type == "inform" then type = "info" end
    --  TriggerClientEvent('t-notify:client:Custom', player, {style = type,title = 'SubZero Interactive:Garages',message = msg,duration = 1000})
    --------------------------------
    player.triggerEvent('dark:client:notify', msg, 1)
  end


--- Resticts in index order
Config.RestrictedChannels = {
    { -- Channel 1
        police = true
    },
    { -- Channel 2
        ambulance = true
    },
    { -- Channel 3
        sud = true
    }
}

Config.MaxFrequency = 999

Config.messages = {
    ["not on radio"] = "Nisi povezan ni na jednu frekvenciju",
    ["on radio"] = "Vec si povezan na tu frekvenciju",
    ["joined to radio"] = "Povezan si na: ",
    ["restricted channel error"] = "Nemas dozvolu da se povezes na ovu frekvenciju",
    ["invalid radio"] = "Ova frekvencija nije dostupna.",
    ["you on radio"] = "Vec si povezan na ovaj kanal",
    ["you leave"] = "Izasao si iz kanala.",
    ['volume radio'] = 'Novi zvuk ',
    ['decrease radio volume'] = 'Radio je vec na najvecoj jacini zvuka',
    ['increase radio volume'] = 'Radio je vec na najslabijoj jacini zvuka',
    ['increase decrease radio channel'] = 'Novi kanal ',
}
