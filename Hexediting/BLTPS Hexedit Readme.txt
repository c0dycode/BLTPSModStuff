### Installation ###
Extract all files into the "..\steamapps\common\BorderlandsPreSequel\Binaries\Win32" folder.




### Informations ###

Scrolling through the inventory can bug out, like it can for vendors, for example.

So far these methods have been reported to fix it:

- Reopen the Inventory
- Use the Arrowkeys
- Switch around items

## Moonstone:
Select a range from 500 to 2147483647.

Note: Modifying Moonstone with Gibbed, will only show you 200. While getting more than 500 ingame will actually show up as up to 999. Should you get more than 999, it'll still only show 999 but you'll actually have more.

## Max Level:
Choose from 70 up to 92.

## Backpack:
Choose the max amount of Slots and it's "Spacetrigger".

Spacetrigger :- The default is 39. This means, once you buy the last backpack SDU, and therefore reaching 39 backpackslots, that's the point where you'll have the chosen Max Slots instead.

Meaning - if you choose 24 as a Spacetrigger, you'll get your chosen Max Slots once your purchased SDUs would get you 24 slots. Then 24 will be the point where you'll have your chosen slots at.

Note: Lowering the Spacetrigger from 39 will most likely increase your Slots --TEMPORARILY-- when purchasing another backpack SDU. So these extra-slots will be gone after reopening the game.

##  Array-Limit
This is usually not needed.
However, people that come across this limit now have an automatic way of patching.
See an example here:
https://github.com/c0dycode/BL2ModStuff/tree/master/Hexediting#removing-the-100-element-limit

Array-Limit Enabled = Default. The Limit is active!
Array-Limit Disabled = The limit is removed!

Changelog
# v1.0
```
Initial release of the TPS-Version of the Multitool:
Leveling works up to 92 and enemies/items seem to scale properly(?!) Got a drop that said "Requires Overpower 20". 
You TPS folks know more about that than I do :P

I think I ported everything from the BL2-Version over. Except Eridium, Torque and Seraph ofc. Game starts fine, no in-depth testing done yet.
Backpack also seems to work fine.

Any issues? You tell me! :P
```