void setup()
{
  size(400, 100);
  background(255);
  for (int i = 10; i < 350; i = i + 50)
  {
    house(i, 20);
  } 
}


void house(float x, float y)
{
  pushMatrix();
  translate(x, y);
  triangle(15, 0, 0, 15, 30, 15);
  rect(0, 15, 30, 30);
  rect(12, 30, 10, 15);
  popMatrix();
}


