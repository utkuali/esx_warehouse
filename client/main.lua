ESX = nil
PlayerData = {}
local whstart, pickup, drawmarker, shouldlock, draw, NPCstart, Delstart, Sellstart = false, false, false, false, false, false, false, false
local currentslot, currentblip, vehblip, C_heading, header, text, markerloc, Missioncar, Busy
local locked = true

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
    for i = 1, #Warehouse, 1 do -- this should ensure that objects are created for everyone (not sure tho)
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
    if var == "busy" then
        Busy = status
    end
end)

Warehouse = {
    {slot = "s1_1", empty = true, obj = "ex_prop_crate_pharma_sc"   , x = 1088.61, y = -3096.40, z = -40.0 , created = false},
    {slot = "s1_2", empty = true, obj = "ex_prop_crate_biohazard_sc", x = 1088.61, y = -3096.40, z = -37.82, created = false},
    {slot = "s2_1", empty = true, obj = "ex_prop_crate_gems_sc"     , x = 1091.38, y = -3096.40, z = -40.0 , created = false},
    {slot = "s2_2", empty = true, obj = "ex_prop_crate_elec_sc"     , x = 1091.38, y = -3096.40, z = -37.82, created = false},
    {slot = "s3_1", empty = true, obj = "ex_prop_crate_narc_sc"     , x = 1095.13, y = -3096.40, z = -40.0 , created = false},
    {slot = "s3_2", empty = true, obj = "ex_prop_crate_tob_sc"      , x = 1095.13, y = -3096.40, z = -37.82, created = false},
    {slot = "s4_1", empty = true, obj = "ex_prop_crate_wlife_sc"    , x = 1097.51, y = -3096.40, z = -40.0 , created = false},
    {slot = "s4_2", empty = true, obj = "ex_prop_crate_ammo_sc"     , x = 1097.51, y = -3096.40, z = -37.82, created = false},
    {slot = "s5_1", empty = true, obj = "ex_prop_crate_art_02_sc"   , x = 1101.31, y = -3096.40, z = -40.0 , created = false},
    {slot = "s5_2", empty = true, obj = "ex_prop_crate_art_bc"      , x = 1101.31, y = -3096.40, z = -37.82, created = false},
    {slot = "s6_1", empty = true, obj = "ex_prop_crate_art_sc"      , x = 1104.00, y = -3096.40, z = -40.0 , created = false},
    {slot = "s6_2", empty = true, obj = "ex_prop_crate_art_02_bc"   , x = 1104.00, y = -3096.40, z = -37.82, created = false}
}

------------------------------------------------

RegisterNetEvent("utku_wh:start")
AddEventHandler("utku_wh:start", function(action)
    Timer = Config.deltime
    currentslot = action
    GetCurrentInfo()
    Citizen.Wait(500)
    Delstart = true
    Starttimer = true
    Busy = true
    TriggerServerEvent("utku_wh:upVar_s", "busy", true)
    exports['mythic_notify']:SendAlert("success", _U("pickup_s"))
    Citizen.Wait(500)
    exports['mythic_notify']:SendAlert("success", _U("15min"))
end)

