-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

author "Andyyy7666"
description "Casino stuff"
version "1.0.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

files {
    "data/**",
    "modules/**/client.lua"
}

shared_scripts {
    "@ox_lib/init.lua",
    "shared/**"
}

client_scripts {
    "client/**"
}
server_scripts {
    "server/**"
}

dependencies {
    "ox_target",
    "ox_lib"
}
