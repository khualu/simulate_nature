void setup()
{
  size(200,200);
  background(255);
  
  stroke(128);
  rect(20, 20, 40, 40);
  
  stroke(0);
  pushMatrix();
  scale(3.0, 0.5);
  rect(20, 20, 40, 40);
  popMatrix();
}

  