RegisterNetEvent("utku_wh:sell")
AddEventHandler("utku_wh:sell", function(count, amount)
    Timer = Config.selltime
    GetSellInfo(count, amount)
    TriggerEvent("utku_wh:startSell")
    Citizen.Wait(1000)
    Sellstart = true
    Starttimer = true
    Busy = true
    TriggerServerEvent("utku_wh:upVar_s", "busy", true)
    for i = 1, #Warehouse, 1 do -- should work now !
        Warehouse[i].empty = true
        Warehouse[i].created = false
        TriggerServerEvent("utku_wh:updateWH", Warehouse)
    end
    Citizen.Wait(6000)
    NPCstart = true
    Citizen.Wait(1000)
    TriggerEvent("utku_wh:delobj")
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

RegisterNetEvent("utku_wh:delobj")
AddEventHandler("utku_wh:delobj", function()
    for i = 1, #Warehouse, 1 do
        if Warehouse[i].empty == true then
            local coords = vector3(Warehouse[i].x, Warehouse[i].y, Warehouse[i].z)
            local obj = ESX.Game.GetClosestObject((Warehouse[i].obj), coords)
            DeleteEntity(obj)
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
        end
    end
end)

Citizen.CreateThread(function() -- Timer
    while true do
        Citizen.Wait(1)
        if Starttimer then
            Citizen.Wait(1000)
            Timer = Timer - 1000
        end
    end
end)

Citizen.CreateThread(function() -- Countdown
    while true do
        Citizen.Wait(1)
        if Starttimer then
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
                exports['mythic_notify']:SendAlert('inform', _U("10sec"), 1000, { ['background-color'] = '#009ff4', ['color'] = '#000000' })
                Citizen.Wait(2000)
            end
            if Timer == 0 then
                Delstart = false
                drawmarker = false
                whstart = false
                NPCstart = false
                Sellstart = false
                Starttimer = false
                pickup = false
                RemoveBlip(currentblip)
                RemoveBlip(Enemyblip)
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

Citizen.CreateThread(function() -- Player and vehicle status check
    while true do
        Citizen.Wait(1)
        while Sellstart or pickup or whstart or Delstart do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            local currentveh = GetVehiclePedIsUsing(ped)
            local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(currentveh))
            local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))
            local enghealth = GetVehicleEngineHealth(Missioncar)

            if IsEntityDead(ped) then -- This works fine
                Delstart = false
                drawmarker = false
                whstart = false
                pickup = false
                Sellstart = false
                NPCstart = false
                Starttimer = false
                Busy = false
                TriggerServerEvent("utku_wh:upVar_s", "busy", false)
                RemoveBlip(currentblip)
                RemoveBlip(Enemyblip)
                RemoveBlip(vehblip)
                currentblip = nil
                currentslot = nil
                PlaySoundFrontend(-1, "Bed", "WastedSounds", 0)
                header = _U("failed")
                text = _U("died")
                Citizen.Wait(200)
                draw = true
                Citizen.Wait(6000)
                draw = false
            end
            if vehname == needcar and (enghealth <= 150) then
                Delstart = false
                drawmarker = false
                whstart = false
                pickup = false
                Sellstart = false
                NPCstart = false
                Starttimer = false
                Busy = false
                TriggerServerEvent("utku_wh:upVar_s", "busy", false)
                RemoveBlip(currentblip)
                RemoveBlip(Enemyblip)
                RemoveBlip(vehblip)
                currentblip = nil
                currentslot = nil
                PlaySoundFrontend(-1, "Bed", "WastedSounds", 0)
                header = _U("failed")
                text = _U("broken")
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

