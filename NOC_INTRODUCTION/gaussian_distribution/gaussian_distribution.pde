import java.util.Random;

Random generator;

void setup() {
  size(1000, 100);
  generator = new Random();
  background(255);
  
  
}

void draw() {
  
  
  // casting syntax for Java, this is float(generator.nextGaussian())
  float x = (float) generator.nextGaussian();
  float stddev = 50;
  float mean = width/2;
  
  x = x * stddev;
  x = x + mean;
  
  fill(0, 10);
  noStroke();
  ellipse(x, height/2, 10, 10);
}
