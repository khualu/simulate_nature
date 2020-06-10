class Particle {
   PVector pos;
   PVector vel;
   PVector acc;
   float mass;
   float lifespan;
   
  Particle(PVector l) {
     acc = new PVector(0,0.05);
     vel = new PVector(random(-1,1),random(-1,0));
     pos = l.get();
     lifespan = 255.0;
  }
  
  void run() {
   update();
   display();
  }
  
   void update() {
    vel.add(acc);
    pos.add(vel);
    lifespan -= 2.0;
  }
  
  void display() {
   stroke(0, lifespan);
   strokeWeight(2);
   fill(127, lifespan);
   ellipse(pos.x,pos.y,12,12);
  }
  
  boolean isDead() {
   if (lifespan < 0.0) {
    return true; 
   } else {
       return false;
   }
  }
 
  //void applyForce(PVector force) {
  // PVector f = PVector.div(force,mass);
  // acc.add(f);
  //}
}
