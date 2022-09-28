resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0.0'
lua54 'yes'
shared_script '@ox_lib/init.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	--'oruzarnica/server.lua',
	--'oruzarnica/config.lua',

}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	--'oruzarnica/client.lua',
	--'oruzarnica/config.lua',

}