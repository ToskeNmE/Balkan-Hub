fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/CircleZone.lua',
  'client/*.lua',
}
server_script {
  'server/*.lua',
}
