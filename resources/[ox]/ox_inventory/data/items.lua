return {

	['meteorite'] = {
		label = 'Meteorite',
		weight = 80,
	},

	['hotdog'] = {
		label = 'Hotdog',
		weight = 120,
	},

	['taco'] = {
		label = 'Taco',
		weight = 180,
	},

	['piswasser'] = {
		label = 'Piswasser',
		weight = 500,
	},

	['mount_whisky'] = {
		label = 'Mount Viski',
		weight = 500,
	},

	['tequila'] = {
		label = 'Tekila',
		weight = 500,
	},

	['nogo_vodka'] = {
		label = 'Nogo vodka',
		weight = 500,
	},

	['raine'] = {
		label = 'Raine voda',
		weight = 250,
	},

	['spray_remover'] = {
		label = 'Cistac grafita',
		weight = 250,
	},

	['spray'] = {
		label = 'Sprej',
		weight = 250,
	},

	['bean_machine_coffe'] = {
		label = 'Kafa',
		weight = 250,
	},

	['uvlight'] = {
		label = 'UV Svetlo',
		stack = false,
		weight = 100,
	},

	['shot_mount_whisky'] = {
		label = 'Casa Mount Viski',
		weight = 330,
	},

	['shot_nogo_vodka'] = {
		label = 'Casa Nogo Vodka',
		weight = 330,
	},

	['shot_tequila'] = {
		label = 'Casa Tekila',
		weight = 330,
	},

	['costa_del_perro'] = {
		label = 'Costa Del Perro',
		weight = 330,
	},

	['rockford_hill'] = {
		label = 'Rockford Hill Reserve',
		weight = 330,
	},

	['vinewood_red'] = {
		label = 'Vinewood Red Zinfadel',
		weight = 330,
	},

	['vinewood_blanc'] = {
		label = 'Vinewood Sauvignon Blanc',
		weight = 330,
	},

	['glass_costa_del_perro'] = {
		label = 'Casa Costa Del Perro',
		weight = 330,
	},

	['glass_rockford_hill'] = {
		label = 'Casa Rockford Hill Reserve',
		weight = 330,
	},

	['glass_vinewood_red'] = {
		label = 'Casa Vinewood Red Zinfadel',
		weight = 330,
	},

	['glass_vinewood_blanc'] = {
		label = 'Casa Vinewood Sauvignon Blanc',
		weight = 330,
	},

	['glukoza'] = {
		label = '100g Glukoza',
		weight = 250,
	},

	['blok_koke'] = {
		label = 'Blok kokaina (500g)',
		weight = 500,
	},

	['kesica'] = {
		label = 'Prazna kesica',
		weight = 1,
	},

	['kesica_koke'] = {
		label = '50g 35% Kokain',
		weight = 50,
	},

	['jewels'] = {
		label = 'Nakit',
		weight = 50,
	},

	['bandage'] = {
		label = 'Zavoj',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['list_koke'] = {
		label = 'Biljka kokaina',
		weight = 50,
	},

	['list_trave'] = {
		label = 'Biljka trave',
		weight = 50,
	},

	['list_trave2'] = {
		label = 'List trave',
		weight = 50,
	},

	['upaljac'] = {
		label = 'Upaljac',
		weight = 30,
	},

	['tompus'] = {
		label = 'Tompus',
		weight = 100,
	},

	['cigara'] = {
		label = 'Cigara',
		weight = 10,
	},

	['joint'] = {
		label = 'Joint',
		weight = 20,
	},

	['kesica_metha'] = {
		label = 'Kesica Metha',
		weight = 20,
	},
	
	['meth'] = {
		label = 'Meth',
	},

	['rizle'] = {
		label = 'rizle',
		weight = 50,
		durability = 100.0,
		buttons = {
			{
				label = 'Napravi joint',
				action = function(slot)
					TriggerEvent('dark-droge:napravijoint')
				end
			},
		}
	},

	['marlboro'] = {
		label = 'Marlboro',
		weight = 100,
	},

	
	['snus'] = {
		label = 'Snus',
		weight = 200,
	},

	['black_money'] = {
		label = 'Prljav novac',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
	},

	['cola'] = {
		label = 'Kola',
		weight = 330,
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 330,
	},

	['iron'] = {
		label = 'Metal',
		weight = 100,
		stack = false,
	},

	['gold'] = {
		label = 'Zlato',
		weight = 200,
		stack = false,
	},
	
	['stone'] = {
		label = 'Kamen',
		weight = 150,
		stack = false,
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['thermal'] = {
		label = 'Termalna Bomba',
		weight = 50,
		stack = false,
	},

	['hack_device'] = {
		label = 'Uredjaj za hakovanje',
		weight = 100,
		stack = false,
	},

	['gold_bar'] = {
		label = 'Zlatna poluga',
		weight = 500,
	},

	['dia_box'] = {
		label = 'Dijamantska poluga',
		weight = 500,
	},

	['id_card_f'] = {
		label = 'ID Kartica Fleeca',
		weight = 50,
	},

	['secure_card'] = {
		label = 'Sigurnosna Kartica Fleeca',
		weight = 50,
	},

	['licna'] = {
		label = 'Licna Karta',
	},

	['vozacka'] = {
		label = 'Vozacka dozvola',
	},

	['oruzije'] = {
		label = 'Dozvola za oruzije',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		consume = 0,
		client = {
			anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
			disable = { move = true, car = true, combat = true },
			usetime = 5000,
			cancel = true
		}
	},

	['alcotester'] = {
		label = 'Alkotest',
	},

	['phone'] = {
		label = 'Telefon',
		weight = 190,
		stack = false,
		consume = 0,
		--client = {
		--	add = function(total)
		--		if total > 0 and GetResourceState('npwd') == 'started' then
		--			exports.npwd:setPhoneDisabled(false)
		--		end
		--	end,

		--	remove = function(total)
		--		if total < 1 and GetResourceState('npwd') == 'started' then
		--			exports.npwd:setPhoneDisabled(true)
		--		end
		--	end
		--}
	},

	['money'] = {
		label = 'Novac',
	},

	['ndrvo'] = {
		label = 'Neobradjeno drvo',
		weight = 250,
		stack = false,
	},

	['pdrvo'] = {
		label = 'Obradjeno drvo',
		weight = 220,
		stack = false,
	},

	['tresnje'] = {
		label = 'Tresnja',
		weight = 5,
	},

	['medikit'] = {
		label = 'Prva pomoc',
		weight = 100,
	},


	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Voda',
		weight = 250,
	},

	['radio'] = {
		label = 'Radio',
		weight = 100,
		consume = 0,
		allowArmed = true
	},

	['armour'] = {
		label = 'Neprobojni pancir',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
		}
	},
}
