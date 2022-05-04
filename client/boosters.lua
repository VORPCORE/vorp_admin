----------------------------------------------------------------------------
---------------------------------- BOOSTERS --------------------------------
VORPBooster = {}

VORPBooster.Boost = function()
    MenuData.CloseAll()
    local elements = {
        { label = _U("godMode"), value = 'god', desc = _U("godMode_desc") },
        { label = _U("noclipMode"), value = 'noclip', desc = _U("noclipMode_desc")},
        { label = _U("goldCores"), value = 'gold', desc = _U("goldCores_desc") }

    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("Boosters"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu'
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()

            end
            if data.current.value == "god" then
               -- run code
            end
        end,

        function(menu)
        menu.close()
    end)

end
