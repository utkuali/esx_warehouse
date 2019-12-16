ESX = nil
PlayerData = {}
local whstart = false
local currentslot = nil
local currentpos = nil
local currentheading = nil
local currentblip = nil
local pickup = false
local drawmarker = false
local locked = true
local shouldlock = false
local currentcar = nil
local currentspawn = nil
local c_heading = nil
local draw = false
local header = nil
local text = nil
local sellcount = nil
local reward = 0
local markerloc = nil
local amount = 0
Delstart = false
Sellstart = false
Missioncar = nil
Obj = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    local shouldSave = false
    ESX.TriggerServerCallback("utku_wh:getWH", function(list)
        if list == nil then
            shouldSave = true
        else
            Warehouse = list
            shouldSave = false
        end
    end)
    Citizen.Wait(500)
    if shouldSave then
        SaveToDatabase()
    end
    for i = 1, #Warehouse, 1 do
        Warehouse[i].created = false
        TriggerServerEvent("utku_wh:updateWH", Warehouse)
    end
end)

RegisterNetEvent("utku_wh:upVar")
AddEventHandler("utku_wh:upVar", function(var, status)
    if var == "locked" then
        locked = status
    end
    if var == "shouldlock" then
        shouldlock = status
    end
end)

Warehouse = {
    {slot = "s1_1", empty = true, obj = "ex_prop_crate_pharma_sc",    x = 1088.61, y = -3096.40, z = -40.0,  created = false},
    {slot = "s1_2", empty = true, obj = "ex_prop_crate_biohazard_sc", x = 1088.61, y = -3096.40, z = -37.82, created = false},
    {slot = "s2_1", empty = true, obj = "ex_prop_crate_gems_sc",      x = 1091.38, y = -3096.40, z = -40.0,  created = false},
    {slot = "s2_2", empty = true, obj = "ex_prop_crate_elec_sc",      x = 1091.38, y = -3096.40, z = -37.82, created = false},
    {slot = "s3_1", empty = true, obj = "ex_prop_crate_narc_sc",      x = 1095.13, y = -3096.40, z = -40.0,  created = false},
    {slot = "s3_2", empty = true, obj = "ex_prop_crate_tob_sc",       x = 1095.13, y = -3096.40, z = -37.82, created = false},
    {slot = "s4_1", empty = true, obj = "ex_prop_crate_wlife_sc",     x = 1097.51, y = -3096.40, z = -40.0,  created = false},
    {slot = "s4_2", empty = true, obj = "ex_prop_crate_ammo_sc",      x = 1097.51, y = -3096.40, z = -37.82, created = false},
    {slot = "s5_1", empty = true, obj = "ex_prop_crate_art_02_sc",    x = 1101.31, y = -3096.40, z = -40.0,  created = false},
    {slot = "s5_2", empty = true, obj = "ex_prop_crate_art_bc",       x = 1101.31, y = -3096.40, z = -37.82, created = false},
    {slot = "s6_1", empty = true, obj = "ex_prop_crate_art_sc",       x = 1104.00, y = -3096.40, z = -40.0,  created = false},
    {slot = "s6_2", empty = true, obj = "ex_prop_crate_art_02_bc",    x = 1104.00, y = -3096.40, z = -37.82, created = false},
}

------------------------------------------------

--RegisterCommand("selltest", function()
    --TriggerServerEvent("utku_wh:sellGoods", reward)
--end)

RegisterNetEvent("utku_wh:start")
AddEventHandler("utku_wh:start", function(action)
    Timer = Config.deltime
    currentslot = action
    GetCurrentInfo()
    Citizen.Wait(500)
    Delstart = true
    exports['mythic_notify']:SendAlert("success", _U("pickup_s"))
    Citizen.Wait(500)
    exports['mythic_notify']:SendAlert("success", _U("15min"))
end)

RegisterNetEvent("utku_wh:sell")
AddEventHandler("utku_wh:sell", function(count, amount)
    Timer = Config.selltime
    GetSellInfo(count, amount)
    Sellstart = true
    for i = 1, #Warehouse, 1 do
        Warehouse[i].empty = true
        Warehouse[i].created = false
    end
    TriggerServerEvent("utku_wh:updateWH", Warehouse)
end)

