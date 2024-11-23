fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP @outsider'
description 'VORP admin menu'
lua54 'yes'

shared_script {
    'config.lua',
    'languages/translation.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'logs.lua',
    'server/*.lua',
}

ui_page 'html/index.html'

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

-- Version check dont touch
version '2.5'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_admin'
