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
            label = "<span style= margin-left:160px;>" .. v.PlayerName .. "</span>",
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
