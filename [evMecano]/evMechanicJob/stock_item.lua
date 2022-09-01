ESX = nil

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)













-- Menu --
local open = false
local MenuStockMenu = RageUI.CreateMenu("↓↓↓↓↓↓", nil)

MenuStockMenu.Closed = function() 
    open = false
end




function OpenStockMenu()

    local menuTest = RageUI.CreateMenu("Stock", nil)

    RageUI.Visible(menuTest, not RageUI.Visible(menuTest))

    while menuTest do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTest,true,true,true,function()

            RageUI.Separator("↓                      ~s~↓")
        
            RageUI.ButtonWithStyle("Kit Carosserie", nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    TriggerServerEvent('evJob:GiveItem', 'Kit carosserie', 'carokit')
                       
                    
                end
            end) 
            
            RageUI.ButtonWithStyle("Kit Réparation", nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    TriggerServerEvent('evJob:GiveItem', 'Kit réparation', 'fixkit')
                       
                    
                end
            end)

            RageUI.Separator("↓    ~r~Fermer le menu     ~s~↓")

            RageUI.ButtonWithStyle("Fermer",nil, {RightLabel = "~y~→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()    
                end
            end)  

        
        end, function()
        end)

        if not RageUI.Visible(menuTest) then
            menuTest=RMenu:DeleteType("StockItem", true)
        end

    end

end












Citizen.CreateThread(function()
    while true do 
        local wait = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                for k in pairs {vector3(-199.587, -1319.966, 31.089)} do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = {vector3(-199.587, -1319.966, 31.089)}
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= 6 then 
                    wait = 0
                    DrawMarker(21, -199.587, -1319.966, 31.089, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 235, 239, 30, 180, true, true, p19, true)
                end
                if dist <= 1.0 then 
                    wait = 0

                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1, 51) then 
                        OpenStockMenu()
                    end
                end
                
            end
        end
    Citizen.Wait(wait)
    end
end)


