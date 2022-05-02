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

--Main menu
function OpenMenu()
    MenuData.CloseAll()

    local elements = {
        { label = "Administration", value = 'administration', desc = "administrate" },
        { label = "Boosters", value = 'boost', desc = "Boost your powers" },
        { label = "Database", value = 'database', desc = "Access database" },
        { label = "Teleport", value = 'teleports', desc = "Teleport to" },
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
            else
                if data.current.value == "administration" then
                    Admin() -- open category

                end
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
        { label = "list of players", value = 'players', desc = "test" },
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
                local players = GetPlayers()
                for k, v in pairs(players) do
                    PlayerList()
                end

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
            subtext  = "PLAYER LIST",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'Admin',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            else
                local players = GetPlayers()
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
        { label = "kick", value = 'kick', desc = "Kick the player" },
        { label = "freeze", value = 'freeze', desc = "freeze " .. Player.name },
        { label = "unfreeze", value = 'unfreeze', desc = "unfreeze the player" },
        { label = "ban", value = 'ban', desc = "Ban player" },
        { label = "spectate", value = 'spectate', desc = "spectate player" },
        { label = "revive", value = 'revive', desc = "revive player" },
        { label = "heal", value = 'heal', desc = "heal player" },
        { label = "goto", value = 'goto', desc = "Go to player" },
        { label = "bring", value = 'bring', desc = "Bring player" },
        { label = "warn", value = 'warn', desc = "Warn player with message" },
    }


    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = GetPlayerName(PlayerId()),
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
