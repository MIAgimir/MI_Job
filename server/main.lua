local players = {}
local workvehicles = {}
local ox_inventory = exports.ox_inventory
local table = lib.table

local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
chunk()

--[[ -- reference for getting thing
    local player = Ox.GetPlayer(source)
    local name = player.name
    print("fuck you "..name)
]]

--[[
Vehicle Spawn method
    if main_goal = blow_up then 
        act_like_you_don't_know_nobody 
        print('make_noises')
    end
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

RegisterServerEvent('mioxjob:checkservice')
AddEventHandler('mioxjob:checkservice', function(job)
    local player = source
    player.hasGroup()
end)

lib.callback.register('mioxjob:checkservice', function(source, target)
    return players[target or source]
end)

-- Testing functions : server to client function ! Send source instead Player !
-- not working yet
RegisterServerEvent('mioxjob:taskcompleted')
AddEventHandler('mioxjob:taskcompleted', function()
    local player = Ox.GetPlayer(source)
    print(json.encode(player, { indent = true }))
    exports.pefcl:addBankBalance(player, { amount = 250, message = 'MI_Job Direct Deposit' })
end)


function setplayerservice()
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
end