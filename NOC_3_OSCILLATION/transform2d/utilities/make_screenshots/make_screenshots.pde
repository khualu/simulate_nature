PFont font; 

void setup()
{
  size(400, 400);
  background(255);
  fill(0);
  font = loadFont("LiberationSans-9.vlw"); 
  
  pushMatrix();
  
  step5( );
  
  popMatrix( );
}

void step1( )
{
  fill(128);
  stroke(128);
  translate(20, 20);
  drawGrid( );
  noStroke();
  fill(0);
  //rect(20, 20, 40, 40); // original.png
}

void step2()
{
  fill(128);
  stroke(128);
  translate(20, 20);
  drawGrid( );
  fill(192);
  rect(20, 20, 40, 40);
  stroke(255, 0, 0);
  arrowLine(60, 60, 80, 100, 0, radians(30), false);
  fill(0);
  noStroke();
  rect(80, 100, 40, 40); // new_coords.png
}

void step3()
{
  fill(192);
  stroke(192);
  translate(20, 20);
  drawGrid( );
  fill(192);
  rect(20, 20, 40, 40);
  pushMatrix();
  translate(60, 80);
  fill(128);
  stroke(128);
  drawGrid( );
  fill(0);
  rect(20, 20, 40, 40);
  popMatrix();
  stroke(255, 0, 0);
  arrowLine(0, 0, 60, 80, 0, radians(30), false);
  save("moved_grid.png");
}

void step4()
{
  fill(192);
  stroke(192);
  pushMatrix();
  translate(100, 100);
  drawGrid( );
  fill(192);
  rect(40, 40, 40, 40);
  rotate(radians(45));
  fill(128);
  stroke(128);
  drawGrid(false);
  fill(0);
  rect(40, 40, 40, 40);
  popMatrix();
  stroke(255, 0, 0);
  noFill();
  ellipseMode(CENTER);
  strokeWeight(1.5);
  arc(100, 100, 400, 400, 0, radians(45));
  arrowhead(100 + 200 * cos(radians(45)),
    100 + 200 * sin(radians(45)),
    7*PI/4, radians(30), false);
  // arrowLine(0, 0, 60, 80, 0, radians(30), false);
  save("/home/david/processing_tutorials/transforms/imgs/rotated_grid.png");
}

void step5()
{
  fill(192);
  stroke(192);
  pushMatrix();
  translate(100, 100);
  drawGrid( );
  fill(192);
  rect(40, 40, 40, 40);

  translate(40, 40);
  drawGrid(false);
  
  rotate(radians(45));
  fill(128);
  stroke(128);
  drawGrid(true);
  
  fill(0);
  rect(0, 0, 40, 40);
  popMatrix();
  stroke(255, 0, 0);
  noFill();
  ellipseMode(CENTER);
  strokeWeight(1.5);
  arrowLine(100, 100, 140, 140, 0, radians(30), false);
  
  arc(140, 140, 400, 400, 0, radians(45));
  arrowhead(140 + 200 * cos(radians(45)),
    140 + 200 * sin(radians(45)),
    7*PI/4, radians(30), false);
  
  save("/home/david/processing_tutorials/transforms/imgs/correct_grid.png");
}
