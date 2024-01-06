Translation = {}

Translation.Langs = {
  English = {
    Menus = {
      DefaultsMenusTitle = {
        menuTitle            = "VORP ADMIN",
        menuSubTitle         = "Main Menu",
        menuSubTitleAdmin    = "Player Manegement",
        menuSubTitlePlayer   = "Players Online",
        menuSubTitleBooster  = "Boosters",
        menuSubTitleDatabase = "Database"
      },
      DefaultsInputs = {
        confirm = "Confirm",
      },
      MainMenuOptions = {
        administration      = "Administration",
        administration_desc = "Provides access to administrative functions and tools.",
        booster             = "Boosters",
        booster_desc        = "Accesses options related to admin boosters.",
        database            = "Database",
        database_desc       = "Allows access to database-related actions and features.",
        teleport            = "Teleports",
        teleport_desc       = "Provides teleportation options and functionalities.",
        devTools            = "Dev Tools",
        devTools_desc       = "Grants access to developer tools and features.",
      },
      MainAdminOptions = {
        playersList = "List of Players",
        playersList_desc = "Access a list of players currently online.",
        adminActions = "Admin Actions",
        adminActions_desc = "Access the menu for administrative actions.",
        offLineActions = "Offline Actions",
        offLineActions_desc = "Access actions that can be performed on players who are currently offline.",
        viewReports = "View Reports",
        viewReports_desc = "View in-game reports of players",
        searchPlayer = "Search Player",
        searchPlayer_desc = " Insert a server ID to find information about a specific player.",
        MenuAdminInput = {
          title = "SEARCH PLAYER",
          placeholder = "Server ID",
          errorMsg = "min 10 max 100 chars dont use dot or commas"
        }
      },
      MainPlayerStatus = {
        playerSteamName  = "Steam Name:",
        playerServerID   = "Server ID:",
        playerName       = "Player Name:",
        playerGroup      = "Player Group:",
        playerJob        = "Player Job:",
        playerGrade      = "Player Grade:",
        playerIdentifier = "Player Identifier:",
        playerMoney      = "Player Money:",
        playerGold       = "Player Gold:",
        playerStaticID   = "Player Static ID:",
        playerWhitelist  = "Player Whitelist:",
        playerWarnings   = "Player Warnings:",
      },
      SubAdminOptions = {
        simpleActions = "Simple Actions",
        simpleActions_desc = "Opens a menu for simple administrative actions.",
        advancedActions = "Advanced Actions",
        advancedActions_desc = "Provides access to advanced administrative actions and features.",
        trollActions = "Troll Actions",
        trollActions_desc = "Grants access to troll-related administrative actions.",
      },
      SubActionsAdminOptions = {
        deleteMountHorse = "Delete Mounted Horse",
        deleteMountHorse_desc = "Performs an action to delete a mounted horse.",
        deleteMountWagon = "Delete Mounted Wagon",
        deleteMountWagon_desc = "Initiates an action to delete a mounted wagon.",
        deleteWagonInRadius = "Delete Wagons in Radius",
        deleteWagonInRadius_desc = "Executes an action to delete wagons within a specified radius.",
        getCoords = "Get Player Coordinates",
        getCoords_desc = "Retrieves a player's current coordinates as an action.",
        adminAnnounce = "Admin Announcement",
        adminAnnounce_desc = "Makes an administrative announcement as an action.",
        DelWagonRadiusInput = {
          title = "DEL WAGON",
          placeholder = "Insert number",
          errorMsg = "numbers only max allowed is 2",
        },
        AnnounceInput = {
          title = "ANNOUNCE",
          placeholder = "Insert text",
          errorMsg = "only letters and numbers, no dots no commas etc",
        },
      },
      SubCoordsMenu = {
        getCoordsXYZ = "Copy XYZ Coordinates",
        getCoordsXYZ_desc = "Copy the XYZ coordinates of your current position.",
        getCoordsVec3 = "Copy Vector3 Coordinates",
        getCoordsVec3_desc = "Copy the Vector3 coordinates of your current position.",
        getCoordsVec4 = "Copy Vector4 Coordinates",
        getCoordsVec4_desc = "Copy the Vector4 coordinates of your current position including heading.",
        getHeading = "Copy Heading",
        getHeading_desc = "Copy the heading (direction) of your current position.",
      },
      SubTrollOptions = {
        killPlayer = "Kill Player",
        killPlayer_desc = "Initiates an action to kill a specific player.",
        invisPlayer = "Make Player Invisible",
        invisPlayer_desc = "Triggers an action to make a player invisible.",
        lightningStrikePlayer = "Lightning Strike Player",
        lightningStrikePlayer_desc = "Executes an action to strike a player with lightning.",
        setPlayerOnFire = "Set Player On Fire",
        setPlayerOnFire_desc = "Takes an action to set a player on fire.",
        teleportToHeaven = "Teleport Player To Heaven",
        teleportToHeaven_desc = "Teleports a player to heaven as an action.",
        ragdollPlayer = "Ragdoll Player",
        ragdollPlayer_desc = "Performs an action to ragdoll a player.",
        drainPlayerStam = "Drain Player Stamina",
        drainPlayerStam_desc = "Drains a player's stamina as an action.",
        cuffPlayer = "Handcuff Player",
        cuffPlayer_desc = "Handcuffs a player as an action.",
        tempHighPlayer = "Temp High",
        tempHighPlayer_desc = "Temporarily increases a player's stats as an action.",
      },
      SubOfflineOptions = {
        banOrUnban = "BAN/UNBAN",
        banOrUnban_desc =
        "Type = ban/unban <br> StaticID = ID Fixed in DB <br> Time example 1h,1d,1w,1m,1y permaban put 0 <br> DONT USE TIME IF TYPE IS UNBAN",
        whiteOrUnwhite = "WHITE/UNWHITE",
        whiteOrUnwhite_desc = "Type = whitelist/unwhitelist <br> StaticID = ID Fixed in DB",
        warnOrUnWarn = "WARN/UNWARN",
        warnOrUnWarn_desc = "Give a SHORT reason!",
        BanTypeInput = {
          title = "BAN PLAYER",
          placeholder = "Ex: ban 6 1d",
          errorMsg = "min 1 max 20, dont use dot, commas etc"
        },
        WhiteTypeInput = {
          title = "WHITE PLAYER",
          placeholder = "Ex: whitelist 6",
          errorMsg = "min 1 max 20, dont use dot, commas etc"
        },
        WarnTypeInput = {
          title = "WARN PLAYER",
          placeholder = "Ex: warn 6",
          errorMsg = "min 1 max 20, dont use dot, commas etc"
        }
      },
      SubSimpleActionOptions = {
        playerSpectate = "Spectate Player",
        playerSpectate_desc = "Spectate the selected player.",
        playerFreeze = "Freeze Player",
        playerFreeze_desc = "Freeze or unfreeze the selected player.",
        playerRevive = "Revive Player",
        playerRevive_desc = "Revive the selected player.",
        playerHeal = "Heal Player",
        playerHeal_desc = "Heal the selected player.",
        playerGoTo = "Go To Player",
        playerGoTo_desc = "Teleport to the location of the selected player.",
        playerGoBack = "Go Back",
        playerGoBack_desc = "Teleport back to your previous location.",
        playerBring = "Bring Player",
        playerBring_desc = "Teleport the selected player to your location.",
        playerSendBack = "Send Back",
        playerSendBack_desc = "Send the selected player back to their previous location.",
        playerWarn = "Warn Player",
        playerWarn_desc = "Warn the selected player with a reason.",
        playerUnWarn = "Unwarn Player",
        playerUnWarn_desc = "Remove a warning from the selected player.",
        WarnInput = {
          title = "WARN PLAYER",
          placeholder = "Reason of Warn",
          errorMsg = "min 10 max 100 chars dont use dot or commas"
        }
      },
      SubAdvancedActionOptions = {
        playerKick = "Kick the player.",
        playerKick_desc = "Kicks the selected player from the server.",
        playerBan = "Ban the player.",
        playerBan_desc = "Permanently bans the selected player from the server.",
        playerUnBan = "Unban the player.",
        playerUnBan_desc = "Removes the ban from the selected player.",
        playerRespawn = "Respawn the player.",
        playerRespawn_desc = "Brings the selected player back to life and respawns them.",
        playerWhitelist = "Whitelist the player.",
        playerWhitelist_desc = "Adds the selected player to the server's whitelist.",
        playerUnWhitelist = "Remove player from whitelist.",
        playerUnWhitelist_desc = "Removes the selected player from the server's whitelist.",
        playerSetJob = "Set player's job.",
        playerSetJob_desc = "Assigns a new job to the selected player.",
        playerSetGroup = "Set player's group.",
        playerSetGroup_desc = "Assigns a new group to the selected player.",
        KickInput = {
          title = "KICK PLAYER",
          placeholder = "Reason of Kick",
          errorMsg = "min 10 max 100 chars dont use dot or commas"
        },
        BanInput = {
          title = "BAN PLAYER",
          placeholder = "Ex: 1d is 1 day",
          errorMsg = "min 2 max 2 chars dont use dot or commas"
        },
        GroupInput = {
          title = "SET GROUP",
          placeholder = "Ex: admin",
          errorMsg = "min 3 max 20, only letters"
        },
        JobInput = {
          title = "SET JOB",
          placeholder = "Ex: police 1 Sheriff",
          errorMsg = "min 3 max 20 no symbols"
        },
      },
      MainBoostOptions = {
        selfGodMode              = "Activate God Mode",
        selfGodMode_desc         = "Become invulnerable to damage",
        selfNoClip               = "Enable NoClip",
        selfNoClip_desc          = "Pass through objects and terrain",
        move                     = "W/A/S/D/Q/Z- MOVE",
        speedMode                = "LShift to Change speed",
        cammode                  = "H-Relative mode",
        selfGoldCores            = "Gold Cores self-buff",
        selfGoldCores_desc       = "Boost your stats with Gold Cores",
        enabledInfinityAmmo      = "Enable Infinite Ammo",
        enabledInfinityAmmo_desc = "Never run out of ammunition",
        spawnWagon               = "Spawn a Wagon",
        spawnWagon_desc          = "Summon a wagon to your location",
        spawnHorse               = "Spawn a Horse",
        spawnHorse_desc          = "Call a horse to ride",
        selfHeal                 = "Heal yourself",
        selfHeal_desc            = "Restore your health and vitality",
        selfRevive               = "Self-Revive",
        selfRevive_desc          = "Resurrect yourself when downed",
        selfInvisible            = "Turn yourself Invisible",
        selfInvisible_desc       = "Become invisible to others",
        SpawnHorseInput          = {
          title = "SPAWN HORSE",
          placeholder = "A_C_Horse_Arabian_Grey",
          errorMsg = "min 5 max 60 chars"
        },
        SpawnWagonInput          = {
          title = "SPAWN WAGON",
          placeholder = "U_M_M_CircusWagon_01",
          errorMsg = "min 5 max 60 chars"
        },
        Prompts                  = {
          backward   = "BACKWARD",
          forward    = "FORWARD",
          speed      = "SPEED",
          down       = "DOWN",
          up         = "UP",
          cancel     = "CANCEL",
          speed_desc = "No clip | Speed "
        }
      },
      MainDatabaseOptions = {
        give = "Give",
        give_desc = "Grant an item or resource to a player",
        remove = "Remove",
        remove_desc = "Take away an item or resource from a player",
      },
      SubDatabaseGiveOptions = {
        showInventory        = "Show player's inventory",
        showInventory_desc   = "View the items and resources in a player's inventory",
        giveItem             = "Give an item",
        giveItem_desc        = "Grant a specific item to a player",
        giveWeapon           = "Give a weapon",
        giveWeapon_desc      = "Provide a weapon to a player",
        giveMoneyOrGold      = "Give money or gold",
        giveMoneyOrGold_desc = "Transfer currency or gold to a player's account <br> 0 FOR CASH 1 FOR GOLD AND QUANTITY",
        giveHorse            = "Give a horse",
        giveHorse_desc       = "Bestow a horse to a player",
        giveWagon            = "Give a wagon",
        giveWagon_desc       = "Assign a wagon to a player",
        GiveItemInput        = {
          title = "GIVE ITEM",
          placeholder = "Item and Quantity",
          errorMsg = "Dont use dot or commas etc"
        },
        GiveWeaponInput        = {
          title = "GIVE WEAPON",
          placeholder = "WEAPON_MELEE_KNIFE",
          errorMsg = "Dont use dot or commas etc"
        },
        GiveCurrencyInput        = {
          title = "GIVE CURRENCY",
          placeholder = "Currency and Quantity",
          errorMsg = "Dont use dot or commas etc"
        },
        GiveHorseInput        = {
          title = "GIVE HORSE",
          placeholder = "HASH | NAME | SEX",
          errorMsg = "Dont use dot or commas etc"
        },
        GiveWagonInput        = {
          title = "GIVE WAGON",
          placeholder = "HASH | NAME",
          errorMsg = "Dont use dot or commas etc"
        },
      }
    },
    Notify = {
      noperms           = "~e~You dont have permmision.",
      userNotExist      = "User dont exist.",
      switchedOn        = "Switched ON",
      switchedOff       = "Switched OFF",
      cantWarnStaff     = "You cant WARN staff",
      cantKickStaff     = "You cant KICK staff",
      cantBanStaff      = "You cant BAN staff",
      empty             = "Its Empty",
      whiteApproved     = "Whitelist was approved",
      whiteRemoved      = "Whitelist was removed",
      incorrectType     = "Incorrect Type!",
      missingArgument   = "Missing argument! Check example!",
      needWeaponInHands = "You need a weapon in hand!",
      reviseRules       = "Please revise our rules!"
    },
    Webhooks = {
      ActionsAdmin = {
        title = "📋 `/ADMIN ACTIONS`",
        usedfreeze = "❄️ Froze a player: ",
        usedbring = "🚀 Teleported a player to you: ",
        usedgoto = "🌍 Teleported to a player: ",
        usedreviveplayer = "💉 Revived a player: ",
        usedhealplayer = "🩹 Healed a player: ",
        warned = "⚠️ Warned a player: ",
        unwarned = "✅ Removed a warning from a player: ",
        usedspectate = "👁️ Spectated a player: ",
        usedrespawn = "💀 Respawned a player: ",
        usedkick = "👢 Kicked a player: ",
        usedban = "🔨 Banned a player: ",
        usedunban = "🔓 Unbanned a player: ",
        usedwhitelist = "📝 Whitelisted a player: ",
        usedunwhitelist = "🗑️ Removed player from whitelist: ",
        usedsetgroup = "👥 Set group for a player: ",
        usedsetjob = "💼 Set job for a player: ",
        usedannounce = "📢 Announced: ",
      },
      ActionBoosters = {
        title = "📋 `/BOOSTERS`",
        usedgod = "🛡️ Activated GodMode",
        usedgoldcores = "💎 Used Gold Cores",
        usednoclip = "🚀 Enabled NOCLIP",
        usedrevive = "💉 Self-Revived",
        usedheal = "🩹 Self-Healed",
        usedinfinitammo = "🔫 Enabled Infinite Ammo",
        spawn = "🆕 Spawned: ",
      },
      ActionDatabase = {
        title = "📋 `/DATABASE`",
        usedgiveitem = "🎁 Granted items to player",
        usedgiveweapon = "🔫 Provided weapons to player",
        usedgivecurrency = "💰 Transferred currency to player",
        usedgivehorse = "🐎 Gave a horse to player",
        usedgivewagon = "🚛 Assigned a wagon to player",
        usedclearmoney = "💸 Cleared player's money",
        usedcleargold = "💰 Cleared player's gold",
        usedclearitems = "🧺 Cleared player's items",
        usedclearweapons = "🔫 Cleared player's weapons",
      }
    }
  }
}
