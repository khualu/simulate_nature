import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Box> boxes;

Box2DProcessing box2d;

Surface surface;

void setup() {
  size(640,360); 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boxes = new ArrayList<Box>();
  
  surface = new Surface();
}

void draw() {
  box2d.step();
  
  background(255);
  surface.display();
  
  Box p = new Box(width/2,50); 
  boxes.add(p);

  for (Box b : boxes) {
    b.display(); 
 }
 
 for (int i = boxes.size()-1; i >= 0; i--) {
   Box b = boxes.get(i);
   if (b.done()) {
    boxes.remove(i); 
   }
 }
}
