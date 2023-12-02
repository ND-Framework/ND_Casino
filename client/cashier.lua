local prices = require "data.prices"
local membershipData = prices.membership
local membershipOptions = {}

for i=1, #membershipData do
    local data = membershipData[i]
    membershipOptions[i] = {
        label = data.label,
        value = i
    }
end

local peds = {
    {
        model = `S_F_Y_Casino_01`,
        coords = vec4(1117.34, 220.00, -49.43, 83.14),
        distance = 60.0,
        target = {
            type = "addBoxZone",
            offset = vec3(0.0, 1.0, 0.5),
        },
        anim = {
            dict = "AMB@PROP_HUMAN_SEAT_CHAIR@FEMALE@PROPER@BASE",
            clip = "BASE"
        },
        blip = {
            label = "Cashier",
            sprite = 683,
            scale = 0.8,
            color = 0
        },
        attachToObject = {
            object = `vw_prop_casino_stool_02a`,
            radius = 2.0,
            pos = vec3(0.1, -0.025, 0.78),
            rot = vec3(0.0, 0.0, 90.0)
        },
        clothing = {
            torso = {drawable = 0, texture = 1},
            torso2 = {drawable = 0, texture = 0},
            bag = {drawable = 0, texture = 0},
            undershirt = {drawable = 0, texture = 0},
            leg = {drawable = 0, texture = 0},
            kevlar = {drawable = 0, texture = 0},
            mask = {drawable = 0, texture = 0},
            face = {drawable = 3, texture = 1},
            accessory = {drawable = 0, texture = 0},
            badge = {drawable = 0, texture = 0},
            hair = {drawable = 0, texture = 1},
            shoes = {drawable = 1, texture = 0},
            bracelets = {drawable = -1, texture = -1},
            hat = {drawable = -1, texture = -1},
            glasses = {drawable = 0, texture = 0},
            ears = {drawable = -1, texture = -1},
            watch = {drawable = -1, texture = -1},
        },
        options = {
            {
                name = "nd_casino:chipsBuy",
                icon = "fa-solid fa-arrow-right-arrow-left",
                label = "Aquire chips",
                distance = 1.6,
                onSelect = function(data)
                    local input = lib.inputDialog("Aquire chips", {
                        {type = "number", label = "Amount of chips", description = ("Purchase chips, $%d for each chip"):format(prices.chips), required = true}
                    })
                    if not input or not input[1] then return end
                    TriggerServerEvent("ND_Casino:interactCashier", "buy", input[1])
                end
            },
            {
                name = "nd_casino:chipSell",
                icon = "fa-solid fa-sack-dollar",
                label = "Trade in chips",
                distance = 1.6,
                onSelect = function(data)
                    local input = lib.inputDialog("Trade in chips", {
                        {type = "number", label = "Amount of chips", description = ("Trade in chips, receive $%d for each"):format(prices.chips), required = true}
                    })
                    if not input or not input[1] then return end
                    TriggerServerEvent("ND_Casino:interactCashier", "sell", input[1])
                end
            },
            {
                name = "nd_casino:chipVIP",
                icon = "fa-solid fa-crown",
                label = "Buy VIP membership",
                distance = 1.6,
                canInteract = function()
                    if not IsCasinoVIP then return true end
                end,
                onSelect = function(data)
                    local input = lib.inputDialog("Buy VIP membership", {
                        {
                            type = "select",
                            label = "Membership Duration",
                            description = "Select the duration for your VIP membership",
                            required = true,
                            options = membershipOptions,
                        }
                    })
                    if not input or not input[1] then return end
                    TriggerServerEvent("ND_Casino:interactCashier", "vip", input[1])
                end
            }
        }
    }
}

local createAiPed = require "modules.peds.client"
for i=1, #peds do
    createAiPed(peds[i])
end
