local bridge = {}
local NDCore = exports["ND_Core"]
local inventory = exports["ox_inventory"]

function bridge.removeMoney(src, amount, reason)
    local player = NDCore:getPlayer(src)
    if not player or player.getData("bank") < amount then return end
    return player.deductMoney("bank", amount, reason)
end

function bridge.addMoney(src, amount, reason)
    local player = NDCore:getPlayer(src)
    if not player then return end
    player.addMoney("bank", amount, reason)
end

function bridge.getChips(src)
    if GetResourceState("ox_inventory") ~= "started" then return 0 end
    return inventory:GetItem(src, "casino_chips", nil, true)
end

function bridge.removeChips(src, amount)
    if GetResourceState("ox_inventory") ~= "started" then return end
    return inventory:RemoveItem(src, "casino_chips", amount) == true
end

function bridge.addChips(src, amount)
    if GetResourceState("ox_inventory") ~= "started" then return end
    inventory:AddItem(src, "casino_chips", amount)
end

function bridge.getMembership(src)
    local player = NDCore:getPlayer(src)
    if not player then return end
    return player.getMetadata("casino_vip_membership")
end

function bridge.updateMembership(src, expires)
    local player = NDCore:getPlayer(src)
    if not player then return end
    local metadata = player.setMetadata("casino_vip_membership", expires)
    return metadata.casino_vip_membership
end

function bridge.updateAllPlayers()
    local players = NDCore:getPlayers()
    for src, _ in pairs(players) do
        UpdateMemberStatus(src, IsCasinoMember(src))
        Wait(100)
    end
end

AddEventHandler("ND:characterLoaded", function(character)
    local src = character.source
    if not src then return end
    UpdateMemberStatus(src, IsCasinoMember(src))
end)

return bridge
