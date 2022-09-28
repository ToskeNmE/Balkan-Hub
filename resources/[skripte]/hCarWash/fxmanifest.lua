fx_version   'cerulean'
lua54 'yes'
game         'gta5'

client_script {

    "client.lua",
    "config.lua",
}
server_script {
    "config.lua",
    "server.lua",
}

shared_scripts {
	'@ox_lib/init.lua',
}

ui_page "html/index.html"

files {
    'html/*',
    'html/fonts/*',
}
