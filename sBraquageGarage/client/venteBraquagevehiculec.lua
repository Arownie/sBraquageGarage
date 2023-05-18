ESX = nil


local markerLocation = vector3(1530.88, 1703.31, 109.77)
local isMotoBsSpawned = false
local playerPed = nil



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
  end
  
  while true do
    Citizen.Wait(0)
    DrawMarker(1, markerLocation.x, markerLocation.y, markerLocation.z-0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
    playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if GetDistanceBetweenCoords(playerCoords, markerLocation, true) < 2.0 then
        -- Afficher le message "Appuyez sur E pour vendre/monter la moto."
        local message = isMotoBsSpawned and "Appuyez sur ~g~E~w~ pour vendre la moto."
        DrawText3Ds(markerLocation.x, markerLocation.y, markerLocation.z + 0.5, "Appuyez sur ~g~E~w~ pour vendre la moto volée")
        -- Vérifier si la touche E est appuyée
        if IsControlJustReleased(0, 38) then
          if isMotoBsSpawned then
            -- Vérifier si le joueur est sur une MotoBs
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                if GetEntityModel(vehicle) == GetHashKey('MotoB') then
                    -- Faire despawn la MotoBs
                    SetEntityAsMissionEntity(vehicle, true, true)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
                    -- Marquer la MotoBs comme non spawnée
                    isMotoBsSpawned = false
                    -- Ajouter 1000 au joueur
                    TriggerServerEvent('playerDespawnedMotoBs')
                    TriggerEvent('esx:addMoney', 1000)
                    TriggerEvent('esx:showNotification', '~r~Merci, et voila 1000$')
                end
            end
        
            else
                -- Vérifier si la MotoBs est présente dans le monde
                local MotoB = GetClosestVehicle(markerLocation.x, markerLocation.y, markerLocation.z, 3.0, 0, 71)
                if DoesEntityExist(MotoB) and GetEntityModel(MotoB) == GetHashKey('MotoB') then
                    -- Faire spawn la MotoBs
                    TaskWarpPedIntoVehicle(playerPed, MotoB, -1)
                    -- Marquer la MotoBs comme spawnée
                    isMotoBsSpawned = true
                else
                    -- Afficher un message d'erreur si la MotoBs n'est pas présente dans le monde
                    exports['mythic_notify']:SendAlert('error', 'Il n\'y a pas de vehicule du braquage disponible à cet endroit.')
                end
            end
        end
    end
  end
end)

RegisterNetEvent('esx:addMoney')
AddEventHandler('esx:addMoney', function(amount)
    TriggerServerEvent('esx:addAccountMoney', 'money', amount)
end)

print("[^1Auteur^0] : ^4Sly Zapesti#9737^0")