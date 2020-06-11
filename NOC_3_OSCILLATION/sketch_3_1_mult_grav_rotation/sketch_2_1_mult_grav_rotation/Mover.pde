// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {
  float a = 0.0;
  float aVel = 0.0;
  float aAcc = 0.0;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover() {
    location = new PVector(random(100,400),random(20,100));
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    mass = random(0.5, 4);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    a += aVel;
    aVel += aAcc;
    
    aAcc = velocity.x/25;
    constrain(aAcc,-0.001,0.001);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0,127);
    pushMatrix();
    translate(location.x,location.y);
    rotate(radians(a));
    rectMode(CENTER);
    rect(0,0,mass*16,mass*16);
    popMatrix();
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }

  }

}
