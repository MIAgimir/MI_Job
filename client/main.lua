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
local doingtask = false
local vehNetId = nil
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

end

local function spawnped_tasker()
    if pedtasker.spawned then return end
    local taskped = Config.dotask1[math.random(1, #Config.dotask1)]
    local currenttaskped = taskped.ped_model
    local model2 = joaat(currenttaskped)
    lib.requestModel(model2)

    local taskcoords = Config.dotask1[math.random(1, #Config.dotask1)]
    local currenttaskcoords = taskcoords.ped_loc
    local coords = currenttaskcoords
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

local function removeTask_Ped()

end

RegisterNetEvent('mioxjob:start_taskone', function()
    spawnped_tasker()
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

-- Resource management
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Wait(100)
    spawntaskped()
end)