Citizen.CreateThread(function() -- Scaleform Wasted (IllusiveTea <3)
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

Citizen.CreateThread(function() -- Blips
    while true do
        Citizen.Wait(1)
        if Delstart then
            if not DoesBlipExist(currentblip) then
                Citizen.Wait(50)
                currentblip = AddBlipForCoord(Currentpos)
                SetBlipSprite(currentblip, 478)
				SetBlipColour(currentblip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U("blip_p"))
				EndTextCommandSetBlipName(currentblip)
				SetBlipAsShortRange(currentblip, false)
				SetBlipAsMissionCreatorBlip(currentblip,true)
                SetBlipRoute(currentblip, 1)
                Citizen.Wait(500)
                RequestModel(GetHashKey(Currentcar))
                while not HasModelLoaded(GetHashKey(Currentcar)) do
                    Citizen.Wait(1)
                end
                Missioncar = CreateVehicle(GetHashKey(Currentcar), Currentpos, false, true)

                SetEntityHeading(Missioncar, Currentheading)
                SetVehicleOnGroundProperly(Missioncar)
                SetModelAsNoLongerNeeded(GetHashKey(Currentcar))
                pickup = true
            else
                Citizen.Wait(1)
            end
        end
        if whstart then
            local ped = PlayerPedId()
            local vehicle = IsPedInAnyVehicle(ped, false)
            local currentveh = GetVehiclePedIsUsing(ped)
            local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(currentveh))
            local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))

            if vehname == needcar and vehicle then
                if not DoesBlipExist(currentblip) then
                    RemoveBlip(vehblip)
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
            else
                if not DoesBlipExist(vehblip) then
                    RemoveBlip(currentblip)
                    vehblip = AddBlipForEntity(Missioncar)
                    SetBlipSprite(vehblip, 478)
                    SetBlipColour(vehblip, 38)
                    SetBlipFlashes(vehblip, true)
			        BeginTextCommandSetBlipName("STRING")
			        AddTextComponentString(_U("blip_v"))
			        EndTextCommandSetBlipName(vehblip)
                    SetBlipAsShortRange(vehblip, false)
                    ESX.ShowNotification(_U("getback_vehicle"))
                else
                    Citizen.Wait(1)
                end
            end
        end
        if Sellstart then
            local ped = PlayerPedId()
            local vehicle = IsPedInAnyVehicle(ped, false)
            local currentveh = GetVehiclePedIsUsing(ped)
            local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(currentveh))
            local needcar = GetDisplayNameFromVehicleModel(GetEntityModel(Missioncar))

            if vehname == needcar and vehicle then
                if not DoesBlipExist(currentblip) then
                    RemoveBlip(vehblip)
                    Citizen.Wait(50)
                    currentblip = AddBlipForCoord(Currentpos)
                    SetBlipSprite(currentblip, 479)
			        SetBlipColour(currentblip, 5)
			        BeginTextCommandSetBlipName("STRING")
			        AddTextComponentString(_U("blip_s"))
			        EndTextCommandSetBlipName(currentblip)
			        SetBlipAsShortRange(currentblip, false)
			        SetBlipAsMissionCreatorBlip(currentblip, true)
                    SetBlipRoute(currentblip, 1)
                else
                    Citizen.Wait(1)
                end
            else
                if not DoesBlipExist(vehblip) then
                    RemoveBlip(currentblip)
                    vehblip = AddBlipForEntity(Missioncar)
                    SetBlipSprite(vehblip, 478)
                    SetBlipColour(vehblip, 38)
                    SetBlipFlashes(vehblip, true)
			        BeginTextCommandSetBlipName("STRING")
			        AddTextComponentString(_U("blip_v"))
			        EndTextCommandSetBlipName(vehblip)
                    SetBlipAsShortRange(vehblip, false)
                    ESX.ShowNotification(_U("getback_vehicle"))
                else
                    Citizen.Wait(1)
                end
            end
        end
    end
end)

