fx_version 'cerulean'
games { 'rdr3', 'gta5' }

shared_script '@es_extended/imports.lua'

client_scripts {
    'config.lua',
    'client/main.lua'
}
server_script {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/images/*.png'
}