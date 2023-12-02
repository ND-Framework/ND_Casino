local createAiPed = require "modules.peds.client"
local createProp = require "modules.props.client"

local props = {
    {
        model = `vw_prop_vw_valet_01a`,
        location = vec4(925.893, 51.215, 80.106, 58.0)
    },
    {
        model = `prop_notepad_02`,
        location = vec4(925.89, 51.24, 81.105, 64.0)
    },
    {
        model = `prop_pencil_01`,
        location = vec4(925.89, 51.24, 81.113, 280.0)
    }
}

local peds = {
    {
        model = `S_M_Y_Casino_01`,
        coords = vec4(926.31, 50.96, 81.10, 58.0),
        distance = 60.0,
        anim = {
            dict = "anim@amb@casino@valet_scenario@pose_a@",
            clip = "base_a_m_y_vinewood_01"
        },
        clothing = {
            mask = {drawable = 1, texture = 0},
            bag = {drawable = 0, texture = 0},
            torso2 = {drawable = 1, texture = 1},
            badge = {drawable = 0, texture = 0},
            shoes = {drawable = 1, texture = 0},
            undershirt = {drawable = 3, texture = 0},
            leg = {drawable = 0, texture = 0},
            accessory = {drawable = 2, texture = 0},
            torso = {drawable = 1, texture = 4},
            kevlar = {drawable = 0, texture = 0},
            face = {drawable = 5, texture = 0},
            hair = {drawable = 5, texture = 0},
            hat = {drawable = -1, texture = -1},
            glasses = {drawable = -1, texture = -1},
            watch = {drawable = -1, texture = -1},
            ears = {drawable = -1, texture = -1},
            bracelets = {drawable = -1, texture = -1}
        },
        options = {
            {
                name = "nd_casino:valetPark",
                icon = "fa-solid fa-square-parking",
                label = "Park vehicle",
                distance = 2.0,
                onSelect = function(data)
                    local vehicle = Bridge.getNearestValetVehicle(cache.ped)
                    if not vehicle then return end
                    for i=0, 5 do SetVehicleDoorShut(vehicle, i, false) end

                    local netId = NetworkGetNetworkIdFromEntity(vehicle)
                    TriggerServerEvent("ND_Casino:parkVehicleValet", netId)
                end
            },
            {
                name = "nd_casino:valetBring",
                icon = "fa-solid fa-car",
                label = "Bring vehicle",
                distance = 2.0,
                onSelect = function(data)
                    TriggerServerEvent("ND_Casino:bringValet")
                end
            }
        },
    }
}

for i=1, #props do
    createProp(props[i])
end

for i=1, #peds do
    createAiPed(peds[i])
end



-- local parkings = {}
-- RegisterCommand("set-parking", function(source, args, rawCommand)
--     local coords = GetEntityCoords(cache.vehicle)
--     local heading = GetEntityHeading(cache.vehicle)
--     local park = vec4(coords.x, coords.y, coords.z, heading)
--     local index = #parkings+1
--     parkings[index] = park
--     print("Created parking", index, park)
-- end, false)

-- RegisterCommand("get-parkings", function(source, args, rawCommand)
--     local info = ""
--     for i=1, #parkings do
--         local park = parkings[i]
--         info = ("%s\nvec4(%.2f, %.2f, %.2f, %.2f),"):format(info, park.x, park.y, park.z, park.w)
--     end
--     lib.setClipboard(info)
-- end, false)
