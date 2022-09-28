fx_version 'cerulean'
game 'gta5'

lua54 'yes'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/images/*.png'
}

shared_scripts {
	'@es_extended/locale.lua',
	'@es_extended/imports.lua',
	'prevod/*',
	'config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*'
}

client_script 'client/*'

dependencies {
	'/onesync',
	'es_extended',
}
