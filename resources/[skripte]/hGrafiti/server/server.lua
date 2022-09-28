ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

SPRAYS = {}

FastBlacklist = {}

Citizen.CreateThread(function()
    if Config.Blacklist then
        for _, word in pairs(Config.Blacklist) do
            FastBlacklist[word] = word
        end
    end
end)

function GetSprayAtCoords(pos)
    for _, spray in pairs(SPRAYS) do
        if spray.location == pos then
            return spray
        end
    end
end

function AddSpray(Source, spray)
    local i = 1
    while true do
        if not SPRAYS[i] then
            SPRAYS[i] = spray
            break
        else
            i = i + 1
        end
    end

    PersistSpray(spray)
    TriggerEvent('rcore_sprays:addSpray', Source, spray.text, spray.location)
    TriggerClientEvent('rcore_spray:setSprays', -1, SPRAYS)
end

function StartSpraying(args, source)
    local sprayText = args[1]

    if FastBlacklist[sprayText] then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = { Config.Text.BLACKLISTED }
        })
    else
        if sprayText then
            if sprayText:len() <= 9 then
                TriggerClientEvent('rcore_spray:spray', source, args[1])
                saljigrafite("Grafiti", GetPlayerName(source) .. " je krenuo da crta grafit sa tekstom **" .. args[1] .. "**")
            else
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                    args = { Config.Text.WORD_LONG }
                })
            end
        else
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = { Config.Text.USAGE }
            })
        end
    end
end

function RemoveSprayAtPosition(Source, pos)
    local sprayAtCoords = GetSprayAtCoords(pos)

    MySQL.Async.execute([[
            DELETE FROM sprays WHERE x >= @x1 AND y >= @y1 AND z >= @z1 and x <= @x2 AND y <= @y2 AND z <= @z2 and text=@text AND font=@font AND color=@color  LIMIT 1
        ]], {
        ['@x1'] = pos.x - 0.1,
        ['@y1'] = pos.y - 0.1,
        ['@z1'] = pos.z - 0.1,
        ['@x2'] = pos.x + 0.1,
        ['@y2'] = pos.y + 0.1,
        ['@z2'] = pos.z + 0.1,
        ['@text'] = sprayAtCoords.text,
        ['@font'] = sprayAtCoords.font,
        ['@color'] = sprayAtCoords.originalColor,
    })

    for idx, s in pairs(SPRAYS) do
        if s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z then
            SPRAYS[idx] = nil
        end
    end
    TriggerClientEvent('rcore_spray:setSprays', -1, SPRAYS)

    local sprayAtCoordsAfterRemoval = GetSprayAtCoords(pos)

    -- ensure someone doesnt bug it so its trying to remove other tags
    -- while deducting loyalty from not-deleted-but-at-coords tag
    if sprayAtCoords and not sprayAtCoordsAfterRemoval then
        TriggerEvent('rcore_sprays:removeSpray', Source, sprayAtCoords.text, sprayAtCoords.location)
    end
end

RegisterNetEvent('rcore_spray:addSpray')
AddEventHandler('rcore_spray:addSpray', function(spray)
    local Source = source

    if not Config.DisableESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        local item = xPlayer.getInventoryItem("spray")

        if item.count > 0 then
            xPlayer.removeInventoryItem("spray", 1)
            AddSpray(Source, spray)
        else
            TriggerClientEvent('chat:addMessage', Source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = { Config.Text.NEED_SPRAY }
            })
        end
    else
        AddSpray(Source, spray)
    end
end)

function PersistSpray(spray)
    MySQL.Async.execute([[
        INSERT sprays
        (`x`, `y`, `z`, `rx`, `ry`, `rz`, `scale`, `text`, `font`, `color`, `interior`)
        VALUES
        (@x, @y, @z, @rx, @ry, @rz, @scale, @text, @font, @color, @interior)
    ]], {
        ['@x'] = spray.location.x,
        ['@y'] = spray.location.y,
        ['@z'] = spray.location.z,
        ['@rx'] = spray.realRotation.x,
        ['@ry'] = spray.realRotation.y,
        ['@rz'] = spray.realRotation.z,
        ['@scale'] = spray.scale,
        ['@text'] = spray.text,
        ['@font'] = spray.font,
        ['@color'] = spray.originalColor,
        ['@interior'] = spray.interior,
    })
end

Citizen.CreateThread(function()
    MySQL.Sync.execute([[
        DELETE FROM sprays 
        WHERE DATEDIFF(NOW(), created_at) >= @days
    ]], { ['days'] = Config.SPRAY_PERSIST_DAYS })

    local results = MySQL.Sync.fetchAll([[
        SELECT x, y, z, rx, ry, rz, scale, text, font, color, created_at, interior
        FROM sprays
    ]])

    for _, s in pairs(results) do
        table.insert(SPRAYS, {
            location = vector3(s.x + 0.0, s.y + 0.0, s.z + 0.0),
            realRotation = vector3(s.rx + 0.0, s.ry + 0.0, s.rz + 0.0),
            scale = tonumber(s.scale) + 0.0,
            text = s.text,
            font = s.font,
            originalColor = s.color,
            interior = (s.interior == 1) and true or false,
        })
    end

    TriggerClientEvent('rcore_spray:setSprays', -1, SPRAYS)
end)

RegisterNetEvent('rcore_spray:playerSpawned')
AddEventHandler('rcore_spray:playerSpawned', function()
    local Source = source
    TriggerClientEvent('rcore_spray:setSprays', Source, SPRAYS)
end)

RegisterCommand('spray', function(source, args)
    if not Config.DisableESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        local item = xPlayer.getInventoryItem("spray")

        if item.count > 0 then
            StartSpraying(args, source)
        else
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = { Config.Text.NEED_SPRAY }
            })
        end
    else
        StartSpraying(args, source)
    end
end, false)

function HasSpray(serverId, cb)
    if not Config.DisableESX then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local item = xPlayer.getInventoryItem("spray")

        cb(item.count > 0)
    else
        cb(true)
    end
end

function saljigrafite(name, message)
  local vrijeme = os.date('*t')  
  local poruka = {
        {
            ["color"] = 16711680,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "Grandson Direktor\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
            },
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/930796837709950986/imlJuIF7tErbFU4zbbOkM5fJA2UstqUpfq8-s1EbjPdX8-Lb4ilAM46vlt3y5u-Lv_Vv", function(err, text, headers) end, 'POST', json.encode({username = "Grandson Direktor 📜", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end