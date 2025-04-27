local playersData = {}

RegisterServerEvent("karpuz:topla")
AddEventHandler("karpuz:topla", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Rastgele karpuz sayısı (1 ile 5 arasında)
    local karpuzMiktar = math.random(1, 5)
    
    -- Envantere karpuz ekle
    Player.Functions.AddItem("karpuz", karpuzMiktar)
    
    -- Bilgi mesajı
    TriggerClientEvent("QBCore:Notify", src, karpuzMiktar .. "x Karpuz topladın!")
end)

RegisterServerEvent("karpuz:isle")
AddEventHandler("karpuz:isle", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Envanterde karpuz sayısını kontrol et
    local karpuzSayisi = Player.Functions.GetItemByName("karpuz").amount

    if karpuzSayisi >= 2 then
        local islemedeKarpuz = 2 -- 2 karpuz işlemeye sokulacak
        local karpuzSuyuMiktar = math.floor(islemedeKarpuz / 2)

        -- İşlenmiş karpuzları çıkar
        Player.Functions.RemoveItem("karpuz", islemedeKarpuz)

        -- Karpuz suyu ekle
        Player.Functions.AddItem("karpuzsuyu", karpuzSuyuMiktar)

        -- Bilgi mesajı
        TriggerClientEvent("QBCore:Notify", src, "2x Karpuz işlendikten sonra " .. karpuzSuyuMiktar .. "x Karpuz Suyu elde ettin!")
    else
        TriggerClientEvent("QBCore:Notify", src, "İşlemek için yeterli karpuz yok!", "error")
    end
end)

RegisterServerEvent("karpuz:sat")
AddEventHandler("karpuz:sat", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Envanterde karpuz suyu kontrol et
    local karpuzSuyuSayisi = Player.Functions.GetItemByName("karpuzsuyu").amount

    if karpuzSuyuSayisi > 0 then
        local kazanc = karpuzSuyuSayisi * 500 -- 1 karpuz suyu = 500$
        
        -- Karpuz suyunu çıkar
        Player.Functions.RemoveItem("karpuzsuyu", karpuzSuyuSayisi)

        -- Para ekle
        Player.Functions.AddMoney("cash", kazanc)

        -- Bilgi mesajı
        TriggerClientEvent("QBCore:Notify", src, karpuzSuyuSayisi .. "x Karpuz Suyu satıldı. Kazanç: " .. kazanc .. "$")
    else
        TriggerClientEvent("QBCore:Notify", src, "Satacak karpuz suyu yok!", "error")
    end
end)