RegisterNetEvent("utku_wh:itemEkle")
AddEventHandler("utku_wh:itemEkle", function(currentslot)
    for i = 1, #Warehouse, 1 do
        if Warehouse[i].slot == currentslot then
            Warehouse[i].empty = false
            TriggerServerEvent("utku_wh:updateWH", Warehouse)
        end
    end
end)

Citizen.CreateThread(function() -- update object
    while true do
        Citizen.Wait(1)
        for i = 1, #Warehouse, 1 do
            if Warehouse[i].empty == false then
                if Warehouse[i].created == false then
                    local coords = vector3(Warehouse[i].x, Warehouse[i].y, Warehouse[i].z)
                    local hash = GetHashKey(Warehouse[i].obj)
                    CreateObject(hash, coords, false, false)
                    Warehouse[i].created = true
                    TriggerServerEvent("utku_wh:updateWH", Warehouse)
                end
            end
            if Warehouse[i].empty == true then
                if Warehouse[i].created == true then
                    local coords = vector3(Warehouse[i].x, Warehouse[i].y, Warehouse[i].z)
                    local obj = GetClosestObjectOfType(coords, 1, GetHashKey(Warehouse[i].obj), false, 0, 0)
                    DeleteEntity(obj)
                    print("deleted: " ..Warehouse[i].slot)
                end
            end
        end
    end
end)

Citizen.CreateThread(function() -- Countdown
    while true do
        Citizen.Wait(1)
        if Delstart then
            Citizen.Wait(1000)
            Timer = Timer - 1000
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if Delstart then
            if Timer == 600000 then
                exports['mythic_notify']:SendAlert("success", _U("10min"))
                Citizen.Wait(5000)
            end
            if Timer == 300000 then
                exports['mythic_notify']:SendAlert("success", _U("5min"))
                Citizen.Wait(5000)
            end
            if Timer == 60000 then
                exports['mythic_notify']:SendAlert("success", _U("1min"))
                Citizen.Wait(5000)
            end
            if Timer == 10000 then
                PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
                exports['mythic_notify']:SendAlert('inform', _U("10sec"), 900, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
                Citizen.Wait(2000)
            end
            if Timer == 0 then
                Delstart = false
                drawmarker = false
                whstart = false
                pickup = false
                RemoveBlip(currentblip)
                currentblip = nil
                currentslot = nil
                Citizen.Wait(200)
                PlaySoundFrontend(-1, "Bed", "WastedSounds", 0)
                header = _U("failed")
                text = _U("timesup")
                Citizen.Wait(200)
                draw = true
                Citizen.Wait(6000)
                draw = false
            end
        end
    end
end)

--[[Citizen.CreateThread(function() SIDE BLIP COME BACK HERE
    while true do
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
        local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))
        if not Delstart then
        if  IsPedInAnyVehicle(PlayerPedId(), false) and vehname == needcar then
            print(vehname)
            print(needcar)
            if not DoesBlipExist(sideblip) then
                Citizen.Wait(50)
                drawmarker = true
                sideblip = AddBlipForCoord(Config.Locations.deliver)
                SetBlipSprite(sideblip, 473)
			    SetBlipColour(sideblip, 1)
			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString(_U("blip_d"))
			    EndTextCommandSetBlipName(sideblip)
			    SetBlipAsShortRange(sideblip, false)
			    SetBlipAsMissionCreatorBlip(sideblip, true)
                SetBlipRoute(sideblip, 1)
            else
                Citizen.Wait(100)
            end
        else
            RemoveBlip(sideblip)
        end
    end
        Citizen.Wait(100)
    end
end)]]

