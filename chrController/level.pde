
// class (struct) for platforms. Data is x/y of upper left corner, then width and height
class Platform {
     
     int originX;
     int originY;
     int platformLength;
     int platformHeight;
     PVector centroid;
     int halfX;
     int halfY;
     
     Platform( int a, int b, int c, int d ) {
          originX = a;
          originY = b;
          platformLength = c;
          platformHeight = d;
          centroid = new PVector(a+c/2,b+d/2);
          halfX = c/2;
          halfY = d/2;
     }    
}

void generateLevel() {
//     platforms.add( new Platform(0,height-20,width,20) ); // bottom of screen
     platforms.add( new Platform(300,300,100,20) );
     platforms.add( new Platform(20,20,50,10) );
     platforms.add( new Platform(450,450,100,30) );
     platforms.add( new Platform(200,570,300,30) );
}

void renderLevel() {
     fill(255);
     stroke(255);
     for( int i=0; i<platforms.size(); i++ ) {
          Platform p = platforms.get(i);
          rect( p.originX, p.originY, p.platformLength, p.platformHeight );
          stroke(0);
          ellipse( p.centroid.x, p.centroid.y, 4, 4 );
     }
}
