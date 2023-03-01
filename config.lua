Config = {}
Config.Debug = true

Config.JobGroup = { 'job1' }

Config.TaskOneOps = {
    [1] = {
        -- Locations
        totasklocation = vector4(397.815, 64.673, 97.977, 356.114),
        taskobjective = vector3(398.157, 67.518, 97.977),
        -- Model
        taskped = 'a_f_m_beach_01',
        taskpayout = math.random(100,300)
    }
    
}