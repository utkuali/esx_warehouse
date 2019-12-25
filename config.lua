Config = {}

Config.Locale = "en"

Config.rndfail = math.random(1, 500) -- Percantage of purchase fail = 1/500 (money always removed)
Config.deltime = 900000 -- 15min
Config.selltime = 900000 -- 15 min
Config.enablenpc = true -- NPC enemies during sell
Config.blackmoney = false -- set true if you want to pay with blackmoney
Config.itemmultiplier = 1.5 -- set this for make items single sell price
Config.bonus = 1.2 -- Higher values makes bonus sell price lower // DO NOT SET LOWER THAN 1 !!!


Config.Locations = {
    depokapi = vector3(67.17  , -2570.20, 5.0   ),
    depo     = vector3(1087.43, -3099.27, -40.00),
    laptop   = vector3(1088.40, -3101.44, -39.00),
    deliver  = vector3(58.13  , -2564.27, 5.0   )
}

Config.ObjLocations = {
    laptop   = {x = 1088.40, y = -3101.44, z = -39.00},
    crate1_1 = {x = 1088.61, y = -3096.40, z = -39.00},
    crate1_2 = {x = 1091.38, y = -3096.40, z = -38.89},
    crate2_1 = {x = 1091.38, y = -3096.40, z = -39.00},
    crate2_2 = {x = 1091.38, y = -3096.40, z = -38.89},
    crate3_1 = {x = 1095.13, y = -3096.40, z = -39.00},
    crate3_2 = {x = 1095.13, y = -3096.40, z = -38.89},
    crate4_1 = {x = 1097.51, y = -3096.40, z = -39.00},
    crate4_2 = {x = 1097.51, y = -3096.40, z = -38.89},
    crate5_1 = {x = 1101.31, y = -3096.40, z = -39.00},
    crate5_2 = {x = 1101.31, y = -3096.40, z = -38.89},
    crate6_1 = {x = 1104.00, y = -3096.40, z = -39.00},
    crate6_2 = {x = 1104.00, y = -3096.40, z = -38.89}
}

Config.Price = {
    s1_1 = math.random(40000, 55000),
    s1_2 = math.random(75000, 90000),
    s2_1 = math.random(110000, 125000),
    s2_2 = math.random(45000, 60000),
    s3_1 = math.random(70000, 85000),
    s3_2 = math.random(55000, 70000),
    s4_1 = math.random(80000, 95000),
    s4_2 = math.random(150000, 165000),
    s5_1 = math.random(90000, 105000),
    s5_2 = math.random(85000, 100000),
    s6_1 = math.random(105000, 120000),
    s6_2 = math.random(65000, 80000),
}