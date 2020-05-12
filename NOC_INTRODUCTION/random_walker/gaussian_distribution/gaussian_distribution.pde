import java.util.Random;

Random generator;

void setup() {
  size(400, 300);
  generator = new Random();
  
  
}

void draw() {
  background(255);
  
  // casting syntax for Java, this is float(generator.nextGaussian())
  float x = (float) generator.nextGaussian();
  float stddev = 15;
  float mean = width/2;
  
  x = x * stddev;
  x = x + mean;
  
  fill(0, 10);
  ellipse(x, height/2, 10, 10);
}
