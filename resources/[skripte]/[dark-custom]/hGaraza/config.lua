Config                      = {}
Config.DrawDistance         = 15.0
Config.MarkerType           = 2
Config.MarkerSize           = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor          = {r = 28, g = 132, b = 230}
Config.MinimumHealth 		= 850.0
Config.ImpoundPrice			= 500
Config.MaxSubs				= 2

Config.Locale = 'en'

Config.Garages = {
	-- GLAVNA
	{
		Marker 	= vector3(217.2194, -807.454, 30.752),
		PullOut = vector3(232.9774, -791.062, 30.597),
		Blip	= true,
		Visible = {}
	},
	-- SPOREDNA
	{
		Marker 	= vector3(437.6189, -1305.12, 30.688),
		PullOut = vector3(437.6189, -1305.12, 30.688),
		Blip	= true,
		Visible = {}
	},
	-- VOLKSWAGEN GROUPA
	{
		Marker 	= vector3(142.4836, -127.444, 54.827),
		PullOut = vector3(147.1652, -124.913, 54.826),
		Blip	= false,
		Visible = {}
	},
}

Config.Impound = {
	{ coords = vector3(214.5900, -806.394, 29.815), heading = 338.76},
	{ coords = vector3(432.6867, -1306.75, 29.998), heading = 320.59},
	{ coords = vector3(142.6785, -130.683, 53.826), heading = 348.5},
}

Config.PoliceImpound = {
	--vector3(395.59, -976.81, -100.00)
	--vector3(244.35, -790.37, 30.48)
}

Config.SetSubowner = {
	--vector3(-531.76, -192.48, 37.32)
	--vector3(245.78, -786.33, 29.62)
}