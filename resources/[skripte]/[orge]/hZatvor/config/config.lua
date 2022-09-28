Zconfig = {}

Zconfig.JailPositions = {
	["Cell"] = { ["x"] = 1758.44, ["y"] = 2490.21, ["z"] = 45.84, ["h"] = 130.15 }
}

Zconfig.Cutscene = {
	["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },

	["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },

	["PolicePosition"] = { ["x"] = 402.91702270508, ["y"] = -1000.6376953125, ["z"] = -99.004028320313, ["h"] = 356.88052368164 }
}

Zconfig.PrisonWork = {
	["DeliverPackage"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0 },

	["Packages"] = {
		[1] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["state"] = true }
	}
}

Zconfig.Teleports = {
	["Prison Work"] = { 
		["x"] = 0.00, 
		["y"] = 0.00, 
		["z"] = 0.00, 
		["h"] = 0.00, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["x"] = 1846.493, 
		["y"] = 2585.988, 
		["z"] = 45.672, 
		["h"] = 267.6, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["x"] = 0.00, 
		["y"] = 0.00, 
		["z"] = 0.00, 
		["h"] = 0.00, 
		["goal"] = { 
			"Prison Work", 
			"Security", 
			"Visitor" 
		} 
	},

	["Security"] = { 
		["x"] = 0.00,
		["y"] = 0.00, 
		["z"] = 0.00, 
		["h"] = 0.00, 
		["goal"] = { 
			"Jail",
			"Boiling Broke"
		} 
	},

	["Visitor"] = {
		["x"] = 0.00, 
		["y"] = 0.00, 
		["z"] = 0.00, 
		["h"] = 0.00, 
		["goal"] = { 
			"Jail" 
		} 
	}
}