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
  
    PVector wind = new PVector (0.2,0);
    if (mousePressed) {
      wind.div(m.mass);
      m.applyForce(wind); 
    }
    // execute all functions
    m.update();
    m.edges();
    m.display();
  }
}
