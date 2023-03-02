-- Local variables
local playerload = LocalPlayer.state.isLoggedIn

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


local function createTaskLocation()

end

local function removeTask_Ped()

end

RegisterNetEvent('mioxjob:start_taskone', function()
    createTaskLocation()
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
    if not playerload then return end
    Wait(100)
end)