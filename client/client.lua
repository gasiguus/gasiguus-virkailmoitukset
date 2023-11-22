ESX = exports["es_extended"]:getSharedObject()

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('gunshot')
AddEventHandler('gunshot', function(gx, gy, gz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if Config.GunshotAlert then
			local transG = 400
			local gunshotBlip = AddBlipForCoord(gx, gy, gz)
			SetBlipSprite(gunshotBlip,  313)
			SetBlipDisplay(gunshotBlip, 4)
			SetBlipColour(gunshotBlip,  1)
			SetBlipScale(gunshotBlip, 0.5)
			SetBlipAlpha(gunshotBlip,  transG)
			SetBlipAsShortRange(gunshotBlip,  true)
			BeginTextCommandSetBlipName("STRING")
    		AddTextComponentString(('Shooting Scene'))
    		EndTextCommandSetBlipName(gunshotBlip)
			while transG ~= 0 do
				Wait(blipGunTime * 4)
				transG = transG - 1
				SetBlipAlpha(gunshotBlip,  transG)
				if transG == 0 then
					SetBlipSprite(gunshotBlip,  2)
					return
				end
			end
		end
	end
end)

RegisterNetEvent('carrobbery')
AddEventHandler('carrobbery', function(tx, ty, tz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if Config.CarRobAlert then
			local transT = 400
			local thiefBlip = AddBlipForCoord(tx, ty, tz)
			SetBlipSprite(thiefBlip,  227)
			SetBlipDisplay(thiefBlip, 4)
			SetBlipColour(thiefBlip,  1)
			SetBlipScale(thiefBlip, 0.7)
			SetBlipAlpha(thiefBlip,  transT)
			SetBlipAsShortRange(thiefBlip,  true)
			BeginTextCommandSetBlipName("STRING")
    		AddTextComponentString(('Car Robbery'))
    		EndTextCommandSetBlipName(thiefBlip)
			while transT ~= 0 do
				Wait(blipJackingTime * 4)
				transT = transT - 1
				SetBlipAlpha(thiefBlip,  transT)
				if transT == 0 then
					SetBlipSprite(thiefBlip,  2)
					return
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local player = GetPlayerPed(-1)
		if IsPedShooting(player) then
			if IsPedCurrentWeaponSilenced(player) == false and GetSelectedPedWeapon(player) == GetHashKey('WEAPON_STUNGUN') == false then
				local pelpos = GetEntityCoords(player,  true)
				TriggerServerEvent('gg_policeinform:gunshotPlace', pelpos.x, pelpos.y, pelpos.x)
                if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
                    TriggerEvent('gg_policeinform:notify', Strings.police_basic, Strings.gun_shot_desc, 'error')
				Citizen.Wait(1500)
                end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local player = GetPlayerPed(-1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(player)) then
			local car = GetVehiclePedIsTryingToEnter(player)
			local pedd = GetPedInVehicleSeat(car, -1)
			if DoesEntityExist(pedd) then
				if not IsPedAPlayer(pedd) then
					Citizen.Wait(5000)
					if not IsPedSittingInAnyVehicle(pedd) then
						GiveWeaponToPed(pedd, GetHashKey("weapon_pistol"), 250, false)
						SetAiWeaponDamageModifier(1.0)
						SetPedAccuracy(pedd, 100)
						SetPedShootRate(pedd, 1000)
						TaskShootAtEntity(pedd, player, 30000, 0xC6EE6B4C)
						local pelpos = GetEntityCoords(player, true)
						TriggerServerEvent('gg_policeinform:carrobplace', pelpos.x, pelpos.y, pelpos.x)
                        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
                            TriggerEvent('gg_policeinform:notify', Strings.police_basic, Strings.car_rob_desc, 'error')
						SetPedAsNoLongerNeeded(pedd)
                        end
					end
				end
			end
		end
	end
end)