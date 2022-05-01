------------------------------------------------------------------------------------
------------------------------- CLIENT ---------------------------------------------
local Key = Config.Key
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

--open menu
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId() --player
        local isDead = IsPedDeadOrDying(player) -- is dead

        if IsControlJustPressed(0, Key) and not isDead and not Inmenu then
            print(Key)
            TriggerServerEvent("vorp_admin:GetGroup") -- check permission
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
