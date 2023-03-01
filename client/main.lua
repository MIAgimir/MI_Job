local table = lib.table
InService = player.inService and 
table.contains(Config.JobGroup, player.inService) 
and player.hasGroup(Config.JobGroup)

local taskLoc = nil
local taskped = {
    spawned = false,
    ped = nil
}
local currenttask = nil
local isdoingtask = nil

local task1 = Config.TaskOneOps[math.random(1, #Config.TaskOneOps)].totasklocation
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
    SetBlipColour(taskLoc, 27)
    SetBlipRoute(taskLoc, true)
    SetBlipRouteColour(taskLoc, 27)
    SetBlipScale(taskLoc, 0.8)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Task One')
    EndTextCommandSetBlipName(taskLoc)
end

local function createTask_Ped()
    local model = joaat('a_f_m_beach_01')
    lib.requestModel(model)

    currenttask = task1

    local ped = CreatePed(0, model, currenttask.x, 
        currenttask.y, currenttask.z-1, currenttask.w, false, false)

    taskped.ped = ped

    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {
        {
            name = 'mioxjob:doingtask',
            event = 'mioxjob:doingtask',
            icon = 'fa-solid fa-toolbox',
            label = 'Do Task',
            canInteract = function(_, distance)
                return distance < 2.0
            end
        }
    }
    exports.ox_target:addLocalEntity(taskped.ped, options)
    taskped.spawned = true
end

local function removeTask_Ped()
    exports.ox_target:removeLocalEntity(taskped.ped, { 'mioxjob:doingtask' })
    DeleteEntity(taskped.ped)
    taskped.spawned = false
    taskped.ped = nil
end

RegisterNetEvent('mioxjob:start_taskone', function()
    local task1 = Config.TaskOneOps[math.random(1, #Config.TaskOneOps)]
    currenttask = task1

    createTaskLocation()
    createTask_Ped()

end)

RegisterNetEvent('mioxjob:doingtask', function()
    
    exports.scully_emotemenu:PlayByCommand('sms5')
    if lib.progressCircle({
        duration = 2000,
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
    }) 
    then 
        removeTask_Ped()
        exports.scully_emotemenu:CancelAnimation()
        RemoveBlip(taskLoc)
        TriggerServerEvent('mioxjob:taskcompleted')
        job_paidnotification()
    end
end)