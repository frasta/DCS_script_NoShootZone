-- NoShootZone script from Asta, if any question, find me here: https://discord.gg/ZUZdMzQ
local blueUnits = mist.makeUnitTable({'[blue][plane]','[blue][helicopter]'})
local units = nil
local zone_names = {'zone1','zone2','zone3','zone4'} -- List of the zones you need to check the groundspeed of players
local eventListiner = {}
local initiatorName = nil
local onlinePlayers = nil
local onlinePlayer = nil
local currentUnit = nil
local lastShot = nil
local posit = nil

function eventListiner:onEvent(event)
	if event.id == 1 or event.id == 23 then
		--trigger.action.outText("Pouet",1)
		initiatorName = event.initiator:getPlayerName()
		if(lastShot ~= event.time) then
			lastShot = event.time
			posit = event.initiator:getPoint()
			if(net ~= nil and net.get_player_list() ~= nil and mist ~= nil) then
				onlinePlayers = net.get_player_list()
				units = mist.getUnitsInZones(blueUnits, zone_names)
				if(initiatorName ~= nil and onlinePlayers ~= nil and units ~= nil and next(units) ~= nil) then
					for i = 1, #units do 
						currentUnit = units[i]
						if (Unit ~= nil and currentUnit ~= nil and Unit.getPlayerName(currentUnit) ~= nil and Unit.getPlayerName(currentUnit) == initiatorName ) then -- Checking if player and if alive
							for j = 1, #onlinePlayers do	
								if ( onlinePlayers ~= nil and onlinePlayers[j] ~= nil ) then
									onlinePlayer = onlinePlayers[j]
									if(net.get_player_info(onlinePlayer, "name") == initiatorName) then
										trigger.action.outTextForUnit(currentUnit:getID() , "" .. initiatorName ..", you were not allowed to shoot close to blue bases! (inside the zone with blue dots borders if you check the F10 map)\nYou have been shotdown!", 10)
										net.send_chat(""..initiatorName.." has been shotdown!(No shoot close to blue airfields!)", true)
										trigger.action.explosion(posit , 4) --Higher is this number, bigger is the explosion 💥
									end
								end
							end
						end
					end
				end
			end
		end
		onlinePlayers = nil
		onlinePlayer = nil
		initiatorName = nil
		units = nil
		currentUnit = nil
	end
end
world.addEventHandler(eventListiner)
