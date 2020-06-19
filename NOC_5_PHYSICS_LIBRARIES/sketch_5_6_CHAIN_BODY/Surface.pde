class Surface {
  
  Surface() {
  ChainShape cs = new ChainShape();
  
  Vec2[] vcs = new Vec2[3];
  
  vcs[0] = box2d.coordPixelsToWorld(50,height/4);
  vcs[1] = box2d.coordPixelsToWorld(350,height/2);
  vcs[2] = box2d.coordPixelsToWorld(600,height/5);
  
  cs.createChain(vcs, vcs.length);
  
  // Edge of chain is now a body
  BodyDef bd = new BodyDef();
  Body body = box2d.createBody(bd);
  
  body.createFixture(cs,1);
  }
  
  void display() {
   strokeWeight(1);
   stroke(0);
   fill(0);
   beginShape();
   for (Vec2 v: surface) {
    vertex(v.x, v.y); 
   }
   
   vertex(width,height);
   vertex(0,height);
   endShape(CLOSE);
  }
}
