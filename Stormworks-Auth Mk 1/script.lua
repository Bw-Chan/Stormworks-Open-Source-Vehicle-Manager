-- This is a full rewrite and clean up of the Bw Server script --

-- # Credits # --
-- Bw-Chan <-- keep if you want
-----------------

-- UI/Popup LIST
-- ?auth UI_ID 0
-- VehicleManager UI_ID 1

--Dont need to touch this
g_savedata ={
    -- {player_id,{pet_list}}
    ["players"] = {},
}

--# Configuration #--
announcement_name = "[Server]"
announcement_interval = 400 --in minutes this is 6 mins (roughly)

--Contains info about this script (change to your preference)
info = {
    ["Server_Name"] = "Bw Server",
    ["Server_Type"] = "[No Workshop]",  --or you could do [Workshop] (or anything tbh)
    ["Owner"] = "Bw-Chan",
    ["Version"] = "Auth mk1", --You dont really need to change this but you can if you wish to make edits
    ["Link"] = "discord.gg/[your server]"
}

commands = {
    -- Use: --[[ code ]]-- to blank out modules you do not have (preferably keep all modules all together should limit how much you need to edit here)
    -- This may change once I find out how to communicate between scripts so the other scripts can just dump their commands on startup
	{
        "===Main Help (pg 1/3)===",
	"Rules can be found on the rule board at where you first spawn or you can use ?rules.",
	"Staff names can also be found on the board at spawn.",
	"",
	"?help [page] - brings up a page of commands or tells you that you need to specify a page number :P",
	"?rules - brings up the full list of rules",
	"?admin_help - displays admin commands (Only if you are admin)",
	"?auth - Auths you duh",--Change this to how you want it like: ?noworkshop (make sure to do this throughout the script)
	"?info / ?i - Gives you info about the server owner and Discord Link",
	"",
	"See more: ?help [page]"},
    {
        "===Vehicle Management (pg 2/3)===",
    "?c [vehicle_id] - Clear up your slected vehicle, if left empty will despawn all of them",
	"?r [vehicle_id] - Repairs your selected vehicle, if left empty will repair all of them",
	"?tpveh [vehicle_id] - Teleports your vehicle to you",
	"?as - Toggles your Anti_steal for all vehicles",
	"?pvp - Toggles invulnerability for all vehicles",
	"?ui - Toggles that pesky UI",
	"",
	"See more: ?help [page]"

    },
    {
        "===Extra (pg 3/3)===",
    "?pet / ?companion [pet_breed/remove] - When empty will give a list of breeds, to remove the dog do ?pet remove",
	"?t / ?tool [tool_id] [slot_number]- If empty will display all tool id's",
	"",
	"See more: ?help [page]"
    },
}

--Put any announcements you want in this
announcement_list ={
    -- %s allows you to insert a specified variable in that slot that is a string
    string.format("Come Join Our Discord! %s",info["Link"]),
	"If you dont know what commands are available use: ?help [page]",
	"Nuclear bombs, Flare Bombs, Nuclear reactors designed to explode or anything designed to annoy or break the server are not permitted"
}
--Put in your rules, here are my rules as example (or you could just use em :v)
rules = {
	"1) Please use common sense and stop doing a certain action when told to.",
	"2) Do NOT at any time TP (teleport)/No-clip fight as it is unfair for other players who wish to fight.",
	"3) Vehicles that cause warning messages aswell as large or vehicles with many moving parts are Restricted.",
	"4) No Explicit Roleplay, This means No Suicide, sexual, terrortistic acts.",
	"5) PvP in Hangars or spawn areas are not allowed, Please move.",
	"6) Please Refrain from using Flare Bombs, EMPs or anything to annoy people.",
	"7) Do NOT at all try break the server in any way.",
	"8) Please do not shoot planes/helicopters that are on the ground.",
	"9) Ensure you are given permission by the other player to PvP.",
	"10) Admins have final say.",
	"",
	"And dont forget to have fun!"
}

