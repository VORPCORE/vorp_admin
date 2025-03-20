----------------------------------------------------------------------------
---------------------------------- BOOSTERS --------------------------------
local god = false

local goldenCores = false
local infiniteammo = false
local NoClipActive = false
local invis = false
local T = Translation.Langs[Config.Lang]

function GODmode()
    local player = PlayerPedId()
    if not god then
        TriggerEvent('vorp:TipRight', T.Notify.switchedOn, 3000)
        SetEntityCanBeDamaged(player, false)
        SetEntityInvincible(player, true)
        SetPedConfigFlag(player, 2, true) -- No critical hits
        SetPedCanRagdoll(player, false)
        SetPedCanBeTargetted(player, false)
        Citizen.InvokeNative(0x5240864E847C691C, player, false) -- Set ped can be incapacitaded
        SetPlayerInvincible(player, true)
        Citizen.InvokeNative(0xFD6943B6DF77E449, player, false) -- Set ped can be lassoed
        TriggerServerEvent("vorp_admin:GodMode")                -- log
        god = true
    else
        TriggerEvent('vorp:TipRight', T.Notify.switchedOff, 3000)
        SetEntityCanBeDamaged(player, true)
        SetEntityInvincible(player, false)
        SetPedConfigFlag(player, 2, false)
        SetPedCanRagdoll(player, true)
        SetPedCanBeTargetted(player, true)
        Citizen.InvokeNative(0x5240864E847C691C, player, true)
        SetPlayerInvincible(PlayerId(), false)
        Citizen.InvokeNative(0xFD6943B6DF77E449, player, true)
        god = false
    end
end

function GoldenCores()
    local player = PlayerPedId()
    if not goldenCores then
        TriggerEvent('vorp:TipRight', T.Notify.switchedOn, 3000)
        -- Inner cores
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
        -- Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100) -- Dead Eye

        -- Outter cores
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 5000.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 5000.0)
        -- Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 5000.0) -- Dead Eye

        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 5000.0)
        -- Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 5000.0)-- Dead Eye
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 5000.0)
        TriggerServerEvent("vorp_admin:GoldenCores") -- log
        goldenCores = true
    else
        TriggerEvent('vorp:TipRight', T.Notify.switchedOff, 3000)
        -- Inner cores
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100)

        -- Outter cores
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 0.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 0.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 0.0)

        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 0.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 0.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 0.0)
        goldenCores = false
    end
end

function InfiAmmo()
    local player = PlayerPedId()
    local _, weaponHash = GetCurrentPedWeapon(player, false, 0, false)
    if not infiniteammo then
        infiniteammo = true
        local unarmed = -1569615261
        TriggerEvent("vorp:TipRight", T.Notify.switchedOn, 3000)
        if weaponHash == unarmed then
            TriggerEvent("vorp:Tip", T.Notify.needWeaponInHands, 3000)
        else
            SetPedInfiniteAmmo(player, true, weaponHash)
            TriggerServerEvent("vorp_admin:InfiAmmo") -- log
        end
    else
        infiniteammo = false
        TriggerEvent("vorp:TipRight", T.Notify.switchedOff, 3000)
        SetPedInfiniteAmmo(player, false, weaponHash)
    end
end

