fx_version 'adamant'

game 'gta5'

description 'HHFW AI Doc'

version '0.1.0'

lua54 'yes'
shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}
