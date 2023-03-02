Config = {}
Config.Debug = true

Config.JobGroup = { 'job1' }

Config.job_blip = {
    location = vector2(910.619, -2119.245),
    sprite = 475,
    color = 2,
    scale = 0.8,
    name = 'Job HQ'
}

Config.job_hq = {
    model = 'mp_s_m_armoured_01',
    ped_loc = vector4(906.517, -2123.738, 31.23, 354.87)
}

Config.dotask1 = {
    -- need = location, ped location
    [1] = {
        ped_model = 'mp_s_m_armoured_01',
        task_loc = vector4(912.172, -2124.324, 31.23, 358.096),
        ped_loc = vector(912.172, -2124.324, 31.23, 358.096)
    },
    [2] = {
        ped_model = 'mp_s_m_armoured_01',
        task_loc = vector4(913.679, -2121.773, 31.233, 131.595),
        ped_loc = vector(913.679, -2121.773, 31.233, 131.595)
    }
}

Config.dotask2 = {
    -- need = location, ped location
    [1] = {
        ['task_loc'] = vector4(954.433, -1964.781, 30.42, 131.045),
        ['ped_loc'] = vector(958.1, -1968.27, 30.3, 61.036),
        ['ped_model'] = 'mp_s_m_armoured_01'
    }
}