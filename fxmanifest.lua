-- cfx information --
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

 -- manifest -- 
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
} 

client_scripts {
    '@ox_core/imports/client.lua',
    'client/main.lua',
    'client/vehicle.lua'
}

exports { 
    'radial_checkin',
    'radial_checkout',
    'assignment_check'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/main.lua',
}