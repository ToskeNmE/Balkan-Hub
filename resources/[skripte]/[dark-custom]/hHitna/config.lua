Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 300  -- Revive reward, set to 0 if you don't want it enabled
Config.SaveDeathStatus              = true -- Save Death Status?
Config.LoadIpl                    = false -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 20 -- time til the player bleeds out

Config.EnablePlayerManagement     = false -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.OxInventory = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	{coords = vector3(341.0, -1397.3, 32.5), heading = 48.5}
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(311.7493, -595.750, 43.284),
			sprite = 621,
			scale  = 0.65,
			color  = 1
		},

		Vehicles = {
			{
				Spawner = {coords = vector3(298.6103, -604.738, 42.242), heading = 116.89},
				SpawnPoints = {
					{coords = vector3(297.2820, -608.120, 43.266), heading = 67.18, radius = 4.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(340.0334, -587.212, 74.161),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.8533, -588.005, 74.161), heading = 249.12, radius = 10.0}
				}
			}
		},

	}
}

Config.Vozila = {
	{ label = 'Kombi', carname = 'emsnspeedo' }
}

Config.Uniforms = {

	hitna = {
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
}