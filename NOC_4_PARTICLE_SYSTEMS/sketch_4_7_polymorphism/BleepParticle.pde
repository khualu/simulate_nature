class BleepParticle extends Particle {
   BleepParticle (PVector l) {
     super(l); 
  }


  void display(){
    fill(255,0,0,random(255));
    stroke(0);
    ellipse(position.x,position.y,16,16);
  } 
}
