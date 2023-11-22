fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'gg_policeinform'
description  'cool police information system'
author       'gasiguus'

--[[ Manifest ]]--
dependencies {
	'ox_lib',
	'es_extended',
}

shared_scripts {
	'@ox_lib/init.lua',
}

client_scripts {
    'client/client.lua',
    'config.lua',
    'strings.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'config.lua',
    'strings.lua',
}