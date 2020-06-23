class Surface {
  Vec2[] vcs = new Vec2[6];
  Vec2[] vcsPixels = new Vec2[vcs.length];
  
  Surface() {
  vcs[0] = box2d.coordPixelsToWorld(0,height-50);
  vcs[1] = box2d.coordPixelsToWorld(width/5,height/2);
  vcs[2] = box2d.coordPixelsToWorld(width/5*2,height-50);
  vcs[3] = box2d.coordPixelsToWorld(width/5*3,height-50);
  vcs[4] = box2d.coordPixelsToWorld(width/5*4,height/2);
  vcs[5] = box2d.coordPixelsToWorld(width/5*5,height-50);
  
  ChainShape cs = new ChainShape();
  cs.createChain(vcs, vcs.length);
  
  // Edge of chain is now a body
  BodyDef bd = new BodyDef();
  Body body = box2d.createBody(bd);
  
  body.createFixture(cs,1);
  }
  
  void display() {
  for (int t = 0; t < vcs.length; t++){
     vcsPixels[t] = box2d.coordWorldToPixels(vcs[t]); 
  }
   strokeWeight(1);
   stroke(0);
   beginShape();
   for (int l = 0; l < vcs.length; l++) {
     vertex(vcsPixels[l].x, vcsPixels[l].y);
   }
   vertex(width, height);
   vertex(0, height);
   fill(0);
   endShape(CLOSE);
  }
}
