float r = 300;
float a = 0.0;
float aVel = 0.0;
float aAcc = 0.01;
float n = 0.02;

void setup(){
 size(640,640); 
 background(0);
}

void draw() {
  
  r -= noise(0.2);
  translate(width/2,height/2);
  float x = r * cos(a);
  float y = r * sin(a);
  fill(255);
  stroke(255);
  line(0,0,x,y);
  ellipse(x,y,10,10);
  
  a += aVel;
  aVel += aAcc;
  //aVel = constrain(aVel,0,0.2);
  
}
