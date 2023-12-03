function UpdateMemberStatus(src, isMember)
    TriggerClientEvent("ND_Casino:updateMembershipStatus", src, isMember)
end

function IsCasinoMember(src)
    local expires = Bridge.getMembership(src)
    if not expires then return end
    return expires-os.time() > 0
end

SetTimeout(500, function()
    Bridge.updateAllPlayers()
end)

exports("isMember", IsCasinoMember)
