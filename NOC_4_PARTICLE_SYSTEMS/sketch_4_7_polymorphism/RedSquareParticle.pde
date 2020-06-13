class ReqSquareParticle extends Particle {
  
  float a = 0.0;
  float aVel = 0.0;
  float aAcc = 0.0;
 
  ReqSquareParticle (PVector l) {
   super(l); 
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
    
    a += aVel;
    aVel += aAcc;
    aAcc += lifespan/(lifespan*lifespan);
  }
  
  void display(){
    fill(255,100,0,100);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    rotate(radians(a));
    rectMode(CENTER);
    rect(0,0,16,16);
    popMatrix();
  } 
}