function Boost()
    MenuData.CloseAll()

    local elements = {
        { label = T.Menus.MainBoostOptions.selfGodMode,         value = 'god',          desc = T.Menus.MainBoostOptions.selfGodMode_desc },
        { label = T.Menus.MainBoostOptions.selfNoClip,          value = 'noclip',       desc = "<span>" .. T.Menus.MainBoostOptions.selfNoClip_desc .. "</span><br><span>" .. T.Menus.MainBoostOptions.move .. "</span><br><span>" .. T.Menus.MainBoostOptions.speedMode .. "</span><br>" .. T.Menus.MainBoostOptions.cammode .. "" },
        { label = T.Menus.MainBoostOptions.selfGoldCores,       value = 'goldcores',    desc = T.Menus.MainBoostOptions.selfGoldCores_desc },
        { label = T.Menus.MainBoostOptions.enabledInfinityAmmo, value = 'infiniteammo', desc = T.Menus.MainBoostOptions.enabledInfinityAmmo_desc },
        { label = T.Menus.MainBoostOptions.spawnWagon,          value = 'spawnwagon',   desc = T.Menus.MainBoostOptions.spawnWagon_desc },
        { label = T.Menus.MainBoostOptions.spawnHorse,          value = 'spawnhorse',   desc = T.Menus.MainBoostOptions.spawnHorse_desc },
        { label = T.Menus.MainBoostOptions.selfHeal,            value = 'selfheal',     desc = T.Menus.MainBoostOptions.selfHeal_desc },
        { label = T.Menus.MainBoostOptions.selfRevive,          value = 'selfrevive',   desc = T.Menus.MainBoostOptions.selfRevive_desc },
        { label = T.Menus.MainBoostOptions.selfInvisible,       value = 'invisibility', desc = T.Menus.MainBoostOptions.selfInvisible_desc },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'Boost',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleBooster,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'OpenMenu'
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "god" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Godmode")
                if AdminAllowed then
                    GODmode()
                end
            elseif data.current.value == "invisibility" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Invisibility")
                if AdminAllowed then
                    if invis == false then
                        SetEntityVisible(PlayerPedId(), false)
                        invis = true
                    elseif invis == true then
                        SetEntityVisible(PlayerPedId(), true)
                        invis = false
                    end
                end
            elseif data.current.value == "goldcores" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Golden")
                if AdminAllowed then
                    GoldenCores()
                end
            elseif data.current.value == "noclip" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.Noclip")
                if AdminAllowed then
                    if not NoClipActive then
                        EnableNoclip(player)
                        NoClipActive = true
                        VORP.NotifyObjective(T.Notify.switchedOn, -1)
                        TriggerServerEvent("vorp_admin:NoClip") -- log
                    else
                        ResetNoclip(player)
                        DisableRagdollingWhileFall()
                        NoClipActive = false
                        VORP.NotifyObjective(T.Notify.switchedOff, 5000)
                    end
                end
            elseif data.current.value == "infiniteammo" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.InfiniteAmmo")
                if AdminAllowed then
                    InfiAmmo()
                end
            elseif data.current.value == "selfrevive" then
                TriggerServerEvent('vorp_admin:ReviveSelf', "vorp.staff.SelfRevive")
            elseif data.current.value == "selfheal" then
                TriggerServerEvent('vorp_admin:HealSelf', "vorp.staff.SelfHeal")
                Config.Heal.Players()
                local horse = GetMount(PlayerPedId())
                if horse ~= 0 then
                    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, 600) -- Health
                    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, 600) -- Stamina
                end
            elseif data.current.value == "spawnhorse" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.SpawnHorse")
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.MainBoostOptions.SpawnHorseInput.placeholder, T.Menus.MainBoostOptions.SpawnHorseInput.title, "text", T.Menus.MainBoostOptions.SpawnHorseInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                    MenuData.CloseAll()
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local horse = tostring(result)
                        local playerCoords = GetEntityCoords(player) + 1
                        if horse ~= "" then
                            RequestModel(horse, false)
                            repeat Wait(0) until HasModelLoaded(horse)
                            local horse = CreatePed(joaat(horse), playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, true, false, false)
                            repeat Wait(0) until DoesEntityExist(horse)
                            Citizen.InvokeNative(0x77FF8D35EEC6BBC4, horse, 1, 0)
                            Citizen.InvokeNative(0x028F76B6E78246EB, player, horse, -1, true)
                            TriggerServerEvent("vorp_admin:spawnHorse", result) -- log
                        else
                            VORP.NotifyObjective(T.Notify.empty, 3000)
                        end
                    end)
                end
            elseif data.current.value == "spawnwagon" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.SpawnWagon")
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm,
                        T.Menus.MainBoostOptions.SpawnWagonInput.placeholder,
                        T.Menus.MainBoostOptions.SpawnWagonInput.title, "text",
                        T.Menus.MainBoostOptions.SpawnWagonInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                    MenuData.CloseAll()
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local wagon = result
                        local playerCoords = GetEntityCoords(player)
                        if wagon ~= "" then
                            RequestModel(wagon, false)
                            while not HasModelLoaded(wagon) do
                                Wait(10)
                            end
                            wagon = CreateVehicle(wagon, playerCoords.x, playerCoords.y, playerCoords.z, 0, true, true, false, false)
                            repeat Wait(0) until DoesEntityExist(wagon)
                            Citizen.InvokeNative(0x77FF8D35EEC6BBC4, wagon, 1, 0)
                            SetPedIntoVehicle(player, wagon, -1)
                            TriggerServerEvent("vorp_admin:spawnWagon", result) -- log
                        else
                            VORP.NotifyObjective(T.Notify.empty, 3000)
                        end
                    end)
                end
            end
        end,

        function(menu)
            menu.close()
        end)
