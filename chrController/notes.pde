/*I don't love this controller - double jump is not handled right,
and keyboard input is messy (relies on keyReleased() events, which is not very reliable).
The physics are by no means "real" physics but are the type you'd see in a 2D platformer.

The FSM in the Character class is not too bad. One of the things to note about a character 
controller FSM is that each state is only allowed to transfer to certain other states. That's reflected
in the code here.

Other notes:
 - There's a debug feature that shows when the framerate drops below 60 (which is a lot) with a red dot in the upper left
 - The movement is frame-locked, which is not ideal. If I get some time I might add a "deltatime" feature that makes movement
 smooth regardless of the framerate
*/
