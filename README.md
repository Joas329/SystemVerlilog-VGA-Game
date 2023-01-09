# SystemVerlilog-VGA-Game
A simple game using the VGA module from the DE10-lite 

## Modules:
The videogame consists of the following modules:
Clk_1ms
A simple clock division module that takes the 50MHz original clock from the DE10-lite and divides into a clock that ticks every 1ms. The output of this clock is later used on other modules for speed measures.
Enemy
This is the enemy module that produces the exact position of the enemy block by adding one unit to its y-coordinate. Moreover, it also checks
### Inputs:
•	X counter from the VGA module
•	Y counter from the VGA module
•	Clk 50MHz clock from the board
### Outputs:
•	X_enemy  The horizontal position of the enemy
•	Y_enemy  the vertical position of the enemy
## Player
This module deals with tracking the position of the player based on the inputs of two buttons that are implemented using the I/O ports of the DE10-lite
### Inputs:
•	Clk_1ms  clock of 1ms 
•	Button  Arduino button that takes the input for the left button.
•	Button1  Arduino button that takes the input for the right button.
•	X and Y  position counter from the VGA module that track the pixel from the screen’s horizontal and vertical position in reference to the screen.
### Outputs:
•	X_player  the horizontal position of the player with reference to the screen.
•	Y_player  the vertical position of the player with reference to the screen.
## Button Hardware Design:
The part of the code that takes the input of the button is:

 ![image](https://user-images.githubusercontent.com/51135069/211236618-88a4294a-7588-4b18-af5d-7251222d1d91.png)

This meaning that the input is waiting a positive signal of 1’b1 to enable the conditional block. Hence, we can define the simple hardware of the button to produce a HIGH signal of 1’b1 once the button has been pressed. 
 ![image](https://user-images.githubusercontent.com/51135069/211236624-6b9fead8-a0a4-4643-a669-549991b6a2f6.png)
## VGA
 ![image](https://user-images.githubusercontent.com/51135069/211236654-7722fadf-ccf8-4861-8259-430d4656b2e6.png)

Tables from DE10-lite User Manual
This module produces the two counters for the vertical and horizontal variables that reference the position of a pixel in the screen. Moreover, this counter have a standard of how to be made as the VGA connection can only go from 0 to 799 pixels horizontally, from which only 460 pixels can be changed colors. On the other hand, for the vertical counter, it reaches until 524 from which only 480 can be used to display colors. The module outputs these two outputs and then the game is render with the help of another module that acts as an interface where all other game’s modules and players will be rendered.
### Inputs:
•	Clk  Original 50MHz clock from the board
### Outputs:
•	Hsynq  Horizontal synchronization variables
•	Vsynq  Vertical synchronization Variables
•	X   Horizontal coordinate counter
•	Y  Vertical coordinate counter


## Render
This module renders every module and aspect of the game onto the screen by constantly checking the position of the initial coordinate that dictates each player’s character. 
 ![image](https://user-images.githubusercontent.com/51135069/211236689-f0d48e9f-813e-458d-b38a-c2a16cf10a37.png)

To correctly display the position of each aspect of the game, some initial values were calculated to keep track of the hardware boundaries based on the horizontal and vertical counter. Moreover, there have been stated two different horizontal boundaries that restrain the character from further movement and leaving the screen. Tese ones being 264 and 664 pixels.
### Inputs:
•	Clk  Original 50 MHz clock
•	X and Y  Vertical and Horizontal coordinate counters
•	Reset  a button that resets the game from the losing screen to paly again
•	X_player and Y_player  coordinate counters for the player
•	X_enemy and y_enemy  coordinate counters for the enemy
###Outputs:
•	RGB  three different values that are the three colors that the VGA connection uses to display colors on the screen. These colors are later assigned as outputs to the screen.
# Implementation:
## Game Logic Implementation:
The game works the following way:
The moment the program is sent into the board, the game is already running. The enemy will come towards the player and if this one touches the player, the screen will go red indicating that the game has been lost. Nevertheless, one can restart the game by pressing the restart button.
## Module Connection Schematic:
 ![image](https://user-images.githubusercontent.com/51135069/211236671-5f436c0e-180a-44eb-8d42-97d3e9520a1c.png)



