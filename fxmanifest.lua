fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'outsider'
description 'VORP admin menu'
version '1.0.0'

client_scripts {
    'client/functions.lua',
    'client/client.lua',

}

shared_scritp {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

server_scripts {
    'server/server.lua'
}
