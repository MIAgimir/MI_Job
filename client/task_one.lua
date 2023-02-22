local workPed = {
    spawned = false,
    ped = nil,
}

local doingTaskOne = false

--[[ Task One Job Start ]]--
local function createBossPed(coords)
    local coords = Config.WorkPed.coords
    local ped = CreatePed(0, model, 
    coords.x, coords.y, coords.z - 1, coords.w, false, false)
    workPed.ped = ped
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    local options = {
        {
            name = 'mioxjob:doTaskOne',
            label = 'Task 1',
            icon = 'fa-solid fa-circle-info',
            event = 'mi_ox_job:client:doTaskOne',
            canInteract = function(_, distance)
                return distance < 2.0 and not doingTaskOne or doingTaskTwo
            end
        }
    }
    exports.ox_target:addLocalEntity(workPed.ped, options)

end

--[[ TaskOne Net Event ]]--
RegisterNetEvent('mi_ox_job:client:doTaskOne', function()
    if doingTaskOne then return end
    doingTaskOne = true
end)

--[[ CompletingTaskOne Net Event ]]--
RegisterNetEvent('mi_ox_job:client:doTaskOne', function()

    if lib.progressBar({
        duration = 5000,
        label = 'Completing Task One',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
    }) then
    exports.scully_emotemenu:CancelAnimation()
    doingTaskOne = false
    lib.notify({
        description = 'Task One Completed',
        type = 'success'
    })

    end
end)

--[[ ReturningToWork Net Event ]]--