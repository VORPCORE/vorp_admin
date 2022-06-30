-------------------------------------------------------------------------------------------------
--------------------------------- ADMIN ACTIONS -------------------------------------------------
-- administration category
local freeze = false
local lastLocation = {}
local spectating = false
local lastcoords


function Admin()
    MenuData.CloseAll()
    local elements = {
        { label = _U("playerslist"), value = 'players', desc = _U("playerlist_desc") },
        { label = _U("adminactions"), value = 'actions', desc = _U("adminactions_desc") },
        { label = _U("offLineactions"), value = 'offline', desc = _U("offlineplayers_desc") },
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

            elseif data.current.value == "actions" then
                Actions()
            elseif data.current.value == "offline" then
                OffLine()

            end
        end,
        function(menu)
            menu.close()
        end)
end

--TODO added to langs
function PlayerList()
    MenuData.CloseAll()
    local elements = {}
    local players = GetPlayers()

    for k, playersInfo in pairs(players) do

        elements[#elements + 1] = {
            label = "<span style= margin-left:160px;>" .. playersInfo.PlayerName .. "</span>",
            value = "players" .. k,
            desc = "Steam Name: <span style=color:MediumSeaGreen;> "
                .. playersInfo.name .. "</span><br>Server ID:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.serverId .. "</span><br>Player Group:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.Group .. "</span><br>Player Job:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.Job .. "</span> Grade:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.Grade .. "</span><br>Identifier:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.SteamId .. "</span><br>Player Money:  <span style=color:MediumSeaGreen;>"
                .. playersInfo.Money .. "</span><br>Player Gold:  <span style=color:Gold;>"
                .. playersInfo.Gold .. "</span><br>Player Static ID: <span style=color:Red;>"
                .. playersInfo.staticID .. "</span><br>Player Is whitelist:  <span style=color:Gold;>"
                .. playersInfo.WLstatus .. "</span><br>Player warnings:  <span style=color:Gold;>"
                .. playersInfo.warns .. "</span>", info = playersInfo
        }

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
            end
            if data.current.value then
                local player = data.current.info
              
                OpenSubAdminMenu(player)

            end
        end,
        function(menu)
            menu.close()
        end)

end

function OpenSubAdminMenu(Player)
    MenuData.CloseAll()
    local elements = {
        { label = "simple actions", value = 'simpleaction', desc = "simples actions " },
        { label = "advanced actions", value = 'advancedaction', desc = "advanced actions" },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "Player Manegement",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'PlayerList',
        },
        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "simpleaction" then
                OpenSimpleActionMenu(Player)
            elseif data.current.value == "advancedaction" then
                OpenAdvancedActions(Player)
            end
        end,
        function(menu)
            menu.close()
        end)

end

