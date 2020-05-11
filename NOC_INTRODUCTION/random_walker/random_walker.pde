Walker w;

void setup() {
  size(800, 600);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.render();
}
