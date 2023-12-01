local teleports = require "data.teleports"

local function teleportPlayer(coords, withVehicle)
    if withVehicle and cache.vehicle then
        if cache.seat ~= -1 then return end
        BringVehicleToHalt(cache.vehicle, 1.0, 500, false)
        SetTimeout(500, function()
            StopBringVehicleToHalt(cache.vehicle)
        end)
    end

    DoScreenFadeOut(500)
    Wait(500)
    FreezeEntityPosition(cache.ped, true)
    
    lib.hideTextUI()
    StartPlayerTeleport(PlayerId(), coords.x, coords.y, coords.z, coords.w, withVehicle, true, true)
    while IsPlayerTeleportActive() or not HasCollisionLoadedAroundEntity(cache.ped) do Wait(10) end

    FreezeEntityPosition(cache.ped, false)
    Wait(500)
    DoScreenFadeIn(500)
end

local function getDestination(info)
    if type(info) == "string" then
        return teleports[info].location
    end
    return info
end

for name, info in pairs(teleports) do
    if not info.location then goto skip end
    local point = lib.points.new({
        coords = info.location,
        distance = info.distance or 10,
        destination = getDestination(info.destination),
    })

    if info.onEnter then
        function point:onEnter()
            teleportPlayer(self.destination, info.allowVehicle)
        end
        goto skip
    end
    function point:nearby()
        local coords = self.coords
        local range = info.range or 1.2
        if not info.hide then            
            DrawMarker(
                1, -- type
                coords.x, coords.y, coords.z, -- position
                0.0, 0.0, 0.0, -- direction
                0.0, 0.0, 0.0, -- rotation
                range, range, 0.5, -- scale
                0, 15, 255, 150, -- rgba
                false, false, 2, false, nil, nil, false -- bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts
            )
        end
        if self.currentDistance < range then
            if not self.text then
                self.text = true
                lib.showTextUI(info.text)
            end
            if IsControlJustReleased(0, 38) then
                teleportPlayer(self.destination, info.allowVehicle)
            end
        elseif self.text then
            self.text = false
            lib.hideTextUI()
        end
    end
    ::skip::
end
