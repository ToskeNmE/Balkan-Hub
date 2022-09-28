lua54 'yes'
game 'gta5'
fx_version 'adamant'

escrow_ignore {
  'config.lua' 
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/*.lua'
}