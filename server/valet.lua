local parkings = require "data.parking"
local parkedVehicles = {}

local function isParkingAvailable(vehicles, spot)
    for i=1, #vehicles do
        local veh = vehicles[i]
        local coords = GetEntityCoords(veh)
        if #(coords-spot.xyz) < 2 then
            return
        end
    end
    return true
end

local function getParking(spots)
    local vehicles = GetAllVehicles()
    return lib.waitFor(function()
        local spot = spots[math.random(1, #spots)]
        if isParkingAvailable(vehicles, spot) then
            return spot
        end
    end)
end

local function getVehicleFromNetId(netId)
    return lib.waitFor(function()
        local entity = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(entity) then return entity end
    end)
end

RegisterNetEvent("ND_Casino:parkVehicleValet", function(netId)
    local src = source
    local vehicle = getVehicleFromNetId(netId)
    if not vehicle then
        return TriggerClientEvent("ox_lib:notify", src, {
            title = "Vehicle not found!",
            description = "You don't have keys to any nearby vehicle",
            type = "error"
        })
    end

    local parking = getParking(parkings.carpark)
    if not parking then
        return TriggerClientEvent("ox_lib:notify", src, {
            title = "Parking not found!",
            description = "We don't have any parking spots left",
            type = "error"
        })
    end

    if parkedVehicles[src] then
        if getVehicleFromNetId(parkedVehicles[src]) == vehicle then
            return TriggerClientEvent("ox_lib:notify", src, {
                title = "Vehicle already parked!",
                description = "We've already parked this vehicle for you",
                type = "error"
            })
        end
    end

    SetEntityCoords(vehicle, parking.x, parking.y, parking.z)
    SetEntityHeading(vehicle, parking.w)
    parkedVehicles[src] = netId
    TriggerClientEvent("ox_lib:notify", src, {
        title = "Vehicle parked!",
        description = "We've taken care of your vehicle and parked it",
        type = "success"
    })
end)

RegisterNetEvent("ND_Casino:bringValet", function()
    local src = source
    if not parkedVehicles[src] then return end

    local vehicle = getVehicleFromNetId(parkedVehicles[src])
    if not vehicle then
        return TriggerClientEvent("ox_lib:notify", src, {
            title = "Vehicle not found!",
            description = "We couldn't find your vehicle",
            type = "error"
        })
    end

    local parking = getParking(parkings.valet)
    if not parking then
        return TriggerClientEvent("ox_lib:notify", src, {
            title = "Vehicle not found!",
            description = "We couldn't find your vehicle",
            type = "error"
        })
    end

    SetEntityCoords(vehicle, parking.x, parking.y, parking.z)
    SetEntityHeading(vehicle, parking.w)
    parkedVehicles[src] = nil
    TriggerClientEvent("ox_lib:notify", src, {
        title = "Vehicle brought back!",
        description = "We've brought your vehicle back to you",
        type = "success"
    })
end)
