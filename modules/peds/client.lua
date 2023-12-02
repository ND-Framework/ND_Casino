local ox_target = exports.ox_target
local locations = {}

local clothingComponents = {
    face = 0,
    mask = 1,
    hair = 2,
    torso = 3,
    leg = 4,
    bag = 5,
    shoes = 6,
    accessory = 7,
    undershirt = 8,
    kevlar = 9,
    badge = 10,
    torso2 = 11
}
local clothingProps = {
    hat = 0,
    glasses = 1,
    ears = 2,
    watch = 6,
    bracelets = 7
}

local function configPed(ped)
    SetPedCanBeTargetted(ped, false)
    SetEntityCanBeDamaged(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetPedResetFlag(ped, 249, true)
    SetPedConfigFlag(ped, 185, true)
    SetPedConfigFlag(ped, 108, true)
    SetPedConfigFlag(ped, 208, true)
    SetPedCanRagdoll(ped, false)
end

local function setClothing(ped, clothing)
    if not clothing then return end
    for component, clothingInfo in pairs(clothing) do
        if clothingComponents[component] then
            SetPedComponentVariation(ped, clothingComponents[component], clothingInfo.drawable, clothingInfo.texture, 0)
        elseif clothingProps[component] then
            SetPedPropIndex(ped, clothingProps[component], clothingInfo.drawable, clothingInfo.texture, true)
        end
    end
end

local function getCloesestAttachObject(coords, radius, object)
    return lib.waitFor(function()
        local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, radius or 1.5, object, false, false, false)
        if obj and DoesEntityExist(obj) then
            return obj
        end
    end)
end

local function createAiPed(info)
    local ped
    local model = type(info.model) == "string" and GetHashKey(info.model) or info.model
    local blipInfo = info.blip
    local anim = info.anim
    local attach = info.attachToObject
    local clothing = info.clothing
    local coords = info.coords
    local options = info.options
    local point = lib.points.new({
        coords = vec3(coords.x, coords.y, coords.z),
        distance = info.distance or 25.0
    })
    
    local id = #locations+1
    locations[id] = {
        point = point,
        options = info.options
    }

    function point:onEnter()
        local found, ground = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
        lib.requestModel(model)
        ped = CreatePed(4, model, coords.x, coords.y, found and ground or coords.z, coords.w or coords.h or info.heading, false, false)

        local time = GetCloudTimeAsInt()
        while not DoesEntityExist(ped) and GetCloudTimeAsInt()-time < 5 do
            Wait(100)
        end

        configPed(ped)
        setClothing(ped, clothing)
        locations[id].ped = ped

        if anim and anim.dict and anim.clip then
            lib.requestAnimDict(anim.dict)
            TaskPlayAnim(ped, anim.dict, anim.clip, 2.0, 8.0, -1, 1, 0, 0, 0, 0)
        end

        if attach then
            local object = getCloesestAttachObject(coords, attach.radius, attach.object)
            if object then
                AttachEntityToEntity(ped, object, -1, attach.pos.x, attach.pos.y, attach.pos.z, attach.rot.x, attach.rot.y, attach.rot.z, false, false, true, true, 2, true)
            end
        end

        if options then
            Wait(500)
            local targetInfo = info.target
            if targetInfo and targetInfo.type == "addBoxZone" then
                local targetCorods = GetOffsetFromEntityInWorldCoords(ped, targetInfo.offset.x, targetInfo.offset.y, targetInfo.offset.z)
                ox_target:addBoxZone({
                    coords = targetCorods,
                    radius = 2.5,
                    drawSprite = true,
                    options = options
                })
            else
                ox_target:addLocalEntity({ped}, options)
            end
        end

        if blipInfo then
            local blip = AddBlipForEntity(ped)
            SetBlipSprite(blip, blipInfo.sprite or 280)
            SetBlipScale(blip, blipInfo.scale or 0.8)
            SetBlipColour(blip, blipInfo.color or 3)
            SetBlipAsShortRange(blip, true)
            if blipInfo.label then                
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipInfo.label)
                EndTextCommandSetBlipName(blip)
            end
        end
    end

    function point:onExit()
        if ped and DoesEntityExist(ped) then
            if options then
                local targetInfo = info.target
                if not targetInfo or targetInfo.type ~= "addBoxZone" then
                    ox_target:removeLocalEntity({ped})
                end
            end
            Wait(500)
            DeleteEntity(ped)
        end
    end
end

local function removeAiPed(id)
    local info = locations[id]
    if not info then return end

    local ped = info.ped
    info.point:remove()
    locations[id] = nil

    if ped and DoesEntityExist(ped) then
        if info.options then
            ox_target:removeLocalEntity({ped})
        end
        DeleteEntity(ped)
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    if cache.resource ~= resourceName then return end
    for i, _ in ipairs(locations) do
        removeAiPed(i)
    end
end)

-- RegisterCommand("get-clothing", function(source, args, rawCommand)
--     local info = ""
--     for k, v in pairs(clothingComponents) do
--         info = ("%s\n%s = {drawable = %s, texture = %s},"):format(info, k, GetPedDrawableVariation(cache.ped, v), GetPedTextureVariation(cache.ped, v))
--     end
--     for k, v in pairs(clothingProps) do
--         info = ("%s\n%s = {drawable = %s, texture = %s},"):format(info, k, GetPedPropIndex(cache.ped, v), GetPedPropTextureIndex(cache.ped, v))
--     end
--     lib.setClipboard(info)
-- end, false)

return createAiPed
