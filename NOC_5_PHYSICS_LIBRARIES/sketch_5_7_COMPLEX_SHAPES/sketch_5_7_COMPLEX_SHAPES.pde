import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

ArrayList<Boundary> boundaries;
ArrayList<CustomShape> polygons;

void setup() {
  size(640,360); 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-20);
  
  polygons = new ArrayList<CustomShape>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/4,height-5,width/2-100,10));
  boundaries.add(new Boundary(3*width/4,height-50,width/2-100,10));
}

void draw() {
  background(255);
  box2d.step();
  
  for (Boundary wall: boundaries) {
   wall.display(); 
  }

  for (CustomShape cs: polygons) {
    cs.display();
  }
 
 for (int i = polygons.size()-1; i >= 0; i--) {
   CustomShape b = polygons.get(i);
   if (b.done()) {
    polygons.remove(i); 
   }
 }
}

void mousePressed() {
  CustomShape cs = new CustomShape(mouseX,mouseY);
  polygons.add(cs);
}
