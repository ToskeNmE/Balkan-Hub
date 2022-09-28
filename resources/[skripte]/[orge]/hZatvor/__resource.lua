resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"config/*.lua",
	"server/*.lua"
}

client_scripts {
	"config/*.lua",
	"client/*.lua"
}

files {
	'html/index.html',
	'html/*.css',
	'html/*.js',
	'html/*.png'
}