RMenu.Add("Mecano", "Mecano_main", RageUI.CreateMenu("Rdv Mecano", "Made by evann™"))
RMenu:Get("Mecano", "Mecano_main").Closed = function()
    print("vous avez fermé le menu")

end





Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-205.894, -1326.834, 30.89)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1
            DrawMarker(32, -205.894, -1326.834, 30.89, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 235, 239, 30, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 1 then  
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get("Mecano","Mecano_main"), true)
                end
            end
        end

        Citizen.Wait(interval)
    end
end)



Citizen.CreateThread(function()
        

       while true do
           RageUI.IsVisible(RMenu:Get("Mecano","Mecano_main"),true,true,true,function()
           
               RageUI.ButtonWithStyle("Appeller un Mecano", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                   if s then
                       TriggerServerEvent('evJob:AnnonceRdv')
                       Citizen.Wait(20000)

                   end
            
               end)




           end, function()end, 1)
           Citizen.Wait(0)
       end
 
end)
