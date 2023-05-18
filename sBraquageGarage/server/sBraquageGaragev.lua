ESX = nil


-- Déclencher l'événement lorsque le joueur vole une voiture
RegisterServerEvent('voiture:volee')
AddEventHandler('voiture:volee', function()

end)

-- Serveur
RegisterServerEvent("AfficherZoneSurCarte")
AddEventHandler("AfficherZoneSurCarte", function(x, y, z, rayon)
    TriggerClientEvent("esx:showNotification", -1, "Une Alarme de Garage a été déclanché!")
    TriggerClientEvent("AfficherZoneSurCarte", -1, x, y, z, rayon) -- Envoie l'événement à tous les clients (-1)
end)


TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

-- Then, you can use it like this:

RegisterServerEvent('playerDespawnedMotoBs')
AddEventHandler('playerDespawnedMotoBs', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(1000)
    RemoveBlip(gpsMarker)
end)