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
                desc = "Steam Name: <span style=color:MediumSeaGreen;> "
                    .. v.name .. "</span><br>Server ID:  <span style=color:MediumSeaGreen;>"
                    .. v.serverId .. "</span><br>Player Group:  <span style=color:MediumSeaGreen;>"
                    .. v.Group .. "</span><br>Player Job:  <span style=color:MediumSeaGreen;>"
                    .. v.Job .. "</span> Grade:  <span style=color:MediumSeaGreen;>"
                    .. v.Grade .. "</span><br>Identifier:  <span style=color:MediumSeaGreen;>"
                    .. v.SteamId .. "</span><br>Player Money:  <span style=color:MediumSeaGreen;>"
                    .. v.Money .. "</span><br>Player Gold:  <span style=color:Gold;>"
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
        { label = _U("kick_p"), value = 'kick', desc = _U("kick_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("freeze_p"), value = 'freeze', desc = _U("freeze_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("unfreeze_p"), value = 'unfreeze', desc = _U("unfreeze_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("ban_p"), value = 'ban', desc = _U("ban_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("spectate_p"), value = 'spectate', desc = _U("spectate_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("revive_p"), value = 'revive', desc = _U("revive_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("respawn_p"), value = 'respawn', desc = _U("respawn_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("heal_p"), value = 'heal', desc = _U("heal_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("goto_p"), value = 'goto', desc = _U("goto_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("bring_p"), value = 'bring', desc = _U("bring_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },
        { label = _U("warn_p"), value = 'warn', desc = _U("warn_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>" },

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
    local player = PlayerPedId()
    local elements = {
        { label = "Spawn Ped", value = 'spawnped', desc = "Spawn a ped" },
        { label = "Spawn animal", value = 'spawnanimal', desc = "Spawn an animal" },
        { label = "delete Object", value = 'delobject', desc = "Delete an object" },
        { label = "Delete Horse", value = 'delhorse', desc = "Delete a horse when sitting on one" },
        { label = "Delete wagon", value = 'delwagon', desc = "Delete a wagon when sitting on one" },




    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "SubMenu",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "delhorse" then
                --todo
                -- permission
                -- send to discord

                local mount = GetMount(player)
                if IsPedOnMount(player) then
                    DeleteEntity(mount)
                    TriggerEvent('vorp:TipRight', "you have deleted a horse", 3000)
                end
            elseif data.current.value == "delwagon" then
                --todo
                -- permission
                -- send to discord
                local wagon = GetVehiclePedIsIn(player, true)

                if IsPedInAnyVehicle(player, true) then
                    wagon = GetVehiclePedIsIn(player, true)
                end
                if DoesEntityExist(wagon) then
                    DeleteVehicle(wagon)
                    DeleteEntity(wagon)
                end
                TriggerEvent('vorp:TipRight', "you have deleted a Wagon", 3000)

            elseif data.current.value == "spawnanimal" then
                --todo
                -- permission
                -- send to discord

                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "textarea",
                    button = "Confirm", -- button name
                    placeholder = "insert hash", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "HASH", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9]{5,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = "must use only letters", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }
                MenuData.CloseAll()
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local animal = result
                    local playerCoords = GetEntityCoords(player)

                    if animal ~= nil then
                        RequestModel(animal)
                        while not HasModelLoaded(animal) do
                            Wait(10)
                        end

                        animal = CreatePed(animal, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, animal, 1, 0)
                        Wait(2000)
                        FreezeEntityPosition(animal, true)


                    end
                end)

            elseif data.current.value == "spawnped" then
                --todo
                -- permission
                -- send to discord

                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "textarea",
                    button = "Confirm", -- button name
                    placeholder = "insert hash", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "Insert Hash", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9]{5,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = "must use only letters", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }
                MenuData.CloseAll()
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local ped = result
                    local playerCoords = GetEntityCoords(player)

                    if ped ~= nil then
                        RequestModel(ped)
                        while not HasModelLoaded(ped) do
                            Wait(10)
                        end

                        ped = CreatePed(ped, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 1, 0)
                        Wait(2000)
                        FreezeEntityPosition(ped, true)
                    end
                end)
            end

        end,

        function(menu)
            menu.close()
        end)

end
