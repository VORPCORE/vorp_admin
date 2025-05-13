local stafftable = {}
local PlayersTable = {}
local T <const> = Translation.Langs[Config.Lang]

local function checkResourceStarted()
    local has_inventory_started <const> = GetResourceState("vorp_inventory") == "started"
    local has_core_started <const> = GetResourceState("vorp_core") == "started"
    if not has_inventory_started or not has_core_started then
        local resource_stopped <const> = not has_inventory_started and "vorp_inventory" or "vorp_core"
        error(("Resource %s is not started vorp_admin willstop"):format(resource_stopped))
    end
end

checkResourceStarted()

local Core <const> = exports.vorp_core:GetCore()

local function getUserData(User, _source)
    local Character = User.getUsedCharacter
    local group = Character.group

    local playername = (Character.firstname or "no name") .. ' ' .. (Character.lastname or "noname")
    local job = Character.job
    local identifier = Character.identifier
    local PlayerMoney = Character.money
    local PlayerGold = Character.gold
    local JobGrade = Character.jobGrade
    local getid = Core.Whitelist.getEntry(identifier)
    local getstatus = Core.Whitelist.getEntry(identifier)

    local data = {
        serverId = _source,
        name = GetPlayerName(_source),
        Group = group,
        PlayerName = playername,
        Job = job,
        SteamId = identifier,
        Money = PlayerMoney,
        Gold = PlayerGold,
        Grade = JobGrade,
        staticID = getid and tonumber(getid.id) or "no id",
        WLstatus = getstatus and tostring(getstatus.status) or "no status",
    }
    return data
end

-- Register CallBack
Core.Callback.Register("vorp_admin:Callback:getplayersinfo", function(_, cb, args)
    if next(PlayersTable) then
        if args.search == "search" then -- is for unique player
            if PlayersTable[args.id] then
                local User = Core.getUser(args.id)
                if User then
                    local data = getUserData(User, args.id)
                    PlayersTable[args.id] = data
                    return cb(PlayersTable[args.id])
                end
                return cb(false)
            else
                return cb(false)
            end
        end

        for id, _ in pairs(PlayersTable) do
            local User = Core.getUser(id)
            if User then
                local data = getUserData(User, id)
                PlayersTable[id] = data
            end
        end
        return cb(PlayersTable)
    end
    return cb(false)
end)


local function AllowedToExecuteAction(source, action)
    local user <const> = Core.getUser(source)
    if not user then return end

    local group <const> = Config.UseCharactersAdmin and user.getUsedCharacter.group or user.getGroup

    if Config.AllowedActions[group] then
        if Config.AllowedActions[group].actions.all then
            return true
        end

        return Config.AllowedActions[group].actions[action]
    end
end

-------------------------------------------------------------------------------
--------------------------------- EVENTS TELEPORTS -----------------------------
--TP TO
RegisterNetEvent("vorp_admin:TpToPlayer", function(targetID, _, name)
    local _source = source

    if not Core.getUser(targetID) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "tp_to_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local targetCoords = GetEntityCoords(GetPlayerPed(targetID))
    TriggerClientEvent('vorp_admin:gotoPlayer', _source, targetCoords)

    if name then
        TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Goto, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedgoto .. "\n> " .. name)
    else
        TriggerEvent("vorp_admin:logs", _source, Logs.TeleportLogs.Tptoplayer, T.Webhooks.ActionTeleport.title, T.Webhooks.ActionTeleport.usedtptoplayer .. "\nID: " .. targetID)
    end
end)

--SENDBACK
RegisterNetEvent("vorp_admin:sendAdminBack", function()
    local _source = source
    if not AllowedToExecuteAction(_source, "send_player_back") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:sendAdminBack', _source)
end)


--FREEZE
RegisterNetEvent("vorp_admin:freeze", function(targetID, freeze, _, name)
    local _source = source
    local _target = targetID
    local state = freeze

    if not Core.getUser(_target) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "freeze_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerClientEvent("vorp_admin:Freezeplayer", targetID, state)

    if name then -- only log when is using freeze
        TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Freezed, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedfreeze .. "\n> " .. name)
    end
