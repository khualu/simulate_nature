void setup() {
 size(400,100);
 background(255);
 
 for (int i = 10; i < 350; i = i + 50) {
  house(i, 10); 
 }
}

void house(int x, int y) {
 pushMatrix();
 translate(x,y);
 triangle(15,0,0,15,30,15);
 triangle(45,30,30,45,60,45);
 rect(60,60,20,20);
 popMatrix();
}
