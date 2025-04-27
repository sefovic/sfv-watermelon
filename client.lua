local isNearPickup = false
local isNearProcessing = false
local isNearSell = false

-- NPC oluşturma fonksiyonu
local function SpawnNPC(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    local ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1, coords.w, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end

-- NPC’leri oluştur
CreateThread(function()
    SpawnNPC("s_m_m_farmer_01", Config.ProcessingNPC)
    SpawnNPC("a_m_m_business_01", Config.SellNPC)
end)

-- Pickup kontrolleri
CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)

        isNearPickup = false
        for _, loc in pairs(Config.PickupLocations) do
            local dist = #(playerCoords - vector3(loc.x, loc.y, loc.z))
            if dist < 2.0 then
                isNearPickup = true
                DrawText3D(loc.x, loc.y, loc.z, "[E] Karpuz Topla")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("karpuz:topla")
                end
            end
        end

        local processDist = #(playerCoords - vector3(Config.ProcessingNPC.x, Config.ProcessingNPC.y, Config.ProcessingNPC.z))
        if processDist < 2.0 then
            DrawText3D(Config.ProcessingNPC.x, Config.ProcessingNPC.y, Config.ProcessingNPC.z, "[E] Karpuzları İşle")
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("karpuz:isle")
            end
        end

        local sellDist = #(playerCoords - vector3(Config.SellNPC.x, Config.SellNPC.y, Config.SellNPC.z))
        if sellDist < 2.0 then
            DrawText3D(Config.SellNPC.x, Config.SellNPC.y, Config.SellNPC.z, "[E] Karpuz Sat")
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("karpuz:sat")
            end
        end
    end
end)

-- 3D Yazı
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z + 0.5, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