end

local function DisableControls()
    DisableControlAction(0, 0xB238FE0B, true) -- Disable controls here
    DisableControlAction(0, 0x3C0A40F2, true) -- Disable controls here
end


local Prompt1 = 0
local Prompt2 = 0
local Prompt4 = 0
local Prompt6 = 0
local PromptGroup = GetRandomIntInRange(0, 0xffffff)

--PROMPTS
CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession
    FreezeEntityPosition(PlayerPedId(), false)

    local str = T.Menus.MainBoostOptions.Prompts.down .. "/" .. T.Menus.MainBoostOptions.Prompts.up

    Prompt1 = UiPromptRegisterBegin()
    UiPromptSetControlAction(Prompt1, Config.Controls.goDown)
    UiPromptSetControlAction(Prompt1, Config.Controls.goUp)
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(Prompt1, str)
    UiPromptSetEnabled(Prompt1, true)
    UiPromptSetVisible(Prompt1, true)
    UiPromptSetStandardMode(Prompt1, true)
    UiPromptSetGroup(Prompt1, PromptGroup, 0)
    UiPromptRegisterEnd(Prompt1)

    local str = T.Menus.MainBoostOptions.Prompts.speed
    Prompt2 = UiPromptRegisterBegin()
    UiPromptSetControlAction(Prompt2, Config.Controls.changeSpeed) -- shift
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(Prompt2, str)
    UiPromptSetEnabled(Prompt2, true)
    UiPromptSetVisible(Prompt2, true)
    UiPromptSetStandardMode(Prompt2, true)
    UiPromptSetGroup(Prompt2, PromptGroup, 0)
    UiPromptRegisterEnd(Prompt2)

    local str = T.Menus.MainBoostOptions.Prompts.backward .. "/" .. T.Menus.MainBoostOptions.Prompts.forward
    Prompt4 = UiPromptRegisterBegin()
    UiPromptSetControlAction(Prompt4, Config.Controls.goBackward)
    UiPromptSetControlAction(Prompt4, Config.Controls.goForward)
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(Prompt4, str)
    UiPromptSetEnabled(Prompt4, true)
    UiPromptSetVisible(Prompt4, true)
    UiPromptSetStandardMode(Prompt4, true)
    UiPromptSetGroup(Prompt4, PromptGroup, 0)
    UiPromptRegisterEnd(Prompt4)

    local str = T.Menus.MainBoostOptions.Prompts.cancel
    Prompt6 = UiPromptRegisterBegin()
    UiPromptSetControlAction(Prompt6, Config.Controls.Cancel)
    str = VarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(Prompt6, str)
    UiPromptSetEnabled(Prompt6, true)
    UiPromptSetVisible(Prompt6, true)
    UiPromptSetStandardMode(Prompt6, true)
    UiPromptSetGroup(Prompt6, PromptGroup, 0)
    UiPromptRegisterEnd(Prompt6)
end)

function ResetNoclip(ped)
    SetEntityCollision(ped, true, true)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true)
    SetEveryoneIgnorePlayer(PlayerId(), false)
    SetPedCanBeTargetted(ped, true)
    SetGameplayCamInitialHeading(0.0)
    SetPlayerLockon(PlayerId(), true)
    ClearPedTasks(ped, true, true)
end

function EnableNoclip(ped)
    ClearPedTasks(ped, true, true)
    SetGameplayCamInitialHeading(0.0)
    SetPlayerLockon(PlayerId(), false)
    SetEntityCollision(ped, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false)
    SetEveryoneIgnorePlayer(PlayerId(), true)
    SetPedCanBeTargetted(ped, false)
end

