/* Character  Controller Example
by MJ
An example of a 2D platformer style character controller.
It's harder than it looks!
I don't love this controller - double jump is not handled right,
and keyboard input is messy (relies on keyReleased() events, which is not very reliable).
The physics are by no means "real" physics but are the type you'd see in a 2D platformer.

The FSM in the Character class is not too bad. One of the things to note about a character 
controller FSM is that each state is only allowed to transfer to certain other states. That's reflected
in the code here.
*/

PlayerCharacter player;

void setup() {  
  size( 800, 600 );
  player = new PlayerCharacter();
}

void draw() {
  background( 128 );  
  player.update();
  player.render();
}

// actions like jump are handled as an event, rather than a state
void keyPressed() {
   if( key == ' ' && jumpAllowed ) {
     jumpPressed = true; //<>//
     jumpAllowed = false;
   } 
}

// I was not able to find a good "keyboard polling" routine in Processing. So I have to use these 
// "keyReleased()" events, which causes artifacts when two keys are held down at once.
void keyReleased() {
  if( key == ' ' ) {
    jumpAllowed = true;
  }
  if( leftRight == MOVING_LEFT && key == 'a' ) { leftRight = 0; }
  if( leftRight == MOVING_RIGHT && key == 'd' ) { leftRight = 0; }
}
