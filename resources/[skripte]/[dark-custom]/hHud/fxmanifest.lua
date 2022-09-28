
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/*.png',
	'html/script.js',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}