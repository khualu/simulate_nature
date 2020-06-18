class Box {
   float x,y;
   float w,h; 
   
   Box(int x_, int y_) {
    x = x_;
    y = y_;
    w = 10;
    h = 10;
   }
   
   void display() {
      fill(127);
      rect(x,y,w,h);
      rectMode(CENTER);
   }
}
