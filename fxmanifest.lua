fx_version 'cerulean'
game 'gta5'

author 'Mercy Collective'
description 'Dumpster Diving (Mercy Framework)'
version '1.0.0'

shared_scripts {
    'shared/sh_*.lua',
}

client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    'shared/sv_*.lua',
    'server/sv_*.lua',
}

lua54 'yes'