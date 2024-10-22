shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

ui_page 'Modules/headbag/ui/index.html'
files {
  'Modules/headbag/ui/index.html',
  'Modules/headbag/ui/style.css',
  'Modules/headbag/ui/worek.png',
  'Modules/headbag/ui/script.js'
}


shared_scripts { 
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    "Main.lua", 
    "Modules/**/shared/*.lua" 
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "Modules/**/server/*.lua",
}
client_scripts {
    "Utils/Clientv2/RageUI/RMenu.lua",
    "Utils/Clientv2/RageUI/menu/RageUI.lua",
    "Utils/Clientv2/RageUI/menu/Menu.lua",
    "Utils/Clientv2/RageUI/menu/MenuController.lua",
    "Utils/Clientv2/RageUI/components/*.lua",
    "Utils/Clientv2/RageUI/menu/elements/*.lua",
    "Utils/Clientv2/RageUI/menu/items/*.lua",
    "Utils/Clientv2/RageUI/menu/panels/*.lua",
    "Utils/Clientv2/RageUI/menu/windows/*.lua",
    "Utils/Clientv1/RageUI/RMenu.lua",
    "Utils/Clientv1/RageUI/menu/RageUI.lua",
    "Utils/Clientv1/RageUI/menu/Menu.lua",
    "Utils/Clientv1/RageUI/menu/MenuController.lua",
    "Utils/Clientv1/RageUI/components/*.lua",
    "Utils/Clientv1/RageUI/menu/elements/*.lua",
    "Utils/Clientv1/RageUI/menu/items/*.lua",
    "Utils/Clientv1/RageUI/menu/panels/*.lua",
    "Utils/Clientv1/RageUI/menu/windows/*.lua",
    "Modules/**/client/*.lua"
}

ox_libs {
    'zones'
}


data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_plant_coca_a.ytyp'
