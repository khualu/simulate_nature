class ParticleSystem {
  
  ArrayList<Particle> particles;
  PVector origin;

 
  ParticleSystem() {
     particles = new ArrayList<Particle>();
    
  }
  
  void addParticle(){
    //particles.add(new Particle());
    particles.add(new Particle(new PVector(width/2,50)));
  }
  
  void run() {
    
   for (int i = particles.size() -1; i >= 0; i --) {
     Particle p = particles.get(i);
     p.update();
     p.display();
   
     if (p.isDead()) {
       particles.remove(i); 
     }
   }  
  }
  
}
