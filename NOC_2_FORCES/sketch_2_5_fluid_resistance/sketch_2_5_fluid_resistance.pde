// Five moving bodies
Mover[] movers = new Mover[9];

// Liquid
Liquid liquid;
Liquid gas;
Liquid weird;

void setup() {
  size(640, 600);
  reset();
  // Create liquid object
  gas = new Liquid(0, 150, width, 80, 0.25);
  liquid = new Liquid(0, 300, width, 80, 0.1);
  weird = new Liquid(0, 450, width, 80, -0.01);
}

void draw() {
  background(255);

  // Draw water
  liquid.display();
  gas.display();
  weird.display();

  for (int i = 0; i < movers.length; i++) {

    // Is the Mover in the liquid?
    if (liquid.contains(movers[i])) {
      // Calculate drag force
      PVector dragForce = liquid.drag(movers[i]);
      // Apply drag force to Mover
      movers[i].applyForce(dragForce);
    }
    
    if (gas.contains(movers[i])) {
      // Calculate drag force
      PVector dragForce = gas.drag(movers[i]);
      // Apply drag force to Mover
      movers[i].applyForce(dragForce);
    }
    
    if (weird.contains(movers[i])) {
      PVector dragForce = weird.drag(movers[i]);
      movers[i].applyForce(dragForce);
    }

    // Gravity is scaled by mass here!
    PVector gravity = new PVector(0, 0.1*movers[i].mass);
    // Apply gravity
    movers[i].applyForce(gravity);

    // Update and display
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }

  fill(0);
  text("click mouse to reset", 10, 30);
}

void mousePressed() {
  reset();
}

// Restart all the Mover objects randomly
void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 3), 40+i*70, 0);
  }
}
