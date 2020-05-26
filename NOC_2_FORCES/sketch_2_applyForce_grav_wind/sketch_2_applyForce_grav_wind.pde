Mover m;

void setup() {
  size(640,360);
  m = new Mover();
}

void draw() {
  background(255);
  
  PVector grav = new PVector (0, 0.4);
  m.applyForce(grav);
  
  PVector wind = new PVector (0.2,0);
  if (mousePressed) {
     m.applyForce(wind); 
  }
  
  // execute all functions
  m.update();
  m.edges();
  m.display();
}
