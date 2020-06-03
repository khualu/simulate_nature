Mover[] movers;

void setup() {
  size(640,360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
     movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  
  for (Mover m : movers) {
  
    PVector grav = new PVector (0, 0.4);
    grav.mult(m.mass);
    m.applyForce(grav);
    
    // friction computing
    
    
    
    if (mousePressed) {
      PVector drag = m.vel.get();
      drag.normalize();
      float c = -0.01;
      float speed = m.vel.mag();
      drag.mult(c*speed*speed);
      m.applyForce(drag);
    }
    // execute all functions
    m.update();
    m.edges();
    m.display();
  }
}
