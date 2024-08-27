# Stormworks-Open-Source-Vehicle-Manger

This is the second part of your Server! yay

If you have any issues feel free to contact me, discord: bwchan (I will also keep an eye on the issues stuff but I might be a bit slower to do so since I will probably be doing other things)

> Please credit me if you can, if you do not want to then well me big sad.

Note: Using Visual Studio Code will help a ton with reading these things and writing but it will slow down testing a little.

This handles more advanced functions like:
- Vehicle Manipulation
- Player data state toggles
- Player data
- Admin Vehicle Manipulation

## Lets get Started!

For a guide to adding the addon to your server go to [Stormworks-Open-Source-Auth](https://github.com/Bw-Chan/Stormworks-Open-Source-Auth)

Saves me having to repeat myself :P

![image](https://github.com/user-attachments/assets/d16a959f-61ef-499e-a6f5-d483bed6df3a)

For this script's config there.. isnt very much to configure because it is just more of a background work horse script.
The Manager name is what will show up on the UI for displaying basic information like:

![image](https://github.com/user-attachments/assets/cd2acb31-7758-415b-a727-e6e67506d2f9)

Which displays your PVP state, Anti Steal State and what vehicles you have which is all you really need to know.

KEEP THINGS SIMPLE AND NON OBSTRUCTIVE FOR YOUR PLAYERS! but the option to toggle the ui with ?ui is still there.

Then there is the Max Vehicle Count which dictates how many vehicles each player can have I'd reconmend 1 per player but you can do what you want.

And lastly the defaults, they tell the onPlayerJoin function what data the players should start with regarding their pvp and anti-steal state.

I would not recommend AT ALL turning the anti-steal state to false because that allows other players to steal other's creations and you dont want that, being the couragous, illustrious and generous dictator- I mean Server Owner that you are. (obvious joking)

As for the pvp well that is up to you prefferably it should be false so no one ends up being killed and stirring up arguements.

## ?help Commands
### (For Copy and pasting incase you deleted it in the auth script :P)
```
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
```
## The scary advanced stuff

As for the rest of the script it can be a bit harder to understand because of the way stormworks handles its vehicles.
I'll make this as simple as I can, Vehicles in stormworks are called groups so any loose objects that you spawn with your car/train/helicopter/whatever.. is classed as another vehicle within that group.

Here if you like artworks this will surely help you understand a bit better.

![Illustration](https://github.com/user-attachments/assets/8d5b23b8-a701-4c22-9f5e-5e4b317a92dd)

In code it is represented as: 
```
GROUP = server.getVehicleGroup(group_id) -- Groups have Id's attached to them so you can quick refer to them
GROUP = {1,2} --These are the vehicle_id's in that group (dont actually do this part in code this is a visual repersentation)
```

The First vehicle_id is in index 1 (in other languages that is usually 0 but lua likes being special)

The second vehicle_id is in index 2

So to get the car I would have to:

```
GROUP = server.getVehicleGroup(1)
vehicle_one = GROUP[1] --this gets the list outputted from the instruction above and looks for index 1
-- therefore getting my car :D
-- If I wanted the caravan I would do
vehicle_two = GROUP[2]

-- vehicle_one and vehicle_two would have the id's of the vehicles in tha image above.
```

This should have hopefully given you a better understanding of why there are so many goddamn for loops and if statements doing checks and stuff but yeah going through lists is great fun.

Stormworks does have its own doccumentation that you can find in-game in the addon menu. There are alternative doccumentation on websites but in my opinion nothing can beat a quick easy access to the in-game docs.
![image](https://github.com/user-attachments/assets/a69fb7e5-6656-4a7b-8bb6-d9db3b562ea7)

This is as much as I will probably explain for now. I will probably add to this the more people ask about it, the only confusion I could probably of guessed was with the way vehicles work in the game :P
