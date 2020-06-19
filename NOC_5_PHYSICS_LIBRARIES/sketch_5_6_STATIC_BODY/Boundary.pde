class Boundary {
  float x;
  float y;
  float w;
  float h;
  
  // still need a body for box2d
  Body b;
  
  Boundary(float x_, float y_, float w_, float h_) {
   x = x_;
   y = y_;
   w = w_;
   h = h_;
   
   // Define polygon 
   PolygonShape ps = new PolygonShape();
   float box2dW = box2d.scalarPixelsToWorld(w/2);
   float box2dH = box2d.scalarPixelsToWorld(h/2);
   
   ps.setAsBox(box2dW,box2dH);
   
   
   // create the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.STATIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
   b = box2d.createBody(bd);
   
   // attach the shape with a fixture
   b.createFixture(ps,1);
  }
  
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
  
}
