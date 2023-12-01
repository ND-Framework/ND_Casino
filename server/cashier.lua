local membershipData = require "data.membership"

local interactFunctions = {
    buy = function(amount)
        
    end,
    sell = function(amount)
        
    end,
    vip = function(index)
        local info = membershipData[i]

    end
}

RegisterNetEvent("ND_Casino:interactCashier", function(interactType, info)
    local func = interactFunctions[interactType]
    if not func then return end
    func(info)
end)
