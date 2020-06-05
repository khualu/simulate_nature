float x = 0;
float y = 0;

void setup() {
 size(640,360);
 background(255);
}

void draw() {
  x += 0.1;
  y = sin((frameCount/100) * x * PI) * 50;
  pushMatrix();
  scale(3,1.0);
  translate(10,180);
  stroke(0);
  //strokeWeight(2);
  line(x,y,x,y);
  popMatrix();
}
