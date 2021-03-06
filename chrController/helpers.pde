
// state enums
static final int GROUNDED = 0;
static final int WALKING = 1;
static final int JUMPING = 2;
static final int FALLING = 3;
static final int DOUBLEJUMP = 4;
static final int FALLFROMDOUBLEJUMP = 5;

//a few globals
boolean debug = false; // for showing framerate

//helper function
int signOf( float input ) {
  if( floor(input) >= 0 ) {
    return 1;
  }
  return -1;
}

// AABB collision test against platforms
 boolean collides( int chrPosX, int chrPosY, int hw ) { 
     for( int i=0; i<platforms.size(); i++ ) {
          Platform p = platforms.get(i);
          if( abs(chrPosX - p.centroid.x) > hw + p.halfX ) { continue; }
          if( abs(chrPosY - p.centroid.y) > hw + p.halfY ) { continue; }
          else{ 
               if( chrPosY < p.centroid.y ) {
                    player.isGrounded = true;
               }
               return true; 
          }
     }
     return false;
}
