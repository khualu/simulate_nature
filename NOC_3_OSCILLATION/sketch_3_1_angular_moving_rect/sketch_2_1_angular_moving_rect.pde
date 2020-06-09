float a = 0.0;
float aVel = 0.0;
float aAcc = 0.0;


void setup() {
 size(640,360); 
}

void draw() {
 background(255);
 
 a += aVel;
 aVel += aAcc;
 
 aAcc = map(mouseX,0,width,-0.02,0.02);
 
 rectMode(CENTER);
 stroke(0);
 fill(128);
 translate(width/2,height/2);
 rotate(radians(a));
 rect(0,0, 64, 36);
}
