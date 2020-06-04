void setup( )
{
  size(200, 200);
  background(255);
  smooth();
  line(0, 0, 200, 0); // draw axes
  line(0, 0, 0, 200);
  
  pushMatrix();
  fill(255, 0, 0);
  rotate(radians(30));
  translate(70, 70);
  scale(2.0);
  rect(0, 0, 20, 20);
  popMatrix();

  pushMatrix();
  fill(255);
  stroke(0);
  translate(70, 70);
  rotate(radians(30));
  scale(2.0);
  rect(0, 0, 20, 20);
  popMatrix();
}

