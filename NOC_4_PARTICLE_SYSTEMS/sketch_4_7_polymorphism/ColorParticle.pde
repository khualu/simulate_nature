class ColorParticle extends Particle {
    ColorParticle (PVector l) {
     super(l); 
  }
  
  void display() {
   fill(random(100,255),random(100,255),random(100,255));
   ellipse(position.x,position.y,20,20);
   stroke(0);
  }
  
}
