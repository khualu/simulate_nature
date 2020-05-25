class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector t_noise;
 
  Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    t_noise = new PVector(0,0);
  }
  
  void update(){
    // creating perlin noise
    p += 0.01;
    pnoise = noise(p);
    
    //creating movement
    acceleration = PVector.random2D();
    acceleration.mult(pnoise);
    
    velocity.add(acceleration);
    position.add(velocity);
    
    velocity.limit(5);
  }
  
  void edges() {
  if (position.x > width)   position.x = 0;
  if (position.x < 0)       position.x = width;
  if (position.y > height)  position.y = 0;
  if (position.y < 0)       position.y = height;
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(position.x,position.y,48,48);
  }
}
