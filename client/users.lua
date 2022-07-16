------------------------------------------------------------------------------------------------------
------------------------------------------ USERS MENU ------------------------------------------------
local VORP = {}

TriggerEvent("getCore", function(core)
    VORP = core
end)

function OpenUsersMenu()
    MenuData.CloseAll()
    local elements = {
        { label = _U("Scoreboard"), value = 'scoreboard', desc = _U("scoreboard_desc") },
        { label = _U("Report"), value = 'report', desc = _U("reportoptions_desc") },
        { label = _U("requeststaff"), value = 'requeststaff', desc = _U("Requeststaff_desc") },
        { label = _U("showMyInfo"), value = 'showinfo', desc = _U("showmyinfo_desc") },
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

            if data.current.value == "scoreboard" then
                ScoreBoard()
            elseif data.current.value == "report" then
                Report()
            elseif data.current.value == "requeststaff" then
                RequestStaff()
            elseif data.current.value == "showinfo" then
                VORP.NotifyRightTip(_U("notyetavailable"), 4000)
            end
        end,
        function(data, menu)
            menu.close()

        end)
end

function ScoreBoard()
    MenuData.CloseAll()
    local elements = {}

    local players = GetPlayers()
    for key, playersInfo in pairs(players) do

        if Config.showUsersInfo == "showAll" then
            ShowInfo = "</span><br>Server ID:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.serverId ..
                "</span><br>Player Group:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.Group ..
                "</span><br>Player Job: <span style=color:MediumSeaGreen;> " ..
                playersInfo.Job
        elseif Config.showUsersInfo == "showJob" then
            ShowInfo = "</span><br>Player Job: <span style=color:MediumSeaGreen;> " ..
                playersInfo.Job
        elseif Config.showUsersInfo == "showGroup" then
            ShowInfo = "</span><br>Player Group:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.Group
        elseif Config.showUsersInfo == "showID" then
            ShowInfo = "</span><br>Server ID:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.serverId
        end
        elements[#elements + 1] = {
            label = playersInfo.PlayerName,
            value = "players",
            desc = ShowInfo
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = "SCOREBOARD",
            subtext  = "Players online",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenUsersMenu', --Go back
        },
        function(data, menu)
            if data.current == "backup" then
                _G[data.trigger]()
            end

        end,

        function(data, menu)
            menu.close()

        end)
end

function ShowMyInfo()
    MenuData.CloseAll()
    local elements = {
        label = "",
        value = "",
        desc = ""
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = "SCOREBOARD",
            subtext  = "Players online",
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenUsersMenu', --Go back
        },
        function(data, menu)
            if data.current == "backup" then
                _G[data.trigger]()
            end

        end,

        function(data, menu)
            menu.close()

        end)
end

function Report()
    local player = GetPlayerServerId(tonumber(PlayerId()))

    local myInput = {
        type = "enableinput", -- dont touch
        inputType = "textarea",
        button = _U("confirm"), -- button name
        placeholder = _U("message"), --placeholdername
        style = "block", --- dont touch
        attributes = {
            inputHeader = _U("reportheader"), -- header
            type = "text", -- inputype text, number,date.etc if number comment out the pattern
            pattern = "[A-Za-z0-9 ]{10,100}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
            title = "Must only contain numbers and letters max 100 .", -- if input doesnt match show this message
            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
        }
    }



    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
        local report = tostring(result)
        if report and report ~= "" then

            if Config.ReportLogs then -- if nil dont send
                TriggerServerEvent("vorp_admin:logs", Config.ReportLogs, _U("report"),
                    _U("playerreported") .. report)
                VORP.NotifySimpleTop(_U("reportitle"), _U("reportsent"), 3000)
                TriggerServerEvent("vorp_admin:alertstaff", player)
            end
        end
    end)

end

function RequestStaff()
    MenuData.CloseAll()
    local elements = {
        { label = _U("needhelp"), value = "new", desc = _U("needhelp_desc") },
        { label = _U("foundbug"), value = "bug", desc = _U("foundbug_desc") },
        { label = _U("rulesbroken"), value = "rules", desc = _U("rulesbroken_desc") },
        { label = _U("someonecheating"), value = "cheating", desc = _U("someonecheating_desc") },

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("requestsubtitle"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenUsersMenu', --Go back
        },
        function(data, menu)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "new" then
                TriggerServerEvent("vorp_admin:requeststaff", "new")
                VORP.NotifyRightTip(_U("requestsent"), 4000)
            elseif data.current.value == "bug" then
                TriggerServerEvent("vorp_admin:requeststaff", "bug")
                VORP.NotifyRightTip(_U("requestsent"), 4000)
            elseif data.current.value == "rules" then
                TriggerServerEvent("vorp_admin:requeststaff", "rules")
                VORP.NotifyRightTip(_U("requestsent"), 4000)
            elseif data.current.value == "cheating" then
                TriggerServerEvent("vorp_admin:requeststaff", "cheating")
                VORP.NotifyRightTip(_U("requestsent"), 4000)
            end
        end,

        function(data, menu)
            menu.close()

        end)
end
