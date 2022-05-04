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
                Boost()
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
