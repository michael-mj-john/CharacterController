
// state enums
static final int GROUNDED = 0;
static final int WALKING = 1;
static final int JUMPING = 2;
static final int FALLING = 3;
static final int MOVING_RIGHT = 1;
static final int MOVING_LEFT = 2;

//a few globals
boolean jumpPressed = false;
boolean jumpAllowed = true;
int leftRight;

//helper function
int signOf( float input ) {
  if( floor(input) >= 0 ) {
    return 1;
  }
  return -1;
}
