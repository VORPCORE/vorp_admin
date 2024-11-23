Config = {
    -- Add your language
    DevMode             = false,      -- Leave false

    AlignMenu           = 'top-left', -- align menu

    useAdminCommand     = true,       -- Can open menu with adim command below

    commandAdmin        = "adminMenu",

    -- Language setting - English | Portuguese_PT | Portuguese_BR | French | German | Spanish
    Lang                = "English",

    Key                 = 0x3C3DD371, -- PGDOWN Open Menu

    CanOpenMenuWhenDead = true,       -- If true any staff can open menu when dead, !WARNING! staff can abuse this to get revived

    useQWreports        = true,       -- Disable this if you are not using qw reports

    VorpStable          = true,       -- If you are using vorp_stable then set to true if syn stable set false  when giving worses or wagons it will go directly to databse

    -- Heal
    Heal                = {
        Players = function()
            TriggerEvent("vorpmetabolism:changeValue", "Thirst", 1000)
            TriggerEvent("vorpmetabolism:changeValue", "Hunger", 1000)
            -- TriggerEvent('fred_meta:consume', 100, 100, 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0) -- Fred Metabolism
        end
    },
    ---------------------- NO CLIP ----------------------
    Controls            = {

        goUp = 0xF84FA74F,        -- Q
        goDown = 0x07CE1E61,      -- Z
        turnLeft = 0x7065027D,    -- A
        turnRight = 0xB4E465B4,   -- D
        goForward = 0x8FD015D8,   -- W
        goBackward = 0xD27782E3,  -- S
        changeSpeed = 0x8FFC75D6, -- L-Shift
        camMode = 0x24978A28,     -- H
        Cancel = 0x4AF4D473       -- Delete

    },
    Speeds              = {
        -- You can add or edit existing speeds with relative label
        { label = 'Very Slow', speed = 0 },
        { label = 'Slow',      speed = 0.5 },
        { label = 'Normal',    speed = 2 },
        { label = 'Fast',      speed = 10 },
        { label = 'Very Fast', speed = 15 },
        { label = 'Max',       speed = 29 },
    },
    Offsets             = {
        y = 0.2,                -- Forward and backward movement speed multiplier
        z = 0.1,                -- Upward and downward movement speed multiplier
        h = 1,                  -- Rotation movement speed multiplier
    },
    FrozenPosition      = true, -- Frozen on open menu vorp.staff.OpenMenu

    AllowedGroups       = {
        admin = true,
        -- add more groups here that are allowed to use admin menu, advanced permissions are done in the permissions.cfg folder where you can add certain groups to certain actions
    },
    -----------------------------------------------------
    -- Users scoreboard
    -- Only one can be added
    -- Choose what info should show to all users
    showUsersInfo       = "showAll", -- showAll --showJob --showGroup -- showID
    UseUsersMenu        = true,      -- Leave false if you dont need users menu
    EnablePlayerlist    = true,      -- Enable scroeboard
    AlertCooldown       = 60,        -- Cooldown for request staff to request again (seconds)
    --------------------------------------------------------
    -- WEBHOOKS/LOGS

}
