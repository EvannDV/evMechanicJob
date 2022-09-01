ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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

-- MENU FUNCTION --
local open = false 
local MenuBossmechanic = RageUI.CreateMenu('Boss Action', 'Boss Menu') 
MenuBossmechanic.Closed = function()
  open = false
end






function OpenMenuBossEvJob()

    local menuTest = RageUI.CreateMenu("Boss Actions","Interactions")

    RageUI.Visible(menuTest, not RageUI.Visible(menuTest))

    while menuTest do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTest,true,true,true,function()

            RageUI.Separator("↓     ~y~Gestion de l'entreprise     ~s~↓")
        
            
            RageUI.ButtonWithStyle("Actions Patron", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()    
                end
            end)

        
        end, function()
        end)

        if not RageUI.Visible(menuTest) then
            menuTest=RMenu:DeleteType("mechanic", true)
        end

    end

end














function aboss()
    TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
        menu.close()
    end, {wash = false})
end

Citizen.CreateThread(function()
    while true do
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and ESX.PlayerData.job.grade_name == 'boss' then
            for k in pairs {vector3(-207.056, -1331.389, 34.89)} do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = {vector3(-207.056, -1331.389, 34.89)}
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= 6 then
                    wait = 0
                    DrawMarker(29, -207.056, -1331.389, 34.89, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.7, 0.7, 0.7, 235, 239, 30, 180, true, true, p19, true)  
                    if dist <= 1.0 then
                        wait = 0


                        AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                        DisplayHelpTextThisFrame("HELP", false)
                        if IsControlJustPressed(1,51) then
                            OpenMenuBossEvJob()
                        end
                    end
                end
            end
        end
    Wait(wait)
    end
end)


