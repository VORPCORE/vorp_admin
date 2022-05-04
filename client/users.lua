------------------------------------------ USERS MENU ------------------------------------------------
VORPUsers = {}

VORPUsers.OpenUsersMenu = function()
    MenuData.CloseAll()
    local elements = {
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


        end,

        function(data, menu)
        menu.close()

    end)
end
