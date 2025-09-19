local T = Translation.Langs[Config.Lang]
local active = false
---------------------------------------------------------------------------------------------------
---------------------------------- DEV TOOLS ------------------------------------------------------

local function LoadModel(ped)
    if not IsModelInCdimage(ped) then
        print("invalid model")
        return
    end

    if not HasModelLoaded(ped) then
        RequestModel(ped, false)
        repeat Wait(0) until HasModelLoaded(ped)
    end
end

local devAimEnabled = false
local laserThreadRunning = false
local StartDevLaserLoop -- forward declaration

local function ToggleDevLaser()
    devAimEnabled = not devAimEnabled
    if devAimEnabled then
        TriggerEvent("vorp:TipRight", "Dev Laser ON (aim at an entity)", 3000)
        StartDevLaserLoop()
    else
        -- graceful stop: loop will exit on next tick
        TriggerEvent("vorp:TipRight", "Dev Laser OFF", 2500)
    end
end


function OpenDevTools()
    MenuData.CloseAll()
    local elements = {
        { label = T.Menus.MainDevToolsOptions.spawnPedWithList,    value = 'pedlist',    desc = T.Menus.MainDevToolsOptions.spawnPedWithList_desc },
        { label = T.Menus.MainDevToolsOptions.spawnPedWithInput,   value = 'spawnped',   desc = T.Menus.MainDevToolsOptions.spawnPedWithInput_desc },
        { label = T.Menus.MainDevToolsOptions.coordsMenu,          value = 'getcoords',  desc = T.Menus.MainDevToolsOptions.coordsMenu_desc },
        { label = T.Menus.MainDevToolsOptions.spawnWagonWithInput, value = 'spawnwagon', desc = T.Menus.MainDevToolsOptions.spawnWagonWithInput_desc },
        { label = T.Menus.MainDevToolsOptions.spawnWagonWithList,  value = 'wagonlist',  desc = T.Menus.MainDevToolsOptions.spawnWagonWithList_desc },
        { label = T.Menus.MainDevToolsOptions.objectMenu,          value = 'delobject',  desc = T.Menus.MainDevToolsOptions.objectMenu_desc },
        { label = T.Menus.MainDevToolsOptions.imapViwer,           value = 'imap',       desc = T.Menus.MainDevToolsOptions.imapViwer_desc },
        { label = T.Menus.MainDevToolsOptions.scenarioHashViwer,   value = 'scenario',   desc = T.Menus.MainDevToolsOptions.scenarioHashViwer_desc },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'OpenDevTools',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleDevTools,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'OpenMenu'
        },
        function(data, menu)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value == "spawnped" then
                MenuData.CloseAll()
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.MainDevToolsOptions.SpawnPedInput.placeholder, T.Menus.MainDevToolsOptions.SpawnPedInput.title, "text",
                    T.Menus.MainDevToolsOptions.SpawnPedInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local ped = tostring(result)
                    if ped ~= "" then
                        LoadModel(ped)
                        local offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
                        local npc = CreatePed(joaat(ped), offset.x, offset.y, offset.z, 0.0, true, true, true, false)
                        repeat Wait(0) until DoesEntityExist(npc)

                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, npc, 1, 0)
                        SetModelAsNoLongerNeeded(ped)
                        SetEntityAsNoLongerNeeded(npc)
                    else
                        TriggerEvent('vorp:TipRight', T.Notify.empty, 3000)
                    end
                end)
                return
            end

            if data.current.value == "pedlist" then
                return SpawnPeds("peds")
            end

            if data.current.value == "wagonlist" then
                return SpawnPeds("wagons")
            end

            if data.current.value == "delobject" then
                return OpenObjMenu()
            end

            if data.current.value == "getcoords" then
                return OpenCoordsMenu()
            end

            if data.current.value == "imap" then
                return ExecuteCommand("imapview")
            end

            if data.current.value == "scenario" then
                active = not active
                while active do
                    Wait(1000)
                    local ped = PlayerPedId()
                    local retval = IsPedUsingAnyScenario(ped)
                    if retval then
                        local hash = Citizen.InvokeNative(0x569F1E1237508DEB, ped)
                        print("scenario Hash", hash)
                    end
                end
            end

            if data.current.value == "spawnwagon" then
                MenuData.CloseAll()
                local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm,
                    T.Menus.MainDevToolsOptions.SpawnWagonInput.placeholder,
                    T.Menus.MainDevToolsOptions.SpawnWagonInput.title, "text",
                    T.Menus.MainDevToolsOptions.SpawnWagonInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local wagon = tostring(result)
                    local player = PlayerPedId()
                    local playerCoords = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0)
                    if wagon ~= "" then
                        LoadModel(wagon)
                        local Wagon = CreateVehicle(wagon, playerCoords.x, playerCoords.y, playerCoords.z, 0, true, true, true)
                        repeat Wait(0) until DoesEntityExist(Wagon)
                        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, Wagon, 1, 0)
                        SetPedIntoVehicle(player, Wagon, -1)
                        SetModelAsNoLongerNeeded(wagon)
                        SetEntityAsNoLongerNeeded(Wagon)
                    else
                        TriggerEvent('vorp:TipRight', T.Notify.empty, 3000)
                    end
                end)
            end
        end,
        function(data, menu)
            menu.close()
        end)
