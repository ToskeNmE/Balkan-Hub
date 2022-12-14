Config = {
      MenuHead = 'Dpemotes',
      -- Change the language of the menu here!.
      -- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
      -- try en, fr, de or sv.
	MenuLanguage = 'en',	
      -- Set this to true to enable some extra prints
	DebugDisplay = false,
      -- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
      -- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= true,
      -- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = false,
      -- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 'F3', -- Get the button name here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can disable the Favorite emote KeyBinding here.
	FavKeybindEnabled = true,
	FavKeybind = 'NUMPAD4', -- Get the button name here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can change the header image for the f9 menu here
      -- Use a 512 x 128 image!
      -- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgyukle.com/2020/03/08/nwO7fe.png",
      -- You can change the menu position here
	MenuPosition = "right", -- (left, right)
      -- You can disable the Ragdoll KeyBinding here.
	RagdollEnabled = false,
	RagdollKeybind = '', -- Get the button number here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
      -- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
      -- You can disable the Shared Emotes here.
      SharedEmotesEnabled = true,
      CheckForUpdates = false,
      -- Keybinds
      KeyBinding = false,
}


Config.OpenKey = 'F3' -- Change this

Config.Languages = {
      ['en'] = {
          ['emotes'] = 'Animaciones',
          ['danceemotes'] = "???? Bailes",
          ['propemotes'] = "???? Objetos",
          ['favoriteemotes'] = "???? Favoritos",
          ['favoriteinfo'] = "Selecciona una animaci??n para hacerla favorita!.",
          ['rfavorite'] = "Reiniciar favoritas",
          ['prop2info'] = "??? Las animaciones de objetos son ajustadas al final",
          ['set'] = "Seleccionar (",
          ['setboundemote'] = ") para ser tu animacion atado?",
          ['newsetemote'] = "~w~  es ahora tu animacion atada, presiona ~g~CapsLock~w~ para usarla.",
          ['cancelemote'] = "Cancelar animaci??n",
          ['cancelemoteinfo'] = "~r~X~w~ cancela la animaci??n corriente",
          ['walkingstyles'] = "Formas de caminar",
          ['resetdef'] = "Volver a por defecto",
          ['normalreset'] = "Normal (Reiniciar)",
          ['moods'] = "Moods",
          ['infoupdate'] = "Informaci??n",
          ['infoupdateav'] = "Informaci??n(Actualizaci??n)",
          ['infoupdateavtext'] = "",
          ['suggestions'] = "Suggestions?",
          ['suggestionsinfo'] = "",
        ['notvaliddance'] = "No es un baile v??lido.",
        ['notvalidemote'] = "No es una animaci??n v??lida.",
        ['nocancel'] = "No hay animaci??n para cancelar.",
        ['maleonly'] = "No puedes usar esta animaci??n!",
        ['emotemenucmd'] = "Usa /emotemenu para abrir un menu.",
        ['shareemotes'] = "???? Compartidos",
        ['shareemotesinfo'] = "Invita a una persona cerca para realizar la animaci??n",
        ['sharedanceemotes'] = "???? Bailes compartidos",
        ['notvalidsharedemote'] = "no es una animaci??n v??lida.",
        ['sentrequestto'] = "Enviar pregunta a ~y~",
        ['nobodyclose'] = "Nadie ~r~cerca~w~ de ti.",
        ['doyouwanna'] = "~y~Y~w~ para aceptar, ~r~L~w~ para rechazar (~g~",
        ['refuseemote'] = "Animaci??n no aceptada.",
        ['makenearby'] = "Hacer que el jugador cercano lo haga",
        ['camera'] = "Pritisni ~y~G~w~ da blicas sa fotoaparatom",
        ['makeitrain'] = "Pritisni ~y~G~w~ da bacas pare",
        ['pee'] = "Sost??n ~y~G~w~ para orinar.",
        ['spraychamp'] = "Sost??n ~y~G~w~ para batir la champagna",
        ['bound'] = "Ligador ",
        ['to'] = "a",
        ['currentlyboundemotes'] = " Animaciones ligadas:",
        ['notvalidkey'] = "no es una tecla v??lida.",
        ['keybinds'] = "???? Teclas",
        ['keybindsinfo'] = "Usar"
    },
  }
