local table = lib.table
InService = player.inService and 
table.contains(Config.JobGroup, player.inService) 
and player.hasGroup(Config.JobGroup)

local taskLoc = nil
local taskobj = {
    spawned = false,
    obj = nil
}
local currenttask = nil
local isdoingtask = nil
-- Is possible to use NPWD message export for job? https://projecterror.dev/docs/

local function createTaskLocation()
    if taskLoc ~= nil then
        RemoveBlip(taskLoc)
        taskLoc = nil
    end
    taskLoc = AddBlipForCoord(currenttask.totasklocation.x, 
        currenttask.totasklocation.y, 
        currenttask.totasklocation.z)
    SetBlipSprite(taskLoc, 1)
    SetBlipColour(taskLoc, 5)
    SetBlipRoute(taskLoc, true)
    SetBlipRouteColour(taskLoc, 5)
    SetBlipScale(taskLoc, 0.8)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Task One')
    EndTextCommandSetBlipName(taskLoc)
end

RegisterNetEvent('mioxjob:start_taskone', function()
    -- Begin task | recieve text/notification, set route, interact w/ skill check, call complete
    local task1 = Config.TaskOneOps[math.random(1, #Config.TaskOneOps)]
    currenttask = task1

    createTaskLocation()

    local options = {
        {
            name = 'mioxjob:doingtask',
            event = 'mioxjob:client:doingtask',
            icon = 'fa-solid fa-toolbox',
            label = 'Do Task',
            canInteract = function(_, distance)
                return distance < 2.0
            end
        }
    }
    
    local models = { 'prop_dumpster_02b' }
    --local optionsNames = { 'mioxjob:doingtask' }

    exports.ox_target:addModel(models, options) 

end)

RegisterNetEvent('mioxjob:doingtask', function()
    
    if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        
    }) then print('Do stuff when complete') else print('Do stuff when cancelled') end

end)