------------------------------------------------------------------------------------------------------
------------------------------------------ USERS MENU ------------------------------------------------
local VORPNotify = {}

TriggerEvent("getCore", function(core)
    VORPNotify = core
end)

function OpenUsersMenu()
    MenuData.CloseAll()
    local elements = {
        { label = "Scoreboard", value = 'scoreboard', desc = " list of online players" },
        { label = "Report", value = 'report', desc = "Report Options" },
        { label = "request staff", value = 'requestStaff', desc = "Request staff presence" },
        { label = "create ticket", value = 'ticket', desc = "add a ticket in discord" },
        { label = "show My Info", value = 'showinfo', desc = " show your character info" },
        { label = "show Jobs Online", value = 'showjobs', desc = "show jobs online" },
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

                VORPNotify.displayRightTip(" not yet available", 4000)
                
            elseif data.current.value == "requeststaff" then

                VORPNotify.displayRightTip(" not yet available", 4000)
            elseif data.current.value == "ticket" then

                VORPNotify.displayRightTip(" not yet available", 4000)
            elseif data.current.value == "showinfo" then

                VORPNotify.displayRightTip(" not yet available", 4000)
            elseif data.current.value == "showjobs" then

                VORPNotify.displayRightTip(" not yet available", 4000)
            end


        end,

        function(data, menu)
            menu.close()

        end)
end

function ScoreBoard()
    MenuData.CloseAll()
    local elements = {
    }

    local players = GetPlayers()
    for key, playersInfo in pairs(players) do

        elements[#elements + 1] = {
            label = "<span style= margin-left:160px;>" .. playersInfo.PlayerName .. "</span>",
            value = "players",
            desc = "</span><br>Server ID:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.serverId ..
                "</span><br>Player Group:  <span style=color:MediumSeaGreen;>" ..
                playersInfo.Group ..
                "</span><br>Player Job: <span style=color:MediumSeaGreen;> " .. playersInfo.Job .. ""
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
    local myInput = {
        type = "enableinput", -- dont touch
        inputType = "textarea",
        button = "Confirm", -- button name
        placeholder = "Your message", --placeholdername
        style = "block", --- dont touch
        attributes = {
            inputHeader = "REPORT SITUATION", -- header
            type = "text", -- inputype text, number,date.etc if number comment out the pattern
            pattern = "[A-Za-z ]{5,10}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
            title = "Must only contain numbers.", -- if input doesnt match show this message
            style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
        }
    }

    TriggerEvent("vorpinputs:advancedInput", myInput, function(result)
        local message = result
        print(message)
        -- send to discord
        -- send as a notification for all available staff
        -- send chat message for all available staff
    end)

end
