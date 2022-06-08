----------------------------------------------------------------------------
---------------------------------- BOOSTERS --------------------------------
local god = false
local player
local goldenCores = false
local infiniteammo = false
function Boost()
    MenuData.CloseAll()
    player = PlayerPedId()
    local elements = {
        { label = "god Mode", value = 'god', desc = _U("godMode_desc") },
        { label = "noclip Mode", value = 'noclip', desc = _U("noclipMode_desc") },
        { label = "golden Cores", value = 'goldcores', desc = _U("goldCores_desc") },
        { label = "infinite ammo", value = 'infiniteammo', desc = _U("infammo_desc") }

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
                    TriggerEvent('vorp:TipRight', "god mode on", 3000)


                    SetEntityCanBeDamaged(player, false)
                    SetEntityInvincible(PlayerId(), true)
                    SetPedConfigFlag(player, 2, true) -- no critical hits
                    SetPedCanRagdoll(player, false)
                    SetPedCanBeTargetted(player, false)
                    Citizen.InvokeNative(0x5240864E847C691C, player, false) --set ped can be incapacitaded
                    SetPlayerInvincible(PlayerId(), true)
                    SetPlayerInvincible(NetworkGetPlayerIndexFromPed(player), true)
                    Citizen.InvokeNative(0xFD6943B6DF77E449, player, false) -- set ped can be lassoed
                else
                    god = false
                    TriggerEvent('vorp:TipRight', "god mode off", 3000)
                    SetEntityCanBeDamaged(player, true)
                    SetEntityInvincible(player, false)
                    SetPedConfigFlag(player, 2, false)
                    SetPedCanRagdoll(player, true)
                    SetPedCanBeTargetted(player, true)
                    Citizen.InvokeNative(0x5240864E847C691C, player, true)
                    SetPlayerInvincible(PlayerId(), false)
                    Citizen.InvokeNative(0xFD6943B6DF77E449, player, true)
                end

            elseif data.current.value == "goldcores" then
                if not goldenCores then

                    goldenCores = true
                    TriggerEvent('vorp:TipRight', "switch on", 3000)
                    -- inner cores
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100)

                    --outter cores
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 5000.0)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 5000.0)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 5000.0)

                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 5000.0)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 5000.0)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 5000.0)
                else
                    goldenCores = false
                    TriggerEvent('vorp:TipRight', "switched off", 3000)
                    --inner cores
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
                    Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100)

                    --outter cores
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 0.0)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 0.0)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 0.0)

                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 0.0)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 0.0)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 0.0)
                end
            elseif data.current.value == "noclip" then
                TriggerEvent('vorp:TipRight', "not yet available", 3000)

            elseif data.current.value == "infiniteammo" then

                local _, weaponHash = GetCurrentPedWeapon(player, false, 0, false)

                if not infiniteammo then
                    infiniteammo = true
                    local unarmed = -1569615261
                    TriggerEvent("vorp:TipRight", "switched on", 3000)
                    if weaponHash == unarmed then
                        TriggerEvent("vorp:Tip", "no weapon in hand ", 3000)
                    else
                        SetPedInfiniteAmmo(player, true, weaponHash)
                    end

                else
                    infiniteammo = false
                    TriggerEvent("vorp:TipRight", "switched off", 3000)
                    SetPedInfiniteAmmo(player, false, weaponHash)
                end
            end
        end,

        function(menu)
            menu.close()
        end)

end
