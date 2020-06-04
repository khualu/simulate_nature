// show pivot points on robot's shoulders
void setup()
{
  size(200, 200);
  background(255);
  smooth();
  drawRobot();
}

void drawRobot()
{
  noStroke();
  fill(38, 38, 200);
  rect(20, 0, 38, 30); // head
  rect(14, 32, 50, 50); // body

  fill(255, 0, 0);
  ellipse(11, 32, 4, 4);
  ellipse(66, 32, 4, 4);
  fill(38, 38, 200);
  rect(0, 32, 12, 37); // left arm
  rect(66, 32, 12, 37); // right arm
  
  
  
  rect(22, 84, 16, 50); // left leg
  rect(40, 84, 16, 50); // right leg
  
  fill(222, 222, 249);
  ellipse(30, 12, 12, 12); // left eye
  ellipse(47, 12, 12, 12);  // right eye
}
