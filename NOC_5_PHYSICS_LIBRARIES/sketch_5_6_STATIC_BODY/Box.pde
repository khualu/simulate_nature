class Box {
   Body body;
   
   float w,h;
   
   Box(float x, float y) {
    w = random(4,20);
    h = random(4,20);
   
   
   // 1. Define the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
   body = box2d.createBody(bd);

   // 2. Create body
   body = box2d.createBody(bd);
   
   // 3. Create a Shape
   PolygonShape ps = new PolygonShape();
   float box2Dw = box2d.scalarPixelsToWorld(w/2); 
   float box2Dh = box2d.scalarPixelsToWorld(h/2); 
   ps.setAsBox(box2Dw, box2Dh);
   
   // 4. Create a fixture
   FixtureDef fd = new FixtureDef();
   fd.shape = ps;
   // Parameters that affect physics
   fd.density = 1;
   fd.friction = 0.3;
   fd.restitution = 0.5;
   
   // 5. Put it together
   body.createFixture(fd);
 }
   
   // Kill function for bodies outside of window
   void killBody(){
    box2d.destroyBody(body);
   }
   
   boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height) {
     killBody();
     return true;
    }
    return false;
   }
   
   void display() {
     // Get the location of the body from Box2D and translate to pixel coordinates
     Vec2 pos = box2d.getBodyPixelCoord(body);
     float a = body.getAngle();
     
     pushMatrix();
     translate(pos.x,pos.y);
     rotate(-a);
     fill(127);
     strokeWeight(2);
     rectMode(CENTER);
     rect(0,0,w,h);
     popMatrix();
   }
}
