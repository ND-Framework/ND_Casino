local entities = {}

local function createProp(info)
    local coords = info.location
    local model = info.model
    lib.requestModel(model)
    local entity = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
    FreezeEntityPosition(entity, true)
    SetEntityHeading(entity, coords.w)
    entities[#entities+1] = entity
end

AddEventHandler("onResourceStop", function(resourceName)
    if cache.resource ~= resourceName then return end
    for i=1, #entities do
        local entity = entities[i]
        if entity and DoesEntityExist(entity) then
            DeleteEntity(entity)
        end
    end
end)

return createProp
