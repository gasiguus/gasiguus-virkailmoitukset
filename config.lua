Config = {}


-- Set true to the one you want to use.
Config.GunshotAlert = true -- When someone shoots, the police are notified

Config.CarRobAlert = true -- When someone rob car, the police are notifed






RegisterNetEvent('gg_policeinform:notify')
AddEventHandler('gg_policeinform:notify', function(title, alert, msgType)	
    if not msgType then
        lib.notify({
            title = title,
            description = alert,
            type = 'inform',
            icon = 'gun',
            iconColor = '#C53030',
        })
    else
        lib.notify({
            title = title,
            description = alert,
            type = msgType,
            icon = 'gun',
            iconColor = '#C53030',
        })
    end
end)
