class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  
  float mass;
 
  Mover() {
    pos = new PVector(random(width),height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    mass = random(0.5,4);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void edges() {
  if (pos.x > width) {
    pos.x = width;
    vel.x *= -1;
    } else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    } else if (pos.y > height)  {
     vel.y *= -1; 
     pos.y = height;
     }
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(pos.x, pos.y,mass*20,mass*20);
  }
  
  void applyForce(PVector force) {
     PVector f = PVector.div(force,mass);
     acc.add(f);
  }
}