--Is a whitelist of your admin's steam_id's (prevents people getting admin who shoudln't)
--Make sure you are included
-- {name,steam_id}, --
admins = {
    {"admin1",0},
    {"admin2",1}
}

--Admin_commands for this module
admin_commands = {
	"?warn [player_id] [Reason]",
	"?kick [player_id]",
	"?ban [player_id]",
	"?announce [announcment]",
	"?kill [player_id] - Kills the player",
	"?smite [player_id] - Kills the player with kaboom",
	--VehicleManager
	"?setpvp [player_id] [true/false]" ,
	"?remove [Vehicle_id]",
	"?vehlist - Displays the players name, ID and vehicles spawned"
}

--# Required Items (Do not change unless updates add new stuff) #--

pets = {
	{"beagle",18},
	{"border collie",19},
	{"boxer",20},
	{"corgi",21},
	{"dachschund",22},
	{"dalmatian",23},
	{"doberman",24},
	{"german shepherd",25},
	{"grayhound",26},
	{"jack russel",27},
	{"labrador",28},
	{"newfoundland",29},
	{"pug",30},
	{"shiba",31},
	{"siberian husky",32},
	{"st bernard",33},
	{"vizdla",34},
	{"yorkshire terrier",35},
}
tools = {
	--{tool_ID, Name, Int, Float, Slot_Number}--
	--Clothing
	{1,"diving",0,0,10},
	{2,"firefighter",0,0,10},
	{3,"scuba",0,0,10},
	{4,"parachute",1,0,10},
	{5,"arctic",0,0,10},
	{29,"hazmat",0,0,10},
	{74,"bomb_disposal",0,0,10},
	{75,"chest_rig",0,0,10},
	{76,"black_hawk_vest",0,0,10},
	{77,"plate_vest",0,0,10},
	{78,"armor_vest",0,0,10},
	{79,"space_suit",0,0,10},
	{80,"space_stui_exploration",0,0,10},
	--Items
	{6,"binoculars",0,0,2},
	{7,"cable",0,0,1},
	{8,"compass",0,0,2},
	{9,"defibrillator",4,0,1},
	{10,"fire_extinguisher",0,100,1},
	{11,"first_aid",4,0,2},
	{12,"flare",4,0,2},
	{13,"flaregun",1,0,2},
	{14,"flaregun_ammo",4,0,2},
	{15,"flashlight",0,100,2},
	{16,"hose",0,0,1},
	{17,"night_vision_binoculars",0,100,2},
	{18,"oxygen_mask",0,100,2},
	{19,"radio",0,100,2},
	{20,"radio_signal_locator",0,100,2},
	{21,"remote_control",0,100,2},
	{22,"rope",0,0,1},
	{23,"strobe_light",0,100,2},
	{24,"strobe_light_infrared",0,100,2},
	{25,"transponder",0,100,2},
	{26,"underwater_welding_torch",0,250,1},
	{27,"welding_torch",0,400,1},
	{28,"coal",0,0,2},
	{30,"radiation_detector",0,100,2},
	{31,"c4",1,0,2},
	{32,"c4_detonator",0,0,2},
	{33,"speargun",1,0,1},
	{34,"speargun_ammo",4,0,2},
	{35,"pistol",17,0,2},
	{36,"pistol_ammo",17,0,2},
	{37,"smg",40,0,1},
	{38,"smg_ammo",40,0,2},
	{39,"rifle",30,0,1},
	{40,"rifle_ammo",30,0,2},
	{41,"grenade",1,0,2},
	{42,"machine_gun_ammo_box_k",0,0,1},
	{43,"machine_gun_ammo_box_he",0,0,1},
	{44,"machine_gun_ammo_box_he_frag",0,0,1},
	{45,"machine_gun_ammo_box_ap",0,0,1},
	{46,"machine_gun_ammo_box_i",0,0,1},
	{47,"light_auto_ammo_box_k",0,0,1},
	{48,"light_auto_ammo_box_he",0,0,1},
	{49,"light_auto_ammo_box_he_frag",0,0,1},
	{50,"light_auto_ammo_box_ap",0,0,1},
	{51,"light_auto_ammo_box_i",0,0,1},
	{52,"rotary_auto_ammo_box_k",0,0,1},
	{53,"rotary_auto_ammo_box_he",0,0,1},
	{54,"rotary_auto_ammo_box_he_frag",0,0,1},
	{55,"rotary_auto_ammo_box_ap",0,0,1},
	{57,"heavy_auto_ammo_box_k",0,0,1},
	{58,"heavy_auto_ammo_box_he",0,0,1},
	{59,"heavy_auto_ammo_box_he_frag",0,0,1},
	{60,"heavy_auto_ammo_box_ap",0,0,1},
	{61,"heavy_auto_ammo_box_i",0,0,1},
	{62,"battle_shell_k",0,0,1},
	{63,"battle_shell_he",0,0,1},
	{64,"battle_shell_he_frag",0,0,1},
	{65,"battle_shell_ap",0,0,1},
	{66,"battle_shell_i",0,0,1},
	{67,"artillery_shell_k",0,0,1},
	{68,"artillery_shell_he",0,0,1},
	{69,"artillery_shell_he_frag",0,0,1},
	{70,"artillery_shell_ap",0,0,1},
	{71,"artillery_shell_i",0,0,1},
	{72,"chemlight",0,0,2},
	{73,"dog_whistle",0,0,2},
    {81,"fishing_rod",0,0,1},
    --fish (Disabled by default to reduce the sheer amount of text, couldnt do a page system because of the current way things are done)
    --[[
    {82,"anchovie",3,0,2},
    {83,"arctic_char",3,0,2},
    {84,"ballan_lizardfish",3,0,2},
    {86,"ballan_wrasse",3,0,2},
    {87,"barreleye_fish",3,0,2},
	{88,"black_bream",3,0,2},
	{89,"black_dragonfish",3,0,2},
	{90,"clown_fish",3,0,2},
	{91,"cod",3,0,2},
	{92,"dolphinfish",3,0,2},
	{93,"gulper_eel",3,0,2},
	{94,"haddock",3,0,2},
	{95,"hake",3,0,2},
	{96,"herring",3,0,2},
	{97,"john_dory",3,0,2},
	{98,"labrus",3,0,2},
	{99,"lanternfish",3,0,2},
	{100,"mackerel",3,0,2},
	{101,"midshipman",3,0,2},
	{102,"perch",3,0,2},
	{103,"pike",3,0,2},
	{104,"pinecone_fish",3,0,2},
	{105,"pollack",3,0,2},
	{106,"red_mullet",3,0,2},
	{107,"rockfish",3,0,2},
	{108,"sablefish",3,0,2},
	{109,"salmon",3,0,2},
	{110,"sardine",3,0,2},
	{111,"scad",3,0,2},
	{112,"sea_bream",3,0,2},
	{113,"sea_halibut",3,0,2},
	{114,"sea_piranha",3,0,2},
	{115,"seabass",3,0,2},
	{116,"slimehead",3,0,2},
	{117,"snapper",3,0,2},
	{118,"snapper_gold",3,0,2},
	{119,"snook",3,0,2},
	{120,"spadefish",3,0,2},
	{121,"trout",3,0,2},
	{122,"tubeshoulders_fish",3,0,2},
	{123,"viperfish",3,0,2},
	{124,"yellowfin_tuna",3,0,2},
	{125,"blue crab",3,0,2},
	{126,"brown_box_crab",3,0,2},
	{127,"coconut_crab",3,0,2},
	{128,"dungeness_crab",3,0,2},
	{129,"furry_lobster",3,0,2},
	{130,"homarus_americanus",3,0,2}, --(Atlantic Lobster)
	{131,"homarus_gammarus",3,0,2}, --(Common Lobster)
	{132,"horseshoe_crab",3,0,2},
	{133,"jasus_edwardsii",3,0,2}, --(Red Rock Lobster)
	{134,"jasus_lalandii",3,0,2}, --(Cape Rock Lobster)
	{135,"jonah_crab",3,0,2},
	{136,"king_crab",3,0,2},
	{137,"mud_crab",3,0,2},
	{138,"munida_lobster",3,0,2},
	{139,"ornate_rock_lobster",3,0,2},
	{140,"panulirus_interruptus",3,0,2},
	{141,"red_king_crab",3,0,2},
	{142,"reef_lobster",3,0,2},
	{143,"slipper_lobster",3,0,2},
	{144,"snow_crab",3,0,2},
	{145,"southern_rock_lobster",3,0,2},
	{146,"spider_crab",3,0,2},
	{147,"spiny_lobster",3,0,2},
	{148,"stone_crab",3,0,2}
    ]]--
}

--#      MAIN SCRIPT        #--
-- Change at your discretion --

--# Simplifications #--
--simplifies the announcement call down
function announce(message,user_peer_id)
    user_peer_id = user_peer_id or -1
    server.announce(info["Server_Name"],message,(user_peer_id))
end

--# Functions #--

function onPlayerJoin(steam_id, name, peer_id, is_admin, auth)
	announce("Welcome ".. name) --Change this for a different welcome message
	server.removeAuth(peer_id) --removes auth so they have to rid of the popup
    for _,i in pairs(admins) do
        if steam_id ~= i[2] and is_admin then --checks if they arent in the whitelist and if they are admin removes unwanted admins
            server.removeAdmin(peer_id)
        elseif steam_id == i[2] and not is_admin then
            server.addAdmin(peer_id) --automatically adds admins you specified just incase you forgot to configure server_config.xml
        end
    end

	if not is_admin then
        --Change the popup for any different command for auth
		server.setPopupScreen(peer_id, 0, name, true, info["server_Type"].."\n Please Read Rules! ?auth for auth", 0, 0)
	end
    table.insert(g_savedata["players"],1,{name,peer_id,{}})
end

function onPlayerLeave(steam_id, name, peer_id, admin, auth)
	announce(name .. " left the game")
	for _,i in pairs(g_savedata["players"]) do --if the player have spawned pets it removes them
		if i[1] == peer_id then
			server.despawnObject(g_savedata["players"][_][2], true) --removes their pet
			table.remove(g_savedata["players"], _)--removes the player from list
            break --to prevent any uneccesery searching
		end
	end
end

-- Controls the Announcements
function onTick()
    system_time_seconds = server.getTimeMillisec()/1000 --Bit of maths to get seconds

	if (system_time_seconds % announcement_interval == 0) then --Every multiple of announcement_interval causes this set to fire
		randInt = math.floor(math.random(1,#announcement_list)) --gets a random message string from the announcements list
		announce(announcement_list[randInt])
	end
end

-- # CUSTOM COMMANDS # --
function onCustomCommand(full_message, user_peer_id, is_admin, is_auth, command, one, two, three, four, five)
    local command = command:lower()--makes it so you can type ?INFO and it still works
	--# Public User Commands #--
	
    --change this for your ?noworkshop or such
	if (command== "?auth") then 
		server.addAuth(user_peer_id)
		server.removePopup(user_peer_id, 0)
	end
	
    --Displays server info
	if (command == "?info" or command == "?i") then
        local owner = string.format("Server Owner: %s",info["Owner"]).."\n"
        local type = string.format("Server Type: %s",info["Server_Type"]).."\n"
        local version = string.format("Script Version: %s",info["Version"]).."\n"
        local link = string.format("Server Link: %s",info["Link"]).."\n"
        local name = string.format("Server Name: %s",info["Server_Name"]).."\n"
        
		local text = name..owner..type..link..version
		announce(text, user_peer_id)
	end
	
    --Will display modules (like this one) and their commands when stated which one you want to look at
    --Not sure currently Will come back to this
	if (command == "?help" or command == "?h") then
		commandsT = ""
		if one then
			one = tonumber(one)
			if one==1 or one==2 or one==3 then
			for _,i in pairs(commands[one]) do
				commandsT = commandsT .. i .. "\n"
			end
				server.announce("[Server]", commandsT, (user_peer_id))
			else
				server.announce("[Server]", "Please specify a number (page 1-3)", (user_peer_id))
			end
		else
			for _,i in pairs(commands[1]) do
				commandsT = commandsT .. i .. "\n"
			end
			server.announce("[Server]", commandsT, (user_peer_id))
		end
	end
	
    --gets your staff and posts it to you. how fancy!
	if (command == "?staff") then
        local staffT = ""
		for _,i in pairs(admins) do
			staffT = staffT .. i[1] .. "\n"
		end
		announce(staffT, user_peer_id)
	end
	
	--Chunky command for the chunky amount of tools YOU get to choose from you can specify slot or let the list do the rest
	if (command == "?tool" or command == "?t" or command == "?tools") then
		if one then
			for _,o in pairs(tools) do
				if tonumber(one) == o[1] then
					if two then
						Slot = two
					else
						Slot = o[5]
					end
					server.announce("[Server]","Tool Spawned",(user_peer_id))
					peer_object_id, is_success = server.getPlayerCharacterID(user_peer_id)
					server.setCharacterItem(peer_object_id, Slot, one, false, o[3], o[4])
					break
				end
			end
		else
			ToolsT=""
			for _,o in pairs(tools) do
				ToolsT = ToolsT .. o[1] .." ".. o[2] .."\n"
			end
			announce(ToolsT, user_peer_id)
		end
	end
	
    --command for your user's comfort (you can just diable this with --[[]]-- before and after this if statement)
	if (command == "?companion") or (command == "?pet") then
		if one then
			if one == "remove" then
				for _,i in ipairs(g_savedata["players"]) do
					if g_savedata["players"][_][1] == user_peer_id then
						server.despawnObject(g_savedata["players"][_][2], true)
					end
				end
			else
				player_transform_matrix, is_success = server.getPlayerPos(user_peer_id)
				for _,i in pairs(pets) do
					if one == i[1] then
						object_id = server.spawnCreature(player_transform_matrix, i[2], 1)
				
						table.insert(g_savedata["players"],1,{user_peer_id,object_id})
						--checks for another pet for specific personel
						for _,i in ipairs(g_savedata["players"]) do
							if g_savedata["players"][_][1] == user_peer_id then
								if g_savedata["players"][_][2] ~= object_id then
									server.despawnObject(g_savedata["players"][_][2], true)
								end
							end
						end
						break
					end
				end
			end
		else
			petT=""
			for _,i in pairs(pets) do
				petT = petT .. i[1] .. "\n"
			end
			server.announce("[Server]", petT, (user_peer_id))
		end
	end
	
    --prints the list of rules pretty simple right?
	if (command == "?rules") then
		rulesT = ""
		for _,i in pairs(rules) do
			rulesT = rulesT .. i .. "\n"
		end
		server.announce("[Server]", rulesT, (user_peer_id))
	end
	
	-- # Admin User Commands # --
	
    --gets the list of admin commands
	if (command == "?admin_help" and is_admin) then
		local AcommandsT = ""
		for _,i in pairs(admin_commands) do
				AcommandsT = AcommandsT .. i .. "\n"
		end
		announce(AcommandsT, user_peer_id)
	elseif (command == "?admin_help" and not is_admin) then
		announce("You are not an admin, but nice try", user_peer_id)
	end
	
    --Gets the the full message cuts off the ?announce part and bam
	if (command == "?announce" and is_admin) then
		full_message = full_message:gsub("%^?announce ","")
		full_message = full_message:gsub("%?","")
		server.announce("[ANNOUNCEMENT]", full_message)--I will not use the simplified announce because of this :P
	end
	
    --Just a fancier ?announce
	if (command == "?warn" and is_admin) then
		name, is_success = server.getPlayerName(one)
		server.announce("[ Admin Tools ]",name.." has been Warned for reason: "..two)
	end
	
    --What do you expect? They will keel over and die (definately of natural causes)
	if (command == "?kill" and is_admin) then
		if one then
			object_id= server.getPlayerCharacterID(one)
			server.killCharacter(object_id)
		end
	end
	
    --Using the power of the gods you can smite people... with a tiny explosion
	if (command == "?smite" and is_admin) then
		if one then
			object_id = server.getPlayerCharacterID(one)
			transform_matrix = server.getPlayerPos(one)
			server.spawnExplosion(transform_matrix, 1)
			server.killCharacter(object_id)
		end
	end	
end