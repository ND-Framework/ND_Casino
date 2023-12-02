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

function bridge.removeChips(src, amount)
    if GetResourceState("ox_inventory") ~= "started" then return end
    if inventory:GetItem(src, "casino_chips", nil, true) < amount then return end
    return inventory:RemoveItem(src, "casino_chips", amount) == true
end

function bridge.addChips(src, amount)
    if GetResourceState("ox_inventory") ~= "started" then return end
    inventory:AddItem(src, "casino_chips", amount)
end

return bridge
