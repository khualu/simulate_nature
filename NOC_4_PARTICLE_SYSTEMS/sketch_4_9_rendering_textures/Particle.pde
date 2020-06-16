class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  PImage img;
  
  float mass = 1; // Let's do something better here!

  Particle(PVector l, PImage img_) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0;
    img = img_;
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, position.x, position.y);
    //stroke(0,lifespan);
    //strokeWeight(2);
    //fill(127,lifespan);
    //ellipse(position.x,position.y,12,12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
