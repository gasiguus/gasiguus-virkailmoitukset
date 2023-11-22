ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('gg_policeinform:gunshotplace')
AddEventHandler('gg_policeinform:gunshotplace', function(a, b, c)
local xPlayers = arp.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("gunshot", xPlayers[i], a, b, c)
		end
	end
end)

RegisterServerEvent('gg_policeinform:carrobplace')
AddEventHandler('gg_policeinform:carrobplace', function(a, b, c)
local xPlayers = arp.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("carrobbery", xPlayers[i], a, b, c)
		end
	end
end)