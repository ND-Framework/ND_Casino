local bridgeResources = {
    ["ND_Core"] = "nd",
    ["es_extended"] = "esx",
    ["qb-core"] = "qb"
}

local function getBridge()
    for resource, framework in pairs(bridgeResources) do
        if GetResourceState(resource):find("start") then
            return ("modules.bridge.%s.%s"):format(framework, lib.context)
        end
    end
    return ("modules.bridge.standalone.%s"):format(lib.context)
end

Bridge = require(getBridge())
