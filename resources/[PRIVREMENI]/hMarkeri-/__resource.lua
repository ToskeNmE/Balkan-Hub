resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.1.1'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

