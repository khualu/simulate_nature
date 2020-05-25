Mover m;

void setup() {
  size(640,360);
  m = new Mover();
}

void draw() {
  background(255);
  m.update();
  m.edges();
  m.display();
}
