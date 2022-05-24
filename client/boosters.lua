----------------------------------------------------------------------------
---------------------------------- BOOSTERS --------------------------------
local god = false
local player

function Boost()
    player = PlayerPedId()
    MenuData.CloseAll()
    local elements = {
        { label = "godMode", value = 'god', desc = _U("godMode_desc") },
        { label = "noclipMode", value = 'noclip', desc = _U("noclipMode_desc") },
        { label = "goldCores", value = 'gold', desc = _U("goldCores_desc") }

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
                if not god then
                    god = true
                    print("god mode on")
                    SetEntityCanBeDamaged(player, false)
                    SetEntityInvincible(player, true)

                else
                    god = false
                    print("god mode off")
                    SetEntityCanBeDamaged(player, true)
                    SetEntityInvincible(player, false)

                end

            end
        end,

        function(menu)
            menu.close()
        end)

end
