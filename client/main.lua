local casinoIpl = require "data.ipl"
IsCasinoVIP = false

local function unloadIpl(ipl)
    return IsIplActive(ipl) and RemoveIpl(ipl)
end

local function loadIpl(ipl)
    return not IsIplActive(ipl) and RequestIpl(ipl)
end

AddEventHandler("onResourceStart", function(resourceName)
    if cache.resource ~= resourceName then return end
    for i=1, #casinoIpl do
        loadIpl(casinoIpl[i])
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if cache.resource ~= resourceName then return end
    for i=1, #casinoIpl do
        unloadIpl(casinoIpl[i])
    end
end)

RegisterNetEvent("ND_Casino:updateMembershipStatus", function(isMember)
    IsCasinoVIP = isMember
end)

exports("isMember", function()
    return IsCasinoVIP
end)

if GetResourceState("ND_AppearanceShops") == "started" then
    local clothing = require("data.clothing")
    exports["ND_AppearanceShops"]:createClothingStore(clothing)
end
