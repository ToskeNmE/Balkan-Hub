fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    'client.lua',
}
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}