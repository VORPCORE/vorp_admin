------------------------------------------------------------------------------------
------------------------------- CLIENT ---------------------------------------------
local Key = Config.Key
local CanOpen = Config.CanOpenMenuWhenDead
local Inmenu

-- get menu
TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

AddEventHandler('menuapi:closemenu', function()
    Inmenu = false
end)

-- close menu
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local player = PlayerPedId()
        ClearPedTasksImmediately(player, true, true) -- clear tasks
        MenuData.CloseAll() --close menu
    end
end)

--check if can open menu
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId() --player
        local isDead = IsPedDeadOrDying(player) -- is dead so admins dont revive them selves unless they have permissions

        if CanOpen then
            if IsControlJustPressed(0, Key) and not Inmenu then

                TriggerServerEvent("vorp_admin:GetGroup") -- check permission

            end
        else
            if IsControlJustPressed(0, Key) and not isDead and not Inmenu then

                TriggerServerEvent("vorp_admin:GetGroup") -- check permission
            end
        end

        Citizen.Wait(10)
    end
end)


--Open menu
RegisterNetEvent("vorp_admin:OpenMenu")
AddEventHandler("vorp_admin:OpenMenu", function()
    MenuData.CloseAll()
    OpenMenu()
end)


RegisterNetEvent("vorp_admin:OpenUsersMenu")
AddEventHandler("vorp_admin:OpenUsersMenu", function()
    MenuData.CloseAll()
    VORPUsers.OpenUsersMenu()
end)
