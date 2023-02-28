local players = {}
local ox_inventory = exports.ox_inventory
local table = lib.table

--[[ -- reference for getting thing
    local player = Ox.GetPlayer(source)
    local name = player.name
    print("fuck you "..name)
]]

--[[ Player Service Actions ]]--
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

--[[ -- reference for getting groups
    local group = player.get('inService')
    local grade = player.getGroup(group)
    local paycheck = 0

    local payment = Config.Paychecks?[group]?[grade]
    if payment then paycheck += payment end
]]

RegisterServerEvent('mioxjob:checkservice')
AddEventHandler('mioxjob:checkservice', function(job)
    local player = source
    player.hasGroup()
end)

lib.callback.register('mioxjob:checkservice', function(source, target)
    return players[target or source]
end)

-- Testing functions : server to client function
RegisterServerEvent('mioxjob:taskcompleted')
AddEventHandler('mioxjob:taskcompleted', function(taskpayout)
    local Player = exports.pefcl:getAccountsByIdentifier(Player, -1)
    exports.pefcl:addBankBalance(Player, { amount = 250, message = 'MI_Job Direct Deposit' })
end)