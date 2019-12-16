resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "config.lua",
    "locales/en.lua",
    "server/main.lua"
}

client_scripts {
    "@es_extended/locale.lua",
    "config.lua",
    "locales/en.lua",
    "client/main.lua",
    "client/functions.lua",
    "client/locationpicker.lua"
}