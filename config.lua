Config = {}
Config.Debug = true

Config.JobGroup = { 'job1' }

Config.Cooldown = 1

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

Config.job_vehicle = {
    model = 'speedo',
    type = 'automobile',
    spawn = vector4(912.867, -2102.854, 30.525, 234.787)
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