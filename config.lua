Config = {}
Config.Debug = true

Config.JobGroup = { 'job1' }

Config.job_blip = {
    location = vector2(910.619, -2119.245),
    sprite = 1,
    color = 5,
    scale = 0.8,
    name = 'JOB HQ'
}

Config.job_hq = {
    model = 'mp_s_m_armoured_01',
    ped_loc = vector4(906.439, -2123.929, 31.23, 356.29)
}

Config.dothetask = {
    -- need = location, ped location
    [1] = {
        ['task_loc'] = vector4(954.433, -1964.781, 30.42, 131.045),
        ['ped_loc'] = vector(958.1, -1968.27, 30.3, 61.036)
    }
}