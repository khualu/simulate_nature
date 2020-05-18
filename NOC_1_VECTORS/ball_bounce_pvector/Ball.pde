class Ball {
  
 PVector position;
 PVector velocity;
 
 Ball() {
  position = new PVector(width/2,height/2);
  velocity = new PVector(4, -1.5);
 }
  
 void move() {
  position.add(velocity); 
 }
  
 void bounce() {
   //Bounce logic
  if (( position.x > width) || position.x < 0) {
    velocity.x = velocity.x * -1;
  }
  if (( position.y > height) || position.y < 0) {
   velocity.y = velocity.y * -1; 
  }
   
 }
 
 void display() {
  stroke(0);
  strokeWeight(2);
  fill(182);
  ellipse(position.x,position.y,50,50);
 }
  
}
