fx_version 'adamant'

game 'gta5'

author 'evann™'

-- RageUI V2

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua"
}

client_scripts {
    "cl_main.lua",
    "garage.lua",
    "coffre.lua",
    "boss.lua",
    "stock_item.lua",
    "rdv.lua",
}

server_scripts {
    'server.lua',
    'config.lua'
}