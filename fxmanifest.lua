
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'


name 'MI_Ox_Job'
author 'MIAgimir'
version      '0.0.1'
repository 'https://github.com/MIAgimir/MI_Ox_Job'
description 'Ox_Core based job template for development use'


dependencies {
	'/server:6116',
	'/onesync',
	'oxmysql',
	'ox_lib',
}

ui_page 'web/build/index.html'

shared_scripts {
	'@ox_lib/init.lua',
}

shared_scripts {
	'config.lua'
}

client_scripts {
	'task_one.lua',
    'utils.lua'
}

server_scripts {
	'main.lua',
}