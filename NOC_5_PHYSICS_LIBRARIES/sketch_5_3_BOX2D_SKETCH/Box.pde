class Box {
   float x,y;
   float w,h; 
   
   // Define the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC();
   bd.position.set(x,y);
   
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
