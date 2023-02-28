Config = {}
Config.Debug = true

Config.JobGroup = { 'job1' }

Config.TaskOneOps = {
    [1] = {
        -- Locations
        totasklocation = vector4(397.815, 64.673, 97.977, 356.114),
        taskobjective = vector3(398.157, 67.518, 97.977),
        -- Model
        taskintobjet = 'v_ind_cm_electricbox',
        taskpayout = math.random(100,300)
    }
    
}