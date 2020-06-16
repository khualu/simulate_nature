ParticleSystem ps;

void setup() {
  size(640,360);
  PImage img = loadImage("circle_02.png");
  ps = new ParticleSystem(new PVector(width/2,50), img);
}

void draw() {
  background(255);
  
  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1);
  ps.applyForce(gravity);
  
  if (mousePressed) {
    PVector wind = new PVector(0.1,0);
    ps.applyForce(wind);
  }
  
  ps.addParticle();
  ps.run();
}
  
  
