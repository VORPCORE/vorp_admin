---------------------------------------------------------------------------------------------------
--------------------------------------- FUNCTIONS -------------------------------------------------

--close menu

function Closem()
    MenuData.CloseAll()
    if Inmenu then
        Inmenu = false
    end
end

--Get players list
function GetPlayers()
    TriggerServerEvent("vorp_admin:GetPlayers")
    local X = {}

    RegisterNetEvent("vorp_admin:SendPlayers", function(data)
        X = data
    end)

    while next(X) == nil do
        Wait(10)
    end

    return X
end

---------------------------------------------------------------------------------------------------------------
----------------------------------- MAIN MENU -----------------------------------------------------------------
function OpenMenu()
    MenuData.CloseAll()
    local elements = {
        { label = "Administration", value = 'administration', desc = "Administration" },
        { label = "Boosters", value = 'boost', desc = "admin powers" },
        { label = "Database", value = 'database', desc = "Access database" },
        { label = "Teleport", value = 'teleport', desc = "Teleport options" },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubTitle"),
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if data.current == "backup" then
                _G[data.trigger]()
            end

            if data.current.value == "administration" then
                Admin() -- open category

            end

            if data.current.value == "boost" then
                VORPBooster.Boost()
            end

            if data.current.value == "database" then
                DataBase()
            end

            if data.current.value == "teleport" then
                Teleport()
            end



        end,

        function(data, menu)
        menu.close()

    end)
end

-- administration category
function Admin()
    MenuData.CloseAll()
    local elements = {
        { label = "Players List", value = 'players', desc = "list of players on the server" },
        { label = "Admin Actions", value = 'actions', desc = "Admin actions options" },



    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubTitle"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "players" then
                PlayerList()
            end

            if data.current.value == "actions" then
                Actions()
            end

        end,

        function(menu)
        menu.close()
    end)

end

--TODO added to langs
function PlayerList()
    MenuData.CloseAll()
    local elements = {
    }

    local players = GetPlayers()
    for k, v in pairs(players) do

        table.insert(elements,
            {
            label = v.PlayerName,
            value = "players",
            desc = "<span>Steam Name: "
                .. v.name .. "</span><br><span>Server ID: "
                .. v.serverId .. "</span><br><span>Player Group: "
                .. v.Group .. "</span><br><span>Player Job: "
                .. v.Job .. " Grade: "
                .. v.Grade .. "</span><br><span>Identifier: "
                .. v.SteamId .. "</span><br><span>Player Money: "
                .. v.Money .. "</span><br><span>Player Gold: "
                .. v.Gold .. "</span>"
        })
    end


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubtitle2"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'Admin',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            else

                for k, Player in pairs(players) do

                    AdminActions(Player)
                end
            end
        end,
        function(menu)
        menu.close()
    end)

end

function AdminActions(Player)
    MenuData.CloseAll()
    local elements = {
        { label = _U("kick_p"), value = 'kick', desc = _U("kick_desc") .. Player.PlayerName },
        { label = _U("freeze_p"), value = 'freeze', desc = _U("freeze_desc") .. Player.PlayerName },
        { label = _U("unfreeze_p"), value = 'unfreeze', desc = _U("unfreeze_desc") .. Player.PlayerName },
        { label = _U("ban_p"), value = 'ban', desc = _U("ban_desc") .. Player.PlayerName },
        { label = _U("spectate_p"), value = 'spectate', desc = _U("spectate_desc") .. Player.PlayerName },
        { label = _U("revive_p"), value = 'revive', desc = _U("revive_desc") .. Player.PlayerName },
        { label = _U("respawn_p"), value = 'respawn', desc = _U("respawn_desc") .. Player.PlayerName },
        { label = _U("heal_p"), value = 'heal', desc = _U("heal_desc") .. Player.PlayerName },
        { label = _U("goto_p"), value = 'goto', desc = _U("goto_desc") .. Player.PlayerName },
        { label = _U("bring_p"), value = 'bring', desc = _U("bring_desc") .. Player.PlayerName },
        { label = _U("warn_p"), value = 'warn', desc = _U("warn_desc") .. Player.PlayerName },

    }


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = Player.PlayerName, --char player name
            align    = 'top-left',
            elements = elements,
            lastmenu = 'PlayerList',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end

            if data.current.value == "freeze" then

            end

            if data.current.value == "unfreeze" then

            end

            if data.current.value == "bring" then

            end
        end,

        function(menu)
        menu.close()
    end)


