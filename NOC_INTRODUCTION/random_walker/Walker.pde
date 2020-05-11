class Walker {
  int x,y;
  
  Walker () {
    x = width/2;
    y = height/2;
  }
  
  void render() {
    stroke(0);
    point(x,y);
  }
  
   void step() {
   int choice = int(random(4));
   
   if (choice == 0) {
     x = x + int(random(5));
   } else if (choice == 1) {
     x = x - int(random(5));
   } else if (choice == 2) {
     y = y + int(random(5)); 
   } else {
     y = y - int(random(5));
    }
  }
  
  void reset() {
    if (x <= 0) {
      x = width/2;
      y = height/2;
    } else if (x >= width) {
      x = width/2;
      y = height/2;
    } else if (y <= 0) {
      x = width/2;
      y = height/2;
    } else if (y >= height) {
      x = width/2;
      y = height/2;
    }
  }
  
  //void step() {
  // int choice = int(random(8));
   
  // if (choice == 0) {
  //    x++;
  // } else if (choice == 1) {
  //   x--;
  // } else if (choice == 2) {
  //   y++;
  // } else if (choice == 3) {
  //   y--;
  // } else if (choice == 4) {
  //   x++;
  //   y++;
  // } else if (choice == 5) {
  //   x--;
  //   y--;
  // } else if (choice == 6) {
  //   x++;
  //   y--;
  // } else  {
  //   x--;
  //   y++;
  // }
  //}
  
}
