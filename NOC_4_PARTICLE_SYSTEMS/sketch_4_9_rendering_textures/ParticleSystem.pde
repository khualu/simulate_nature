class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  PVector img;

  ParticleSystem(PVector position, PImage img_) {
    origin = position.get();
    particles = new ArrayList<Particle>();
    img = img_;
  }

  
  void addParticle() {
    particles.add(new Particle(origin, img));
  }

  // A function to apply a force to all Particles
  void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
