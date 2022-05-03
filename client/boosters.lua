VORPBooster = {}

VORPBooster.Boost = function()
    MenuData.CloseAll()
    local elements = {
        { label = "God mode", value = 'god', desc = "God mode protect you against every element " },
        { label = "Noclip mode", value = 'noclip', desc = "No clip makes you invisible " },
        { label = "Gold cores", value = 'Gold', desc = "Gives you golden cores " },

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
            if data.current.value == "god" then

            end
        end,

        function(menu)
        menu.close()
    end)

end