function OpenSimpleActionMenu(PlayerInfo)

    MenuData.CloseAll()
    local elements = {
        { label = _U("spectate_p"), value = 'spectate',
            desc = _U("spectate_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("freeze_p"), value = 'freeze',
            desc = _U("freeze_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("revive_p"), value = 'revive',
            desc = _U("revive_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("heal_p"), value = 'heal',
            desc = _U("heal_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("goto_p"), value = 'goto',
            desc = _U("goto_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("goback_p"), value = 'goback',
            desc = _U("goback_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("bring_p"), value = 'bring',
            desc = _U("bring_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("sendback"), value = 'sendback',
            desc = _U("sendback_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.serverId },
        { label = _U("warn_p"), value = 'warn',
            desc = _U("warn_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.staticID, info2 = PlayerInfo.Group, info3 = PlayerInfo.serverId },
        { label = _U("unwarn_p"), value = 'unwarn',
            desc = _U("unwarn_desc") .. "<span style=color:MediumSeaGreen;>" .. PlayerInfo.PlayerName .. "</span>",
            info = PlayerInfo.staticID, info2 = PlayerInfo.serverId },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = "SubMenu",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'PlayerList', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "freeze" then
                local target = data.current.info
                if target then
                    if not freeze then
                        freeze = true
                        TriggerServerEvent("vorp_admin:freeze", target, freeze)
                        TriggerEvent("vorp:TipRight", _U("switchedon"), 3000)
                    else
                        freeze = false
                        TriggerServerEvent("vorp_admin:freeze", target, freeze)
                        TriggerEvent("vorp:TipRight", _U("switchedoff"), 3000)
                    end
                end


            elseif data.current.value == "bring" then
                local target = data.current.info

                local adminCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("vorp_admin:Bring", target, adminCoords)

            elseif data.current.value == "sendback" then

                local target = data.current.info
                if lastLocation then
                    TriggerServerEvent("vorp_admin:TeleportPlayerBack", target)
                end


            elseif data.current.value == "goto" then
                local target = data.current.info

                TriggerServerEvent("vorp_admin:TpToPlayer", target)

            elseif data.current.value == "goback" then
                if lastLocation then
                    TriggerServerEvent("vorp_admin:sendAdminBack")
                end
            elseif data.current.value == "revive" then
                local target = data.current.info
                TriggerServerEvent('vorp_admin:revive', target)
            elseif data.current.value == "heal" then
                local target = data.current.info
                TriggerServerEvent('vorp_admin:heal', target)
            elseif data.current.value == "warn" then
                local staticID = data.current.info
                local targetGroup = data.current.info2
                local target = data.current.info3
                local status = "warn"
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "textarea",
                    button = _U("confirm"), -- button name
                    placeholder = "Reason for warn", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "WARN PLAYER", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{10,100}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 10 max 100 chars dont use dot or commas", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local reason = tostring(result)
                    if reason ~= "" then
                        if targetGroup ~= "user" then
                            TriggerEvent("vorp:TipRight", "you cant warn staff staff", 4000)
                        else

                            TriggerServerEvent("vorp_admin:warns", target, status, staticID, reason)
                        end

                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

            elseif data.current.value == "unwarn" then
                local staticID = data.current.info
                local target = data.current.info2
                local status = "unwarn"
                TriggerServerEvent("vorp_admin:warns", target, status, staticID)
            elseif data.current.value == "spectate" then
                local target = data.current.info
                TriggerServerEvent("vorp_admin:spectate", target)

            end
        end,

        function(menu)
            menu.close()
        end)

end

function OpenAdvancedActions(Player)
    MenuData.CloseAll()
    local elements = {
        { label = _U("kick_p"), value = 'kick',
            desc = _U("kick_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.Group, info2 = Player.serverId },
        { label = _U("ban_p"), value = 'ban',
            desc = _U("ban_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.staticID, info2 = Player.Group, info3 = Player.serverId },
        { label = "unban", value = 'unban',
            desc = _U("unban_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.staticID },
        { label = _U("respawn_p"), value = 'respawn',
            desc = _U("respawn_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId },
        { label = "whitelist", value = 'whitelist',
            desc = _U("whitelist_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId, info2 = Player.staticID },
        { label = "unwhitelist", value = 'unwhitelist',
            desc = _U("unwarn_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId, info2 = Player.staticID },
        { label = "setjob", value = 'setjob',
            desc = _U("setjob_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId },
        { label = "setgroup", value = 'setgroup',
            desc = _U("setgroup_desc") .. "<span style=color:MediumSeaGreen;>" .. Player.PlayerName .. "</span>",
            info = Player.serverId },
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

            if data.current.value == "respawn" then
                local target = data.current.info
                TriggerServerEvent("vorp_admin:respawnPlayer", target)
            elseif data.current.value == "kick" then
                local targetGroup = data.current.info
                local targetID = data.current.info2
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "Reason for kick", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "KICK PLAYER", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{10,100}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 10 max 100 chars dont use dot or commas", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local reason = tostring(result)
                    if reason ~= "" then
                        if targetGroup ~= "user" then
                            TriggerEvent("vorp:TipRight", "you cant kick staff", 4000)
                        else

                            TriggerServerEvent("vorp_admin:kick", targetID, reason)
                        end

                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)


            elseif data.current.value == "ban" then
                local group = data.current.info2
                local staticID = data.current.info
                local target = data.current.info3

                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = " example 1d is 1 day", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "BAN PLAYER", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{2,2}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 2 max 2 chars dont use dot or commas", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local time = tostring(result)
                    if time ~= "" then

                        if group ~= "user" then
                            TriggerEvent("vorp:TipRight", "you cant ban staff", 4000)
                        else
                            TriggerServerEvent("vorp_admin:BanPlayer", target, staticID, time)
                        end

                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

            elseif data.current.value == "unban" then
                local staticID = data.current.info
                TriggerEvent("vorp:unban", staticID)
            elseif data.current.value == "whitelist" then
                local target = data.current.info
                local staticID = data.current.info2
                local type = "addWhiteList"
                TriggerServerEvent("vorp_admin:Whitelist", target, staticID, type)
                TriggerEvent("vorp:TipRight", "whitelist was set", 5000)

            elseif data.current.value == "unwhitelist" then
                local target = data.current.info
                local staticID = data.current.info2
                local type = "removewhitelist"
                TriggerServerEvent("vorp_admin:Whitelist", target, staticID, type)
                TriggerEvent("vorp:TipRight", "whitelist was removed", 5000)
            elseif data.current.value == "setgroup" then
                local target = data.current.info
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "NAME", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "SET GROUP", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z]{3,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 3 max 20 only letters", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tostring(cb)

                    if result ~= "" then
                        TriggerServerEvent("vorp_admin:setGroup", target, result)
                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

            elseif data.current.value == "setjob" then
                local target = data.current.info
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "JOB  GRADE", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "SET JOB", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{3,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 3 max 20 no . no , no - no _", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tostring(cb)

                    if result ~= "" then

                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local jobname, jobgrade = tostring(splitstring[1]), tonumber(splitstring[2])
                        if jobname and jobgrade then
                            TriggerServerEvent("vorp_admin:setJob", target, jobname, jobgrade)
                        end
                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

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
        { label = _U("deletehorse"), value = 'delhorse', desc = _U("deletehorse_desc") },
        { label = _U("deletewagon"), value = 'delwagon', desc = _U("deletewagon_desc") },
        { label = _U("deletewagonradius"), value = 'delwagonradius', desc = _U("deletewagonradius_desc") },
        { label = _U("getcoords"), value = 'getcoords', desc = _U("getcoords_desc") },

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

            if data.current.value == "delhorse" then
                --todo
                -- permission
                -- send to discord
                TriggerEvent("vorp:delHorse")

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
                    TriggerEvent('vorp:TipRight', _U("youdeletedWagon"), 3000)
                else
                    TriggerEvent('vorp:TipRight', _U("youneedtobeseatead"), 3000)
                end

            elseif data.current.value == "delwagonradius" then

                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "Insert a number", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "Radius", -- header
                        type = "number", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[0-9]{1,2}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = "numbers only max allowed is 2", -- if input doesnt match show this message
                        style = "border-radius: 10px; backgRound-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local radius = result

                    if radius ~= "" then
                        TriggerEvent("vorp:deleteVehicle", radius)
                    else
                        TriggerEvent('vorp:TipRight', _U("advalue"), 3000)
                    end
                end)
            elseif data.current.value == "getcoords" then
                OpenCoordsMenu()

            end

        end,

        function(menu)
            menu.close()
        end)

end

function OpenCoordsMenu()
    MenuData.CloseAll()
    local elements = {
        { label = _U("XYZ"), value = 'v2', desc = _U("copyclipboardcoords_desc") },
        { label = _U("vector3"), value = 'v3', desc = _U("copyclipboardvector3_desc") },
        { label = _U("vector4"), value = 'v4', desc = _U("copyclipboardvector4_desc") },
        { label = _U("heading"), value = 'heading', desc = _U("copyclipboardheading_desc") },



    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("getcoords"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'Actions', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value then
                local DataCoords = data.current.value
                CopyToClipboard(DataCoords)
            end

        end,

        function(menu)
            menu.close()
        end)

end

--to test
function OffLine()
    MenuData.CloseAll()
    local elements = {
        { label = "BAN/UNBAN", value = 'bans',
            desc = "type = ban/unban<br> StaticID = number NOT server ID <br> Time example 1h,1d,1w,1m,1y permaban 0 <br>DONT USE IF TYPE IS UNBAN" },
        { label = "WHITE/UNWHITE", value = 'whites',
            desc = " type = whitelist/unwhitelist <br> StaicID = number<br> check discord to get his static ID or databse" },
        { label = "WARN/UNWARN", value = 'warn', desc = _U("warn_desc") },

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("getcoords"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'Admin',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end

            if data.current.value == "bans" then

                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "TYPE STATICID *TIME", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "BAN/UNBAN", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{1,10}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 1 max 20 no . no , no - no _", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = cb
                    if result ~= "" then

                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local type, StaticID, time = tostring(splitstring[1]), tonumber(splitstring[2]),
                            tostring(splitstring[3])

                        if type == "ban" then
                            if StaticID and time then
                                TriggerEvent("vorp:ban", StaticID, time) -- need to test
                            end
                        elseif type == "unban" then
                            TriggerEvent("vorp:unban", StaticID)
                        else
                            TriggerEvent("vorp:TipRight", " incorrect type")
                        end

                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

            elseif data.current.value == "whites" then
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "TYPE STATICID", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "WHITE/UNWHITE", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[0-9 ]{1,10}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 1 max 20 no . no , no - no _", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = cb
                    if result ~= "" then
                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local type, StaticID = tostring(splitstring[1]), tonumber(splitstring[2])
                        if type and StaticID then -- if empty dont run
                            if type == "whitelist" then
                                TriggerEvent("vorp:whitelistPlayer", StaticID)
                            elseif type == "unwhitelist" then
                                TriggerEvent("vorp:unwhitelistPlayer", StaticID)
                            else
                                TriggerEvent("vorp:TipRight", "incorrect")
                            end
                        end
                    else
                        TriggerEvent("vorp:TipRight", "its empty?")
                    end
                end)
            elseif data.current.value == "warns" then
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "textarea",
                    button = _U("confirm"), -- button name
                    placeholder = "TYPE STATICID", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = "WARN/UNWARN", -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[A-Za-z0-9 ]{10,100}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = " min 10 max 100 chars dont use dot or commas", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
                    local result = tostring(cb)
                    if result ~= "" then

                        local splitstring = {}
                        for i in string.gmatch(result, "%S+") do
                            splitstring[#splitstring + 1] = i
                        end
                        local type, StaticID = tostring(splitstring[1]), tonumber(splitstring[2])

                        if type and StaticID then

                            if type == "warn" then
                                TriggerEvent("vorp:warn", StaticID)
                            elseif type == "unwarn" then
                                TriggerEvent("vorp:unwarn", StaticID)
                            else
                                TriggerEvent("vorp:TipRight", "incorrect")
                            end
                        else
                            TriggerEvent("vorp:TipRight", "missing one argument add type and staticID")
                        end

                    else
                        TriggerEvent("vorp:TipRight", "empty")
                    end
                end)

            end

        end,

        function(menu)
            menu.close()
        end)

end

RegisterNetEvent("vorp_admin:Freezeplayer")
AddEventHandler("vorp_admin:Freezeplayer", function(state)
    FreezeEntityPosition(PlayerPedId(), state)
end)

RegisterNetEvent("vorp_admin:respawn", function(target)
    Wait(50)
    DoScreenFadeOut(1000)
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(1000)
    DoScreenFadeIn(4000)
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerEvent('vorp:ShowBottomRight', "Please revise our rules!", 10000)
end)


RegisterNetEvent("vorp_sdmin:spectatePlayer")
AddEventHandler("vorp_sdmin:spectatePlayer", function(target, targetCoords)
    local admin = PlayerPedId()
    local playerIdx = GetPlayerFromServerId(tonumber(target))
    local ped = GetPlayerPed(playerIdx)

    if not spectating then
        DoScreenFadeOut(2000)
        lastcoords = GetEntityCoords(admin)
        SetEntityVisible(admin, false)
        SetEntityCanBeDamaged(admin, false)
        SetEntityInvincible(admin, true)
        SetEntityCoords(admin, targetCoords.x + 15, targetCoords.y + 15, targetCoords.z)
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        AttachCamToEntity(Camera, ped, 0.0, -2.0, 1.0, false)
        SetCamActive(Camera, true)
        RenderScriptCams(true, true, 1, true, true)
        Wait(1000)
        DoScreenFadeIn(2000)
        spectating = true
    else
        DoScreenFadeOut(2000)
        RenderScriptCams(true, false, 1, true, true)
        DestroyCam(Camera, true)
        DestroyAllCams()
        SetEntityCoords(admin, lastcoords.x, lastcoords.y, lastcoords.z - 1)
        SetEntityVisible(admin, true)
        SetEntityCanBeDamaged(admin, false)
        SetEntityInvincible(admin, true)
        Wait(1000)
        DoScreenFadeIn(4000)
        spectating = false
    end

end)
