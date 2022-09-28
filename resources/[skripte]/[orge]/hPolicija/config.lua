Config                            = {}

Config.DrawDistance               = 20.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 3.0, y = 3.0, z = 3.0 }
Config.MarkerHelikopter           = { x = 6.0, y = 6.0, z = 2.5 }
Config.MarkerAuto                 = { x = 3.0, y = 3.0, z = 3.0 }
Config.MarkerColor                = { r = 49, g = 105, b = 235 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.Locale                     = 'en'

Config.Ped = {
	Oruzarnica = 's_m_y_cop_01',
	Vehicle = 's_f_y_cop_01',
}

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(418.72, -979.51, 29.42),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 18
		},

		Armories = {
			{ coords = vector3(484.9929, -1003.80, 24.734), heading = 4.44},
		},

		Vehicles = {
			{
				Spawner = { coords = vector3(460.0398, -984.243, 24.729), heading = 119.3 },
				SpawnPoints = {
					{ coords = vector3(454.2789, -984.514, 25.552), heading = 359.65, radius = 1.5 },
				},
			}
		},

		Helicopters = {
			{
				Spawner = vector3(462.24, -982.42, 43.69),
				SpawnPoints = {
					{ coords = vector3(448.78, -981.1, 43.69), heading = 92.6, radius = 10.0 },
				}
			}
		},

		ParkirajHelikopter = {
			vector3(448.78, -981.1, 42.69),
		},

		Lift = {},

		Budzenje = {},

		BossActions = {},

		ParkirajAuto = {
		},

		Cloakrooms = {},

	}

}

Config.Vozila = {
	police = {
		{ carname = 'golfpd', label = 'Volkswagen Golf' },
		{ carname = 'lrdiscovery', label = 'Land Rover Discovery' },
		{ carname = 'pboxer', label = 'Peugeout Boxer' },
		{ carname = 'pkaroq', label = 'Skoda Karoq' },
		{ carname = 'plcruiser', label = 'Land Cruiser' },
		{ carname = 'policeb', label = 'BMW R1200' },
		{ carname = 'ppajero', label = 'Mitshubishi Pajero' },
		{ carname = 'prapid', label = 'Skoda Rapid' },
		{ carname = 'presretac', label = 'Audi A4 Presretac' },
		{ carname = 'saj', label = 'Mercedes G Klasa' },
		{ carname = 'soctaviapn', label = 'Skoda Octavia' },
		{ carname = 'superbu', label = 'Skoda Superb' },
		{ carname = 'fiat2014', label = 'fiat2014' },
		{ carname = 'pdrover', label = 'Land Rover' },
		{ carname = 'zandvarmerija', label = 'Jeeap' },
	},
	sheriff = {
		{ carname = 'umtahoe', label = 'Chevrolet Tahoe' },
		{ carname = 'ACTPOLavantum', label = 'Audi RS7' },
		{ carname = 'bmwm5', label = 'BMW M5' },
		{ carname = 'e63unmark', label = 'Mercedes E63' },
		{ carname = 'presretac', label = 'Audi A6' }
	},
	deltaforce = {
		{ carname = 'umtahoe', label = 'Chevrolet Tahoe' },
		{ carname = 'ACTPOLavantum', label = 'Audi RS7' },
		{ carname = 'bmwm5', label = 'BMW M5' },
		{ carname = 'e63unmark', label = 'Mercedes E63' },
		{ carname = 'presretac', label = 'Audi A6' },
	}
}

Config.Uniforms = {

	saobracajac = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 92,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 52,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 113,    ['chain_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},

	oficir = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 92,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 52,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 113,    ['chain_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},

	interventa = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 110,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,       ['arms_2'] = 0,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 113,    ['chain_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},

	inspektor = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 102,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 52,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 113,    ['chain_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},

	nacelnik = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		}
	},

	narednik = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		}
	},
	gilet_wear = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	}

}

