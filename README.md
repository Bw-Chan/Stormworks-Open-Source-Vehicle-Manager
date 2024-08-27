# Stormworks-Open-Source-Vehicle-Manger

This is the second part of your Server! yay

If you have any issues feel free to contact me, discord: bwchan (I will also keep an eye on the issues stuff but I might be a bit slower to do so since I will probably be doing other things)

> Please credit me if you can, if you do not want to then well me big sad.

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
