------------------------------------------------------------------------------------------------------------
---------------------------------------- TELEPORTS ---------------------------------------------------------
local lastLocation = {}
local autotpm = false
local T = Translation.Langs[Config.Lang]

function Teleport()
    MenuData.CloseAll()
    local elements = {
        { label = T.Menus.MainTeleportOptions.tpmAuto,                  value = 'autotpm',     desc = T.Menus.MainTeleportOptions.tpmAuto_desc },
        { label = T.Menus.MainTeleportOptions.tpmToMarker,              value = 'tpm',         desc = T.Menus.MainTeleportOptions.tpmToMarker_desc },
        { label = T.Menus.MainTeleportOptions.tpToCoords,               value = 'tptocoords',  desc = T.Menus.MainTeleportOptions.tpToCoords_desc },
        { label = T.Menus.MainTeleportOptions.tpToPlayer,               value = 'tptoplayer',  desc = T.Menus.MainTeleportOptions.tpToPlayer_desc },
        { label = T.Menus.MainTeleportOptions.adminGoBackLastLocation,  value = 'admingoback', desc = T.Menus.MainTeleportOptions.adminGoBackLastLocation_desc },
        { label = T.Menus.MainTeleportOptions.bringPlayer,              value = 'bringplayer', desc = T.Menus.MainTeleportOptions.bringPlayer_desc },
        { label = T.Menus.MainTeleportOptions.sendPlayerToLastLocation, value = 'sendback',    desc = T.Menus.MainTeleportOptions.sendPlayerToLastLocation_desc },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'Teleport',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleTeleport,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'OpenMenu', -- Go back
        },

        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value == "tpm" then
                local coords = GetEntityCoords(PlayerPedId())
                local waypointCoords = GetWaypointCoords()
                local waypoint = IsWaypointActive()
                if not waypoint then
                    return VORP.NotifyObjective("theres no waypoint set", 5000)
                end

                TriggerServerEvent('vorp:teleportWayPoint', "vorp.staff.WayPoint", coords, waypointCoords)
            elseif data.current.value == 'autotpm' then
                if autotpm == false then
                    autotpm = true
                    TriggerEvent('vorp:TipRight', T.Notify.switchedOn, 3000)
                    while autotpm do
                        Wait(2000)
                        TriggerServerEvent('vorp:teleportWayPoint', "vorp.staff.AutoTpm")
                    end
                else
                    TriggerEvent('vorp:TipRight', T.Notify.switchedOff, 3000)
                    autotpm = false
                end
            elseif data.current.value == "tptocoords" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.TpCoords")
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm,
                        T.Menus.MainTeleportOptions.InsertCoordsInput.placeholder,
                        T.Menus.MainTeleportOptions.InsertCoordsInput.title, "text",
                        T.Menus.MainTeleportOptions.InsertCoordsInput.errorMsg, '.*{5,60}')
                    local oldCoords = GetEntityCoords(PlayerPedId())
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local coords = result
                        local admin = PlayerPedId()
                        if coords ~= "" and coords then
                            local finalCoords = {}
                            coords = string.gsub(coords, "(vector[34])", "")
                            coords = string.gsub(coords, "[^%d%. -]", "")

                            for i in string.gmatch(coords, "%S+") do
                                finalCoords[#finalCoords + 1] = i
                            end
                            local x, y, z = tonumber(finalCoords[1]), tonumber(finalCoords[2]), tonumber(finalCoords[3])
                            DoScreenFadeOut(2000)
                            Wait(2000)
                            SetEntityCoords(admin, x, y, z, false, false, false, false)
                            DoScreenFadeIn(3000)
                            TriggerServerEvent("vorp_admin:tptocoords", oldCoords, x, y, z)
                        else
                            VORP.NotifyObjective(T.Notify.empty, 5000)
                        end
                    end)
                end
            elseif data.current.value == "tptoplayer" then
                TriggerEvent("vorpinputs:getInput", T.Menus.DefaultsInputs.confirm, T.Menus.DefaultsInputs.serverID,
                    function(result)
                        local TargetID = result
                        if TargetID ~= "" then
                            TriggerServerEvent("vorp_admin:TpToPlayer", TargetID, "vorp.staff.TpPlayer")
                        else
                            VORP.NotifyObjective(T.Notify.empty, 5000)
                        end
                    end)
            elseif data.current.value == "admingoback" then
                if lastLocation then
                    TriggerServerEvent("vorp_admin:sendAdminBack", "vorp.staff.TpPlayer")
                end
            elseif data.current.value == "bringplayer" then
                TriggerEvent("vorpinputs:getInput", T.Menus.DefaultsInputs.confirm, T.Menus.DefaultsInputs.serverID,
                    function(result)
                        local TargetID = result
                        if TargetID ~= "" and lastLocation then
                            local adminCoords = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent("vorp_admin:Bring", TargetID, adminCoords, "vorp.staff.BringPlayer", nil, TargetID)
                        else
                            VORP.NotifyObjective(T.Notify.empty, 5000)
                        end
                    end)
            elseif data.current.value == "sendback" then
                TriggerEvent("vorpinputs:getInput", T.Menus.DefaultsInputs.confirm, T.Menus.DefaultsInputs.serverID,
                    function(result)
                        local TargetID = result
                        if TargetID ~= "" and lastLocation then
                            TriggerServerEvent("vorp_admin:TeleportPlayerBack", TargetID, "vorp.staff.SendBack")
                        else
                            TriggerEvent("vorp:TipRight", T.Notify.goToPlayerFirst, 4000)
                        end
                    end)
            end
        end,

        function(menu)
            menu.close()
        end)
end
