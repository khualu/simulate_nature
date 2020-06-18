import shiffman.box2d.*;

ArrayList<Box> boxes;

Box2DProcessing box2d;

void setup() {
  size(640,360); 
  background(255);
  boxes = new ArrayList<Box>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}

void draw() {
  background(255);
  
  box2d.step();
  
  
  if (mousePressed) {
    Box p = new Box(mouseX,mouseY); 
    boxes.add(p);
 }
 
  for (Box b : boxes) {
    b.display(); 
 }
}
