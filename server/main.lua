local players = {}
local table = lib.table

CreateThread(function()
    for _, player in pairs(Ox.GetPlayers(true, { groups = Config.JobGroup })) do
        local inService = player.get('inService')

        if inService and table.contains(Config.JobGroup, inService) then
            players[player.source] = player
        end
    end
end)

RegisterNetEvent('ox:setPlayerInService', function(group)
    local player = Ox.GetPlayer(source)

    if player then
        if group and table.contains(Config.JobGroup, group) 
        and player.hasGroup(Config.JobGroup) then
            players[source] = player
            return player.set('inService', group, true)
        end

        player.set('inService', false, true)
    end

    players[source] = nil
end)

AddEventHandler('ox:playerLogout', function(source)
    players[source] = nil
end)
