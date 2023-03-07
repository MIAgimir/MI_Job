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

-- Testing functions : server to client function ! Send source instead Player !
-- not working yet
RegisterServerEvent('mioxjob:taskcompleted')
AddEventHandler('mioxjob:taskcompleted', function()

    local player = Ox.GetPlayer(source)
    print(json.encode(player, { indent = true }))

    
    exports.pefcl:addBankBalance(player, { amount = 250, message = 'MI_Job Direct Deposit' })

end)

--[[
Vehicle Spawn method
    if main_goal = blow_up then 
        act_like_you_don't_know_nobody 
        print('make_noises')
    end
]]
RegisterNetEvent('mioxjob:server:spawn_workvehcile', function(model, coords, vehicletype)
    local model = model
    local vehicletype = vehicletype
    local coords = coords
    local hash = joaat(model)
    local src = source

    local vehset = CreateVehicleServerSetter(hash, vehicletype, coords.x, coords.y, coords.z, coords.w)
    local checks = 0

    while not DoesEntityExist(vehset) do
        if checks == 10 then break end
        Wait(50)
        checks += 1
    end

    if DoesEntityExist(vehset) then
        local netId = NetworkGetNetworkIdFromEntity(vehset)

            Entity(vehset).state.workvehicles = true

            workvehicles[#workvehicles+1] = {
                netId = netId,
                owner = src,
            }
    end
end)