float y = 0;
float startAngle = 0;
float amplitude = 100;
float angleVel = 0.23;

void setup() {
 size(600,300); 
}

void draw() {
  background(0);
  startAngle += 0.015;
  float angle = startAngle;
  
  for( int x = 0; x < width; x = x + 30)
  {
    float y = amplitude * sin(angle);
    pushMatrix();
    translate(0,height/2);
    ellipse(x,y,36,36);
    fill(128,128,128,90);
    stroke(90);
    popMatrix();
  angle += angleVel;
  }
  angle += 0.05;
}