Citizen.CreateThread(function()
    while true do
        local scaleform = RequestScaleformMovie("mp_big_message_freemode")

        while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
        end

        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
        PushScaleformMovieMethodParameterString(header)
        PushScaleformMovieMethodParameterString(text)
        PushScaleformMovieMethodParameterInt(5)
        EndScaleformMovieMethod()
        while draw do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function() -- blip create(pickup)
    while true do
        Citizen.Wait(1)
        if Delstart then
            if not DoesBlipExist(currentblip) then
                Citizen.Wait(50)
                currentblip = AddBlipForCoord(currentpos)
                SetBlipSprite(currentblip, 478)
				SetBlipColour(currentblip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U("blip_p"))
				EndTextCommandSetBlipName(currentblip)
				SetBlipAsShortRange(currentblip, false)
				SetBlipAsMissionCreatorBlip(currentblip,true)
                SetBlipRoute(currentblip, 1)
                Citizen.Wait(500)
                RequestModel(GetHashKey(currentcar))
                while not HasModelLoaded(GetHashKey(currentcar)) do
                    Citizen.Wait(1)
                end
                Missioncar = CreateVehicle(GetHashKey(currentcar), currentpos, false, true)

                SetEntityHeading(Missioncar, currentheading)
                SetVehicleOnGroundProperly(Missioncar)
                SetModelAsNoLongerNeeded(GetHashKey(currentcar))
                    --[[
                    Hash = 1875981008
                    Obj = CreateObject(Hash, currentpos, false, false)
                    FreezeEntityPosition(Obj, true)
                    SetEntityCollision(Obj, false, true)]]
                pickup = true
            else
                Citizen.Wait(1)
            end
        end
        if whstart then
            if not DoesBlipExist(currentblip) then
                Citizen.Wait(50)
                markerloc = Config.Locations.deliver
                drawmarker = true
                currentblip = AddBlipForCoord(Config.Locations.deliver)
                SetBlipSprite(currentblip, 473)
			    SetBlipColour(currentblip, 1)
			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString(_U("blip_d"))
			    EndTextCommandSetBlipName(currentblip)
			    SetBlipAsShortRange(currentblip, false)
			    SetBlipAsMissionCreatorBlip(currentblip, true)
                SetBlipRoute(currentblip, 1)
            else
                Citizen.Wait(1)
            end
        end
        if Sellstart then
            if not DoesBlipExist(currentblip) then
                local ped = PlayerPedId()

                Citizen.Wait(50)
                currentblip = AddBlipForCoord(currentpos)
                SetBlipSprite(currentblip, 479)
			    SetBlipColour(currentblip, 5)
			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString(_U("blip_s"))
			    EndTextCommandSetBlipName(currentblip)
			    SetBlipAsShortRange(currentblip, false)
			    SetBlipAsMissionCreatorBlip(currentblip, true)
                SetBlipRoute(currentblip, 1)

                RequestModel(GetHashKey(currentcar))
                while not HasModelLoaded(GetHashKey(currentcar)) do
                    Citizen.Wait(1)
                end
                Missioncar = CreateVehicle(GetHashKey(currentcar), currentspawn, false, true)

                SetEntityHeading(Missioncar, c_heading)
                SetVehicleOnGroundProperly(Missioncar)
                SetModelAsNoLongerNeeded(GetHashKey(currentcar))
                DoScreenFadeOut(500)
                Citizen.Wait(500)
                SetPedIntoVehicle(ped, Missioncar, -1)
                Citizen.Wait(1000)
                DoScreenFadeIn(500)
                markerloc = currentpos
                drawmarker = true
            else
                Citizen.Wait(1)
            end
        end
    end
end)