end

function SpawnPeds(action)
    MenuData.CloseAll()
    local elements = {}
    if action == "peds" then
        for _, value in ipairs(Peds) do
            elements[#elements + 1] = {
                label = value,
                value = value,
                desc = T.Menus.MainDevToolsOptions.spawnPeds_desc
            }
        end
    elseif action == "wagons" then
        for _, value in ipairs(Vehicles) do
            elements[#elements + 1] = {
                label = value,
                value = value,
                desc = T.Menus.MainDevToolsOptions.spawnVehicle_desc
            }
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'SpawnPeds',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleDevTools,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'OpenMenu'
        },
        function(data, menu)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value then
                local player = PlayerPedId()
                local playerCoords = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0)
                LoadModel(data.current.value)
                if action == "peds" then
                    local npc = CreatePed(joaat(data.current.value), playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, true, false, false)
                    repeat Wait(0) until DoesEntityExist(npc)
                    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, npc, true, 0) -- variation
                else
                    local Wagon = CreateVehicle(joaat(data.current.value), playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, true)
                    repeat Wait(0) until DoesEntityExist(Wagon)
                    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, Wagon, true, 0)
                    SetPedIntoVehicle(player, Wagon, -1)
                end
                SetModelAsNoLongerNeeded(data.current.value)
            end
        end,
        function(data, menu)
            menu.close()
        end)
end

function OpenObjMenu()
    MenuData.CloseAll()
    local player = PlayerPedId()
    local elements = {
        { label = T.Menus.SubDevToolsOptions.printModel,  value = 'print',     desc = T.Menus.SubDevToolsOptions.printModel_desc },
        { label = T.Menus.SubDevToolsOptions.deleteModel, value = 'del',       desc = T.Menus.SubDevToolsOptions.deleteModel_desc },
        { label = T.Menus.SubDevToolsOptions.coordsMenu,  value = 'getcoords', desc = T.Menus.SubDevToolsOptions.coordsMenu_desc },
        { label = T.Menus.SubDevToolsOptions.devtoolOn,  value = 'devlaser',  desc = T.Menus.SubDevToolsOptions.devtool_desc },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'OpenObjMenu',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleDevTools,
            align    = Config.AlignMenu,
            elements = elements,
            lastmenu = 'Actions', -- Go back
        },

        function(data)
            if data.current == "backup" then
                return _G[data.trigger]()
            end

            if data.current.value == "print" then
                local coords = GetEntityCoords(player)
                local closestObject, distance = GetClosestObject(coords)
                local objectCoords = GetEntityCoords(closestObject)
                local model = GetEntityModel(closestObject)
                print(T.Notify.closesObject .. " " .. model, objectCoords)
                TriggerEvent("vorp:TipRight", T.Notify.closesObject .. " " .. model, 6000)

            elseif data.current.value == "del" then
                local coords = GetEntityCoords(player)
                local closestObject, distance = GetClosestObject(coords)
                TriggerEvent("vorp:TipRight", T.Notify.closesObject .. " " .. closestObject, 4000)
                DeleteObject(closestObject)

            elseif data.current.value == "getcoords" then
                OpenCoordsMenu()

            elseif data.current.value == "devlaser" then
                ToggleDevLaser()
            end
        end,

        function(menu)
            menu.close()
        end)
end

---------------------------------------------------------------------------------------------------
-- DEV SPHERE AIM: shows small sphere at raycast hit + entity info + hotkey copy coords
--   /devlaser  → toggle ON/OFF
--   H          → copy entity info
--   G          → copy vector3 coords of last hit
---------------------------------------------------------------------------------------------------
local lastHit = { coords = nil, entity = nil }
local lastOutlined = nil

