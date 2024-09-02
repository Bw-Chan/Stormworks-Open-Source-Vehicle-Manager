-- This is a full rewrite and clean up of the Bw Server script --

-- # Credits # --
-- Bw-Chan <-- keep if you want
-----------------


g_savedata = {
    --Dont need to touch this
    -- ["players"] = {{name,peer_id,{vehicle_group_id,...},Anti_steal_State,Pvp_State,UI_State},....}
    ["players"] = {},
    -- # Configuration # --
    ["Manager_Name"] = "BW-VM mk1", --For vehicle info popups/UI
    ["MaxVehiclesAllowed"] = 1,
    ["Default_PVP_Value"] = false,
    ["Default_AS_Value"] = true
}


--# Simplified functions best if you dont change these #--
function toggleAS(peer_id,state)
	for a,peer in pairs(g_savedata["players"]) do
		if peer[2] == peer_id then
			g_savedata["players"][a][4] = state
			for b,group_id in pairs(peer[3]) do
				VEHICLES = server.getVehicleGroup(group_id)
				for c,vehicle_id in pairs(VEHICLES) do
					server.setVehicleEditable(vehicle_id, not state)
				end
			end
			server.notify(peer_id, "[ANTI-STEAL]", "Toggled State: "..tostring(state), 8)
		end
	end
end
--function to toggle the pvp
function togglePVP(peer_id,state)
	for a,peer in pairs(g_savedata["players"]) do
		if peer[2] == peer_id then
			g_savedata["players"][a][5] = state
			for b,group_id in pairs(peer[3]) do
				VEHICLES = server.getVehicleGroup(group_id)
				for c,vehicle_id in pairs(VEHICLES) do
					server.setVehicleInvulnerable(vehicle_id, not state)
				end
			end
			server.notify(peer_id, "[PVP]", "Toggled State: "..tostring(state), 8)
		end
	end
end
--function to toggle the UI
function toggleUI(peer_id,state)
	for a,peer in pairs(g_savedata["players"]) do
		if peer[2] == peer_id then
			g_savedata["players"][a][6] = state
			server.notify(peer_id, "[UI]", "Toggled State: "..tostring(state), 8)
		end
	end
end

--#      MAIN SCRIPT        #--
-- Change at your discretion --

--Adds player to g_savedata and sets up their defaults
function onPlayerJoin(steam_id, name, peer_id, is_admin, is_auth) --Adds player to g_savedata players for easier reload
	local AntiSteal = g_savedata["Default_AS_Value"]
	local PVP = g_savedata["Default_PVP_Value"]
	local UI = true --always true (player can toggle this off)
	table.insert(g_savedata["players"],1,{name,peer_id,{},AntiSteal,PVP,UI})
end
--Removed the player from g_savedate
function onPlayerLeave(steam_id, name, peer_id, is_admin, is_auth) --Removes player from g_savedata players
	for _,i in pairs(g_savedata["players"]) do
		if peer_id == i[2] then
			for p,o in pairs(i[3]) do
				server.despawnVehicleGroup(o, true)
			end
			for i=1,3,1 do
				server.removePopup(peer_id, peer_id+i) --Removes the Vehicle Manager UI for the player
			end
            table.remove(g_savedata["players"], _) --<-- PROBLEM
		end
	end
end
--When a group spawns several checks happen to go through g_savedata
--and compairs Id's to make sure a vehicle is put into the correct player's vehicle list.
function onGroupSpawn(group_id, peer_id,x,y,z,cost)
	local VEHICLES = server.getVehicleGroup(group_id)
	local players = g_savedata["players"]
	local GroupList = players[3]
	local name = server.getPlayerName(peer_id)
	for _,i in pairs(players) do
		if i[2] == peer_id then
			table.insert(g_savedata["players"][_][3],1,tostring(group_id))
			for o,vehicle_id in pairs(VEHICLES) do
				server.setVehicleEditable(vehicle_id, not i[4])
				server.setVehicleInvulnerable(vehicle_id, not i[5])
				server.setVehicleTooltip(vehicle_id, "ID: "..group_id.."\n".."["..name.."]")
			end
			server.notify(i[2], g_savedata["Manager_Name"], "Spawned Vehicle ID: \n"..group_id, 5)
		end
	end