Citizen.CreateThread(function() -- marker
    while true do
        Citizen.Wait(1)
        if drawmarker then
            local pedloc = GetEntityCoords(PlayerPedId())
            local dst = GetDistanceBetweenCoords(pedloc, markerloc, true)

            if dst <= 200 then
                DrawMarker(1, markerloc, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
            end
        end
    end
end)

Citizen.CreateThread(function() -- pick up and deliver
    while true do
        Citizen.Wait(1)
        if pickup then
            local player = PlayerPedId()
            local dst = GetDistanceBetweenCoords(GetEntityCoords(player), currentpos, true)
            local ped = GetPlayerPed(-1)

            if dst <= 2.0 then
                local vehicle = IsPedInAnyVehicle(ped, false)
                local currentveh = GetVehiclePedIsUsing(player)
                local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(currentveh))
                local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))

                if vehname == needcar and vehicle then
                    Delstart = false
                    pickup = false
                    Citizen.Wait(100)
                    PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
                    RemoveBlip(currentblip)
                    currentblip = nil
                    Citizen.Wait(100)
                    whstart = true
                end
            end
        end
        if whstart then
            local player = PlayerPedId()
            local dst2 = GetDistanceBetweenCoords(GetEntityCoords(player), Config.Locations.deliver, true)

            if dst2 <= 2.5 then
                local vehicle = IsPedInAnyVehicle(player, false)
                local currentveh = GetVehiclePedIsUsing(player)
                local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(currentveh))
                local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))
                if vehname == needcar and vehicle then
                    BringVehicleToHalt(currentveh, 3.5, 1, false)
                    Citizen.Wait(10)
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    drawmarker = false
                    whstart = false
                    Citizen.Wait(10)
                    RemoveBlip(currentblip)
                    currentblip = nil
                    PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
                    DeleteEntity(currentveh)
                    SetEntityCoords(player, Config.Locations.depo, 1, 0, 0, 1)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
                    --exports['mythic_notify']:SendAlert("success", _U("delivered"))
                    TriggerEvent("utku_wh:itemEkle", currentslot)
                    header = _U("success")
                    text = _U("delivered")
                    Citizen.Wait(200)
                    draw = true
                    Citizen.Wait(1000)
                    currentslot = nil
                    Citizen.Wait(5000)
                    draw = false
                end
            end
        end
        if Sellstart then
            local player = PlayerPedId()
            local playercar = GetVehiclePedIsUsing(player)
            local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(playercar))
            local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))

            if vehname == needcar then
                if (GetDistanceBetweenCoords(GetEntityCoords(player), currentpos, true) <= 2.5) then
                    BringVehicleToHalt(playercar, 3.5, 1, false)
                    Citizen.Wait(10)
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    drawmarker = false
                    Sellstart = false
                    Citizen.Wait(10)
                    RemoveBlip(currentblip)
                    currentblip = nil
                    PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
                    DeleteEntity(playercar)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
                    --exports['mythic_notify']:SendAlert("success", _U("delivered"))
                    TriggerServerEvent("utku_wh:sellGoods", reward)
                    header = _U("success")
                    text = _U("sold")
                    Citizen.Wait(200)
                    draw = true
                    Citizen.Wait(1000)
                    currentslot = nil
                    Citizen.Wait(5000)
                    draw = false
                end
            end
        end
    end
end)

--[[
Citizen.CreateThread(function() -- NPC actions
    while true do
        Citizen.Wait(1)
        if Sellstart then

        end
    end
end)
]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pedcoord = GetEntityCoords(ped)
        local dstCheck = GetDistanceBetweenCoords(pedcoord, Config.Locations.depo, true)
        if dstCheck <= 2 then
            if IsControlJustReleased(0, 38) then
                DoScreenFadeOut(1000)
                Citizen.Wait(500)
                local animDict = "mp_arresting"
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    RequestAnimDict(animDict)
                    Citizen.Wait(10)
                end
                SetEntityCoords(ped, Config.Locations.depokapi, 1, 0, 0, 1)
                SetEntityHeading(ped, 270.25)
                Citizen.Wait(500)
                TriggerServerEvent("utku_wh:checkKey", true)
                Citizen.Wait(200)
                DoScreenFadeIn(1000)
                if shouldlock then
                    TaskPlayAnim(ped, animDict, "a_uncuff", 8.0, 8.0, 2000, 1, 1, 0, 0, 0)
                    exports['progressBars']:startUI(2000, _U("locking"))
                else
                    exports['mythic_notify']:SendAlert("error", _U("exited"))
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local pedcoord = GetEntityCoords(PlayerPedId())
        local coords, coords2 = Config.Locations.depo, Config.Locations.depokapi
        local dst = GetDistanceBetweenCoords(pedcoord, coords, true)
        local dst2 = GetDistanceBetweenCoords(pedcoord, coords2, true)

        if dst <= 6 then
            DrawText3D(1087.43, -3099.27, -39.00, "[~r~E~w~] ".._U("exit"), 0.40)
            DrawText3D(1088.40, -3101.44, -39.00, "[~r~E~w~] ".._U("uselaptop"), 0.40)
        end
        if dst2 <= 6 then
            DrawText3D(67.60, -2569.65, 6.00, "[~r~E~w~] ".._U("enter"), 0.40)
        end
        if dst2 <= 1.5 then
            if IsControlJustReleased(0, 38) and locked then
                TriggerServerEvent("utku_wh:checkKey")
            elseif IsControlJustReleased(0, 38) and not locked then
                TriggerEvent("utku_wh:tpWH", true, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pedcoord = GetEntityCoords(ped)
        local laptoploc = Config.Locations.laptop
        local dst = GetDistanceBetweenCoords(pedcoord, laptoploc, true)

        if IsControlJustReleased(0, 38) and dst <= 1.5 then
            if not Delstart then
            RequestAnimDict("anim@amb@warehouse@laptop@")
            while not HasAnimDictLoaded("anim@amb@warehouse@laptop@") do
                RequestAnimDict("anim@amb@warehouse@laptop@")
                Citizen.Wait(10)
            end
            SetEntityCoords(ped, 1088.45, -3101.28, -40.0, 1, 0, 0, 1)
            SetEntityHeading(ped, 96.45)
            TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "enter", 8.0, 8.0, 0.1, 0, 1, false, false, false)
            Citizen.Wait(600)
            TaskPlayAnim(ped, "anim@amb@warehouse@laptop@", "idle_a", 8.0, 8.0, -1, 1, 1, false, false, false)
            Citizen.Wait(1000)
            OpenLaptop()
        else
            exports['mythic_notify']:SendAlert("error", _U("alreadydel"))
        end
        end
    end
end)

