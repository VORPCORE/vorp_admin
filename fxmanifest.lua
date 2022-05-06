fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'outsider'
description 'VORP admin menu'
version '2.0'

client_scripts {
    'client/*.lua',
}

shared_script {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

server_scripts {
    'server/*.lua',
    'versioncheck.lua',
}


name '^2VORP ADMIN'
github 'https://github.com/VORPCORE/vorp_admin'
fivem_checker 'yes'
