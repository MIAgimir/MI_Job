--[[ Locals ]]--


--[[ General Blip ]]--
local function createWorkBlip()
    workBlip = AddBlipForCoord(
        Config.Workplace.coords.x, 
        Config.Workplace.coords.y,
        Config.Workplace.coords.z)
    SetBlipSprite(workBlip, 90)
    SetBlipColour(workBlip, 5)
    SetBlipScale(workBlip, 0.8)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Air Deliveries')
    EndTextCommandSetBlipName(workBlip)
end

--[[ Resource Management ]]--
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if not FullyLoaded then return end
    Wait(100)
    spawnDelivPed()
    if Config.Workplace.createBlip then createPedBlip() end
end)

AddEventHandler('onResourceStop', function(resource)
    
end)