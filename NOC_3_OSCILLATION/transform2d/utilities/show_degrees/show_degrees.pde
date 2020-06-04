// utility program to show the degrees on a circle
void setup()
{
  PFont font;
  float x;
  float y;
  float w;
  size(200, 200);
  background(255);
  ellipse(100, 100, 80, 80);
  font = loadFont("LiberationSans-12.vlw");
  textFont(font);
  fill(0);
  for (int i = 0; i < 360; i += 45)
  {
    pushMatrix();
    translate(100,100);
    rotate(radians(i));
    line(0, 0, 40, 0);
    popMatrix();
    x = 50 * cos(radians(i));
    y = 100 + 50 * sin(radians(i));
  }
  fill(0);
  noStroke();
  text("0\u00b0 45\u00b0 90\u00b0 135\u00b0 180\u00b0", 0, 15);
  text("225\u00b0 270\u00b0 315\u00b0", 0, 30);
  fill(255, 0, 0);
  text("0 \u03c0/4 \u03c0/2 3\u03c0/4 \u03c0", 0, 170);
  text("5\u03c0/4 3\u03c0/2 7\u03c0/4", 0, 185);
 }
