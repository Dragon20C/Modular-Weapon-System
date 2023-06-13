# Modular-Weapon-System
Work in progress weapon system, plan on making a tutorial when its flushed out!

Functionality:
I have implemented the node based weapon system, this system works by having a main weapon system node that connects things outside of the weapon to the weapon to use, the system works by having a interface for each weapon type, with each interface having their own logic specific to the weapon type, The weapon system node does the calls for the current weapon as to avoid calling every node we only call the one active.
Data is separate and the model  + animations is separate, as long as the model is the same type as the weapon interface it will play the animations correctly.
