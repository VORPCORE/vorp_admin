------------------------------------------------------------------------------------------------------------
---------------------------------------- TELEPORTS ---------------------------------------------------------


function Teleport()
    MenuData.CloseAll()
    local elements = {
        { label = "Tpm", value = 'tpm', desc = "teleport to marker " },
        { label = "Tp to coords", value = 'coords', desc = "teleport to coords x y z" },
        { label = "Tp to player", value = 'tpplayer', desc = "teleport you to player " },
        { label = "Tp player ", value = 'bring', desc = "Brings a player to you " },

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
            if data.current.value == "tpm" then


            end
        end,

        function(menu)
        menu.close()
    end)

end
