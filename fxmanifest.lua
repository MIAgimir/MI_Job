--[[FX Information]]--
fx_version 					'cerulean'
use_experimental_fxv2_oal 	'yes'
lua54 						'yes'
game 						'gta5'
--[[Script Information]]--
name						'MI_Ox_Job'
author						'MIAgimir'
version						'0.0.1'
repository 					'https://github.com/MIAgimir/MI_Ox_Job'
description 				'Ox_Core based job template for development use'

--[[Script Hierarchy]]--
dependencies {
	'/server:6116',
	'/onesync',
	'oxmysql',
	'ox_lib',
}

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/main.lua',
    'client/utils.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/main.lua',
}