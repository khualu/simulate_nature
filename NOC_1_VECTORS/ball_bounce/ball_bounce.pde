float x = 120;
float y = 300;

int xspeed = 5;
int yspeed = 5;

void setup() {
  size(600,600);
  background(255);
}

void draw() {
  //Redraw background
  background(255);
  
  // Step functions
  x = x + xspeed;
  y = y + yspeed;
  
  //Bounce logic
  if (( x > width) || x < 0) {
    xspeed = xspeed * -1;
  }
  if (( y > height) || y < 0) {
   yspeed = yspeed * -1; 
  }
  
  
  // Draw circle
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(x,y,10,10);
}
