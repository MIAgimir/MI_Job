local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
chunk()



-- Testing functions : server to client function ! Send source instead Player !
-- not working yet
RegisterServerEvent('mioxjob:taskcompleted')
AddEventHandler('mioxjob:taskcompleted', function()
    local player = Ox.GetPlayer(source)
    print(json.encode(player, { indent = true }))

    exports.pefcl:addBankBalance(source, 
    { amount = 250, message = 'MI_Job Direct Deposit' })
end)


