function SaveToDatabase()
    TriggerServerEvent("utku_wh:insertWH", Warehouse)
end

function CheckStatus(item)
    for i = 1, #Warehouse, 1 do
        if Warehouse[i].slot == item then
            if Warehouse[i].empty then
                return true
            else
                return false
            end
        end
    end
end

function OpenLaptop() -- Laptop Menu
    local ped = PlayerPedId()

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_laptop', {
        title = _U("main_title"),
        align = "top-left",
        elements = {
            {label = _U("buy_menu"), value = "buy_menu"},
            {label = _U("sell_menu"), value = "sell_menu"}
    }}, function(data, menu)
        if data.current.value == "buy_menu" then
            local elements = {
                {label = _U("b_s1_1")..tostring(ESX.Math.GroupDigits(Config.Price.s1_1)).."$", value = "s1_1"},
                {label = _U("b_s1_2")..tostring(ESX.Math.GroupDigits(Config.Price.s1_2)).."$", value = "s1_2"},
                {label = _U("b_s2_1")..tostring(ESX.Math.GroupDigits(Config.Price.s2_1)).."$", value = "s2_1"},
                {label = _U("b_s2_2")..tostring(ESX.Math.GroupDigits(Config.Price.s2_2)).."$", value = "s2_2"},
                {label = _U("b_s3_1")..tostring(ESX.Math.GroupDigits(Config.Price.s3_1)).."$", value = "s3_1"},
                {label = _U("b_s3_2")..tostring(ESX.Math.GroupDigits(Config.Price.s3_2)).."$", value = "s3_2"},
                {label = _U("b_s4_1")..tostring(ESX.Math.GroupDigits(Config.Price.s4_1)).."$", value = "s4_1"},
                {label = _U("b_s4_2")..tostring(ESX.Math.GroupDigits(Config.Price.s4_2)).."$", value = "s4_2"},
                {label = _U("b_s5_1")..tostring(ESX.Math.GroupDigits(Config.Price.s5_1)).."$", value = "s5_1"},
                {label = _U("b_s5_2")..tostring(ESX.Math.GroupDigits(Config.Price.s5_2)).."$", value = "s5_2"},
                {label = _U("b_s6_1")..tostring(ESX.Math.GroupDigits(Config.Price.s6_1)).."$", value = "s6_1"},
                {label = _U("b_s6_2")..tostring(ESX.Math.GroupDigits(Config.Price.s6_2)).."$", value = "s6_2"},
            }

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "buy_menu", {
                title = _U("buy_menu"),
                align = "top-left",
                elements = elements
            }, function(data2, menu2)
                local action = data2.current.value
                if action == "s1_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s1_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s1_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s1_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s2_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s2_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s2_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s2_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s3_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s3_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s3_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s3_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s4_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s4_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s4_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s4_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s5_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s5_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s5_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s5_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s6_1" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s6_1, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                elseif action == "s6_2" then
                    if CheckStatus(action) then
                        TriggerServerEvent("utku_wh:checkMoney", Config.Price.s6_2, action)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("already_have"))
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == "sell_menu" then
            local worth, bonus, count = GetTotalWorth()

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "sell_menu", {
                title = _U("sell_menu"),
                align = "top-left",
                elements = {
                    {label = _U("cur_price")..tostring(ESX.Math.GroupDigits(worth)).."$", value = "info"},
                    {label = _U("sell"), value = "sell"}
                }
            }, function(data2, menu2)
                local action = data2.current.value

                if action == "info" then
                    exports['mythic_notify']:SendAlert("error", _U("info_s")..tostring(ESX.Math.GroupDigits(bonus)).."$")
                elseif action == "sell" then
                    if count >= 1 then
                        TriggerEvent("utku_wh:sell", count, worth)
                        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                        ESX.UI.Menu.CloseAll()
                    else
                        exports['mythic_notify']:SendAlert("error", _U("empty"))
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end
    end, function(data, menu)
        menu.close()
        TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
    end)
end

