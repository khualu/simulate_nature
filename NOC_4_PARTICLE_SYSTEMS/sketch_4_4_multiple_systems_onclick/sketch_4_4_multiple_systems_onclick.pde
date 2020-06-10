ArrayList<ParticleSystem> systems;

void setup() {
 size(640,360);
 systems = new ArrayList<ParticleSystem>();
 background(255);
 smooth();
}

void draw() {
 background(255);
  
 for (ParticleSystem ps : systems) {
   ps.addParticle();
   ps.run();  
 }
}

void mousePressed() {
  systems.add(new ParticleSystem(1,new PVector(mouseX,mouseY)));
}
