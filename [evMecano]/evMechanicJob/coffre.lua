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
local MenuCoffreEv = RageUI.CreateMenu("Coffre", "Coffre")

MenuCoffreEv.Closed = function()
    open = false
end

function OpenMenuCoffreEv()
    local menuTest = RageUI.CreateMenu("Coffre",nil)

    RageUI.Visible(menuTest, not RageUI.Visible(menuTest))

    while menuTest do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTest,true,true,true,function()

            RageUI.Separator("                             ")
        
            RageUI.ButtonWithStyle("Deposer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then    
                    OpenDeposerEvJob()
                    RageUI.CloseAll()
                end
            end)  

            

            RageUI.ButtonWithStyle("Prendre",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    OpenPrendreEvJob()
                    RageUI.CloseAll()   
                end
            end)  

        
        end, function()
        end)

        if not RageUI.Visible(menuTest) then
            menuTest=RMenu:DeleteType("Titre", true)
        end

    end

end



Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				for k in pairs {vector3(-227.832, -1333.385, 30.89)} do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = {vector3(-227.832, -1333.385, 30.89)}
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= 6 then
					wait = 0
					DrawMarker(21, -227.832, -1333.385, 30.89, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.7, 0.7, 0.7, 235, 239, 30, 180, true, true, p19, true)  
				end

				if dist <= 1.0 then
					wait = 0
					
					AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                    DisplayHelpTextThisFrame("HELP", false)
					if IsControlJustPressed(1,51) then
						OpenMenuCoffreEv()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)

-- fonction --
function OpenPrendreEvJob()
	ESX.TriggerServerCallback('evJob:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'LTD',
			title    = 'stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'LTD',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('evJob:prendreitems', itemName, count)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenDeposerEvJob()
	ESX.TriggerServerCallback('evJob:inventairejoueur', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'police',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'police',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('evJob:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenDeposerEvJob()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end