--TP to warehouse
RegisterNetEvent("utku_wh:tpWH")
AddEventHandler("utku_wh:tpWH", function(output, method)
    if output then
        local ped = PlayerPedId()
        local animDict = "mp_arresting"
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Citizen.Wait(10)
        end
        SetEntityCoords(ped, Config.Locations.depokapi, 1, 0, 0, 1)
        SetEntityHeading(ped, 270.25)
        TaskPlayAnim(ped, animDict, "a_uncuff", 8.0, 8.0, 2000, 1, 1, 0, 0, 0)
        if method then
            exports['progressBars']:startUI(2000, _U("unlocking"))
        elseif not method then
            exports['progressBars']:startUI(2000, _U("entering"))
        end
        Citizen.Wait(1000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(ped, Config.Locations.depo, 1, 0, 0, 1)
        Citizen.Wait(500)
        DoScreenFadeIn(1000)
        exports['mythic_notify']:SendAlert("success", _U("entered"))
    end
    if output == false then
        exports['mythic_notify']:SendAlert("error", _U("locked"))
    end
end)

function GetCurrentInfo()
    local random    = math.random(1,36)
    local randomcar = math.random(1, 13)

    if random == 1 then
        currentpos     = Locations.c1
        currentheading = Locations.h1dw
    end
    if random == 2 then
        currentpos     = Locations.c2
        currentheading = Locations.h2
    end
    if random == 3 then
        currentpos     = Locations.c3
        currentheading = Locations.h3
    end
    if random == 4 then
        currentpos     = Locations.c3_2
        currentheading = Locations.h2
    end
    if random == 5 then
        currentpos     = Locations.c4
        currentheading = Locations.h4
    end
    if random == 6 then
        currentpos     = Locations.c5
        currentheading = Locations.h5
    end
    if random == 7 then
        currentpos     = Locations.c6
        currentheading = Locations.h6
    end
    if random == 8 then
        currentpos     = Locations.c7
        currentheading = Locations.h7
    end
    if random == 9 then
        currentpos     = Locations.c8
        currentheading = Locations.h8
    end
    if random == 10 then
        currentpos     = Locations.c9
        currentheading = Locations.h9
    end
    if random == 11 then
        currentpos     = Locations.c10
        currentheading = Locations.h10
    end
    if random == 12 then
        currentpos     = Locations.c11
        currentheading = Locations.h11
    end
    if random == 13 then
        currentpos     = Locations.c12
        currentheading = Locations.h12
    end
    if random == 14 then
        currentpos     = Locations.c13
        currentheading = Locations.h13
    end
    if random == 15 then
        currentpos     = Locations.c14
        currentheading = Locations.h14
    end
    if random == 16 then
        currentpos     = Locations.c15
        currentheading = Locations.h15
    end
    if random == 17 then
        currentpos     = Locations.c16
        currentheading = Locations.h16
    end
    if random == 18 then
        currentpos     = Locations.c17
        currentheading = Locations.h17
    end
    if random == 19 then
        currentpos     = Locations.c18
        currentheading = Locations.h18
    end
    if random == 20 then
        currentpos     = Locations.c19
        currentheading = Locations.h19
    end
    if random == 21 then
        currentpos     = Locations.c20
        currentheading = Locations.h20
    end
    if random == 22 then
        currentpos     = Locations.c21
        currentheading = Locations.h21
    end
    if random == 23 then
        currentpos     = Locations.c22
        currentheading = Locations.h22
    end
    if random == 24 then
        currentpos     = Locations.c23
        currentheading = Locations.h23
    end
    if random == 25 then
        currentpos     = Locations.c24
        currentheading = Locations.h24
    end
    if random == 26 then
        currentpos     = Locations.c25
        currentheading = Locations.h25
    end
    if random == 27 then
        currentpos     = Locations.c26
        currentheading = Locations.h26
    end
    if random == 28 then
        currentpos     = Locations.c27
        currentheading = Locations.h27
    end
    if random == 29 then
        currentpos     = Locations.c28
        currentheading = Locations.h28
    end
    if random == 30 then
        currentpos     = Locations.c29
        currentheading = Locations.h29
    end
    if random == 31 then
        currentpos     = Locations.c30
        currentheading = Locations.h30
    end
    if random == 32 then
        currentpos     = Locations.c31
        currentheading = Locations.h31
    end
    if random == 33 then
        currentpos     = Locations.c32
        currentheading = Locations.h32
    end
    if random == 34 then
        currentpos     = Locations.c33
        currentheading = Locations.h33
    end
    if random == 35 then
        currentpos     = Locations.c34
        currentheading = Locations.h34
    end
    if random == 36 then
        currentpos     = Locations.c35
        currentheading = Locations.h35
    end
    if randomcar == 1 then
        currentcar = Cars.v1
    end
    if randomcar == 2 then
        currentcar = Cars.v2
    end
    if randomcar == 3 then
        currentcar = Cars.v3
    end
    if randomcar == 4 then
        currentcar = Cars.v4
    end
    if randomcar == 5 then
        currentcar = Cars.v5
    end
    if randomcar == 6 then
        currentcar = Cars.v6
    end
    if randomcar == 7 then
        currentcar = Cars.v7
    end
    if randomcar == 8 then
        currentcar = Cars.v8
    end
    if randomcar == 9 then
        currentcar = Cars.v9
    end
    if randomcar == 10 then
        currentcar = Cars.v10
    end
    if randomcar == 11 then
        currentcar = Cars.v11
    end
    if randomcar == 12 then
        currentcar = Cars.v12
    end
    if randomcar == 13 then
        currentcar = Cars.v13
    end
end

function GetSellInfo(count, amount)
    local rnd4 = math.random(1,4)
    reward = amount
    if count <= 4 then
        currentspawn = Sell.sp1
        c_heading = Sell.h1
        if rnd4 == 1 then
            currentpos = Sell.s1
            currentcar = Sell.car1
        elseif rnd4 == 2 then
            currentpos = Sell.s2
            currentcar = Sell.car2
        elseif rnd4 == 3 then
            currentpos = Sell.s3
            currentcar = Sell.car3
        elseif rnd4 == 4 then
            currentpos = Sell.s4
            currentcar = Sell.car4
        end
    end
    if count > 4 and count <= 8 then
        currentspawn = Sell.sp2
        c_heading = Sell.h1
        if rnd4 == 1 then
            currentpos = Sell.s5
            currentcar = Sell.car5
        elseif rnd4 == 2 then
            currentpos = Sell.s6
            currentcar = Sell.car6
        elseif rnd4 == 3 then
            currentpos = Sell.s7
            currentcar = Sell.car7
        elseif rnd4 == 4 then
            currentpos = Sell.s8
            currentcar = Sell.car8
        end
    end
    if count > 8 and count <= 12 then
        currentspawn = Sell.sp2
        c_heading = Sell.h2
        if rnd4 == 1 then
            currentpos = Sell.s9
            currentcar = Sell.car9
        elseif rnd4 == 2 then
            currentpos = Sell.s10
            currentcar = Sell.car10
        elseif rnd4 == 3 then
            currentpos = Sell.s10
            currentcar = Sell.car10
        elseif rnd4 == 4 then
            currentpos = Sell.s10
            currentcar = Sell.car10
        end
    end
end