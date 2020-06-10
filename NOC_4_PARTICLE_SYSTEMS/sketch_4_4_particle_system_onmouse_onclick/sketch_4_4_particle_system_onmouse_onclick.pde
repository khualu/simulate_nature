ParticleSystem ps;

void setup() {
 size(640,360);
 ps = new ParticleSystem();
 background(255);
 smooth();
}

void draw() {
 background(255);

 if (mousePressed){
 ps.addParticle();
 }
 ps.run();
   

}
