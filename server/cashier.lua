local prices = require "data.prices"

local interactFunctions = {
    buy = function(src, amount)
        local money = amount*prices.chips
        if not Bridge.removeMoney(src, money, ("Purchased %d Casino chips"):format(amount)) then return end
        Bridge.addChips(src, amount)
    end,
    sell = function(src, amount)
        local money = amount*prices.chips
        if Bridge.getChips(src) < amount then return end
        Bridge.removeChips(src, amount)
        Bridge.addMoney(src, money, ("Sold %d Casino chips"):format(amount))
    end,
    vip = function(src, index)
        local info = prices.membership[index]
        Bridge.removeMoney(src, info.price, ("Casino %s VIP membership"):format(info.label))

        local expires = os.time()+(info.expiresInHours*3600)
        Bridge.updateMembership(src, expires)
        UpdateMemberStatus(src, IsCasinoMember(src))
    end
}

RegisterNetEvent("ND_Casino:interactCashier", function(interactType, info)
    local src = source
    local func = interactFunctions[interactType]
    if not func then return end
    func(src, info)
end)
