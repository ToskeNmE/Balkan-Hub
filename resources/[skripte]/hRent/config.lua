Config = {
    ESXBilling = false, -- na false po defaultu
    Porez = 800, -- po satu
    Lokacije = {
        ["Rent Vozila"] = {
            coords = {
                rent = vector3(-1032.45, -2734.78, 20.17),
                spawn = vector3(-1027.89, -2731.08, 19.74),
                heading = 100.0 
            },
            Vehicles = {
                --{name = "blista",label = "Blista", price = 100, max_time = 6 --[[ hours ]]}, --max time means, if you reach the max time with rented car you need to pay fine
                {name = "asea",label = "Asea", price = 50, max_time = 1 --[[ hours ]]},
                {name = "intruder",label = "Intruder", price = 100, max_time = 1 --[[ hours ]]},
                {name = "ruiner",label = "Ruiner", price = 150, max_time = 1 --[[ hours ]]},
                {name = "slamvan",label = "Slamvan", price = 200, max_time = 1 --[[ hours ]]},
                {name = "virgo",label = "Virgo", price = 250, max_time = 1 --[[ hours ]]},
                {name = "fugitive",label = "Fugitive", price = 300, max_time = 1 --[[ hours  ]]},
            }
        },
    }
}
