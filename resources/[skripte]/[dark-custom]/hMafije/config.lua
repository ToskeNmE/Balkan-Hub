Config  = {}
Config.EnableESXIdentity  = true -- ako koristite esx_identity
Config.Webhuk = "" -- Ovdje dodajete svoj wehuk za mafije da imate logove itd :)
Config.Locale  = 'hr'

Config.Propovi = {
	Arrmory = 'prop_ld_int_safe_01',
	Vozila = 'prop_parknmeter_01',
	BossMenu = 'prop_tool_bench02',
}

Config.Level = {
	['0'] = {
		label = 'iron',
        cena = 0,
	},
	['1'] = {
		label = 'bronze',
        cena = 10,
	},
	['2'] = {
		label = 'silver',
        cena = 20,
	},
	['3'] = {
		label = 'gold',
        cena = 30,
	},
	['4'] = {
		label = 'platinum',
        cena = 40,
	},
	['5'] = {
		label = 'diamond',
        cena = 50,
	},
}

-- OVDJE DODAJETE NOVE POSLOVE SVE
Config.Mafije = {
    cigani = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1145.94, 4898.27, 220.97), heading = 214.38},
        },
        Vehicles = {
            {coords = vector3(-1077.83, 4911.5, 213.87), heading = 147.38},
        },
        BossActions = {
            {coords = vector3(-1133.47, 4948.584, 222.26), heading = 70.07},
        },
        SpawnLocation = vector3(-1071.72, 4906.41, 212.97),
        MeniVozila = {
            ['peyote'] = 'Vapid Peyote',
            ['ztype'] = 'Truffade Z-Type',
            ['stratum'] = 'Zirconium Stratum',
            ['rs5'] = 'rs5',
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = true,
        Nabudzi = true,
        Tablice = 'CIGANI', -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    delije = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(558.3274, -1759.89, 29.314), heading = 68.29},
        },
        Vehicles = {
            {coords = vector3(561.8573, -1770.69, 29.356), heading = 337.55},
        },
        BossActions = {
            {coords = vector3(550.6295, -1770.61, 33.442), heading = 69.31},
        },
        SpawnLocation = vector3(572.4630, -1754.84, 29.168),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    narcos = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-2618.64, 1707.666, 142.37), heading = 143.68},
        },
        Vehicles = {
            {coords = vector3(-2606.98, 1674.017, 141.86), heading = 126.73},
        },
        BossActions = {
            {coords = vector3(-2619.33, 1711.273, 146.32), heading = 21.1},
        },
        SpawnLocation = vector3(-2604.00, 1677.341, 141.86),
        MeniVozila = {
            ['s500w223'] = 'Mercedes S500',
            ['W463A1'] = 'Mercedes G500 Brabus',
            ['rmodlp750'] = 'Lamborghini Huracan LP750'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    grobari = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-917.200, -1526.63, 5.1765), heading = 23.91},
        },
        Vehicles = {
            {coords = vector3(-901.129, -1535.39, 5.0223), heading = 206.55},
        },
        BossActions = {
            {coords = vector3(-904.383, -1514.47, 5.0239), heading = 295.83},
        },
        SpawnLocation = vector3(-906.984, -1537.52, 5.0236),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    vwgroup = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(145.8890, -150.370, 60.488), heading = 17.2},
        },
        Vehicles = {
            {coords = vector3(150.8464, -121.555, 54.826), heading = 339.33},
        },
        BossActions = {
            {coords = vector3(142.0933, -165.040, 60.488), heading = 151.19},
        },
        SpawnLocation = vector3(142.9615, -123.110, 54.813),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    kavacki = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1111.68, 314.2474, 66.977), heading = 173.25},
        },
        Vehicles = {
            {coords = vector3(-1117.32, 301.5229, 66.321), heading = 351.27},
        },
        BossActions = {
            {coords = vector3(-1096.15, 318.8760, 66.577), heading = 261.92},
        },
        SpawnLocation = vector3(-1129.68, 306.1525, 66.183),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    bonnano = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1296.90, 506.2532, 97.559), heading = 2.73},
        },
        Vehicles = {
            {coords = vector3(-1266.51, 511.0917, 97.132), heading = 359.49},
        },
        BossActions = {
            {coords = vector3(-1290.04, 500.8432, 97.559), heading = 265.86},
        },
        SpawnLocation = vector3(-1270.13, 500.3276, 97.176),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    autoplac = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-12.6031, -1662.35, 33.044), heading = 169.08},
        },
        Vehicles = {
            {coords = vector3(-25.9093, -1683.78, 29.384), heading = 208.13},
        },
        BossActions = {
            {coords = vector3(-24.3427, -1671.20, 29.479), heading = 229.9},
        },
        SpawnLocation = vector3(-30.8052, -1680.61, 29.441),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    hellangels = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1452.84, 501.3072, 117.59), heading = 278.76},
        },
        Vehicles = {
            {coords = vector3(-1470.62, 509.6037, 117.62), heading = 192.66},
        },
        BossActions = {
            {coords = vector3(-1459.87, 499.9163, 117.59), heading = 100.68},
        },
        SpawnLocation = vector3(-1472.35, 515.0545, 117.89),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    yakuza = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-111.844, 1001.158, 235.76), heading = 109.16},
        },
        Vehicles = {
            {coords = vector3(-127.979, 1007.993, 235.73), heading = 114.51},
        },
        BossActions = {
            {coords = vector3(-104.654, 1010.495, 235.75), heading = 110.18},
        },
        SpawnLocation = vector3(-126.596, 1004.188, 235.73),
        MeniVozila = {
            ['gxevox'] = 'gxevox',
            ['pgt322'] = 'porsche 911'
        }, 
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    zemunski = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-2587.80, 1911.126, 167.49), heading = 186.05},
        },
        Vehicles = {
            {coords = vector3(-2597.12, 1928.138, 167.30), heading = 189.86},
        },
        BossActions = {
            {coords = vector3(-2603.55, 1915.589, 163.45), heading = 2.79},
        },
        SpawnLocation = vector3(-2587.29, 1930.648, 167.30),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    elchapo = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(1407.402, 1155.023, 114.44), heading = 91.33},
        },
        Vehicles = {
            {coords = vector3(1400.290, 1122.250, 114.83), heading = 359.29},
        },
        BossActions = {
            {coords = vector3(1400.570, 1127.180, 114.33), heading = 2.29},
        },
        SpawnLocation = vector3(1407.466, 1118.233, 114.83),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },

    crips = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(495.1947, -1832.86, 28.446), heading = 48.6},
        },
        Vehicles = {
            {coords = vector3(510.7856, -1849.37, 27.079), heading = 215.09},
        },
        BossActions = {
            {coords = vector3(500.0484, -1832.12, 28.502), heading = 323.02},
        },
        SpawnLocation = vector3(505.3275, -1844.23, 27.465),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['bmwg07'] = 'BMW X7',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },

    automafija = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(728.1610, -1064.38, 22.168), heading = 357.89},
        },
        Vehicles = {
            {coords = vector3(735.2141, -1093.67, 22.169), heading = 173.88},
        },
        BossActions = {
            {coords = vector3(725.8359, -1066.62, 28.311), heading = 85.49},
        },
        SpawnLocation = vector3(731.3280, -1088.90, 22.169),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    cosanostra = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-980.568, 117.4327, 55.853), heading = 216.07},
        },
        Vehicles = {
            {coords = vector3(-965.096, 110.4140, 56.028), heading = 43.67},
        },
        BossActions = {
            {coords = vector3(-971.071, 122.4585, 57.048), heading = 131.37},
        },
        SpawnLocation = vector3(-957.105, 113.9744, 56.785),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    italijani = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-949.462, 196.0877, 67.390), heading = 348.64},
        },
        Vehicles = {
            {coords = vector3(-954.148, 184.5756, 66.587), heading = 172.79},
        },
        BossActions = {
            {coords = vector3(-958.168, 204.2642, 67.745), heading = 258.21},
        },
        SpawnLocation = vector3(-956.628, 187.9444, 66.582),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    ruska = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-812.209, 175.0342, 76.745), heading = 286.17},
        },
        Vehicles = {
            {coords = vector3(-833.055, 179.3735, 71.104), heading = 90.76},
        },
        BossActions = {
            {coords = vector3(-801.258, 178.8001, 76.740), heading = 286.05},
        },
        SpawnLocation = vector3(-826.064, 179.4619, 71.393),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    komiti = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1932.15, 362.3573, 93.788), heading = 280.78},
        },
        Vehicles = {
            {coords = vector3(-1939.50, 364.4742, 93.727), heading = 10.92},
        },
        BossActions = {
            {coords = vector3(-1917.42, 368.0633, 93.781), heading = 105.17},
        },
        SpawnLocation = vector3(-1938.80, 357.3908, 93.375),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    scarface = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1985.22, 642.7127, 122.53), heading = 153.22},
        },
        Vehicles = {
            {coords = vector3(-1973.30, 618.6631, 122.07), heading = 156.32},
        },
        BossActions = {
            {coords = vector3(-1985.22, 642.7127, 122.53), heading = 245.79},
        },
        SpawnLocation = vector3(-1970.45, 621.9993, 122.00),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    ballas = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(112.5310, -1961.11, 20.950), heading = 201.68},
        },
        Vehicles = {
            {coords = vector3(105.0828, -1954.28, 20.671), heading = 181.56},
        },
        BossActions = {
            {coords = vector3(125.5975, -1956.87, 20.734), heading = 49.64},
        },
        SpawnLocation = vector3(107.8339, -1943.48, 20.803),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    gsf = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-17.8798, -1439.19, 31.101), heading = 86.13},
        },
        Vehicles = {
            {coords = vector3(-19.9927, -1444.61, 30.615), heading = 83.31},
        },
        BossActions = {
            {coords = vector3(-9.44784, -1439.27, 31.101), heading = 272.88},
        },
        SpawnLocation = vector3(-25.4207, -1439.67, 30.654),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    ludisrbi = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1912.01, 2073.675, 140.38), heading = 316.25},
        },
        Vehicles = {
            {coords = vector3(-1920.43, 2048.764, 140.73), heading = 76.15},
        },
        BossActions = {
            {coords = vector3(-1885.85, 2075.003, 140.99), heading = 162.7},
        },
        SpawnLocation = vector3(-1923.42, 2040.399, 140.73),
        MeniVozila = {
            ['pgt322'] = 'porsche 911',
            ['senna'] = 'MC LAREN SENNA',
            ['gxevox'] = 'EVO GX',   
            ['s63amg18'] = 'S63',   
        },  
        --Boja = 145, -- boja vozila :)
        Zatamni = true,
        Nabudzi = true,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    pinkpanter = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1153.64, -1522.08, 10.642), heading = 221.22},
        },
        Vehicles = {
            {coords = vector3(-1151.61, -1519.82, 4.3652), heading = 301.33},
        },
        BossActions = {
            {coords = vector3(-1158.62, -1518.43, 10.632), heading = 32.59},
        },
        SpawnLocation = vector3(-1161.19, -1526.48, 4.2474),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    camorra = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(227.9855, 766.2496, 204.78), heading = 242.52},
        },
        Vehicles = {
            {coords = vector3(220.0788, 756.6828, 204.78), heading = 243.3},
        },
        BossActions = {
            {coords = vector3(232.5899, 773.8634, 204.78), heading = 238.34},
        },
        SpawnLocation = vector3(213.6332, 760.7933, 204.75),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    josamsedamgang = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1507.42, 99.71697, 60.797), heading = 223.16},
        },
        Vehicles = {
            {coords = vector3(-1536.16, 84.23674, 56.776), heading = 136.73},
        },
        BossActions = {
            {coords = vector3(-1531.75, 143.7152, 60.798), heading = 220.32},
        },
        SpawnLocation = vector3(-1525.35, 90.48928, 56.520),
        Helikopter = {vector3(-1554.23, 108.4805, 56.779)},
        SpawnHelija = vector3(-1572.87, 94.81968, 58.455),
        MeniHelia = {
            ['buzzard2'] = 'Buzzard2',
        },
        MeniVozila = {
            ['bdivo'] = 'Bugatti Divo',
            ['bmwg07'] = 'BMW X7',
            ['rc'] = 'KTM RC',
            ['rmodlp750'] = 'Lamborghini LP750',
            ['pgt322'] = 'porsche 911'
        },
        Boja = 74, -- boja vozila :)
        Zatamni = true,
        Nabudzi = true,
        Tablice = '187', -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    favela = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(22.66713, 4370.327, 42.927), heading = 2.03},
        },
        Vehicles = {
            {coords = vector3(-49.4708, 4419.076, 57.568), heading = 47.52},
        },
        BossActions = {
            { coords = vector3(17.21597, 4348.628, 47.984), heading = 176.03},
        },
        SpawnLocation = vector3(-49.4708, 4419.076, 57.568),
        Helikopter = {vector3(-63.8262, 4396.047, 55.662)},
        SpawnHelija = vector3(-56.0487, 4397.489, 55.982),
        MeniHelia = {
            ['buzzard2'] = 'Buzzard2',
        },
        MeniVozila = {
            ['sanchez'] = 'Sanchez',
            ['mesa3'] = 'Mesa',
            ['sultan'] = 'Sultan',
            ['rumpo3'] = 'Rumpo',
            ['technical2'] = 'Technical',
            ['pgt322'] = 'Porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = true,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    cleanbois = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(-1790.29, 420.0838, 132.30), heading = 179.93},
        },
        Vehicles = {
            {coords = vector3(-1792.14, 463.6586, 128.30), heading = 19.21},
        },
        BossActions = {
            {coords = vector3(-1795.45, 420.6714, 132.25), heading = 290.31},
        },
        SpawnLocation = vector3(-1798.46, 458.2591, 128.30),
        MeniVozila = {
            ['W463A1'] = 'Mercedes G500 Brabus',
            ['s500w223'] = 'Mercedes S500',
            ['c63w205'] = 'Mercedes C63',
            ['pgt322'] = 'porsche 911'
        },
        Boja = 12, -- boja vozila :)
        Zatamni = true,
        Nabudzi = true,
        Tablice = 'CL34NBO15', -- ovdje stavljate ovako: Tablice = 'TEST'
    },
    bahama = {
        --Cloakrooms = {vector3(0,0,0)},
        Armories = {
            {coords = vector3(1993.492, 3050.436, 47.215), heading = 335.66},
        },
        Vehicles = {
            {coords = vector3(2010.477, 3051.596, 47.213), heading = 236.81},
        },
        BossActions = {
            {coords = vector3(1990.378, 3045.635, 47.215), heading = 147.15},
        },
        SpawnLocation = vector3(1998.999, 3061.310, 47.049),
        MeniVozila = {
            ['baller'] = 'Baller',
            ['pgt322'] = 'porsche 911'
        },
        --Boja = 145, -- boja vozila :)
        Zatamni = false,
        Nabudzi = false,
        --Tablice = nil, -- ovdje stavljate ovako: Tablice = 'TEST'
    }
}


Config.VozilaZaProdaju = {
    {ime = "610lb", cena = 200},
    {ime = "4444", cena = 100},
    {ime = "aventsvjr", cena = 75},
    {ime = "bc", cena = 50},
    {ime = "f620s", cena = 75},
    {ime = "gls600", cena = 75},
    {ime = "gxevox", cena = 100},
    {ime = "m13fortwo", cena = 100},
    {ime = "mgt18lb", cena = 100},
    {ime = "nh2r", cena = 150},
    {ime = "pgt322", cena = 150},
    {ime = "s63amg18", cena = 75},
    {ime = "s1000rr", cena = 90},
    {ime = "senna", cena = 75},
    {ime = "sunrise1", cena = 100},
    {ime = "urus2018", cena = 100},
    {ime = "venenor", cena = 100},
    {ime = "xxxxx", cena = 100},
    {ime = "zx10r", cena = 100},
}
