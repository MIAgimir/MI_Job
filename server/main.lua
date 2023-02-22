local jobVehicles = {}

RegisterNetEvent('mi_ox_job:server:taskOneFail', function()
    local src = source

end)

RegisterNetEvent('mi_ox_job:server:taskOneComplete', function()
    local src = source
    

    Player.Functions.AddMoney('bank', payout, "job-complete")
end)

RegisterNetEvent('mi_ox_job:server:spawnVehicle', function(model, coords, vehicleType)
    local model = model
    local vehicleType = vehicleType
    local coords = coords
    local hash = joaat(model)
    local src = source
    local vehicle = CreateVehicleServerSetter(hash, vehicleType, 
    coords.x, coords.y, coords.z, coords.w)
    local check = 0

    while not DoesEntityExist(vehicle) do
        if checks == 10 then break end
        wait(25)
        checks += 1

        if DoesEntityExist(vehicle) then
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
                Entity(vehicle).state.jobVehicle = true
                jobVehicles[#jobVehicles+1] = {
                    netId = netId,
                    owner = src,
                }
        end
    end
    
end)