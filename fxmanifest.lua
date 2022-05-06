fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'outsider'
description 'VORP admin menu'
version '1.0'

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
}
kc_checker 'yes'
kc_name '^4Self Check'
kc_github 'https://github.com/VORPCORE/vorp_admin'
