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

function OpenLaptop()
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
                {label = _U("b_s1_1")..tostring(Config.Price.s1_1).."$", value = "s1_1"},
                {label = _U("b_s1_2")..tostring(Config.Price.s1_2).."$", value = "s1_2"},
                {label = _U("b_s2_1")..tostring(Config.Price.s2_1).."$", value = "s2_1"},
                {label = _U("b_s2_2")..tostring(Config.Price.s2_2).."$", value = "s2_2"},
                {label = _U("b_s3_1")..tostring(Config.Price.s3_1).."$", value = "s3_1"},
                {label = _U("b_s3_2")..tostring(Config.Price.s3_2).."$", value = "s3_2"},
                {label = _U("b_s4_1")..tostring(Config.Price.s4_1).."$", value = "s4_1"},
                {label = _U("b_s4_2")..tostring(Config.Price.s4_2).."$", value = "s4_2"},
                {label = _U("b_s5_1")..tostring(Config.Price.s5_1).."$", value = "s5_1"},
                {label = _U("b_s5_2")..tostring(Config.Price.s5_2).."$", value = "s5_2"},
                {label = _U("b_s6_1")..tostring(Config.Price.s6_1).."$", value = "s6_1"},
                {label = _U("b_s6_2")..tostring(Config.Price.s6_2).."$", value = "s6_2"},
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
                    {label = _U("cur_price")..tostring(worth).."$", value = "info"},
                    {label = _U("sell"), value = "sell"}
                }
            }, function(data2, menu2)
                local action = data2.current.value

                if action == "info" then
                    exports['mythic_notify']:SendAlert("error", _U("info_s")..tostring(bonus).."$")
                elseif action == "sell" then
                    TriggerEvent("utku_wh:sell", count, worth)
                    TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "exit", 8.0, 8.0, 0.1, 0, 1, false, false, false)
                    ESX.UI.Menu.CloseAll()
                    --exports['mythic_notify']:SendAlert("error", "Selling has not started yet!")
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

function GetTotalWorth()
    local count = 0
    local worth = 0
    for i=1, #Warehouse, 1 do
        if Warehouse[i].empty == false then
            if Warehouse[i].slot == "s1_1" then
                count = count + 2
                worth = worth + Config.Price.s1_1 * 2
            end
            if Warehouse[i].slot == "s1_2" then
                count = count + 2
                worth = worth + Config.Price.s1_2 * 2
            end
            if Warehouse[i].slot == "s2_1" then
                count = count + 2
                worth = worth + Config.Price.s2_1 * 2
            end
            if Warehouse[i].slot == "s2_2" then
                count = count + 2
                worth = worth + Config.Price.s2_2 * 2
            end
            if Warehouse[i].slot == "s3_1" then
                count = count + 2
                worth = worth + Config.Price.s3_1 * 2
            end
            if Warehouse[i].slot == "s3_2" then
                count = count + 2
                worth = worth + Config.Price.s3_2 * 2
            end
            if Warehouse[i].slot == "s4_1" then
                count = count + 2
                worth = worth + Config.Price.s4_1 * 2
            end
            if Warehouse[i].slot == "s4_2" then
                count = count + 2
                worth = worth + Config.Price.s4_2 * 2
            end
            if Warehouse[i].slot == "s5_1" then
                count = count + 2
                worth = worth + Config.Price.s5_1 * 2
            end
            if Warehouse[i].slot == "s5_2" then
                count = count + 2
                worth = worth + Config.Price.s5_2 * 2
            end
            if Warehouse[i].slot == "s6_1" then
                count = count + 2
                worth = worth + Config.Price.s6_1 * 2
            end
            if Warehouse[i].slot == "s6_2" then
                count = count + 2
                worth = worth + Config.Price.s6_2 * 2
            end
        end
    end
    if count > 3 then
        --print("count: "..tostring(count))
        --print("raw: "..tostring(worth))
        --print("bonus: "..tostring(math.floor((worth * count) / 10)))
        --print("total: "..tostring(math.floor(worth + ((worth * count) / 10))))
        return math.floor(worth + ((worth * count) / 10)), math.floor((worth * count) / 10), count/2
    else
        --print("total: "..tostring(worth))
        return worth, 0 , count/2
    end
end

function DrawText3D(x, y, z, text, scale)
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