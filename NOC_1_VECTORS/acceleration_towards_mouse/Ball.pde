class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector mouse;
 
  Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update(){
    PVector mouse = new PVector(mouseX,mouseY);
    mouse.sub(position);
    mouse.setMag(0.35);
    acceleration = mouse;
    
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
    ellipse(position.x, position.y,48,48);
  }
}
