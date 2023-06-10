# Galaga port for Tang nano 20k 

Ports by Somhi adapted from DE10_lite port by Dar (https://sourceforge.net/projects/darfpga/files/Software%20VHDL/galaga/)

[Read history of Galaga Arcade.](https://www.arcade-museum.com/game_detail.php?game_id=7881)

[Parts and Operating Manual](Galaga_-_1981_-_Namco.pdf)

## Note:

This port is not stable and does weird things like not outputting video when game controls are changed, e.g. I had to disable F3/F4/F5 because of that.

### Keyboard players inputs :

~~F3 : Add coins~~
~~F4 : Start 1 player~~
~~F5 : Start 2 player~~
SPACE       : Fire  
RIGHT arrow : right
LEFT  arrow : left

F8 : toggles VGA / RGB video mode

### Playstation gamepads:

START : Add coins
Push mini joystick 1: Start 1 player
Push mini joystick 2 : Start 2 player
2          : Fire  
RIGHT : right
LEFT    : left





Other details : see comments on top file galaga_deca.vhd