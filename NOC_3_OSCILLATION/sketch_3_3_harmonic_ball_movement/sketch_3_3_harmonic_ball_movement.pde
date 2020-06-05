float amplitude = 300;
float period = 150;

void setup() {
 size(640,360);
}

void draw() {
 background(255);
 translate(width/2, height/2);
 
 float x = amplitude *  sin((frameCount/period) * TWO_PI);
 fill(127);
 stroke(0);
 line(0,0,x,0);
 ellipse(x,0,36,36);
}