Config.Colors = {
	{ label = 'Crna', value = 'black'},
	{ label = 'Bela', value = 'white'},
	{ label = 'Siva', value = 'grey'},
	{ label = 'Crvena', value = 'red'},
	{ label = 'Roza', value = 'pink'},
	{ label = 'Plava', value = 'blue'},
	{ label = 'Žuta', value = 'yellow'},
	{ label = 'Zelena', value = 'green'},
	{ label = 'Narandžasta', value = 'orange'},
	{ label = 'Braon', value = 'brown'},
	{ label = 'Ljubičasta', value = 'purple'},
	{ label = 'Hromiran', value = 'chrome'},
	{ label = 'Zlatan', value = 'gold'}
}

function GetColors(color)
	local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = _U('black')},
			{ index = 1, label = _U('graphite')},
			{ index = 2, label = _U('black_metallic')},
			{ index = 3, label = _U('caststeel')},
			{ index = 11, label = _U('black_anth')},
			{ index = 12, label = _U('matteblack')},
			{ index = 15, label = _U('darknight')},
			{ index = 16, label = _U('deepblack')},
			{ index = 21, label = _U('oil')},
			{ index = 147, label = _U('carbon')}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = _U('vanilla')},
			{ index = 107, label = _U('creme')},
			{ index = 111, label = _U('white')},
			{ index = 112, label = _U('polarwhite')},
			{ index = 113, label = _U('beige')},
			{ index = 121, label = _U('mattewhite')},
			{ index = 122, label = _U('snow')},
			{ index = 131, label = _U('cotton')},
			{ index = 132, label = _U('alabaster')},
			{ index = 134, label = _U('purewhite')}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = _U('silver')},
			{ index = 5, label = _U('metallicgrey')},
			{ index = 6, label = _U('laminatedsteel')},
			{ index = 7, label = _U('darkgray')},
			{ index = 8, label = _U('rockygray')},
			{ index = 9, label = _U('graynight')},
			{ index = 10, label = _U('aluminum')},
			{ index = 13, label = _U('graymat')},
			{ index = 14, label = _U('lightgrey')},
			{ index = 17, label = _U('asphaltgray')},
			{ index = 18, label = _U('grayconcrete')},
			{ index = 19, label = _U('darksilver')},
			{ index = 20, label = _U('magnesite')},
			{ index = 22, label = _U('nickel')},
			{ index = 23, label = _U('zinc')},
			{ index = 24, label = _U('dolomite')},
			{ index = 25, label = _U('bluesilver')},
			{ index = 26, label = _U('titanium')},
			{ index = 66, label = _U('steelblue')},
			{ index = 93, label = _U('champagne')},
			{ index = 144, label = _U('grayhunter')},
			{ index = 156, label = _U('grey')}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = _U('red')},
			{ index = 28, label = _U('torino_red')},
			{ index = 29, label = _U('poppy')},
			{ index = 30, label = _U('copper_red')},
			{ index = 31, label = _U('cardinal')},
			{ index = 32, label = _U('brick')},
			{ index = 33, label = _U('garnet')},
			{ index = 34, label = _U('cabernet')},
			{ index = 35, label = _U('candy')},
			{ index = 39, label = _U('matte_red')},
			{ index = 40, label = _U('dark_red')},
			{ index = 43, label = _U('red_pulp')},
			{ index = 44, label = _U('bril_red')},
			{ index = 46, label = _U('pale_red')},
			{ index = 143, label = _U('wine_red')},
			{ index = 150, label = _U('volcano')}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = _U('electricpink')},
			{ index = 136, label = _U('salmon')},
			{ index = 137, label = _U('sugarplum')}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = _U('topaz')},
			{ index = 60, label = _U('light_blue')},
			{ index = 61, label = _U('galaxy_blue')},
			{ index = 62, label = _U('dark_blue')},
			{ index = 63, label = _U('azure')},
			{ index = 64, label = _U('navy_blue')},
			{ index = 65, label = _U('lapis')},
			{ index = 67, label = _U('blue_diamond')},
			{ index = 68, label = _U('surfer')},
			{ index = 69, label = _U('pastel_blue')},
			{ index = 70, label = _U('celeste_blue')},
			{ index = 73, label = _U('rally_blue')},
			{ index = 74, label = _U('blue_paradise')},
			{ index = 75, label = _U('blue_night')},
			{ index = 77, label = _U('cyan_blue')},
			{ index = 78, label = _U('cobalt')},
			{ index = 79, label = _U('electric_blue')},
			{ index = 80, label = _U('horizon_blue')},
			{ index = 82, label = _U('metallic_blue')},
			{ index = 83, label = _U('aquamarine')},
			{ index = 84, label = _U('blue_agathe')},
			{ index = 85, label = _U('zirconium')},
			{ index = 86, label = _U('spinel')},
			{ index = 87, label = _U('tourmaline')},
			{ index = 127, label = _U('paradise')},
			{ index = 140, label = _U('bubble_gum')},
			{ index = 141, label = _U('midnight_blue')},
			{ index = 146, label = _U('forbidden_blue')},
			{ index = 157, label = _U('glacier_blue')}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = _U('yellow')},
			{ index = 88, label = _U('wheat')},
			{ index = 89, label = _U('raceyellow')},
			{ index = 91, label = _U('paleyellow')},
			{ index = 126, label = _U('lightyellow')}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = _U('met_dark_green')},
			{ index = 50, label = _U('rally_green')},
			{ index = 51, label = _U('pine_green')},
			{ index = 52, label = _U('olive_green')},
			{ index = 53, label = _U('light_green')},
			{ index = 55, label = _U('lime_green')},
			{ index = 56, label = _U('forest_green')},
			{ index = 57, label = _U('lawn_green')},
			{ index = 58, label = _U('imperial_green')},
			{ index = 59, label = _U('green_bottle')},
			{ index = 92, label = _U('citrus_green')},
			{ index = 125, label = _U('green_anis')},
			{ index = 128, label = _U('khaki')},
			{ index = 133, label = _U('army_green')},
			{ index = 151, label = _U('dark_green')},
			{ index = 152, label = _U('hunter_green')},
			{ index = 155, label = _U('matte_foilage_green')}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = _U('tangerine')},
			{ index = 38, label = _U('orange')},
			{ index = 41, label = _U('matteorange')},
			{ index = 123, label = _U('lightorange')},
			{ index = 124, label = _U('peach')},
			{ index = 130, label = _U('pumpkin')},
			{ index = 138, label = _U('orangelambo')}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = _U('copper')},
			{ index = 47, label = _U('lightbrown')},
			{ index = 48, label = _U('darkbrown')},
			{ index = 90, label = _U('bronze')},
			{ index = 94, label = _U('brownmetallic')},
			{ index = 95, label = _U('Expresso')},
			{ index = 96, label = _U('chocolate')},
			{ index = 97, label = _U('terracotta')},
			{ index = 98, label = _U('marble')},
			{ index = 99, label = _U('sand')},
			{ index = 100, label = _U('sepia')},
			{ index = 101, label = _U('bison')},
			{ index = 102, label = _U('palm')},
			{ index = 103, label = _U('caramel')},
			{ index = 104, label = _U('rust')},
			{ index = 105, label = _U('chestnut')},
			{ index = 108, label = _U('brown')},
			{ index = 109, label = _U('hazelnut')},
			{ index = 110, label = _U('shell')},
			{ index = 114, label = _U('mahogany')},
			{ index = 115, label = _U('cauldron')},
			{ index = 116, label = _U('blond')},
			{ index = 129, label = _U('gravel')},
			{ index = 153, label = _U('darkearth')},
			{ index = 154, label = _U('desert')}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = _U('indigo')},
			{ index = 72, label = _U('deeppurple')},
			{ index = 76, label = _U('darkviolet')},
			{ index = 81, label = _U('amethyst')},
			{ index = 142, label = _U('mysticalviolet')},
			{ index = 145, label = _U('purplemetallic')},
			{ index = 148, label = _U('matteviolet')},
			{ index = 149, label = _U('mattedeeppurple')}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = _U('brushedchrome')},
			{ index = 118, label = _U('blackchrome')},
			{ index = 119, label = _U('brushedaluminum')},
			{ index = 120, label = _U('chrome')}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = _U('gold')},
			{ index = 158, label = _U('puregold')},
			{ index = 159, label = _U('brushedgold')},
			{ index = 160, label = _U('lightgold')}
		}
	end
	return colors
end