Citizen.CreateThread(function() -- Markers
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

Citizen.CreateThread(function() -- Main action
    while true do
        Citizen.Wait(1)
        if pickup then
            local player = PlayerPedId()
            local dst = GetDistanceBetweenCoords(GetEntityCoords(player), Currentpos, true)

            if dst <= 2.0 then
                local vehicle = IsPedInAnyVehicle(player, false)
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
                    BringVehicleToHalt(currentveh, 2.5, 1, false)
                    Citizen.Wait(10)
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    drawmarker = false
                    whstart = false
                    Busy = false
                    TriggerServerEvent("utku_wh:upVar_s", "busy", false)
                    Citizen.Wait(10)
                    RemoveBlip(currentblip)
                    currentblip = nil
                    PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
                    DeleteEntity(currentveh)
                    SetEntityCoords(player, Config.Locations.depo, 1, 0, 0, 1)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
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
                if (GetDistanceBetweenCoords(GetEntityCoords(player), Currentpos, true) <= 2.5) then
                    BringVehicleToHalt(playercar, 2.5, 1, false)
                    Citizen.Wait(10)
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    drawmarker = false
                    Sellstart = false
                    NPCstart = false
                    Starttimer = false
                    Busy = false
                    TriggerServerEvent("utku_wh:upVar_s", "busy", false)
                    Citizen.Wait(10)
                    RemoveBlip(currentblip)
                    RemoveBlip(Enemyblip)
                    currentblip = nil
                    PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
                    DeleteEntity(playercar)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
                    TriggerServerEvent("utku_wh:sellGoods", Reward)
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

Citizen.CreateThread(function() -- NPC actions // yay it works now!
    while true do
        Citizen.Wait(1)
        if Config.enablenpc then
            while NPCstart do
                local player = PlayerPedId()
                local playerloc = GetEntityCoords(player)
                local finishline = Currentpos
                local distance = GetDistanceBetweenCoords(playerloc, finishline, false)

                if distance >= 400 then
                    Citizen.Wait(2000)
                    if not DoesEntityExist(Driver) or IsEntityDead(Driver) then
                        Citizen.Wait(10000)
                        Currentloc = GetEntityCoords(player)
                        SpawnEnemyNPC(Currentloc.x, Currentloc.y, Currentloc.x, player)
                    end
                else
                    ClearPedTasksImmediately(Driver)            ClearPedTasksImmediately(Passenger)
                    SetPedAlertness(Driver, 0)                  SetPedAlertness(Passenger, 0)
                    SetPedCombatAttributes(Driver, 46, false)   SetPedCombatAttributes(Passenger, 46, false)
                    RemoveBlip(Enemyblip)
                    RemoveRelationshipGroup(Group)
                    Citizen.Wait(15000)
                    DeleteEntity(Driver)                        DeleteEntity(Driver)
                    DeleteEntity(Enemyveh)
                end
                Citizen.Wait(1)
            end
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if Config.enablenpc then
            if NPCstart then
                if IsEntityDead(Driver) then
                    RemoveBlip(Enemyblip)
                end
            end
            if not NPCstart then
                if not IsEntityDead(Driver) and DoesEntityExist(Driver) then
                    ClearPedTasksImmediately(Driver)            ClearPedTasksImmediately(Passenger)
                    SetPedAlertness(Driver, 0)                  SetPedAlertness(Passenger, 0)
                    SetPedCombatAttributes(Driver, 46, false)   SetPedCombatAttributes(Passenger, 46, false)
                    RemoveBlip(Enemyblip)
                    Citizen.Wait(15000)
                    DeleteEntity(Driver)                        DeleteEntity(Passenger)
                    DeleteEntity(Enemyveh)
                end
            end
        end
    end
end)

Citizen.CreateThread(function() -- Door thingy
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
                TriggerServerEvent("utku_wh:checkKey", 1)
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

Citizen.CreateThread(function() -- Texts and another door thingy
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
                TriggerServerEvent("utku_wh:checkKey", 2)
            elseif IsControlJustReleased(0, 38) and not locked then
                TriggerEvent("utku_wh:tpWH", true, false)
            end
        end
    end
end)

Citizen.CreateThread(function() -- Wooow another door , I should organize them
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pedcoord = GetEntityCoords(ped)
        local laptoploc = Config.Locations.laptop
        local dst = GetDistanceBetweenCoords(pedcoord, laptoploc, true)

        if IsControlJustReleased(0, 38) and dst <= 1.5 then
            if not Delstart or not Sellstart then
                TriggerServerEvent("utku_wh:checkKey", 3)
            else
                exports['mythic_notify']:SendAlert("error", _U("alreadydel"))
            end
        end
    end
end)

RegisterNetEvent("utku_wh:startSell")
AddEventHandler("utku_wh:startSell", function()
    local ped = PlayerPedId()

    RequestModel(GetHashKey(Currentcar))
    while not HasModelLoaded(GetHashKey(Currentcar)) do
        Citizen.Wait(1)
    end
    Missioncar = CreateVehicle(GetHashKey(Currentcar), Currentspawn, false, true)

    SetEntityHeading(Missioncar, C_heading)
    SetVehicleOnGroundProperly(Missioncar)
    SetModelAsNoLongerNeeded(GetHashKey(Currentcar))
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    SetPedIntoVehicle(ped, Missioncar, -1)
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    markerloc = Currentpos
    drawmarker = true
    TriggerServerEvent("utku_wh:upVar_s", "locked", true)
end)

RegisterNetEvent("utku_wh:openLaptop")
AddEventHandler("utku_wh:openLaptop", function()
    if not Busy then
        local ped = PlayerPedId()
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
        exports['mythic_notify']:SendAlert("error", _U("busy"))
    end
end)

RegisterNetEvent("utku_wh:tpWH") --TP to warehouse
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

Locations = {
    c1   = vector3(-252.72 , 6347.42 , 31.45 ), h1  = 229.67,     -- Paletobay Care Center
    c2   = vector3(3596.74 , 3661.80 , 32.85 ), h2  = 75.36 ,     -- Humane Lab Garage 1
    c3   = vector3(324.64  , -1474.52, 29.76 ), h3  = 232.44,     -- Center Hospital
    c3_2 = vector3(3597.74 , 3669.79 , 33.0  ), --same heading    -- Humane Lab Garage 2
    c4   = vector3(1356.89 , 3617.91 , 34.0  ), h4  = 289.05,     -- Trevor Lab
    c5   = vector3(165.68  , 2284.27 , 93.51 ), h5  = 251.22,     -- Online Meth Lab
    c6   = vector3(-575.85 , -279.66 , 35.15 ), h6  = 211.72,     -- Vangelico
    c7   = vector3(-3158.51, 1129.05 , 20.0  ), h7  = 340.76,     -- Chumhas-Barbareno Rd., some store
    c8   = vector3(1075.92 , -1949.32, 31.10 ), h8  = 143.46,     -- Gem Factory
    c9   = vector3(-3166.73, 1032.56 , 20.0  ), h9  = 155.60,     -- Chumhas-Barbareno Rd., some electronics store
    c10  = vector3(369.55  , -818.93 , 28.70 ), h10 = 181.19,     -- Digital Den back alley
    c11  = vector3(304.85  , -904.96 , 29.29 ), h11 = 71.09 ,     -- Los Santos Theatre
    c12  = vector3(2489.48 , 4962.31 , 44.0  ), h12 = 135.06,     -- Grapeseed Farm
    c13  = vector3(3333.35 , 5159.93 , 17.70 ), h13 = 154.27,     -- Lighthouse
    c14  = vector3(2702.14 , 3453.09 , 55.73 ), h14 = 149.64,     -- You Tool
    c15  = vector3(-3051.47, 596.57  , 6.60  ), h15 = 287.22,     -- Ineseno Rd, supermarket
    c16  = vector3(-866.31 , -1123.15, 7.20  ), h16 = 118.30,     -- Liquor Hole
    c17  = vector3(1995.38 , 3035.81 , 47.03 ), h17 = 148.03,     -- Yellow Jack Inn
    c18  = vector3(1244.2  , -3289.29, 5.0   ), h18 = 272.84,     -- Some warehose at the port
    c19  = vector3(1259.60 , -2568.98, 42.0  ), h19 = 292.40,     -- El Burro Heights ruined warehouse
    c20  = vector3(1564.63 , -2162.92, 77.60 ), h20 = 356.89,     -- El Burro Heights another warehouse
    c21  = vector3(1686.03 , 6436.29 , 32.45 ), h21 = 150.64,     -- Highway Gas Station
    c22  = vector3(-676.49 , 5776.40 , 17.33 ), h22 = 64.76 ,     -- Bayview Lodge
    c23  = vector3(-105.52 , 6489.80 , 31.32 ), h23 = 234.07,     -- Blaine County Savings Bank
    c24  = vector3(130.33  , 6662.76 , 31.71 ), h24 = 133.51,     -- Blaine County Big Gas Station
    c25  = vector3(82.73   , 3750.16 , 39.90 ), h25 = 172.25,     -- Stab City
    c26  = vector3(-1131.74, 2694.28 , 18.8  ), h26 = 136.75,     -- The Paint Shop
    c27  = vector3(-2571.25, 2338.04 , 33.06 ), h27 = 157.13,     -- Route 68 Gas Station
    c28  = vector3(350.09  , 4450.57 , 62.84 ), h28 = 6.37  ,     -- North Calafia Way near logs
    c29  = vector3(1715.32 , 4808.84 , 41.84 ), h29 = 90.00 ,     -- Grapeseed Supermarket
    c30  = vector3(1947.86 , 3823.04 , 32.06 ), h30 = 28.05 ,     -- Sandy Shores Liquor store
    c31  = vector3(1063.07 , 2656.37 , 39.55 ), h31 = 2.39  ,     -- Route 68 old cafe
    c32  = vector3(584.01  , 2788.04 , 42.19 ), h32 = 359.81,     -- Dollar Pills back
    c33  = vector3(185.26  , 2775.94 , 45.80 ), h33 = 282.55,     -- Some place in Harmony
    c34  = vector3(-53.31  , 1949.29 , 190.10), h34 = 32.89 ,     -- Great Chaparral Settlement
    c35  = vector3(-1821.21, 809.29  , 138.81), h35 = 303.20      -- Limited LTD Gas Station
}

Cars = {
    v1  = "BISON2"  ,
    v2  = "BISON3"  ,
    v3  = "BURRITO" ,
    v4  = "BURRITO2",
    v5  = "BURRITO3",
    v6  = "BURRITO4",
    v7  = "PARADISE",
    v8  = "RUMBO2"  ,
    v9  = "SPEEDO"  ,
    v10 = "SPEEDO4" ,
    v11 = "SURFER"  ,
    v12 = "YOUGA"   ,
    v13 = "YOUGA2"
}

Sell = {
    s1  = vector3(-3055.85, 608.66  , 6.0   ), car1  = "MULE"    , -- Low item count
    s2  = vector3(-2298.06, 433.19  , 173.50), car2  = "MULE"    ,
    s3  = vector3(-441.91 , 6144.82 , 30.55 ), car3  = "MULE"    ,
    s4  = vector3(2454.29 , -369.55 , 92.15 ), car4  = "MULE"    ,
    s5  = vector3(3480.88 , 3668.41 , 33.10 ), car5  = "POUNDER2", -- Medium item count
    s6  = vector3(2772.95 , 1404.07 , 24.0  ), car6  = "POUNDER2",
    s7  = vector3(193.06  , 2787.34 , 45.0  ), car7  = "POUNDER2",
    s8  = vector3(1027.39 , 2657.39 , 38.85 ), car8  = "POUNDER2",
    s9  = vector3(2007.52 , 4987.60 , 40.80 ), car9  = "TERBYTE" , -- High item count
    s10 = vector3(-600.79 , 5301.42 , 69.55 ), car10 = "TERBYTE" ,
    s11 = vector3(3809.66 , 4471.43 , 3.45  ), car11 = "TERBYTE" ,
    s12 = vector3(205.70  , 6384.08 , 30.75 ), car12 = "TERBYTE" ,

    sp1 = vector3(48.72   , -2566.49, 6.0   ), h1    = 359.0     ,
    sp2 = vector3(85.79   , -2587.42, 6.0   ), h2    = 268.17    ,

    method1 = 1, -- not being used right now
    method2 = 2,
    method3 = 3,
    method4 = 4
}