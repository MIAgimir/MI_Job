-- Local variables
local taskped = {
    spawned = false,
    ped = nil,
}

local pedtasker = {
    spawned = false,
    ped = nil,
}
local pedtaskerloc = nil
local currenttask = nil


-- Job HQ Blip
local blips = {
    {title= Config.job_blip.name,
    colour=Config.job_blip.color,
    id=Config.job_blip.sprite,
    x = Config.job_blip.location.x,
    y = Config.job_blip.location.y,
    scale = Config.job_blip.scale}
		}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipAsShortRange(info.blip, true)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
-- Job HQ Model
local function spawntaskped()
    if taskped.spawned then return end
    local model1 = joaat(Config.job_hq.model)

    lib.requestModel(model1)

    local coords = Config.job_hq.ped_loc
    local ped = CreatePed(0, model1, coords.x, coords.y, coords.z - 1, coords.w, false, false)

    taskped.ped = ped

    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {
        {
            name = 'mioxjob:start_taskone',
            label = 'Request a Delivery Route',
            icon = 'fa-solid fa-plane',
            event = 'mioxjob:start_taskone',
            canInteract = function(_, distance)
                return distance < 2.0 
            end
        }
    }

    exports.ox_target:addLocalEntity(taskped.ped, options)

    taskped.spawned = true
end

-- Task location function
local function createTaskLocation()
    if pedtaskerloc ~= nil then
        RemoveBlip(pedtaskerloc)
        pedtaskerloc = nil
    end
    pedtaskerloc =AddBlipForCoord(
        currenttask.task_loc.x, 
        currenttask.task_loc.y,
        currenttask.task_loc.z)
SetBlipSprite(pedtaskerloc, 1)
SetBlipColour(pedtaskerloc, 5)
SetBlipRoute(pedtaskerloc, true)
SetBlipRouteColour(pedtaskerloc, 5)
SetBlipScale(pedtaskerloc, 0.8)
BeginTextCommandSetBlipName('STRING')
AddTextComponentString('Delivery Dropoff')
EndTextCommandSetBlipName(pedtaskerloc)
end

-- Spawn the tasked ped
local function spawnped_tasker(coords)
    if pedtasker.spawned then return end
    local taskped = Config.dotask1[math.random(1, #Config.dotask1)]
    local currenttaskped = taskped.ped_model
    local model2 = joaat(currenttaskped)
    lib.requestModel(model2)

    local coords = coords
    local ped = CreatePed(0, model2, coords.x, coords.y, coords.z - 1, coords.w, false, false)

    pedtasker.ped = ped

    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {
        {
            name = 'mioxjob:doingtask',
            label = 'Request a Delivery Route',
            icon = 'fa-solid fa-plane',
            event = 'mioxjob:doingtask',
            canInteract = function(_, distance)
                return distance < 2.0 
            end
        }
    }

    exports.ox_target:addLocalEntity(pedtasker.ped, options)

    pedtasker.spawned = true
end

-- Remove the tasked ped
local function removeTask_Ped()
    if not pedtasker.spawned then return end

    exports.ox_target:removeLocalEntity(pedtasker.ped, { 'mioxjob:doingtask' })

    DeleteEntity(pedtasker.ped)
    pedtasker.spawned = false
    pedtasker.ped = nil
end

-- NetE - Start Task
RegisterNetEvent('mioxjob:start_taskone', function()
    local task = Config.dotask1[math.random(1, #Config.dotask1)]
    currenttask = task
    taskcoords = currenttask.ped_loc
    spawnped_tasker(taskcoords)
    createTaskLocation()
end)

-- NetE - Doing Task
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
        RemoveBlip(pedtaskerloc)
        TriggerServerEvent('mioxjob:taskcompleted')
        job_paidnotification()
    end
end)

-- exports --
exports('radial_checkin', function()
  exports.scully_emotemenu:PlayByCommand('sms5')
  Wait(5000)
  lib.notify({
    id = 'work_checkin',
    title = 'MINet: [jobname]',
    description = 'You have checked in for work',
    position = 'top-right',
    style = {
        backgroundColor = '#E5E5E5',
        color = '#000000'
    },
    icon = 'circle-check',
    iconColor = '#1FD537'
    })
  exports.scully_emotemenu:CancelAnimation()
end)

exports('radial_checkout', function()
  exports.scully_emotemenu:PlayByCommand('sms5')
  Wait(5000)
  lib.notify({
    id = 'work_checkout',
    title = 'MINet: [jobname]',
    description = 'You have checked out of work',
    position = 'top-right',
    style = {
        backgroundColor = '#E5E5E5',
        color = '#000000'
    },
    icon = 'circle-xmark',
    iconColor = '#E40010'
    })
  exports.scully_emotemenu:CancelAnimation()
end)

exports('assignment_check', function()
  exports.scully_emotemenu:PlayByCommand('sms5')
  lib.notify({
    id = 'work_checkjob',
    title = 'MINet: [jobname]',
    description = 'Checking for assignments',
    position = 'top-right',
    style = {
        backgroundColor = '#E5E5E5',
        color = '#000000'
    },
    icon = 'signal',
    iconColor = '#FCD112'
    })
  Wait(5000)
  exports.scully_emotemenu:CancelAnimation()
  job_startnotification()
  TriggerEvent('mioxjob:start_taskone')
end)

-- Job start notification --
function job_startnotification()
  exports.npwd:getPhoneNumber()
  exports["npwd"]:createNotification({
      notisId = "npwd:tweetBroadcast",
      appId = "MESSAGES",
      content = "You have a work assignment. Check your map",
      secondaryTitle = "MINet: [jobname]",
      keepOpen = false,
      duration = 7500,
  })
end

-- Job paid notification --
function job_paidnotification()
  exports.npwd:getPhoneNumber()
  exports["npwd"]:createNotification({
      notisId = "npwd:tweetBroadcast",
      appId = "BANK",
      content = "You have been paid for your work",
      secondaryTitle = "MINet: [jobname]",
      keepOpen = false,
      duration = 7500,
  })
end


-- On start --
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Wait(100)
    spawntaskped()
end)

