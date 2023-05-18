local ESX = nil

-- Configurer les coordonnées et la taille du marker
local markerVole = vector3(255.2, -1339.01, 32.93)
local markerSize = {x = 0.8, y = 0.8, z = 0.8}
local markerType = 2 -- Ajout de la variable pour le type de marker
local markerColor = {r = 255, g = 0, b = 0, a = 100}
-- Configurer le Ped
local npcModel = "a_m_m_skater_01" -- modèle du PNJ (celui-ci est un skater)
local npcCoords = vector3(254.87, -1348.34, 32.03) -- coordonnées où le PNJ doit spawn
local npcHeading = 270.0 -- direction où le PNJ doit regarder
local npcWeapon = "weapon_snspistol" -- arme que le PNJ doit utiliser
local npcGroup = GetRandomIntInRange(0, 65535) -- groupe auquel appartient le PNJ (un nombre aléatoire entre 0 et 65535)
local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
local rayon = vector3(255.2, -1339.01, 32.93)
local isWelding = false
local gpsCoords = vector3(1530.88, 1703.31, 109.77) 
local marker = nil

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    DrawMarker(markerType, markerVole.x, markerVole.y, markerVole.z - 0.99, 0, 0, 0, 0, 0, 0, markerSize.x, markerSize.y, markerSize.z, markerColor.r, markerColor.g, markerColor.b, markerColor.a, 0, 0, 0, 1, 0, 0, 0)

    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(markerVole.x, markerVole.y, markerVole.z)

    if Vdist2(GetEntityCoords(PlayerPedId()), markerVole) < (markerSize.x * 1.5) then
      DrawText3Ds(markerVole.x, markerVole.y, markerVole.z, "~g~Appuyez sur ~w~E~g~ pour Forcé Le Garage.")

      if IsControlJustReleased(0, 38) and not isWelding then -- La touche 38 correspond à la touche "E" sur PC
        isWelding = true

        if gpsMarker ~= nil then
          -- Si un marqueur GPS est déjà présent, on le supprime
          RemoveBlip(gpsMarker)
          gpsMarker = nil
        else
          -- Sinon, on crée un nouveau marqueur GPS
          gpsMarker = AddBlipForCoord(gpsCoords.x, gpsCoords.y, gpsCoords.z)
          SetBlipSprite(gpsMarker, 1)
          SetBlipColour(gpsMarker, 5)
          SetBlipScale(gpsMarker, 1.0)
          SetBlipAsShortRange(gpsMarker, false)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString("Point De Rendz-vous")
          EndTextCommandSetBlipName(gpsMarker)

          TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
          TriggerServerEvent("AfficherZoneSurCarte")
          TriggerEvent("AfficherZoneSurCarte", 100, 200, 0, 1000)
          Citizen.CreateThread(function()
            Citizen.Wait(35000) -- Attendez 30 secondes de crochetage
            isWelding = false

            -- Appeler l'événement lorsque le joueur vole une voiture
            TriggerServerEvent('voiture:volee')

            RequestModel("MotoB")
            RequestModel(npcModel)

            while not HasModelLoaded(npcModel) do
              Citizen.Wait(100)
            end

            while not HasModelLoaded("MotoB") do
              Citizen.Wait(100)
            end

            local MotoB = CreateVehicle("MotoB", markerVole.x, markerVole.y, markerVole.z, 211.37, true, false)
            TriggerEvent('esx:showNotification', '~r~Le Propiétaire vous a vue Fuyez!!!!!!!!!!!!!')

            -- afficher la notification pour le joueur
            SetPedIntoVehicle(PlayerPedId(), MotoB, -1)

            local npc = CreatePed(28, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, npcHeading, false, true)
            SetPedDropsWeaponsWhenDead(npc, false)
          SetPedCombatAttributes(npc, 46, true)
          SetPedCombatAttributes(npc, 5, true)
          SetPedCombatAttributes(npc, 17, true)
          SetPedCombatAbility(npc, 2)
          SetPedCombatMovement(npc, 2)
          GiveWeaponToPed(npc, GetHashKey(npcWeapon), 500, false, true)
          SetPedRelationshipGroupHash(npc, npcGroup)
          TaskCombatPed(npc, PlayerPedId(), 0, 16)
        end)
      end

  end
end
  end
end)


-- Fonction pour afficher du texte au-dessus du marker
function DrawText3Ds(x, y, z, text)
  local onScreen,_x,_y = World3dToScreen2d(x, y, z)
  local scale = 0.45
  if onScreen then
  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x, _y)

    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    
  end
end

RegisterNetEvent("AfficherZoneSurCarte")
AddEventHandler("AfficherZoneSurCarte", function(x, y, z, rayon)
  Citizen.CreateThread(function()
    local blip = AddBlipForCoord(256.2, -1339.01, 31.93)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 6)
    SetBlipAlpha(blip, 128)
    SetBlipHighDetail(blip, true)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 2.0)

    Citizen.Wait(35000) -- wait for 30 seconds

    RemoveBlip(blip) -- remove the blip
  end)
end)


local blip = AddBlipForCoord(255.2, -1339.01, 32.93)

SetBlipSprite(blip, sprite)
SetBlipDisplay(blip, display)
SetBlipScale(blip, scale)
SetBlipColour(blip, color)
SetBlipAsShortRange(blip, shortRange)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(text)
EndTextCommandSetBlipName(blip)
