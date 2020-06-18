ArrayList<Box> boxes;

void setup() {
  size(600,600); 
  background(255);
  boxes = new ArrayList<Box>();
}

void draw() {
 if (mousePressed) {
  Box p = new Box(mouseX,mouseY); 
  boxes.add(p);
 }
 
 for (Box b : boxes) {
  b.display(); 
 }
}
