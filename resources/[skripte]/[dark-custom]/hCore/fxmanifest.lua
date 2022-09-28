fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'nosi/client.lua',
    'someshit.lua',
    'id/klijent.lua',
    'adminmeni/client.lua',
    'exportovi.lua',
    'entity_view.lua',
    'entity.lua'
}
server_script {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'someshitserver.lua',
    'vip/server.lua',
    'nosi/server.lua',
    'aduznost/server.lua',
    'id/server.lua',
    'adminmeni/server.lua'
}

exports {
  'Draw3DText',
  'NapraviPed'
}
