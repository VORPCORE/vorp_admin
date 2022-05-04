------------------------------------------ USERS MENU ------------------------------------------------


function OpenUsersMenu()
    MenuData.CloseAll()
    local elements = {
        { label = "Scoreboard", value = 'scoreboard', desc = " list of online players" },
        { label = "Report", value = 'report', desc = "" },
        { label = "request staff", value = 'requestStaff', desc = "" },
        { label = "create ticket", value = 'ticket', desc = "" },
        { label = "show My Info", value = 'showinfo', desc = "" },
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
            end

            if data.current.value == "report" then
                Report()

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
    for k, v in pairs(players) do

        table.insert(elements,
            {
            label = "<span style= margin-left:160px;>" .. v.PlayerName .. "</span>",
            value = "players",
            desc = "</span><br><span>Server ID: "
                .. v.serverId .. "</span><br><span>Player Group: "
                .. v.Group .. "</span><br><span>Player Job: "
                .. v.Job .. ""
        })
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

local myInput = {
    type = "enableinput", -- dont touch

    button = "Confirm", -- button name
    placeholder = "Your message", --placeholdername
    style = "block", --- dont touch
    attributes = {
        inputHeader = "REPORT SITUATION", -- header
        type = "text", -- inputype text, number,date.etc if number comment out the pattern
        pattern = "[A-Za-z]+", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
        title = "Must only contain numbers.", -- if input doesnt match show this message
        style = "border-radius: 10px; background-color: white; border:none;" -- style  the inptup
    }
}



function Report()

    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(cb)
        local message = cb
        if message ~= nil then
            local player = GetPlayerServerId(PlayerId()) -- todo add player name
            Wait(50)
            ShowReport(tostring(message), player) --testing
        end
    end)


end

--testing
function ShowReport(message, player)

    MenuData.CloseAll()
    local elements = {
        { label = player, value = 'showinfo', desc = message }, -- need to make it to stay for every restart. do i need to add to database ? also need to add message as a text area
    }



    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = "Report",
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
