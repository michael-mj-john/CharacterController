class PlayerCharacter {
  
  // hopefully all of these fields are self-explanatory. 
  PVector position;
  final int chrSize = 20;
  PVector velocity;
  PVector gravity;
  PVector friction;
  PVector jumpForce;
  PVector doubleJumpForce;
  PVector airAccel; // use a different steering value when in the air
  PVector groundAccel; // default acceleration left/right
  float xClamp; // max speed
  int state;  // see "helpers" file for list of possible states
  boolean jumpPressed = false;
  boolean jumpLocked = false; // to "debounce" the space bar
  boolean hasJumped = false;
  boolean hasDoubleJumped = false;
  int doubleJumpWindow = 300; // milliseconds before double jump is allowed
  int jumpedFrame;
  
  PlayerCharacter() {
    position = new PVector( width/2, height-chrSize );
    velocity = new PVector( 0,0 );
    gravity = new PVector( 0,0.5);
    friction = new PVector( 0.15,0);
    jumpForce = new PVector( 0,-15 );
    doubleJumpForce = new PVector( 0,-12 );
    groundAccel = new PVector(.4, 0 );
    airAccel = new PVector(.2,0);
    xClamp = 4;
    leftRight = 0; //this tracks whether 'a' or 'd' is being held down
  }
  
  void update() {
    if( keyPressed ) {
      if( key == 'a' ) {
        leftRight = MOVING_LEFT;
      }
      if( key == 'd' ) {
        leftRight = MOVING_RIGHT;
      }
    }
    switch( state ) {
      case GROUNDED:
        updateGrounded();
        break;
      case JUMPING:
        updateJumping();
        break;
      case FALLING:
        updateFalling();
        break;
    }
    move();
    println(state);
  }
  
  void move() {
    position.add(velocity); 
    if( !isGrounded() ) {
      velocity.add(gravity);
    }
    //clamp x to edges of screen
    if( position.x > (width - chrSize ) ) { position.x = width - chrSize; }
    if( position.x < 0  ) { position.x = 0; }
    
  }
  
  // isGrounded is a very basic test here, which only works because the character is
  // only on the bottom of the screen. A more sophisticated isGrounded routine would be
  // needed for a real game
  boolean isGrounded() {
     if( position.y >= height - chrSize ) {
       position.y = height - chrSize ;
       velocity.y = 0;
       return true;
     }
     return false;
  }
  
  // this is the code that executes if the character is running or standing on a surface
  void updateGrounded() {
    if( jumpPressed && !jumpLocked ) {  
      velocity.add( jumpForce ); 
      jumpPressed = false;
      jumpedFrame = millis();
      state = JUMPING;
    }
    // move left/right
    if( leftRight == MOVING_LEFT ) {
      if( velocity.x >= -xClamp ) velocity.x -= groundAccel.x;  
    }
    if( leftRight == MOVING_RIGHT ) {
        if( velocity.x <= xClamp ) velocity.x += groundAccel.x;
    }  
    // due to the way this works, the character will never actually stop unless we force it.  //<>//
    // if the current velocity is less than friction, we force velocity to be zero
    if( abs(velocity.x) < friction.x ) { velocity.x = 0; }
    // otherwise, apply friction as normal. Note that the friction vector is reversed depending on the direction of movement
    else { velocity.x -= signOf(velocity.x) * friction.x; }    
  }
  
  // code for when player is jumping (on the up part of the arc).
  // It  might seem redundant, but almost always these kinds of 
  // controllers separate "jumping" from "falling", for a variety of reasons.
  // note that JUMPING can *only* transition to FALLING in this FSM 
  // (in a real game you'd also have states like "HIT" or "DEAD" that are valid)
  void updateJumping() {
    // if player has gone beyond apex of jump
    if( velocity.y > 0 && state == JUMPING ) {
      state = FALLING; // valid state to xfer to from jumping
    }
    // air steering
    if( keyPressed ) {
      if( key == 'a' && velocity.x >= -xClamp ) { velocity.x -= airAccel.x; }
      if( key == 'd' && velocity.x <= xClamp )  { velocity.x += airAccel.x; }
    }
    // handle double jump
    if( jumpPressed && !hasDoubleJumped ) {
      if( millis()-jumpedFrame < doubleJumpWindow ) { jumpPressed = false; } // not allowed to double jump too soon
      else {
        velocity.add( doubleJumpForce ); 
        jumpPressed = false;
        hasDoubleJumped = true;
        state = JUMPING;
      }
    }
  }
  
  // falling updater. Importantly, it manages whether the jump key will be honored
  // during the fall.
  void updateFalling() {
    // if player landed, e.g. on a platform
    if( isGrounded() ) {
       velocity.y = 0;
       state = GROUNDED;
       jumpPressed = false;
       hasDoubleJumped = false;
       return;
    }
    updateJumping(); // for air-steering and double-jump
//    jumpAllowed = false; // only relevant if there is no double-jump
    
  }
    
  void render() {
    fill( 200 );
    rect( position.x, position.y, chrSize, chrSize );
  }
  
  // getter functions
  boolean jumpLocked() {
    return jumpLocked;
  }
  boolean hasJumped() {
    return hasJumped;
  }
  
  // setter functions
  void updateJumpStatus() {
     jumpPressed = true;
     if( !hasDoubleJumped ) { jumpLocked = true; }
  }
  void unlockJump() {
    jumpLocked = false;
  }
}
