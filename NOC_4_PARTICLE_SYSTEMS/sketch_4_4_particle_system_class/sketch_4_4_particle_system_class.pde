ArrayList<Particle> particles;

void setup() {
 size(640,360);
 particles = new ArrayList<Particle>();
 for (int i = 0; i < 10; i++) {
   particles.add(new Particle(new PVector(width/2,50)));
 }
 background(255);
 smooth();
}

void draw() {
 background(255);

 particles.add(new Particle(new PVector(width/2,50)));

   
 for (int i = particles.size() -1; i >= 0; i --) {
   Particle p = particles.get(i);
   p.update();
   p.display();
   
   if (p.isDead()) {
      particles.remove(i); 
   }
 }
 
 //if (particles.size() > 100) {
 //   particles.remove(0); 
 //}
}