end)
---------------------------------------------------------------
--BRING
RegisterNetEvent("vorp_admin:Bring", function(targetID, adminCoords, _, name, target)
    local _source = source

    if not Core.getUser(targetID) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "bring_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerClientEvent("vorp_admin:Bring", targetID, adminCoords)

    if name then
        TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Bring, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedbring .. "\n> " .. name)
    end

    if target then
        TriggerEvent("vorp_admin:logs", _source, Logs.TeleportLogs.Bringplayer, T.Webhooks.ActionTeleport.title, T.Webhooks.ActionTeleport.usedbringplayer .. "\nID: " .. target)
    end
end)

--TPBACK
RegisterNetEvent("vorp_admin:TeleportPlayerBack", function(targetID)
    local _source = source

    if not Core.getUser(targetID) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "tp_player_back") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerClientEvent('vorp_admin:TeleportPlayerBack', targetID)
end)

----------------------------------------------------------------------------------
---------------------------- ADVANCED ADMIN ACTIONS ---------------------------------------

-- KICK
RegisterNetEvent("vorp_admin:kick", function(target, reason, _, name)
    local _source = source

    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "kick_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerClientEvent('vorp:updatemissioNotify', target, T.Notify.kickedNotify, T.Notify.kickedNotify, 5000)

    SetTimeout(5000, function()
        DropPlayer(target, reason)
    end)

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Kick, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedkick .. "\n > " .. name .. "\n: " .. reason)
end)


-- BAN
RegisterNetEvent("vorp_admin:BanPlayer", function(target, staticid, time, _, name)
    local _source = source

    local targetStaticId = tonumber(staticid)
    local datetime = os.time(os.date("!*t"))
    local banTime
    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "ban_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    if time:sub(-1) == 'd' then
        banTime = tonumber(time:sub(1, -2))
        banTime = banTime * 24
    elseif time:sub(-1) == 'w' then
        banTime = tonumber(time:sub(1, -2))
        banTime = banTime * 168
    elseif time:sub(-1) == 'm' then
        banTime = tonumber(time:sub(1, -2))
        banTime = banTime * 720
    elseif time:sub(-1) == 'y' then
        banTime = tonumber(time:sub(1, -2))
        banTime = banTime * 8760
    else
        banTime = tonumber(time)
    end
    if banTime == 0 then
        datetime = 0
    else
        datetime = datetime + banTime * 3600
    end

    TriggerClientEvent('vorp:updatemissioNotify', target, T.Notify.bannedNotify, T.Notify.bannedNotify, 8000)
    SetTimeout(8000, function()
        TriggerEvent("vorpbans:addtodb", false, targetStaticId, datetime)
    end)

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Ban, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedban .. "\n > " .. name .. "\n: " .. time)
end)

-- RESPAWN
RegisterNetEvent("vorp_admin:respawnPlayer", function(target, _, name)
    local _source = source
    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "respawn_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    exports.vorp_inventory:closeInventory(target)

    TriggerClientEvent('vorp:updatemissioNotify', target, T.Notify.respawnedNotify, T.Notify.lostAllItems, 8000)

    SetTimeout(5000, function()
        Core.Player.Respawn(target)
        TriggerClientEvent("vorp_admin:respawn", target) --add effects
    end)

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Respawn, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedrespawn .. "\n > " .. name)
end)



--------------------------------------------------------------------
--------------------------------------------------------------------
-- DATABASE GIVE ITEM

