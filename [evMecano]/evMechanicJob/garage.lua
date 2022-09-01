TriggerServerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)





-------------Menu Garage Spawner




RMenu.Add("Location", "Location_main", RageUI.CreateMenu("Garage", "Made by evann™"))
RMenu:Get("Location", "Location_main").Closed = function()
    print("vous avez fermé le menu")

end

Citizen.CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
        while true do
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local dest = vector3(-190.291, -1290.251, 31.29)
            local distance = GetDistanceBetweenCoords(pos, dest, true)

            if distance > 30 then
                interval = 200
            else
                interval = 1
                DrawMarker(36, -190.291, -1290.251, 31.29, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.5, 0.7, 235, 239, 30, 170, 0, 1, 2, 0, nil, nil, 0)
                if distance < 1 then  
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1, 51) then
                        RageUI.Visible(RMenu:Get("Location","Location_main"), true)
                    end
                end
            end

            Citizen.Wait(interval)
        end
    end
end)



Citizen.CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
        while true do
            RageUI.IsVisible(RMenu:Get("Location","Location_main"),true,true,true,function()
           
                RageUI.ButtonWithStyle("Remorqueuse", nil, {RightBadge = RageUI.BadgeStyle.Armour}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("flatbed")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

            

                RageUI.ButtonWithStyle("Depanneuse 1", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("wastelander")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

                RageUI.ButtonWithStyle("Depanneuse 2", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("towtruck")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

                RageUI.ButtonWithStyle("Voiture de Fonctions", nil, {RightBadge = RageUI.BadgeStyle.GoldMedal}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("sadler")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)



                RageUI.ButtonWithStyle("Ranger le Véhicule", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                    if s then
                        local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                        local playerPed = PlayerPedId()
                        if GetPedInVehicleSeat(Vehicle, -1) == playerPed then     
                            ESX.Game.DeleteVehicle(Vehicle)
                            ESX.ShowNotification('~g~Vehicule rangé')
                        end

                    end
            
                end)




            end, function()end, 1)
            Citizen.Wait(0)
        end
    end

end)