-- credits to txAdmin for the function
local function getFallImpulse(H)
    local coefficient = 1.6428571428571428
    local intercept = 3.5714285714285836
    return coefficient * H + intercept
end

function DisableRagdollingWhileFall()
    CreateThread(function()
        local ped = PlayerPedId()
        local pedHeight = GetEntityHeightAboveGround(ped)
        if pedHeight == nil or pedHeight < 4.0 then
            return
        end

        SetEntityInvincible(ped, true)
        SetRagdollBlockingFlags(ped, (1 << 9)) --RBF_FALLING
        local downForce = getFallImpulse(pedHeight)
        ApplyForceToEntity(ped, 3, 0.0, 0.0, -downForce, 0.0, 0.0, 0.0, 0, true, true, false, true, false)

        local fallAwaitLimit = 1000
        local fallAwaitStep = 25
        local fallAwaitElapsed = 0
        while not IsPedFalling(ped) do
            if fallAwaitElapsed >= fallAwaitLimit then
                SetEntityInvincible(ped, false)

                return
            end
            fallAwaitElapsed = fallAwaitElapsed + fallAwaitStep
            Wait(fallAwaitStep)
        end

        repeat
            Wait(50)
        until not IsPedFalling(ped)
        Wait(750)
        SetEntityInvincible(ped, false)
        ClearRagdollBlockingFlags(ped, (1 << 9)) --RBF_FALLIN
    end)
end

CreateThread(function()
    repeat Wait(2000) until LocalPlayer.state.IsInSession

    local index = 1
    local CurrentSpeed = Config.Speeds[index].speed
    local Label = Config.Speeds[index].label

    while true do
        local sleep = 1000

        if NoClipActive then
            sleep = 0
            local player = PlayerPedId()
            local yoff = 0.0
            local zoff = 0.0

            DisableControls()
            SetEntityVisible(player, false)

            local label = VarString(10, 'LITERAL_STRING', T.Menus.MainBoostOptions.Prompts.speed_desc .. Label .. " " .. CurrentSpeed)
            UiPromptSetActiveGroupThisFrame(PromptGroup, label, 0, 0, 0, 0)

            if IsDisabledControlJustPressed(1, Config.Controls.changeSpeed) then
                if index ~= #Config.Speeds then
                    index = index + 1
                    CurrentSpeed = Config.Speeds[index].speed
                    Label = Config.Speeds[index].label
                else
                    CurrentSpeed = Config.Speeds[1].speed
                    index = 1
                    Label = Config.Speeds[index].label
                end
            end

            if IsDisabledControlPressed(0, Config.Controls.goForward) then
                yoff = Config.Offsets.y
                SetEntityRotation(player, 0.0, 0.0, 0.0, 2, false)
                local heading = GetGameplayCamRelativeHeading()
                SetEntityHeading(player, heading)
            end

            if IsDisabledControlPressed(0, Config.Controls.goBackward) then
                yoff = -Config.Offsets.y
                SetEntityRotation(player, 0.0, 0.0, 0.0, 2, false)
                local heading = GetGameplayCamRelativeHeading()
                SetEntityHeading(player, heading)
            end

            if IsDisabledControlPressed(0, Config.Controls.goUp) then
                zoff = Config.Offsets.z
                local newPos = GetOffsetFromEntityInWorldCoords(player, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
                SetEntityCoordsNoOffset(player, newPos.x, newPos.y, newPos.z, NoClipActive, NoClipActive, NoClipActive)
            end

            if IsDisabledControlPressed(0, Config.Controls.goDown) then
                zoff = -Config.Offsets.z
                local newPos = GetOffsetFromEntityInWorldCoords(player, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
                SetEntityCoordsNoOffset(player, newPos.x, newPos.y, newPos.z, NoClipActive, NoClipActive, NoClipActive)
            end

            if IsDisabledControlPressed(0, Config.Controls.Cancel) then
                NoClipActive = false
                ResetNoclip(player)
                DisableRagdollingWhileFall()
            end


            local newPos = GetOffsetFromEntityInWorldCoords(player, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
            SetEntityCoordsNoOffset(player, newPos.x, newPos.y, newPos.z, NoClipActive, NoClipActive, NoClipActive)
        end
        Wait(sleep)
    end
end)