RegisterNetEvent("vorp_admin:givePlayer", function(target, action, data1, data2, data3, _, name)
    local _source = source
    local user <const> = Core.getUser(target)
    if not user then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "give_" .. action) then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local Character <const> = user.getUsedCharacter

    if action == "item" then
        local item <const> = data1
        local qty <const> = data2

        if not qty or not item then
            return Core.NotifyRightTip(_source, T.Notify.invalidAdd, 5000)
        end

        local itemCheck <const> = exports.vorp_inventory:getItemDB(item)
        local canCarryItem <const> = exports.vorp_inventory:canCarryItem(target, item, qty)

        if not itemCheck then
            return Core.NotifyRightTip(_source, T.Notify.doesNotExistInDB, 5000)
        end

        if not canCarryItem then
            return Core.NotifyRightTip(_source, T.Notify.itemLimit, 5000)
        end

        exports.vorp_inventory:addItem(target, item, qty)

        Core.NotifyRightTip(target, T.Notify.receivedItem .. qty .. T.Notify.of .. itemCheck.label .. "~q~", 5000)
        Core.NotifyRightTip(_source, T.Notify.itemGiven, 4000)

        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Giveitem, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedgiveitem .. "\nPlayer: " .. name .. "\nItem: " .. item .. "\nQTY: " .. qty)

        return
    end

    if action == "weapon" then
        local weapon <const> = data1

        local canCarryWeapons <const> = exports.vorp_inventory:canCarryWeapons(target, 1, nil, weapon)

        if not canCarryWeapons then
            return Core.NotifyRightTip(_source, T.Notify.cantCarryWeapon, 5000)
        end

        exports.vorp_inventory:createWeapon(target, weapon)

        Core.NotifyRightTip(target, T.Notify.receivedWeapon, 5000)
        Core.NotifyRightTip(_source, T.Notify.weaponGiven, 4000)

        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Giveweapon, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedgiveweapon .. "\nPlayer: " .. name .. "\nWeapon: " .. weapon)

        return
    end

    if action == "moneygold" then
        local CurrencyType <const> = data1
        local qty <const> = data2

        if not qty then
            return Core.NotifyRightTip(_source, T.Notify.addQuantity, 5000)
        end

        Character.addCurrency(tonumber(CurrencyType), tonumber(qty))

        if CurrencyType == 0 then
            Core.NotifyRightTip(target, T.Notify.receivedItem .. qty .. T.Notify.money, 5000)
        elseif CurrencyType == 1 then
            Core.NotifyRightTip(target, T.Notify.receivedItem .. qty .. T.Notify.gold, 5000)
        elseif CurrencyType == 2 then
            Core.NotifyRightTip(target, T.Notify.receivedItem .. qty .. T.Notify.ofRoll, 5000)
        end
        Core.NotifyRightTip(_source, T.Notify.sent, 4000)

        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Givecurrency, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedgivecurrency .. "\nPlayer: " .. name .. "\nCurrency: " .. CurrencyType .. "\nQTY: " .. qty)

        return
    end

    if action == "horse" then
        local identifier <const> = Character.identifier
        local charid <const> = Character.charIdentifier
        local hash <const> = data1
        name = data2
        local sex <const> = data3
        if not Config.VorpStable then
            MySQL.insert("INSERT INTO horses ( `identifier`, `charid`, `name`, `model`, `sex`) VALUES ( @identifier, @charid, @name, @model, @sex)", {
                identifier = identifier,
                charid = charid,
                name = tostring(name),
                model = hash,
                sex = sex
            })
        else
            MySQL.insert("INSERT INTO stables ( `identifier`, `charidentifier`, `name`, `modelname`,`type`,`inventory` ) VALUES ( @identifier, @charid, @name, @modelname, @type, @inventory)", {
                identifier = identifier,
                charid = charid,
                name = tostring(name),
                modelname = hash,
                type = "horse",
                inventory = json.encode({})
            })
        end
        Core.NotifyRightTip(target, T.Notify.horseReceived, 5000)
        Core.NotifyRightTip(_source, T.Notify.horseGiven, 4000)

        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Givehorse, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedgivehorse .. "\nPlayer: " .. name .. "\nHorse: " .. hash)

        return
    end

    if action == "wagon" then
        local identifier <const> = Character.identifier
        local charid <const> = Character.charIdentifier
        local hash <const> = data1
        name = data2

        if not Config.VorpStable then
            MySQL.insert("INSERT INTO wagons ( `identifier`, `charid`, `name`, `model`) VALUES ( @identifier, @charid, @name, @model)", {
                identifier = identifier,
                charid = charid,
                name = tostring(name),
                model = hash
            })
        else
            MySQL.insert("INSERT INTO stables ( `identifier`, `charidentifier`, `name`, `modelname`,`type`,`inventory` ) VALUES ( @identifier, @charid, @name, @modelname, @type, @inventory)", {
                identifier = identifier,
                charid = charid,
                name = tostring(name),
                modelname = hash,
                type = "wagon",
                inventory = json.encode({})
            })
        end
        Core.NotifyRightTip(target, T.Notify.wagonReceived, 5000)
        Core.NotifyRightTip(_source, T.Notify.weaponGiven, 4000)

        TriggerEvent("vorp_admin:logs", Config.DatabaseLogs.Givewagon, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedgivewagon .. "\nPlayer: " .. name .. "\nWagon: " .. hash)
    end
