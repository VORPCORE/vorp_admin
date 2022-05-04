----------------------------------------------------------------------------------------------------
------------------------------------- SERVER ------------------------------------------------------

local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)
-- get group permission
RegisterServerEvent("vorp_admin:GetGroup")
AddEventHandler("vorp_admin:GetGroup", function()
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local group = Character.group --char table
    local playername = Character.firstname .. ' ' .. Character.lastname --player char name
    --local group = User.getGroup -- user table
    -- staff menu
    if group == "moderator" or group == "admin" then --group permission
        TriggerClientEvent("vorp_admin:OpenMenu", _source) --open menu
        TriggerClientEvent("vorp:TipRight", _source, "~o~" .. playername .. " ~q~You are being monitored!", 3000)
    end
    -- user menu
    if group == "user" then
        TriggerClientEvent("vorp_admin:OpenUsersMenu", _source) --open menu if it doesnt have group
    end



end)

--get players info list
RegisterServerEvent('vorp_admin:GetPlayers')
AddEventHandler('vorp_admin:GetPlayers', function() --TODO get players info char name and last name steam license etc
    local _source = source
    local players = GetPlayers()
    local data = {}

    for _, player in ipairs(players) do
        local playerPed = GetPlayerPed(player)

        if DoesEntityExist(playerPed) then
            local coords = GetEntityCoords(playerPed)
            local User = VorpCore.getUser(player)
            local Character = User.getUsedCharacter --get player info
            local group = Character.group
            local playername = Character.firstname .. ' ' .. Character.lastname --player char name
            local job = Character.job --player job
            local identifier = Character.identifier --player steam
            local PlayerMoney = Character.money --money
            local PlayerGold = Character.gold --gold
            local JobGrade = Character.jobGrade --jobgrade

            data[tostring(player)] = {
                serverId = player,
                networkId = NetworkGetNetworkIdFromEntity(playerPed),
                x = coords.x,
                y = coords.y,
                z = coords.z,
                name = GetPlayerName(player),
                Group = group,
                PlayerName = playername,
                Job = job,
                SteamId = identifier,
                ped = playerPed,
                Money = PlayerMoney,
                Gold = PlayerGold,
                Grade = JobGrade
            }
        end
    end
    TriggerClientEvent("vorp_admin:SendPlayers", _source, data)
end)
