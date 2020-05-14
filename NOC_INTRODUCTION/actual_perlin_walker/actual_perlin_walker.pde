Walker w;

void setup() {
  size(640,360);
  w = new Walker();
  background(0);
}

void draw() {
  // Run the walker object
  w.step();
  w.render();
}
