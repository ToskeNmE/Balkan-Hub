fx_version 'cerulean'
games { 'gta5' }

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/ui.css',
    'html/ui.js',
    'html/jquery.min.js',
    'html/character.png',
    'html/background.png',
}


client_scripts {
    'config.lua',
    'client/main.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/main.lua',
}