end)


-- REMOVE DB

RegisterNetEvent("vorp_admin:ClearAllItems", function(type, target, _, name)
    local _source = source

    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "clear_inventory") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    exports.vorp_inventory:closeInventory(target)

    if type == "items" then
        local inv <const> = exports.vorp_inventory:getUserInventoryItems(target)
        if not inv then
            return Core.NotifyRightTip(_source, "inventory is empty", 8000)
        end

        for _, inventoryItems in pairs(inv) do
            exports.vorp_inventory:subItem(target, inventoryItems.name, inventoryItems.count)
        end
        Core.NotifyRightTip(_source, T.Notify.itemsWiped, 4000)
        Core.NotifyRightTip(target, T.Notify.itemWipe, 5000)
        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Clearitems, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedclearitems .. "\nPlayer: " .. name .. "\nID: " .. target)
    end

    if type == "weapons" then
        local weaponsPlayer <const> = exports.vorp_inventory:getUserInventoryWeapons(target)
        for _, value in pairs(weaponsPlayer) do
            local id <const> = value.id
            exports.vorp_inventory:subWeapon(target, id)
            exports.vorp_inventory:deleteWeapon(target, id)
            TriggerClientEvent('syn_weapons:removeallammo', target)
            TriggerClientEvent('vorp_weapons:removeallammo', target)
        end

        Core.NotifyRightTip(_source, T.Notify.weaponsWiped, 4000)
        Core.NotifyRightTip(target, T.Notify.weaponWipe, 5000)
        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Clearweapons, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedclearweapons .. "\nPlayer: " .. name .. "\nID: " .. target)
    end
end)

-- GET ITEMS FROM INVENTORY
RegisterNetEvent("vorp_admin:checkInventory", function(targetID)
    local _source = source
    if not Core.getUser(targetID) then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "check_player_inventory") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local inv = exports.vorp_inventory:getUserInventoryItems(targetID)
    TriggerClientEvent("vorp_admin:getplayerInventory", _source, inv)
end)

-- REMOVE CURRENCY
RegisterNetEvent("vorp_admin:ClearCurrency", function(targetID, type, _, name)
    local _source = source

    local user <const> = Core.getUser(targetID)
    if not user then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "clear_currency") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local Character <const> = user.getUsedCharacter
    local money <const> = Character.money
    local gold <const> = Character.gold

    if type == "money" then
        Character.removeCurrency(0, money)
        Core.NotifyRightTip(_source, T.Notify.moneyRemoved, 4000)
        Core.NotifyRightTip(targetID, T.Notify.moneyRemovedFromAdmin, 4000)
        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Clearmoney, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedclearmoney .. "\nPlayer: " .. name .. "\nID: " .. targetID .. "\nCurrency: " .. type)
    else
        Character.removeCurrency(1, gold)
        Core.NotifyRightTip(_source, T.Notify.goldRemoved, 4000)
        Core.NotifyRightTip(targetID, T.Notify.goldRemovedFromAdmin, 4000)
        TriggerEvent("vorp_admin:logs", _source, Logs.DatabaseLogs.Cleargold, T.Webhooks.ActionDatabase.title, T.Webhooks.ActionDatabase.usedcleargold .. "\nPlayer: " .. name .. "\nID: " .. targetID .. "\nCurrency: " .. type)
    end
