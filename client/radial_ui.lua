-- Find method to ensure radial menu is 
-- only usable with the assigned job in the script
-- (if group ~= 'job1', return nil)
-- (if group == 'job1', allow menu to open)
exports('myMenuHandler', function(menu, item)
    print(menu, item)

    if menu == 'police_menu' and item == 1 then
        print('Handcuffs')
    end
end)

-- https://fontawesome.com/search?o=r&new=yes&s=thin
-- Use above link to change icons

lib.addRadialItem({
  {
    id = 'job_work',
    label = 'Assignments',
    icon = 'list-check',
    onSelect = function()
      assignment_check()
    end
  },
  {
    id = 'job_vehicle',
    label = 'Req. Vehicle',
    icon = 'car',
    onSelect = function()
      request_vehicle()
    end
  },
  {
    id = 'job_service',
    label = 'Job Service',
    icon = 'business-time',
    menu = 'service_menu'
  },
  {
    id = 'job_alert',
    label = 'Request Help',
    icon = 'phone-volume',
    menu = 'alert_menu'
  }
})

-- Service to check in / out
lib.registerRadial({
  id = 'service_menu',
  items = {
    {
      label = 'Check Out',
      icon = 'xmark',
      onSelect = function()
        print('Checked out of service')
        radial_checkout()
      end
    },
    {
      label = 'Check In',
      icon = 'check',
      onSelect = function()
        print('Checked into service')
        radial_checkin()
      end
    }
    
  }
})

-- Silent Alert Sytem
lib.registerRadial({
  id = 'alert_menu',
  items = {
    {
      label = 'Police',
      icon = 'handcuffs',
      onSelect = function()
        print('Silent alert sent to Law Enforcement')
        lib.notify({
          title = 'MI-Job Network',
          description = 'Silent Alert sent to local Law Enforcement',
          type = 'inform'
        })
        -- function()
      end
    },
    {
      label = 'Medical',
      icon = 'briefcase-medical',
      onSelect = function()
        print('Silent alert sent to Emerg. Medical Services')
        lib.notify({
          title = 'MI-Job Network',
          description = 'Silent Alert sent to local General Hospital',
          type = 'inform'
        })
        -- function()
      end
    },
    {
      label = 'Rescue',
      icon = 'fire-extinguisher',
      onSelect = function()
        print('Silent alert sent to Emerg. Rescue Services')
        lib.notify({
          title = 'MI-Job Network',
          description = 'Silent Alert sent to local Fire Department',
          type = 'inform'
        })
        -- function()
      end
    }
    
  }
})

-- Functions
-- check into work
function radial_checkin()
  exports.scully_emotemenu:PlayByCommand('sms5')
  Wait(5000)
  lib.notify({
    title = 'MI-Job Network',
    description = 'you have checked into work',
    type = 'success'
  })
  exports.scully_emotemenu:CancelAnimation()
  TriggerServerEvent('ox:setPlayerInService', InService)
end

-- check out of work
function radial_checkout()
  exports.scully_emotemenu:PlayByCommand('sms5')
  Wait(5000)
  lib.notify({
    title = 'MI-Job Network',
    description = 'you have checked out from work',
    type = 'error'
  })
  exports.scully_emotemenu:CancelAnimation()
  TriggerServerEvent('ox:setPlayerInService', InService)
end


-- request work assignment
function assignment_check()
  exports.scully_emotemenu:PlayByCommand('sms5')
  lib.notify({
    title = 'MI-Job Network',
    description = 'checking avaliable assignments',
    type = 'inform'
  })
  Wait(5000)
  exports.scully_emotemenu:CancelAnimation()
  job_startnotification()
  TriggerEvent('mioxjob:start_taskone')
  TriggerServerEvent('mioxjob:taskcompleted') -- tested for server to client event
  --job_paidnotification()
end

-- request work vehicle
function request_vehicle()
  exports.scully_emotemenu:PlayByCommand('sms5')
  Wait(5000)
  lib.notify({
    title = 'MI-Job Network',
    description = 'your work vehicle has arrived',
    type = 'inform'
  })
  exports.scully_emotemenu:CancelAnimation()
end

-- Job start notification (no text)
function job_startnotification()
  exports.npwd:getPhoneNumber()
  exports["npwd"]:createNotification({
      notisId = "npwd:tweetBroadcast",
      appId = "MESSAGES",
      content = "You have a work assignment. Check your map",
      secondaryTitle = "MI_Job Network",
      keepOpen = false,
      duration = 7500,
  })
end

-- Job paid notification (no text)
function job_paidnotification()
  exports.npwd:getPhoneNumber()
  exports["npwd"]:createNotification({
      notisId = "npwd:tweetBroadcast",
      appId = "BANK",
      content = "You have been paid for your work",
      secondaryTitle = "MI_Job Network",
      keepOpen = false,
      duration = 7500,
  })
end