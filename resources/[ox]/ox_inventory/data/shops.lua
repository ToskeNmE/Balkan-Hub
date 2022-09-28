return {
	General = {
		name = 'Prodavnica',
		blip = {
			id = 59, colour = 69, scale = 0.65
		}, inventory = {
			{ name = 'hotdog', price = 5 },
			{ name = 'meteorite', price = 3 },
			{ name = 'water', price = 2 },
			{ name = 'cola', price = 3 },
			{ name = 'sprunk', price = 3 },
			{ name = 'piswasser', price = 2 },
			{ name = 'glukoza', price = 150 },
			{ name = 'kesica', price = 15 },
			{ name = 'phone', price = 500 },
			{ name = 'radio', price = 100 },
			{ name = 'rizle', price = 20 },
			{ name = 'spray_remover', price = 2500 },
			{ name = 'spray', price = 1000 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319),
			vec3(161.8690, 6640.388, 31.698)
		}, targets = {
			{ loc = vec3(25.09, -1346.43, 29.5), length = 4.6, width = 1, heading = 178.0, minZ = 26.65, maxZ = 30.25, distance = 1.5 },
			{ loc = vec3(-3039.65, 584.85, 7.91), length = 3.4, width = 1, heading = 108.0, minZ = 5.11, maxZ = 9.11, distance = 1.5 },
			{ loc = vec3(-3242.41, 1000.54, 12.83), length = 2.6, width = 1, heading = 85.0, minZ = 10.03, maxZ = 14.03, distance = 1.5 },
			{ loc = vec3(1728.67, 6415.53, 35.04), length = 3.8, width = 1, heading = 334.0, minZ = 32.04, maxZ = 36.04, distance = 1.5 },
			{ loc = vec3(1698.11, 4923.59, 42.06), length = 3.8, width = 1, heading = 55.0, minZ = 39.46, maxZ = 43.46, distance = 1.5 },
			{ loc = vec3(1960.25, 3740.87, 32.34), length = 3.6, width = 1, heading = 30.0, minZ = 29.54, maxZ = 33.54, distance = 1.5 },
			{ loc = vec3(548.62, 2670.84, 42.16), length = 3.6, width = 1, heading = 7.0, minZ = 39.36, maxZ = 43.36, distance = 1.5 },
			{ loc = vec3(2677.69, 3280.17, 55.24), length = 4.2, width = 1, heading = 61.0, minZ = 52.64, maxZ = 56.64, distance = 1.5 },
			{ loc = vec3(2556.56, 381.33, 108.62), length = 4.4, width = 1, heading = 88.0, minZ = 105.82, maxZ = 109.82, distance = 1.5 },
			{ loc = vec3(373.25, 326.94, 103.57), length = 3.8, width = 1, heading = 347.0, minZ = 100.77, maxZ = 104.77, distance = 1.5 },
			{ loc = vec3(1164.26, -323.06, 69.21), length = 3.8, width = 1, heading = 11.0, minZ = 66.61, maxZ = 70.61, distance = 1.5 },
			{ loc = vec3(161.39, 6641.61, 31.7), length = 3.8, width = 1, heading = 315.0, minZ = 30.7, maxZ = 34.7, distance = 1.5 },
			{ loc = vec3(-1392.37, -606.0, 30.32), length = 3.0, width = 1, heading = 28.0, minZ = 28.72, maxZ = 32.12, distance = 1.5 },
			{ loc = vec3(1392.3, 3605.8, 34.98), length = 4.0, width = 1, heading = 110.0, minZ = 32.18, maxZ = 36.18, distance = 1.5 },
			{ loc = vec3(1165.58, 2710.21, 38.16), length = 4.2, width = 1, heading = 270.0, minZ = 35.56, maxZ = 39.56, distance = 1.5 },
			{ loc = vec3(-2967.19, 390.97, 15.04), length = 4.2, width = 1, heading = 356.0, minZ = 13.04, maxZ = 17.04, distance = 1.5 },
			{ loc = vec3(-1486.93, -378.37, 40.16), length = 4.2, width = 1, heading = 45.0, minZ = 38.36, maxZ = 42.36, distance = 1.5 },
			{ loc = vec3(-1222.28, -907.63, 12.33), length = 4.2, width = 1, heading = 124.0, minZ = 10.13, maxZ = 14.13, distance = 1.5 },
			{ loc = vec3(1134.99, -982.61, 46.42), length = 4.2, width = 1, heading = 8.0, minZ = 44.22, maxZ = 48.22, distance = 1.5 }
		}
	},

	Blackmarket = {
		name = 'Blackmarket',
		--[[blip = {
			id = 59, colour = 69, scale = 0.65
		},--]] 
		inventory = {
			{ name = 'WEAPON_DRAGUNOV', price = 300000 },
			{ name = 'WEAPON_MINISMG2', price = 50000 },
			{ name = 'WEAPON_BROWNING', price = 20000 },
			{ name = 'WEAPON_DP9', price = 20000 },
			{ name = 'WEAPON_BOOK', price = 800 },
			{ name = 'WEAPON_BRICK', price = 600 },
			{ name = 'WEAPON_SHOE', price = 800 },
			{ name = 'WEAPON_ASSAULTRIFLE2', price = 75000},
			{ name = 'WEAPON_ASSAULTRIFLE', price = 90000},
			{ name = 'WEAPON_MICROSMG2', price = 45000 },
			{ name = 'WEAPON_MICROSMG3', price = 40000 },
			{ name = 'WEAPON_KATANAS', price = 15000 },
			{ name = 'WEAPON_SLEDGEHAM', price = 15000 },
			{ name = 'WEAPON_MACHETE', price = 15000 },
			{ name = 'WEAPON_SHIV', price = 5000 },
			{ name = 'WEAPON_BOTTLE', price = 5000 },
			{ name = 'WEAPON_KNUCKLE', price = 5000 },
			{ name = 'WEAPON_GOLFCLUB', price = 5000 },
			{ name = 'WEAPON_BAT', price = 10000 },
			{ name = 'WEAPON_HAMMER', price = 5000 },
			{ name = 'WEAPON_HATCHET', price = 5000 },
			{ name = 'WEAPON_WRENCH', price = 5000 },
			{ name = 'WEAPON_CROWBAR', price = 15000 },
			{ name = 'WEAPON_SWITCHBLADE', price = 5000 },
			{ name = 'WEAPON_PISTOL50', price = 35000 },
			{ name = 'WEAPON_PISTOL_MK2', price = 25000 },
			{ name = 'WEAPON_COMBATPISTOL', price = 20000 },
			{ name = 'WEAPON_HEAVYPISTOL', price = 30000 },
			{ name = 'WEAPON_SMG', price = 50000 },
			{ name = 'WEAPON_GUSENBERG', price = 60000 },
			{ name = 'WEAPON_MG', price = 120000 },
			{ name = 'WEAPON_ADVANCEDRIFLE', price = 65000 },
			{ name = 'WEAPON_PUMPSHOTGUN', price = 42000 },
			{ name = 'WEAPON_COMPACTRIFLE', price = 100000 },
			{ name = 'WEAPON_DOUBLEACTION', price = 40000 },
			{ name = 'WEAPON_SNIPERRIFLE2', price = 280000 },
			{ name = 'at_suppressor_heavy', price = 6000 },
			{ name = 'at_grip', price = 4000 },
			{ name = 'at_scope_advanced', price = 8000 },
			{ name = 'ammo-9', price = 40 },
			{ name = 'ammo-38', price = 60 },
			{ name = 'ammo-44', price = 80 },
			{ name = 'ammo-45', price = 100 },
			{ name = 'ammo-50', price = 120 },
			{ name = 'ammo-shotgun', price = 140 },
			{ name = 'ammo-rifle', price = 160 },
			{ name = 'ammo-rifle2', price = 160 },
			{ name = 'ammo-sniper', price = 250 },
			{ name = 'ammo-heavysniper', price = 300 },
			{ name = 'id_card_f', price = 5000},
			{ name = 'secure_card', price = 5000},
			{ name = 'thermal', price = 2500},
			{ name = 'hack_device', price = 7000},
		}, 
		locations = {
			vec3(1753.81, -1649.3, 112.66),
		}, 
		targets = {
			{ loc = vec3(1753.81, -1649.3, 112.66), length = 1.4, width = 1, heading = 10, minZ = 110.06, maxZ = 114.06, distance = 1.5 }
		}
	},

	Apoteka = {
		name = 'Apoteka',
		--[[blip = {
			id = 59, colour = 69, scale = 0.65
		},--]] 
		inventory = {
			{ name = 'medikit', price = 5000 },
			{ name = 'bandage', price = 2500 },
		}, 
		locations = {
			vec3(307.52, -595.23, 43.28),
		}, 
		targets = {
			{ loc = vec3(307.52, -595.23, 43.28), length = 2.0, width = 1, heading = 340, minZ = 41.08, maxZ = 45.08, distance = 1.5 }
		}
	},

	Policija = {
		name = 'Policija',
		--[[blip = {
			id = 59, colour = 69, scale = 0.65
		},--]] 
		inventory = {
			{ name = 'licna', price = 30 },
		}, 
		locations = {
			vec3(441.5662, -979.629, 30.689),
		}, 
		targets = {
			{ loc = vec3(442.51, -979.67, 30.69), length = 3.2, width = 1, heading = 1, minZ = 29.49, maxZ = 32.29, distance = 1.5 }
		}
	},

	Kafic = {
		name = 'Kafic',
		--[[blip = {
			id = 59, colour = 69, scale = 0.65
		},--]] 
		inventory = {
			{ name = 'sprunk', price = 3 },
			{ name = 'cola', price = 3 },
			{ name = 'water', price = 2 },
			{ name = 'mount_whisky', price = 5 },
			{ name = 'tequila', price = 10 },
			{ name = 'nogo_vodka', price = 10 },
			{ name = 'raine', price = 10 },
			{ name = 'shot_mount_whisky', price = 5 },
			{ name = 'shot_nogo_vodka', price = 5 },
			{ name = 'shot_tequila', price = 5 },
			{ name = 'costa_del_perro', price = 10 },
			{ name = 'rockford_hill', price = 10 },
			{ name = 'vinewood_red', price = 10 },
			{ name = 'vinewood_blanc', price = 10 },
			{ name = 'glass_costa_del_perro', price = 5 },
			{ name = 'glass_rockford_hill', price = 5 },
			{ name = 'glass_vinewood_red', price = 5 },
			{ name = 'glass_vinewood_blanc', price = 5 },
		}, 
		locations = {
			vec3(-369.59, 204.32, 77.47),
		}, 
		targets = {
			{ loc = vec3(-369.59, 204.32, 77.47), length = 6.4, width = 1, heading = 0, minZ = 74.67, maxZ = 78.67, distance = 1.5 }
		}
	},

	Ammunation = {
		name = 'Oruzarnica',
		blip = {
			id = 110, colour = 47, scale = 0.65
		}, inventory = {
			{ name = 'WEAPON_KNIFE', price = 5000 },
			{ name = 'WEAPON_BATS', price = 7000 },
			{ name = 'WEAPON_PISTOL', price = 25000, metadata = { registered = true }, license = 'weapon' },
			{ name = 'WEAPON_COMBATPISTOL', price = 30000, metadata = { registered = true }, license = 'weapon' },
			{ name = 'WEAPON_PISTOL_MK2', price = 35000, metadata = { registered = true }, license = 'weapon' },
			{ name = 'WEAPON_FLARE', price = 800, },
			{ name = 'ammo-9', price = 100, },
			{ name = 'at_suppressor_light', price = 2500, },
			{ name = 'at_flashlight', price = 2500, },
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	}
}
