fx_version 'cerulean'
games { 'gta5' }

shared_script '@es_extended/imports.lua'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}