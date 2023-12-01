local bridge = {}

function bridge.getNearestValetVehicle(ped)
    local vehicle = GetVehiclePedIsIn(ped, true)
    if DoesEntityExist(vehicle) then
        return vehicle
    end
    lib.notify({
        title = "Vehicle not found!",
        description = "You don't have keys to any nearby vehicle",
        type = "error"
    })
end

return bridge