end
-- Removes the vehicle group from a player's vehicle table
-- Also quick note why the fuck is there no onGroupDespawn? Would of made things a little simpler
function onVehicleDespawn(vehicle_id, peer_id)
	local VEHICLE_DATA, is_success = server.getVehicleData(vehicle_id)
	local group_id = VEHICLE_DATA["group_id"]
	local players = g_savedata["players"]
	for _,i in pairs(players) do
		if peer_id == i[2] then
			for a,group_idF in pairs(i[3]) do
				if group_idF == group_id then
					table.remove(g_savedata["players"][_][3],a)
				end
			end
		end
	end
end

-- This functions as a UI updater
-- and makes sure you dont die with pvp off and
-- Makes sure you dont go over the set amount of vehicles
function onTick(game_ticks)
	for _,i in pairs(g_savedata["players"]) do
		local AntiSteal = i[4] --Get Anti-Steal state from a player in DB
		local PVP = i[5] --Get PVP state from a player in DB
		local UI = i[6] --Get UI state from player in DB
		
		if i[5] == false then
			character_id = server.getPlayerCharacterID(i[2])
			server.reviveCharacter(character_id)
			server.setCharacterData(character_id, 100, true, false)
		end

        --
		if UI then
			vehs=""
			for a,j in pairs(i[3]) do
				vehs = vehs.. "\n" .. tostring(j)
			end
			as=tostring(AntiSteal)
			pvp=tostring(PVP)
			Line1= string.format("%s\n",g_savedata["Manager_Name"])
			Line2= "Anti-Steal: "..as.."\n"
			LineDASH= "-------------\n"
			Line3= "PvP: "..pvp.."\n"
			Line4= "--Vehicles--\n"..vehs
		
			-- Creates and Updates popup for peer_id with id = peer_id+1 (id = 1 essentially)
			server.setPopupScreen(i[2], 1, name, true, Line1..Line2..LineDASH..Line3..Line4,0.9,0.4)
		else
			server.removePopup(i[2], 1) --Removes the Vehicle Manager UI for the player
		end
	end
	--Should limit the vehicles spawned by the player
	for _,i in pairs(g_savedata["players"]) do
		local VehicleCount = #i[3] --gets the length of the vehicles in a player's data
		if VehicleCount > g_savedata["MaxVehiclesAllowed"] then --does a comparison
			server.despawnVehicleGroup(i[3][#i[3]],true)
			table.remove(g_savedata["players"][_][3],#i[3])
		end
	end
end

function onCustomCommand(full_message, peer_id, is_admin, is_auth, command, one, two, three, four, five)
    local command = command:lower()
    local players = g_savedata["players"]
    --DEBUG--
    --[[
    if (command == "?list") then
        local text = ""
            for _,i in pairs(g_savedata["players"]) do
                server.announce("[DEBUG]",tostring(i))
            end
        
    end
    ]]--

    --VEHICLE MANIPULATION COMMANDS--

    --Player Clear Command
    if (command == "?c" or command == "?clear") then
        for _,i in pairs(players) do
            if peer_id == i[2] then
                for a,group_id in pairs(i[3]) do --Should itterate through the list and despawn what is needed
                    if one then --if player states a group_id despawn that one only
                        server.despawnVehicleGroup(one,true)
                        table.remove(g_savedata["players"][_][3],a)
                        server.notify(i[2], g_savedata["Manager_Name"], "Despawned Vehicle ID: \n"..one, 6)
                    else
                        server.despawnVehicleGroup(group_id,true)
                        table.remove(g_savedata["players"][_][3],a)
                        server.notify(i[2], g_savedata["Manager_Name"], "Despawned Vehicle ID: \n"..group_id, 6)
                    end
                end
            end
        end
    end
        
    --Player Repair Command
    if (command == "?r" or command == "?repair") then
        for _,i in pairs(players) do
            if peer_id == i[2] then
                for a,group_id in pairs(i[3]) do
                    VEHICLES = server.getVehicleGroup(group_id)
                    if one then -- if player states a group_id repair that one only
                        for b,vehicle_id in pairs(one) do
                            server.resetVehicleState(vehicle_id)
                        end
                    else
                        for b,vehicle_id in pairs(VEHICLES) do
                            server.resetVehicleState(vehicle_id) --reset each vehicle in group
                        end
                    end
                end
            end
        end
    end
        
    --Player Flip Command
    if (command == "?f" or command == "?flip") then
        for _,i in pairs(players) do
            if peer_id == i[2] then --does a check for player
                local Player_Position = server.getPlayerPos(peer_id)
                --Gets all group_id's from player's data
                --This is only big because of the fact you can choose to specify a group :P
                for a,group_id in pairs(i[3]) do
                    local VEHICLES = server.getVehicleGroup(group_id)
                    if one then
                        --The idea here is that I can do a check when the player specifies a group
                        --is that it will get the vehicles of that group and go through it
                        --Flipping all the vehicles within it
                        if tonumber(one) == tonumber(group_id) then --checks if the id is in the player's list
                            --gets their position
                            VehicleMatrix = server.getVehiclePos(tonumber(vehicle_id))
                            --gets the x y z
                            x,y,z = matrix.position(VehicleMatrix)
                            --sets the translation of the vehicle_id by x y z
                            server.setVehiclePos(tonumber(vehicle_id), matrix.translation(x,y+1,z))
                            break
                        end
                    else
                        --goes through each vehicle flipping them
                        for b,vehicle_id in pairs(VEHICLES) do
                            VehicleMatrix = server.getVehiclePos(tonumber(vehicle_id))

                            x,y,z = matrix.position(VehicleMatrix)

                            server.setVehiclePos(tonumber(vehicle_id), matrix.translation(x,y+1,z))
                        end
                    end
                end
                server.setPlayerPos(peer_id, Player_Position)
                break --prevents further searching
            end
        end
    end
        
    --Player TP_Vehicle Command
    if (command == "?tpveh" or command == "?tp_vehicle") then
        player_matrix = server.getPlayerPos(peer_id)
        x,y,z = matrix.position(player_matrix)
        for _,i in pairs(players) do
            if peer_id == i[2] then
                for a,group_id in pairs(i[3]) do
                    if one then
                        --server.moveGroup(tonumber(one), matrix.translation(x,y+10,z))
                        server.setGroupPos(tonumber(one), matrix.translation(x,y+10,z))
                    else
                        --server.moveGroup(tonumber(group_id), matrix.translation(x,y+10,z))
                        server.setGroupPos(tonumber(group_id), matrix.translation(x,y+10,z))
                    end
                end
            end
        end
    end
        
    --VEHICLE SETTINGS COMMANDS--
        
    --Player PvP Toggle
    if (command=="?pvp") then
        for _,i in pairs(players) do
            if i[2] == peer_id then
                togglePVP(peer_id,not i[5])
            end
            end
    end
        
    --Player Anti-steal Toggle
    if (command=="?as" or command=="?anti_steal") then
        for _,i in pairs(players) do
            if i[2] == peer_id then
                toggleAS(peer_id,not i[4])
            end
        end
    end
        
    --Player UI Toggle
    if (command=="?ui") then
        for _,i in pairs(players) do
            if i[2] == peer_id then
                toggleUI(peer_id,not i[6])
            end
        end
    end
        
    --ADMIN VEHICLE COMMANDS--
    --Displays a list of players and their vehicles
    if (command == "?vehlist") and is_admin then
        plistT = ""
        for _,i in pairs(players) do
            VLPP = ""
            for p,group_id in pairs(i[3]) do
                VLPP = VLPP..tostring(group_id).."\n" --Vehicle list per player
            end
            plistT = plistT .."Name: " ..tostring(i[1]).." , ".."ID: "..tostring(i[2]).."\n"..VLPP
        end
        server.announce("[Admin Tools]", plistT, (peer_id))
    end
    --Sets the pvp of those naughty scoundrels
    if (command == "?setpvp") and is_admin then
        if one and two then --One = target_player Two = state
            for _,i in pairs(players) do
                if i[2] == tonumber(one) then
                    local tobool={ ["true"]=true, ["false"]=false }
                    togglePVP(tonumber(one),tobool[two:lower()])
                end
            end
        else
            server.announce("[Admin Tools]","Make sure to Enter player_id and state",(peer_id))
        end
    end
        
    if (command == "?remove") and is_admin then
        if one then
            for _,i in pairs(players) do
                for a,group_id in pairs(players[_][3]) do
                    if group_id == tonumber(one) then
                        server.announce("[Admin Tools]","Attempting to remove vehicle"..group_id,(peer_id))
                        table.remove(g_savedata["players"][_][3],a)
                    end
                end
            end
            server.despawnVehicleGroup(tonumber(one), true)
            server.announce("[Admin Tools]","Removed Vehicle: "..one,(peer_id))
        else
            server.announce("[Admin Tools]","You need a Vehicle ID",(peer_id))
        end
    end
end					
