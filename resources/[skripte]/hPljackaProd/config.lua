Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'en' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vec3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(372.3989, 326.5726, 103.56), heading = 258.67, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(1165.260, -322.748, 69.205), heading = 105.9, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(-1486.20, -377.708, 40.163), heading = 141.65, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(-1221.88, -908.552, 12.326), heading = 43.3, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vec3(1133.653, -982.663, 46.415), heading = 282.25, money = {7500, 10000}, cops = 3, blip = true, name = '24/7', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'Prodavac',
        ['robbed'] = "Upravo sam opljackan nemam nista vise!",
        ['cashrecieved'] = 'You got:',
        ['currency'] = '$',
        ['scared'] = 'Uplasen:',
        ['no_cops'] = 'Nema dovoljno policajaca',
        ['cop_msg'] = '~r~[10-14] ~w~Za sve jedinice prijavljena je pljacka prodavnice',
        ['set_waypoint'] = 'Ukljucite putanju',
        ['hide_box'] = 'Otkazi prijavu',
        ['robbery'] = 'Pljacka u toku',
        ['walked_too_far'] = 'Prekinula se pljacka!'
    }
}