Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1,167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            menu()
        end
    end

end)


--------Blips


Citizen.CreateThread(function()
    local BLIPMECA = AddBlipForCoord(vector3(97.869, -740.351, 45.755))
    SetBlipSprite(BLIPMECA, 446)
    SetBlipColour(BLIPMECA, 5)
    SetBlipScale(BLIPMECA, 1.0)
    SetBlipAsShortRange(BLIPMECA, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("MÃ©cano")
    EndTextCommandSetBlipName(BLIPLMECA)
end)




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




function menu()

    local etat=true
    local IndexList=1

    local menuTestNumero2 = RageUI.CreateMenu("Mecano","Made by evann™")

    RageUI.Visible(menuTestNumero2, not RageUI.Visible(menuTestNumero2))

    while menuTestNumero2 do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTestNumero2,true,true,true,function()
        
            RageUI.Separator("~y~↓     Actions     ↓")

            RageUI.ButtonWithStyle("Crocheter", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                if Selected then    
                    local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    ExecuteCommand('e karate')
                    Wait(2000)
                    for i = 0, 5 do
                        SetVehicleDoorOpen(Vehicle, i, false, true) 
                    end
                    ESX.ShowNotification('~g~Voiture ouverte')
                end
            end)

            RageUI.ButtonWithStyle("Mettre en Fourriere", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then
                    local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    local playerPed = PlayerPedId()
                    if GetPedInVehicleSeat(Vehicle, -1) == playerPed then     
                        ESX.Game.DeleteVehicle(Vehicle)
                        ESX.ShowNotification('~g~Voiture en fourrière')
                    else
                        ESX.ShowNotification('~r~Met toi place conducteur')
                    end

                end
            end)


            RageUI.ButtonWithStyle("Prendre Clé de Serrage", nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, function(Hovered, Active, Selected)
                if Selected then
                    local weapon = "weapon_wrench"
                    local hashWeapon = GetHashKey(weapon)
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    GiveWeaponToPed(ped , hashWeapon, 250, true, true)
                
                end
            end)

            RageUI.ButtonWithStyle("~y~Annonce ~g~Ouvert", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('evJob:AnnonceOuverture')
                
                end
            end)

            RageUI.ButtonWithStyle("~y~Annonce ~r~Ferme", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('evJob:AnnonceFermeture')
                
                end
            end)

            RageUI.ButtonWithStyle("~y~Annonce ~p~Recrutement", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('evJob:AnnonceRecrutement')
                
                end
            end)

            --RageUI.ButtonWithStyle("Attacher le vehicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                --if Selected then
                    --local playerPed = PlayerPedId()
                    --local vehicle = GetVehiclePedIsIn(playerPed, true)
                    --local wantedVehicle = ESX.Game.GetVehicleInDirection()
                    --AttachEntityToEntity(wantedVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                    --ESX.ShowNotification('~g~Vehicule attaché')
                --end
            --end)

            --RageUI.ButtonWithStyle("Detacher le vehicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                --if Selected then
                    --local playerPed = PlayerPedId()
                    --local vehicle = GetVehiclePedIsIn(playerPed, true)
                    --local wantedVehicle = ESX.Game.GetVehicleInDirection()
                    --DetachEntity(wantedVehicle, true, true)
                    --ESX.ShowNotification('~g~Vehicule attaché')
                --end
            --end)










--------------Enos Billing


            RageUI.ButtonWithStyle("~r~Facture",nil, {RightLabel = "~r~→→"}, not cooldown, function(Hovered,Active,Selected)
                local player, distance = ESX.Game.GetClosestPlayer()
                if Selected then
                    local raison = ""
                    local montant = 0
                    AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            raison = result
                            result = nil
                            AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                result = GetOnscreenKeyboardResult()
                                if result then
                                    montant = result
                                    result = nil
                                    if player ~= -1 and distance <= 3.0 then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ("Benny's"), montant)
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                    else
                                        RageUI.Popup({message = "~r~Probleme~s~: Aucuns joueurs proche"})
                                    end
                                end
                            end
                        end
                    end
					cooldown = true
					Citizen.SetTimeout(5000,function()
						cooldown = false
					end)
				end
            end)


            RageUI.ButtonWithStyle("Debug", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand('restart evJob')
                    RageUI.CloseAll()    
                end
            end)


            




            









        

        end, function()
        end)

        if not RageUI.Visible(menuTestNumero2) then
            menuTestNumero2=RMenu:DeleteType("Titre", true)
        end

    end

end