end)

-----------------------------------------------------------------------------------------------------------------
-- ADMIN ACTIONS

-- GROUP
RegisterNetEvent("vorp_admin:setGroup", function(targetID, newgroup, _, name)
    local _source = source
    local _target = targetID
    local NewPlayerGroup = newgroup
    local user <const> = Core.getUser(_target)
    if not user then
        return Core.NotifyRightTip(_source, T.Notify.userNotExist, 8000)
    end

    if not AllowedToExecuteAction(_source, "set_group") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local character <const> = user.getUsedCharacter

    if Config.giveCharacterGroup and Config.giveUserGroup then -- if both true then set both
        character.setGroup(NewPlayerGroup)
        user.setGroup(NewPlayerGroup)
    elseif Config.giveCharacterGroup then
        character.setGroup(NewPlayerGroup)
    elseif Config.giveUserGroup then
        user.setGroup(NewPlayerGroup)
    end
    local group = "none"

    if Config.UseCharactersAdmin then
        if Config.giveCharacterGroup then
            group = NewPlayerGroup
        end
    else
        if Config.giveUserGroup then
            group = NewPlayerGroup
        end
    end

    -- update staff table if group is staff
    if Config.AllowedActions[group] then
        stafftable[_target] = _target
    else
        return Core.NotifyRightTip(_source, "this group doesnt exist in the AllowedActions table", 8000)
    end

    Core.NotifyRightTip(_target, T.Notify.groupGiven .. group, 5000)

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Setgroup, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedsetgroup .. "\n > " .. name .. "\nGroup: " .. NewPlayerGroup)
end)

-- JOB
RegisterNetEvent("vorp_admin:setJob", function(targetID, newjob, newgrade, newJobLabel, _, name)
    local _source = source
    local _target = targetID
    local user <const> = Core.getUser(_target)
    if not user then
        return Core.NotifyRightTip(_source, "user not found", 8000)
    end

    if not AllowedToExecuteAction(_source, "set_job") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local character <const> = user.getUsedCharacter
    character.setJob(newjob)
    character.setJobGrade(newgrade)
    character.setJobLabel(newJobLabel)

    Core.NotifyRightTip(_target, T.Notify.jobGiven .. newjob, 5000)
    Core.NotifyRightTip(_target, T.Notify.gradeGiven .. newgrade, 5000)
    Core.NotifyRightTip(_target, T.Notify.jobLabelGiven .. newJobLabel, 5000)
    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Setjob, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedsetjob .. "\n > " .. name .. "\nJob:  " .. newjob .. " \nGrade: " .. newgrade)
end)

-- WHITELIST
RegisterNetEvent("vorp_admin:Whitelist", function(_, steam, _, _, name)
    local _source = source

    if not AllowedToExecuteAction(_source, "whitelist_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    Core.Whitelist.unWhitelistUser(steam)

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Unwhitelist, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedunwhitelist .. "\n > " .. name .. "\n: " .. steam)
end)

RegisterNetEvent("vorp_admin:Whitelistoffline", function(steam, type)
    local _source = source

    if not AllowedToExecuteAction(_source, "whitelist_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    --only offline players can be whitelisted
    if type == "whiteList" then
        Core.Whitelist.whitelistUser(steam)
    else
        Core.Whitelist.unWhitelistUser(steam)
    end
end)

-- REVIVE
RegisterNetEvent("vorp_admin:revive", function(target, _, name)
    local _source = source

    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, "user not found", 8000)
    end

    if not AllowedToExecuteAction(_source, "revive_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    if name then
        TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Revive, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedreviveplayer .. "\n> " .. name)
    end

    Core.Player.Revive(target)
end)

