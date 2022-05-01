local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)
-- get group permission
RegisterServerEvent("vorp_admin:GetGroup")
AddEventHandler("vorp_admin:GetGroup", function()
    local _source = source
    local User = VorpCore.getUser(_source)
    local group = User.getGroup -- user table

    if group == "moderator" or group == "admin" then --group permission
        TriggerClientEvent("vorp_admin:OpenMenu", _source) --open menu

    end
end)
