# Galaga ports 

Various ports for Galaga by Somhi  adapted from DE10_lite port by Dar (https://sourceforge.net/projects/darfpga/files/Software%20VHDL/galaga/)

[Read history of Galaga Arcade.](https://www.arcade-museum.com/game_detail.php?game_id=7881)

[Parts and Operating Manual](Galaga_-_1981_-_Namco.pdf)

### Keyboard players inputs :

F3 : Add coins
F4 : Start 1 player
F5 : Start 2 player
SPACE       : Fire  
RIGHT arrow : right
LEFT  arrow : left

F8 : toggles VGA / RGB video mode

Sega Gamepad can be used.

Other details : see comments on top file galaga_deca.vhd



---------------------------------
Compiling
---------------------------------

 - you would need the original MAME ROM files
 - use tools included to convert ROM files to VHDL (read original README.txt)
   -   cs54xx_prog.vhd is not used in the Mist port
 - put the VHDL ROM files (.vhd) into the rtl_dar/proms directory
 - build galaga_xxxx  from corresponding fpga folder

You can build the project with ROM image embedded in the sof file.
*DO NOT REDISTRIBUTE THESE FILES*

See original [README.txt](README.txt)
------------------------

