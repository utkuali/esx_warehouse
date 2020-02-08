fx_version 'adamant'

game "gta5"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "config.lua",
    "locales/en.lua",
    "locales/de.lua",
    "locales/ru.lua",
    "locales/tr.lua",
    "server/main.lua"
}

client_scripts {
    "@es_extended/locale.lua",
    "config.lua",
    "locales/en.lua",
    "locales/de.lua",
    "locales/ru.lua",
    "locales/tr.lua",
    "client/main.lua",
    "client/functions.lua"
}
