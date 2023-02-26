## MI_Ox_Job for [Ox_Core](https://github.com/overextended/ox_core) | **Credit to [OverExtended Team](https://github.com/overextended)**
I'm putting this together cause I want to and I'm too tired to describe it right now.  Ox_Core based job template for development use.

## Instructions
* Watch paint dry

### Insert SQL:
``` INSERT INTO `ox_groups` (`name`, `label`, `grades`, `hasAccount`, `adminGrade`, `colour`) VALUES
	('job1', 'Job Name', '["A", "B", "C", "D", "E", "F"]', b'0', 6, NULL); ```

### Insert into Ox_Inventory Data/Items.lua file
``` ['job1_phone'] = { -- idea: Player uses item for job
        label = 'Work Phone',
        weight = 380,
        consume = 0,
        description = "Used for [insert_job]",
        client = {
            anim = { dict = 'paper_1_rcm_alt1-8', clip = 'player_one_dual-8', flag = 49 },
            prop = { model = 'prop_police_phone', -- need badge props repo
            pos = vec3(0.13, 0.023, -0.04), rot = vec3(-90.0, -180.0, 300.0), bone = 28422 },
            disable = { move = false, car = false, combat = false },
            usetime = 5000,
        }
    },
