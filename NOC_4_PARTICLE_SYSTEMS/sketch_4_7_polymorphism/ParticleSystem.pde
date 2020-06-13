class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    float r = random(1);
    if (r < 0.20) {
      particles.add(new ReqSquareParticle(origin));
    } else if ( r < 0.40) {
      particles.add(new Particle(origin));  
    } else if (r < 0.60) {
      particles.add(new BleepParticle(origin));
    } else if (r < 0.80) {
      particles.add(new ColorParticle(origin));
    } else {
      particles.add(new StarParticle(origin));
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
