# VECTORS
This part of the video series will exists of 6 different models/examples that will be explained. These are the following:
1. _Vectors_
2. _PVector Class_
3. _Vector Math_
4. _Vector Math II_
5. _Acceleration_
6. _Acceleration towards Mouse_

## Vectors are the basis for the whole video series
Daniel describes that vectors will be used throughout the whole series and thus are a very important part to really understand. We will answer the questions "What are vectors?" and "Why should we care about vectors?".

### What is a vector in a 2D space?
A vector is represented with an arrow and it has:
1. Magnitude
2. Direction

![Vector](https://i.imgur.com/bew6FPt.png)

But a vector can be deconstructed into two different vectors. 

![Vector x & y](https://i.imgur.com/S0iM4a5.png)

And why should we care? Because we use it all the time. Almost every sketch in Processing we make, we describe two different forces/vectors that we constantly use. 

###### PVector
But there are better ways of working with vectors in Processing, more on this later. But `PVector` is a class in Processing which makes it way easier of working with vectors. 

### Exercise 1#
Show a sketch or some code that where you model motion. So I remember that in the first year of CMD, I remade pong for the browser in Javascript. The code is a bit long, so I'm gonna put in only the motion related functions.

![PONG](https://i.imgur.com/1zsqe1M.png)

```javascript
window.onload = function () { 
    canvas = document.getElementById('gameCanvas');
    canvasContext = canvas.getContext('2d');

    var framesPersecond = 30;
    setInterval(function () {
        moveEverything();
        drawEverything();
    }, 1000 / framesPersecond); // berekeningen maken in hoeveel FPS


    //dit spreekt redelijk voor zich, maar dit zijn de controls voor P1 & P2
    document.addEventListener("keydown", keyDownTextField, false);

    function keyDownTextField(e) {
        var keyCode = e.keyCode;
        if (keyCode == 81) {
            paddle1Y -= 60;
        } else if (keyCode == 65) {
            paddle1Y += 60;
        } else if (keyCode == 38) {
            paddle2Y = paddle2Y - 60;
        } else if (keyCode == 40) {
            paddle2Y = paddle2Y + 60;
        }
    }
};

function ballReset() {
    if (player1Score >= winScore || player2Score >= winScore) {
        showingWinScreen = true;
    }

    ballSpeedX = -ballSpeedX;
    ballX = canvas.width / 2;
    ballY = canvas.height / 2;
};

// stukje 'AI', leuk om te illustreren
function computerMovement() {
    var paddle2YCenter = paddle2Y + (paddleHeight / 2);
    if (paddle2YCenter < ballY - 35) {
        paddle2Y = paddle2Y + 6;
    } else if (paddle2YCenter > ballY + 35) {
        paddle2Y = paddle2Y - 6;
    }
};

function moveEverything() {
    if (showingWinScreen == true) {
        return;
    }

    ballX = ballX + ballSpeedX;
    ballY = ballY + ballSpeedY;


    if (ballX < 20) { // de 20 zorgt ervoor dat de bal niet over de paddle komt
        if (ballY > paddle1Y && // is de y-coordinaat van de bal groter dan de 0,0 van p1?
            ballY < paddle1Y + paddleHeight) { // komt de bal onder p1 (0,0) +pHoogte? DAN>>
            ballSpeedX = -ballSpeedX;

            var deltaY = ballY - (paddle1Y + paddleHeight / 2);
            ballSpeedY = deltaY * 0.35;
        } else {
            player2Score++; // moet voor ballReset zijn
            ballReset();

        }
    }
    if (ballX > (canvas.width - 20)) {
        if (ballY > paddle2Y &&
            ballY < paddle2Y + paddleHeight) {
            ballSpeedX = -ballSpeedX;


            var deltaY = ballY - (paddle2Y + paddleHeight / 2);
            ballSpeedY = deltaY * 0.35;
        } else {
            player1Score++;
            ballReset();


        }
    }
    if (ballY < 0) {
        ballSpeedY = -ballSpeedY;
    }
    if (ballY > canvas.height) {
        ballSpeedY = -ballSpeedY;
    }
};

function drawNet() {
    // CODE
}

function drawEverything() {
    // CODE
    drawNet();
};

//Bron van: https://www.w3schools.com/tags/canvas_arc.asp
function colorCircle(centerX, centerY, radius, drawColor) {
    // CODE
};

function colorRect(leftX, topY, width, height, drawColor) {
    // CODE
};
```

After this I remade the example shown on the video. 
![](https://i.imgur.com/VxIGMmc.png)
```java
float x = 120;
float y = 300;

int xspeed = 5;
int yspeed = 5;

void setup() {
  size(600,600);
  background(255);
}

void draw() {
  //Redraw background
  background(255);
  
  // Step functions
  x = x + xspeed;
  y = y + yspeed;
  
  //Bounce logic
  if (( x > width) || x < 0) {
    xspeed = xspeed * -1;
  }
  if (( y > height) || y < 0) {
   yspeed = yspeed * -1; 
  }
  
  
  // Draw circle
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(x,y,10,10);
}
```

### PVectors
So, we're going to start using an object variable `(PVector)` and stop using primitive variables `(float x;)`. The syntax for using PVector is as follows:

```java
PVector position;
position = new PVector(100,50);
```

A good place to check some very needed information on `PVectors` is on the [official Processing website](https://processing.org/reference/PVector.html). As we can see down here, `PVector` uses methods specially for it. This is so that Processing understands whats going on.

![](https://i.imgur.com/KREzVlc.png)

### Exercise 2#
Grab the bounce ball sketch and remake it, but with PVector. This was the result:
![](https://i.imgur.com/nNcXkVx.png)

```java
Ball b;

void setup() {
 size (600,500);
 b = new Ball();
}

void draw() {
 background(255);
 b.move();
 b.bounce();
 b.display();
}

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
```