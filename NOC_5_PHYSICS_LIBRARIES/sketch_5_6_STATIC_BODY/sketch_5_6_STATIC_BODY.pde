import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Box> boxes;

Box2DProcessing box2d;

ArrayList<Boundary> boundaries;

void setup() {
  size(640,360); 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/4,height-5,width/2-100,10));
  boundaries.add(new Boundary(3*width/4,height-50,width/2-100,10));
}

void draw() {
  background(255);
  
  box2d.step();
  
  Box p = new Box(width/2,50); 
  boxes.add(p);
  
  for (Boundary wall: boundaries) {
   wall.display(); 
  }

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
