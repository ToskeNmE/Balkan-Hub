fx_version 'adamant'

game 'gta5'

description 'ESX Vangelico Robbery'

version '2.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/esx_vangelico_robbery_cl.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/esx_vangelico_robbery_sv.lua'
}

dependencies {
	'es_extended'
}
