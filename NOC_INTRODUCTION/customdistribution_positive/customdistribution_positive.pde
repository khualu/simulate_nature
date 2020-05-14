int i = 0;

void setup() {
  size (500,500);
  background(255);
}

void draw() {
  float r1 = random(0,500);
  float r2 = random(0,500);
  
  if (r2 < r1) {
     fill(1,1);
     ellipse(r1,r1,5,5);
     i++;
     print(i + ", ");
     
     if (i == 100) {
       noLoop();
     }
  } else {
     return;
  }

}
