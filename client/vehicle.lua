local vehNetId = nil
local onCooldown = false


-- Timer Cooldown
local function startCooldown()
    onCooldown = true
    SetTimeout(Config.Cooldown * 60000, function()
        onCooldown = false
    end)
end

RegisterNetEvent('mioxjob:client:spawn_workvehicle', function()
    if onCooldown then
        lib.notify({
            title = 'MI-Job Network',
            description = 'you need to wait until another vehicle is ready',
            type = 'error'
          })
    end
    TriggerServerEvent('mioxjob:server:spawn_workvehcile',
        Config.job_vehicle.model, 
        Config.job_vehicle.type, 
        Config.job_vehicle.spawn)
end)