-- HEAL
RegisterNetEvent("vorp_admin:heal", function(target, _, name)
    local _source = source

    if not Core.getUser(target) then
        return Core.NotifyRightTip(_source, "user not found", 8000)
    end

    if not AllowedToExecuteAction(_source, "heal_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    if name then
        TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Heal, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedhealplayer .. "\n> " .. name)
    end

    Core.Player.Heal(target)
end)

-- JUST FOR LOGS
-- SPAWN HORSE
RegisterNetEvent("vorp_admin:spawnHorse", function(horse)
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "spawn_horse") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.SelfSpawnHorse, T.Webhooks.ActionBoosters.title, "Horse: " .. horse)
end)

-- SPAWN WAGON
RegisterNetEvent("vorp_admin:spawnWagon", function(wagon)
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "spawn_wagon") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.SelfSpawnWagon, T.Webhooks.ActionBoosters.title, "Wagon: " .. wagon)
end)

-- GODMODE
RegisterNetEvent("vorp_admin:GodMode", function()
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "godmode") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.GodMode, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedgod)
end)

-- GOLDEN CORES
RegisterNetEvent("vorp_admin:GoldenCores", function()
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "golden_cores") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.GoldenCores, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedgoldcores)
end)

-- INFINITE AMMO
RegisterNetEvent("vorp_admin:InfiAmmo", function()
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "infinite_ammo") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.InfiniteAmmo, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedinfinitammo)
end)

-- NOCLIP
RegisterNetEvent("vorp_admin:NoClip", function()
    local _source = source
    -- just incase they want to flood the logs
    if not AllowedToExecuteAction(_source, "noclip") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.NoClip, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usednoclip)
end)

-- SPECTATE
RegisterNetEvent("vorp_admin:spectate", function(targetID, _, name)
    local _source = source

    if not AllowedToExecuteAction(_source, "spectate") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local targetCoords = GetEntityCoords(GetPlayerPed(targetID))
    TriggerClientEvent("vorp_admin:spectatePlayer", _source, targetID, targetCoords)
    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Spectate, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedspectate .. "\n > " .. name)
end)


RegisterNetEvent("vorp_admin:announce", function(announce)
    local _source = source
    if not AllowedToExecuteAction(_source, "allow_announce") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Announce, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedannounce .. "\n > " .. announce)

    Core.NotifySimpleTop(-1, T.Notify.announce, announce, 10000)
end)

RegisterNetEvent('vorp_admin:HealSelf', function()
    local _source = source
    if not AllowedToExecuteAction(_source, "selfheal") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local name = Player(_source).state.Character.FirstName .. Player(_source).state.Character.LastName
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.SelfHeal, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedheal .. "\n> " .. name)

    Core.Player.Heal(_source)
end)

RegisterNetEvent('vorp_admin:ReviveSelf', function()
    local _source = source
    if not AllowedToExecuteAction(_source, "selfrevive") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local name = Player(_source).state.Character.FirstName .. Player(_source).state.Character.LastName
    TriggerEvent("vorp_admin:logs", _source, Logs.BoosterLogs.SelfRevive, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedrevive .. "\n> " .. name)
    Core.Player.Revive(_source)
end)