function SpawnEnemyNPC(x, y, z, target) -- Works decent but not exactly how I want, still working no improving it
    local done, location, heading = GetClosestVehicleNodeWithHeading(x + math.random(-100, 100), y + math.random(-100, 100), z, 1, 3, 0)

    RequestModel(0x964D12DC)
    RequestModel(0x132D5A1A)
    if done and HasModelLoaded(0x964D12DC) and HasModelLoaded(0x132D5A1A) then
        Enemyveh = CreateVehicle(0x132D5A1A, location, heading, true, false)

        ClearAreaOfVehicles(GetEntityCoords(Enemyveh), 200, false, false, false, false, false);
        SetVehicleOnGroundProperly(Enemyveh)
        oke, Group = AddRelationshipGroup("Enemies")
        Driver = CreatePedInsideVehicle(Enemyveh, 12, GetHashKey("g_m_y_mexgoon_03"), -1, true, false)
        Passenger = CreatePedInsideVehicle(Enemyveh, 12, GetHashKey("g_m_y_mexgoon_03"), 0, true, false)
        Enemyblip = AddBlipForEntity(Driver)
        SetBlipAsFriendly(Enemyblip, false)
        SetBlipFlashes(Enemyblip, true)
        SetBlipSprite(Enemyblip, 270)
        SetBlipColour(Enemyblip, 1)

        SetPedRelationshipGroupHash(Driver, Group)                      SetPedRelationshipGroupHash(Passenger, Group) -- Passenger now works, but he is kinda stupid :D
        SetEntityCanBeDamagedByRelationshipGroup(Driver, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(Passenger, false, Group)
        GiveWeaponToPed(Driver, "WEAPON_MICROSMG", 400, false, true)    GiveWeaponToPed(Passenger, "WEAPON_MICROSMG", 400, false, true)
        SetPedCombatAttributes(Driver, 1, true)                         SetPedCombatAttributes(Passenger, 1, true)
        SetPedCombatAttributes(Driver, 2, true)                         SetPedCombatAttributes(Passenger, 2, true)
        SetPedCombatAttributes(Driver, 5, true)	                        SetPedCombatAttributes(Passenger, 5, true)
        SetPedCombatAttributes(Driver, 16, true)                        SetPedCombatAttributes(Passenger, 16, true)
        SetPedCombatAttributes(Driver, 26, true)                        SetPedCombatAttributes(Passenger, 26, true)
        SetPedCombatAttributes(Driver, 46, true)                        SetPedCombatAttributes(Passenger, 46, true)
        SetPedCombatAttributes(Driver, 52, true)                        SetPedCombatAttributes(Passenger, 52, true)
        SetPedFleeAttributes(Driver, 0, 0)                              SetPedFleeAttributes(Passenger, 0, 0)
        SetPedPathAvoidFire(Driver, 1)                                  SetPedPathAvoidFire(Passenger, 1)
        SetPedAlertness(Driver,3)                                       SetPedAlertness(Passenger,3)
        SetPedFiringPattern(Driver, 0xC6EE6B4C)                         SetPedFiringPattern(Passenger, 0xC6EE6B4C)
        SetPedArmour(Driver, 100)                                       SetPedArmour(Passenger, 100)
        TaskCombatPed(Driver, target, 0, 16)                            TaskCombatPed(Driver, target, 0, 16)
        TaskVehicleChase(Driver, target)                                SetPedVehicleForcedSeatUsage(Passenger, Enemyveh, 0, 1)
        SetTaskVehicleChaseBehaviorFlag(Driver, 262144, true)
        SetDriverRacingModifier(Driver, 1.0)
        SetDriverAbility(Driver, 1.0)
        --SetPedAsEnemy(Driver, true)                                     --SetPedAsEnemy(Passenger, true)
        SetPedDropsWeaponsWhenDead(Driver, false)                       SetPedDropsWeaponsWhenDead(Passenger, false)
    end
end

function GetTotalWorth()
    local count = 0
    local worth = 0
    for i = 1, #Warehouse, 1 do
        if Warehouse[i].empty == false then
            if Warehouse[i].slot == "s1_1" then
                count = count + 2
                worth = worth + Config.Price.s1_1 * Config.itemmultiplier -- also lowered this values a bit
            end
            if Warehouse[i].slot == "s1_2" then
                count = count + 2
                worth = worth + Config.Price.s1_2 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s2_1" then
                count = count + 2
                worth = worth + Config.Price.s2_1 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s2_2" then
                count = count + 2
                worth = worth + Config.Price.s2_2 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s3_1" then
                count = count + 2
                worth = worth + Config.Price.s3_1 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s3_2" then
                count = count + 2
                worth = worth + Config.Price.s3_2 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s4_1" then
                count = count + 2
                worth = worth + Config.Price.s4_1 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s4_2" then
                count = count + 2
                worth = worth + Config.Price.s4_2 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s5_1" then
                count = count + 2
                worth = worth + Config.Price.s5_1 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s5_2" then
                count = count + 2
                worth = worth + Config.Price.s5_2 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s6_1" then
                count = count + 2
                worth = worth + Config.Price.s6_1 * Config.itemmultiplier
            end
            if Warehouse[i].slot == "s6_2" then
                count = count + 2
                worth = worth + Config.Price.s6_2 * Config.itemmultiplier
            end
        end
    end
    if count > 3 then
        return math.floor(worth + ((worth * (count/Config.bonus)) / 10)), math.floor((worth * (count/Config.bonus)) / 10), count/2 -- Should make prices a bit lower and reasonable
    else
        return worth, 0 , count/2
    end
end

function GetCurrentInfo()
    local random    = math.random(1, 36)
    local randomcar = math.random(1, 13)

    if random == 1 then
        Currentpos     = Locations.c1
        Currentheading = Locations.h1
    end
    if random == 2 then
        Currentpos     = Locations.c2
        Currentheading = Locations.h2
    end
    if random == 3 then
        Currentpos     = Locations.c3
        Currentheading = Locations.h3
    end
    if random == 4 then
        Currentpos     = Locations.c3_2
        Currentheading = Locations.h2
    end
    if random == 5 then
        Currentpos     = Locations.c4
        Currentheading = Locations.h4
    end
    if random == 6 then
        Currentpos     = Locations.c5
        Currentheading = Locations.h5
    end
    if random == 7 then
        Currentpos     = Locations.c6
        Currentheading = Locations.h6
    end
    if random == 8 then
        Currentpos     = Locations.c7
        Currentheading = Locations.h7
    end
    if random == 9 then
        Currentpos     = Locations.c8
        Currentheading = Locations.h8
    end
    if random == 10 then
        Currentpos     = Locations.c9
        Currentheading = Locations.h9
    end
    if random == 11 then
        Currentpos     = Locations.c10
        Currentheading = Locations.h10
    end
    if random == 12 then
        Currentpos     = Locations.c11
        Currentheading = Locations.h11
    end
    if random == 13 then
        Currentpos     = Locations.c12
        Currentheading = Locations.h12
    end
    if random == 14 then
        Currentpos     = Locations.c13
        Currentheading = Locations.h13
    end
    if random == 15 then
        Currentpos     = Locations.c14
        Currentheading = Locations.h14
    end
    if random == 16 then
        Currentpos     = Locations.c15
        Currentheading = Locations.h15
    end
    if random == 17 then
        Currentpos     = Locations.c16
        Currentheading = Locations.h16
    end
    if random == 18 then
        Currentpos     = Locations.c17
        Currentheading = Locations.h17
    end
    if random == 19 then
        Currentpos     = Locations.c18
        Currentheading = Locations.h18
    end
    if random == 20 then
        Currentpos     = Locations.c19
        Currentheading = Locations.h19
    end
    if random == 21 then
        Currentpos     = Locations.c20
        Currentheading = Locations.h20
    end
    if random == 22 then
        Currentpos     = Locations.c21
        Currentheading = Locations.h21
    end
    if random == 23 then
        Currentpos     = Locations.c22
        Currentheading = Locations.h22
    end
    if random == 24 then
        Currentpos     = Locations.c23
        Currentheading = Locations.h23
    end
    if random == 25 then
        Currentpos     = Locations.c24
        Currentheading = Locations.h24
    end
    if random == 26 then
        Currentpos     = Locations.c25
        Currentheading = Locations.h25
    end
    if random == 27 then
        Currentpos     = Locations.c26
        Currentheading = Locations.h26
    end
    if random == 28 then
        Currentpos     = Locations.c27
        Currentheading = Locations.h27
    end
    if random == 29 then
        Currentpos     = Locations.c28
        Currentheading = Locations.h28
    end
    if random == 30 then
        Currentpos     = Locations.c29
        Currentheading = Locations.h29
    end
    if random == 31 then
        Currentpos     = Locations.c30
        Currentheading = Locations.h30
    end
    if random == 32 then
        Currentpos     = Locations.c31
        Currentheading = Locations.h31
    end
    if random == 33 then
        Currentpos     = Locations.c32
        Currentheading = Locations.h32
    end
    if random == 34 then
        Currentpos     = Locations.c33
        Currentheading = Locations.h33
    end
    if random == 35 then
        Currentpos     = Locations.c34
        Currentheading = Locations.h34
    end
    if random == 36 then
        Currentpos     = Locations.c35
        Currentheading = Locations.h35
    end
    if randomcar == 1 then
        Currentcar = Cars.v1
    end
    if randomcar == 2 then
        Currentcar = Cars.v2
    end
    if randomcar == 3 then
        Currentcar = Cars.v3
    end
    if randomcar == 4 then
        Currentcar = Cars.v4
    end
    if randomcar == 5 then
        Currentcar = Cars.v5
    end
    if randomcar == 6 then
        Currentcar = Cars.v6
    end
    if randomcar == 7 then
        Currentcar = Cars.v7
    end
    if randomcar == 8 then
        Currentcar = Cars.v8
    end
    if randomcar == 9 then
        Currentcar = Cars.v9
    end
    if randomcar == 10 then
        Currentcar = Cars.v10
    end
    if randomcar == 11 then
        Currentcar = Cars.v11
    end
    if randomcar == 12 then
        Currentcar = Cars.v12
    end
    if randomcar == 13 then
        Currentcar = Cars.v13
    end
end

function GetSellInfo(count, amount)
    local rnd4 = math.random(1,4)
    Reward = amount
    if count <= 4 then
        Currentspawn = Sell.sp1
        C_heading = Sell.h1
        if rnd4 == 1 then
            Currentpos = Sell.s1
            Currentcar = Sell.car1
        elseif rnd4 == 2 then
            Currentpos = Sell.s2
            Currentcar = Sell.car2
        elseif rnd4 == 3 then
            Currentpos = Sell.s3
            Currentcar = Sell.car3
        elseif rnd4 == 4 then
            Currentpos = Sell.s4
            Currentcar = Sell.car4
        end
    end
    if count > 4 and count <= 8 then
        Currentspawn = Sell.sp2
        C_heading = Sell.h2
        if rnd4 == 1 then
            Currentpos = Sell.s5
            Currentcar = Sell.car5
        elseif rnd4 == 2 then
            Currentpos = Sell.s6
            Currentcar = Sell.car6
        elseif rnd4 == 3 then
            Currentpos = Sell.s7
            Currentcar = Sell.car7
        elseif rnd4 == 4 then
            Currentpos = Sell.s8
            Currentcar = Sell.car8
        end
    end
    if count > 8 and count <= 12 then
        Currentspawn = Sell.sp2
        C_heading = Sell.h2
        if rnd4 == 1 then
            Currentpos = Sell.s9
            Currentcar = Sell.car9
        elseif rnd4 == 2 then
            Currentpos = Sell.s10
            Currentcar = Sell.car10
        elseif rnd4 == 3 then
            Currentpos = Sell.s10
            Currentcar = Sell.car10
        elseif rnd4 == 4 then
            Currentpos = Sell.s10
            Currentcar = Sell.car10
        end
    end
end

function DrawText3D(x, y, z, text, scale) -- I know I stole it :D mwhwhahaha
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 5000
	DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100)
end
