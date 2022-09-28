fx_version 'cerulean'
games { 'gta5' }

shared_script {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/images/*.png',
    'html/images/*.jpg'
}