RegisterNetEvent("vorp_admin:Unban", function(staticid, _, name)
    local _source = source
    if not AllowedToExecuteAction(_source, "unban_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerEvent("vorp_admin:logs", _source, Logs.AdminLogs.Unban, T.Webhooks.ActionsAdmin.title, T.Webhooks.ActionsAdmin.usedunban .. "\n > " .. name .. "\n: " .. staticid)

    TriggerEvent("vorpbans:addtodb", false, staticid, 0)
end)

RegisterNetEvent("vorp_admin:BanOffline", function(staticid, time)
    local _source = source
    if not AllowedToExecuteAction(_source, "ban_offline") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    TriggerEvent("vorpbans:addtodb", false, staticid, time)
end)

RegisterNetEvent('vorp:teleportWayPoint', function(_, coords, waypointCoords)
    local _source = source
    if not AllowedToExecuteAction(_source, "tp_to_waypoint") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local description = T.Webhooks.ActionTeleport.usedtpm .. "\nWaypoint teleported to " .. tostring(waypointCoords) .. "\nfrom Coords : " .. tostring(coords)
    TriggerEvent("vorp_admin:logs", _source, Logs.TeleportLogs.Tpm, T.Webhooks.ActionTeleport.title, description)

    TriggerClientEvent('vorp:teleportWayPoint', _source, coords)
end)

RegisterNetEvent('vorp_admin:tptocoords', function(oldCoords, x, y, z)
    local _source = source
    if not AllowedToExecuteAction(_source, "tp_to_coords") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local description = T.Webhooks.ActionTeleport.usedtptocoords .. "\nfrom coords: " .. tostring(oldCoords) .. "\nto coords: " .. tostring(vector3(x, y, z))
    TriggerEvent("vorp_admin:logs", _source, Logs.TeleportLogs.Tptocoords, T.Webhooks.ActionTeleport.title, description)
end)

-----------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-- OPEN MAIN MENU
Core.Callback.Register('vorp_admin:CanOpenStaffMenu', function(source, CB, action)
    local _source = source
    local user <const> = Core.getUser(_source)
    if not user then return end

    CB(AllowedToExecuteAction(_source, action))
end)

-------------------------------------------------------------------------------------------------------------------
-------------------------- Troll Actions--------------------------------------------------------------------------
RegisterNetEvent('vorp_admin:ServerTrollKillPlayerHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_kill_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTrollKillPlayerHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerTrollInvisibleHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_invisible") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTrollInvisbleHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerTrollLightningStrikePlayerHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_lightning_strike") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end

    local playerPed = GetPlayerPed(playerserverid)
    local coords = GetEntityCoords(playerPed)
    TriggerClientEvent('vorp_admin:ClientTrollLightningStrikePlayerHandler', -1, coords)
end)

RegisterNetEvent('vorp_admin:ServerTrollSetPlayerOnFireHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_set_player_on_fire") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTrollSetPlayerOnFireHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerTrollTPToHeavenHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_tp_to_heaven") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTrollTPToHeavenHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerTrollRagdollPlayerHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_ragdoll_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTrollRagdollPlayerHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerDrainPlayerStamHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_drain_player_stam") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientDrainPlayerStamHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerHandcuffPlayerHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_handcuff_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientHandcuffPlayerHandler', playerserverid)
end)

RegisterNetEvent('vorp_admin:ServerTempHighPlayerHandler', function(playerserverid)
    local _source = source
    if not AllowedToExecuteAction(_source, "troll_temp_high_player") then
        return Core.NotifyRightTip(_source, "you are not allowed to use this command", 8000)
    end
    TriggerClientEvent('vorp_admin:ClientTempHighPlayerHandler', playerserverid)
end)


AddEventHandler('vorp_admin:logs', function(source, webhook, title, description)
    local _source = source
    local Identifier = GetPlayerIdentifier(_source, 1)
    local discordIdentity = GetPlayerIdentifierByType(_source, "discord")
    local discordId = "no discord"
    if discordIdentity then
        discordId = string.sub(discordIdentity, 9)
    end
    local ip = GetPlayerEndpoint(_source)
    local steamName = GetPlayerName(_source)

    local message = "**Steam name: **`" ..
        steamName ..
        "`**\nIdentifier**`" ..
        Identifier ..
        "` \n**Discord:** <@" ..
        discordId ..
        ">**\nIP: **`" .. (ip or "none") .. "`\n `" .. description .. "`"
    Core.AddWebhook(title, webhook, message, Logs.webhookColor, Logs.name, Logs.logo, Logs.footerLogo, Logs.avatar)
end)


