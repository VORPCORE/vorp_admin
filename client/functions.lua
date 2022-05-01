---------------------------------------------------------------------------------------------------
--------------------------------------- FUNCTIONS -------------------------------------------------

--close menu
function Closem()
    MenuData.CloseAll()
    if Inmenu then
        Inmenu = false
    end
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
        { label = "test", value = 'test', desc = "test" },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubTitle"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu',
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "test" then
                TriggerEvent("vorp:TipRight", " hi there this is a test", 3000)
            end
        end,

        function(menu)
        menu.close()
    end)

end