-- build hash->name dictionary з datapeds.lua
local PedModelsByHash = {}
if Peds then
    for _, model in ipairs(Peds) do
        PedModelsByHash[GetHashKey(model:lower())] = model
    end
end

-- build hash->name dictionary з dataprops.lua
local PropModelsByHash = {}
if Props then
    for _, model in ipairs(Props) do
        PropModelsByHash[GetHashKey(model:lower())] = model
    end
end

-- Draw text
local function DrawText2D(txt, x, y, scale, r, g, b, a)
    local str = CreateVarString(10, "LITERAL_STRING", txt)
    SetTextFontForCurrentCommand(0)
    SetTextScale(scale, scale)
    SetTextColor(r or 255, g or 255, b or 255, a or 255)
    SetTextCentre(true)
    DisplayText(str, x, y)
end

-- Rotation → direction
local function RotationToDirection(rot)
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local cosx = math.cos(x)
    return vector3(-math.sin(z) * cosx, math.cos(z) * cosx, math.sin(x))
end

-- Start raycast from eyes
local function GetEyesOrigin(ped)
    return GetPedBoneCoords(ped, 21030, 0.0, 0.05, 0.02) -- SKEL_Head
end

-- Copy helper
local function CopyToClipboard(str)
    local ok = pcall(function() SendNUIMessage({ string = str }) end)
    if ok then
        TriggerEvent("vorp:TipRight", "Copied to clipboard", 2000)
    else
        TriggerEvent("chat:addMessage", { args = { "^2COPY", str } })
        TriggerEvent("vorp:TipRight", "Copied text printed to console", 2500)
        print(str)
    end
end

function StartDevLaserLoop()
    if laserThreadRunning then return end
    laserThreadRunning = true

    CreateThread(function()
        while devAimEnabled do
            Wait(0)

            local ped   = PlayerPedId()
            local start = GetEyesOrigin(ped)
            local dir   = RotationToDirection(GetGameplayCamRot(2))
            local dest  = start + (dir * 60.0)

            -- laser
            DrawLine(start.x, start.y, start.z, dest.x, dest.y, dest.z, 255, 25, 25, 255)

            -- raycast
            local ray = StartShapeTestRay(start.x, start.y, start.z, dest.x, dest.y, dest.z, -1, ped, 0)
            local _, hit, endCoords, _, entityHit = GetShapeTestResult(ray)

            local info = ("Coords: %.2f, %.2f, %.2f"):format(endCoords.x, endCoords.y, endCoords.z)
            lastHit.coords = endCoords
            lastHit.entity = nil

            if hit == 1 and entityHit ~= 0 and DoesEntityExist(entityHit) then
                lastHit.entity = entityHit
                local model     = GetEntityModel(entityHit)
                local modelName = PedModelsByHash[model] or PropModelsByHash[model] or "Unknown"
                local ec        = GetEntityCoords(entityHit)
                local heading   = GetEntityHeading(entityHit)
                local rot       = GetEntityRotation(entityHit)

                info = ("Coords: %.2f, %.2f, %.2f\nModel Hash: %s\nModel Name: %s\nHeading: %.2f\nRotation: %.2f, %.2f, %.2f")
                    :format(ec.x, ec.y, ec.z, tostring(model), modelName, heading, rot.x, rot.y, rot.z)

                -- red cube marker at hit
                DrawBox(
                    endCoords.x - 0.03, endCoords.y - 0.03, endCoords.z - 0.03,
                    endCoords.x + 0.03, endCoords.y + 0.03, endCoords.z + 0.03,
                    255, 50, 50, 200
                )
            end

            -- HUD text
            DrawText2D(info, 0.5, 0.80, 0.40, 255, 255, 255, 235)
            DrawText2D("Press H = copy entity info | Press G = copy vector3(x, y, z)", 0.5, 0.92, 0.36, 255, 200, 200, 235)

            -- H: copy full info (only if entity)
            if IsControlJustPressed(0, 0x24978A28) and lastHit.entity then
                CopyToClipboard(info)
            end
            -- G: copy just vector3
            if IsControlJustPressed(0, 0x760A9C6F) and lastHit.coords then
                local c = lastHit.coords
                CopyToClipboard(("vector3(%.2f, %.2f, %.2f)"):format(c.x, c.y, c.z))
            end
        end

        -- cleanup after toggle OFF
        laserThreadRunning = false
        lastHit.coords, lastHit.entity = nil, nil
    end)
end
-- =================== /DEV LASER / INSPECT ===================== --