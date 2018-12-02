/* Character  Controller Example
by MJ
An example of a 2D platformer style character controller.
It's harder than it looks!

*/

PlayerCharacter player;
int lastMillis; 

void setup() {  
  size( 800, 600 );
  player = new PlayerCharacter();
  frameRate(60);
}

void draw() {
  background( 128 );  
  player.update();
  player.render();
  if( debug ) {
    if( millis() - lastMillis > 17 ) {
      fill(255,0,0);
      ellipse( 20, 20, 20, 20 );
    }
    lastMillis = millis();
  }
  
}

// actions like jump are handled as an event, rather than a state
void keyPressed() {
   if( key == ' ' && !player.jumpLocked() ) {
     player.updateJumpStatus();
   }  //<>//
}

// I was not able to find a good "keyboard polling" routine in Processing. So I have to use these 
// "keyReleased()" events, which causes artifacts when two keys are held down at once.
void keyReleased() {
  if( key == ' ' ) {
    player.unlockJump(); // using a 'setter'.
  }
  if( leftRight == MOVING_LEFT && key == 'a' ) { leftRight = 0; } // these should be class fields, not globals
  if( leftRight == MOVING_RIGHT && key == 'd' ) { leftRight = 0; }
}
