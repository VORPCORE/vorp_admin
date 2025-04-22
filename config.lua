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

    useQWreports        = true,       -- Disable this if you are not using qw reports, its a script ask in vorp discord

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
        y = 0.2, -- Forward and backward movement speed multiplier
        z = 0.1, -- Upward and downward movement speed multiplier
        h = 1,   -- Rotation movement speed multiplier
    },

    -----------------------------------------------------
    -- Users scoreboard
    -- Only one can be added
    -- Choose what info should show to all users
    showUsersInfo       = "showAll", -- showAll --showJob --showGroup -- showID
    UseUsersMenu        = false,     -- Leave false if you dont need users menu
    EnablePlayerlist    = true,      -- Enable scroeboard
    AlertCooldown       = 60,        -- Cooldown for request staff to request again (seconds)
    --------------------------------------------------------

}

-- if both are true it will give admin to both character and user group
-- todo: add option in menu to choose
Config.giveCharacterGroup = false -- if true when giving group to player it will give to character group

Config.giveUserGroup = true       -- if true when giving group to player it will give to user group

-- all actions based on groups use this table so you dont need to duplicate code
--[[
-- ALL EXISTING ACTIONS
tp_to_player
tp_player_back
bring_player
send_player_back
freeze_player
kick_player
ban_player
unban_player
ban_offline
respawn_player
give_item
give_horse
give_wagon
give_weapon
give_moneygold
clear_inventory
check_player_inventory
clear_currency
set_group
set_job
whitelist_player
revive_player
heal_player
get_coords
delete_horse
delete_wagon
delete_wagons_radius
allow_announce
godmode
infinite_ammo
noclip
spawn_horse
spawn_wagon
golden_cores
spectate
selfheal
selfrevive
tp_to_waypoint
tp_to_coords

troll_kill_player
troll_invisible
troll_lightning_strike
troll_set_player_on_fire
troll_tp_to_heaven
troll_ragdoll_player
troll_drain_player_stam
troll_handcuff_player
troll_temp_high_player

--MENU ACTIONS
open_menu
admin_actions_menu
offline_actions_menu
players_list_menu
view_reports_menu
open_database_menu
give_items_menu
remove_items_menu
simple_actions_menu
advanced_actions_menu
troll_actions_menu
players_list_submenu
admin_menu
boosters_menu
teleport_menu
database_menu
devtools_menu
 ]]

local actions <const> = {
    high = {
        all = true, -- allow all actions
    },

    medium = {
        --ADMIN ACTIONS
        tp_to_player = true,           -- allow to teleport to player
        tp_player_back = true,         -- allow to teleport player back
        bring_player = true,           -- allow to bring player to you
        send_player_back = true,       -- allow to send player back after teleported to you
        freeze_player = true,          -- allow to freeze player
        kick_player = true,            -- allow to kick player
        ban_player = true,             -- allow to ban player
        unban_player = true,           -- allow to use unban player
        ban_offline = true,            -- allow to use ban offline
        respawn_player = true,         -- allow to respawn player
        give_item = true,              -- allow to give item to player
        give_horse = true,             -- allow to give horse to player
        give_wagon = true,             -- allow to give wagon to player
        give_weapon = true,            -- allow to give weapon to player
        give_moneygold = true,         -- allow to give gold or money to player
        clear_inventory = true,        -- allow to clear inventory of player
        check_player_inventory = true, -- allow to check player inventory
        clear_currency = true,         -- allow to clear currency of player
        set_group = true,              -- allow to set group to player
        set_job = true,                -- allow to set job to player
        whitelist_player = true,       -- allow to whitelist player
        revive_player = true,          -- allow to revive player
        heal_player = true,            -- allow to heal player
        get_coords = true,             -- allow to use get coords
        delete_horse = true,           -- allow to use delete horse
        delete_wagon = true,           -- allow to use delete wagon
        delete_wagons_radius = true,   -- allow to use delete wagons radius
        allow_announce = true,         -- allow to use announce
        godmode = true,                -- allow to use godmode
        infinite_ammo = true,          -- allow to use infinite ammo
        noclip = true,                 -- allow to use noclip
        invisibility = true,           -- allow to use invisibility
        spawn_horse = true,            -- allow to use spawn horse
        spawn_wagon = true,            -- allow to use spawn wagon
        golden_cores = true,           -- allow to use golden cores
        spectate = true,               -- allow to use spectate
        selfheal = true,               -- allow to use self heal
        selfrevive = true,             -- allow to use self revive
        tp_to_waypoint = true,         -- allow to use tp to waypoint
        tp_to_coords = true,           -- allow to use tp to coords

        -- troll menu actions
        troll_kill_player = true,        -- allow to use troll kill player
        troll_invisible = true,          -- allow to use troll invisible
        troll_lightning_strike = true,   -- allow to use troll lightning strike
        troll_set_player_on_fire = true, -- allow to use troll set player on fire
        troll_tp_to_heaven = true,       -- allow to use troll tp to heaven
        troll_ragdoll_player = true,     -- allow to use troll ragdoll player
        troll_drain_player_stam = true,  -- allow to use troll drain player stam
        troll_handcuff_player = true,    -- allow to use troll handcuff player
        troll_temp_high_player = true,   -- allow to use troll temp high player


        --MENU ACTIONS
        -- those with these permissions are able to open this menu
        open_menu = true,             -- allow to use open menu
        admin_menu = true,            -- allow to use admin menu
        boosters_menu = true,         -- allow to use boosters menu
        teleport_menu = true,         -- allow to use teleport menu
        database_menu = true,         -- allow to use database menu
        devtools_menu = true,         -- allow to use devtools menu
        admin_actions_menu = true,    -- allow to use admin actions menu
        offline_actions_menu = true,  -- allow to use offline actions menu
        players_list_menu = true,     -- allow to use players list menu
        view_reports_menu = true,     -- allow to use view reports menu
        open_database_menu = true,    -- allow to use open database menu
        give_items_menu = true,       -- allow to use give items menu
        remove_items_menu = true,     -- allow to use remove items menu
        simple_actions_menu = true,   -- allow to use simple actions menu
        advanced_actions_menu = true, -- allow to use advanced actions menu
        troll_actions_menu = true,    -- allow to use troll actions menu
        players_list_submenu = true,  -- allow to use players list submenu

    },
    -- create more here

}

Config.AllowedActions = {

    admin = {
        actions = actions.high,
    },
    moderator = {
        actions = actions.medium,
    },
    -- create more here
}
