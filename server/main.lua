local jobVehicles = {}

RegisterNetEvent('mi_ox_job:server:taskOneFail', function()
    local src = source

end)

RegisterNetEvent('mi_ox_job:server:taskOneComplete', function()
    local src = source
    

    Player.Functions.AddMoney('bank', payout, "job-complete")
end)

RegisterNetEvent('mi_ox_job:server:spawnVehicle', function(model, coords, vehicleType)
    local src = source
    
end)