-- Alert staff of report
RegisterNetEvent('vorp_admin:alertstaff', function(report)
    local _source = source
    local user <const> = Core.getUser(_source)
    if not user then return end

    local character = user.getUsedCharacter
    local playername = character.firstname .. ' ' .. character.lastname

    for _, staff in pairs(stafftable) do
        Core.NotifyRightTip(staff, T.Notify.player .. playername .. T.Notify.reportedToDiscord, 4000)
    end

    TriggerEvent("vorp_admin:logs", _source, Logs.ReportLogs.Reports, T.Webhooks.ActionScoreBoard.title, T.Webhooks.ActionScoreBoard.playerreported .. report)
end)



AddEventHandler("vorp:SelectedCharacter", function(source)
    local _source = source

    if Config.DevMode then
        return print("^1DevMode is enabled, disable on live servers^7")
    end

    local user <const> = Core.getUser(_source)
    if not user then return end
    local user_group = Config.UseCharactersAdmin and user.getUsedCharacter.group or user.getGroup

    if Config.AllowedActions[user_group] then -- only admins
        stafftable[_source] = _source
    end

    local data = getUserData(user, _source)
    PlayersTable[_source] = data
end)

if Config.DevMode then
    RegisterNetEvent("vorp_admin:getStaffInfo", function(source)
        local _source = source
        local user <const> = Core.getUser(_source)
        if not user then return end
        local user_group = Config.UseCharactersAdmin and user.getUsedCharacter.group or user.getGroup

        if Config.AllowedActions[user_group] then
            stafftable[_source] = _source
        end

        local data = getUserData(user, _source)
        PlayersTable[_source] = data
    end)
end

RegisterNetEvent("vorp_admin:requeststaff", function(type)
    local _source = source
    local user <const> = Core.getUser(_source)
    if not user then return end

    local character = user.getUsedCharacter
    local playername = character.firstname .. ' ' .. character.lastname

    for _, staff in pairs(stafftable) do
        if type == "new" then
            Core.NotifyRightTip(staff, playername .. " ID: " .. _source .. T.Notify.requestingAssistance .. T.Notify.new, 4000)
        elseif type == "bug" then
            Core.NotifyRightTip(staff, playername .. " ID: " .. _source .. T.Notify.requestingAssistance .. T.Notify.foundBug, 4000)
        elseif type == "rules" then
            Core.NotifyRightTip(staff, playername .. " ID: " .. _source .. T.Notify.requestingAssistance .. T.Notify.someoneBrokerules, 4000)
        elseif type == "cheating" then
            Core.NotifyRightTip(staff, playername .. " ID: " .. _source .. T.Notify.requestingAssistance .. T.Notify.someoneCheating, 4000)
        end
    end
    if type == "new" then
        TriggerEvent("vorp_admin:logs", _source, Logs.ReportLogs.RequestStaff, T.Webhooks.ActionScoreBoard.title, T.Webhooks.ActionScoreBoard.requeststaff_disc)
    elseif type == "bug" then
        TriggerEvent("vorp_admin:logs", _source, Logs.ReportLogs.BugReport, T.Webhooks.ActionScoreBoard.title, T.Webhooks.ActionScoreBoard.requeststaff_bug)
    elseif type == "rules" then
        TriggerEvent("vorp_admin:logs", _source, Logs.ReportLogs.RulesBroken, T.Webhooks.ActionScoreBoard.title, T.Webhooks.ActionScoreBoard.requeststaff_rulesbroke)
    elseif type == "cheating" then
        TriggerEvent("vorp_admin:logs", _source, Logs.ReportLogs.Cheating, T.Webhooks.ActionScoreBoard.title, T.Webhooks.ActionScoreBoard.requeststaff_cheating)
    end
end)


AddEventHandler('playerDropped', function()
    local _source = source

    if stafftable[_source] then
        stafftable[_source] = nil
    end
    if PlayersTable[_source] then
        PlayersTable[_source] = nil
    end
end)
