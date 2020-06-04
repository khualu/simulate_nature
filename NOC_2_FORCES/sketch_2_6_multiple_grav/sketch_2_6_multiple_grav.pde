// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers;
Attractor a;

void setup() {
  size(640,360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
  a = new Attractor();
}

void draw() {
  background(255);

  for (Mover m : movers) {
    PVector force = a.attract(m);
    m.applyForce(force);
    m.update();
    m.display();
  }

  a.drag();
  a.hover(mouseX,mouseY);
 
  a.display();
 
}

void mousePressed() {
  a.clicked(mouseX,mouseY); 
}

void mouseReleased() {
  a.stopDragging(); 
}
