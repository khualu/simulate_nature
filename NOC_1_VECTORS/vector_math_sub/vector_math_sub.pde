void setup() {
 size(500,300); 
}

void draw(){
    background(255);
    strokeWeight(2);
    stroke(0);
    noFill();
    
    // THIS PUTS THE (0,0) IN THE CENTER OF THE SCREEN
    translate(width/2, height/2);
    
    PVector mouse = new PVector(mouseX,mouseY);
    PVector center = new PVector(width/2,height/2);
    
    //Subtracting vectors to show discrepancy
    mouse.sub(center);
    
    //draw line between new values of Vector.mouse &  Vector.center
    line(0,0,mouse.x,mouse.y);
}
