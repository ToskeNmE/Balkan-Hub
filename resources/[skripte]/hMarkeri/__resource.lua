resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config/*.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config/*.lua',
	'client/*.lua'
}