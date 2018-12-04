/* Character  Controller Example
by MJ
An example of a 2D platformer style character controller.
It's harder than it looks!
*/

PlayerCharacter player;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int lastMillis;
boolean spaceBarLock;

void setup() {  
  size( 800, 600 );
  player = new PlayerCharacter();
  generateLevel();
  frameRate(60);
  spaceBarLock = false;
}

void draw() {
  background( 128 );  
  player.update();
  player.render();
  renderLevel();
       
  //this is a framerate monitor that can be enabled with the "debug" global var
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
   if( key == ' ' && !spaceBarLock ) {
     spaceBarLock = true;
     player.jumpPressed = true;
   }  //<>//
   // r = reset
   if( key == 'r' ) {
     player.position.x = width/2;
     player.position.y = 0;
     player.velocity.setMag(0);
   }
}

// I was not able to find a good "keyboard polling" routine in Processing. So I have to use these 
// "keyReleased()" events, which causes artifacts when two keys are held down at once.
void keyReleased() {
  if( key == ' ' ) {
    spaceBarLock = false;
  }
}