end

------------------------------------------------------------------------------------------------------------------
---------------------------------------- DATABASE ----------------------------------------------------------------
function DataBase()
    MenuData.CloseAll()
    local elements = {
    }

    local players = GetPlayers()
    for k, v in pairs(players) do

        table.insert(elements,
            {
            label = v.PlayerName,
            value = "players",
            desc = "<span>Steam Name: "
                .. v.name .. "</span><br><span>Server ID: "
                .. v.serverId .. "</span><br><span>Player Group: "
                .. v.Group .. "</span><br><span>Player Job: "
                .. v.Job .. " Grade: "
                .. v.Grade .. "</span><br><span>Identifier: "
                .. v.SteamId .. "</span><br><span>Player Money: "
                .. v.Money .. "</span><br><span>Player Gold: "
                .. v.Gold .. "</span>"
        })
    end


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubtitle2"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            else

                for k, Player in pairs(players) do

                    DatabasePlayers(Player)
                end
            end
        end,
        function(menu)
        menu.close()
    end)

end

function DatabasePlayers()
    MenuData.CloseAll()
    local elements = {
        { label = "Give", value = 'give', desc = "Give options " },
        { label = "Remove", value = 'remove', desc = "Remove options" },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Boosters",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'DataBase', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "give" then
                GivePlayers()
            end
            if data.current.value == "remove" then
                RemovePlayers()
            end
        end,

        function(menu)
        menu.close()
    end)

end

function GivePlayers()
    MenuData.CloseAll()
    local elements = {
        { label = "Add Items", value = 'addItems', desc = "give an item to player " },
        { label = "Add Weapons", value = 'addWeapons', desc = "give a weapon to player" },
        { label = "Add money", value = 'addMoney', desc = "give money to player " },
        { label = "Add Gold", value = 'addGold', desc = "give gold to player " },
        { label = "Add Xp", value = 'addXp', desc = "give XP to player " },
        { label = "Add Horse", value = 'addHorse', desc = "give horse to player " },
        { label = "Add Wagon", value = 'addWagon', desc = "give wagon to player " },



    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Boosters",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'DatabasePlayers', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "tpm" then


            end
        end,

        function(menu)
        menu.close()
    end)

end

function RemovePlayers()
    MenuData.CloseAll()
    local elements = {
        { label = "Remove Items", value = 'removeItems', desc = "remove an Item from player" },
        { label = "Remove Weapons", value = 'removeWeapons', desc = "remove a weapon from player" },
        { label = "Remove money", value = 'removeMoney', desc = "remove money from player " },
        { label = "Remove Gold", value = 'removeGold', desc = "remove gold from player " },
        { label = "Remove Xp", value = 'removeXp', desc = "remove xp from player" },
        { label = "Remove Horse", value = 'RemoveHorse', desc = "remove horse from player" },
        { label = "Remove Wagon", value = 'RemoveWagon', desc = " remove wagon from player" },

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Boosters",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'DatabasePlayers', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "removeItems" then

            end
        end,

        function(menu)
        menu.close()
    end)

end

------------------------------------------------------------------------------------------------------------
---------------------------------------- TELEPORTS ---------------------------------------------------------
function Teleport()
    MenuData.CloseAll()
    local elements = {
        { label = "Tpm", value = 'tpm', desc = "teleport to marker " },
        { label = "Tp to coords", value = 'coords', desc = "teleport to coords x y z" },
        { label = "Tp to player", value = 'tpplayer', desc = "teleport you to player " },
        { label = "Tp player ", value = 'bring', desc = "Brings a player to you " },

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Boosters",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "tpm" then


            end
        end,

        function(menu)
        menu.close()
    end)

end

-------------------------------------------------------------------------------------------------------------
---------------------------------------- Actions ------------------------------------------------------------

function Actions()
    MenuData.CloseAll()
    local elements = {
        { label = "Spawn Ped", value = 'tpm', desc = "Spawn a ped" },
        { label = "Spawn animal", value = 'coords', desc = "Spawn an animal" },
        { label = "Spawn object", value = 'coords', desc = "Spawn an Object" },
        { label = "delete Object", value = 'coords', desc = "Delete an object" },
        { label = "Delete Horse", value = 'coords', desc = "Delete a horse" },
        { label = "Delete wagon", value = 'coords', desc = "Delete a wagon" },




    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Boosters",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "tpm" then


            end
        end,

        function(menu)
        menu.close()
    end)

end
