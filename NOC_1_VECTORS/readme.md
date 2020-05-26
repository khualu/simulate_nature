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

### 1.1 Vectors (in Processing)
#### What is a vector in a 2D space?
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

### 1.2 PVectors
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

### 1.3 Vector Math
For this video we're going to go through 4 different functions that are available for the `PVector` class:
* `add()` & `sub()`
* `mult()` "Scaling" & `div()` 
* `mag()` "magnitude"
* `normalize()`

##### `add()`
This is actually what happens and how it works. Not too much of a hassle. So, they are adding two different vectors which ends up like: `w = v + u`.
![add() function](https://i.imgur.com/yjNYnas.png)

##### `sub()`
This is a visualization of how subtracting vectors work. So it's the same magnitude but in the opposite direction. 
![sub() function](https://i.imgur.com/gDAiDx1.png)

There's more to this. Subtracting vectors is often used to get a new vector that describes the discrepancy between these two points. There is a small processing example here. 

```java
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
``` 
![](https://i.imgur.com/uVMZlMw.png)

#### `mult()` AKA "scale"
Daniel describes here that the way `mult()` is used for these kinds of physics sketches is not to multiply two vectors like `w = v * u`, but more like `w = v * n`. Where `n` is the amount of times for scaling a vector. So grow the vector of shrink it. 

If we take the sketch shown above, this would be the only difference:
```java
// Subtracting vectors to show discrepancy
    mouse.sub(center);

// Now multiplying by 2
    mouse.mult(2);
``` 

Now the mouse is halfway the line in the sketch. 

### 1.4 Vector Math II
##### `mag()` Magnitude (POP POP)
Vector magnitude = `||v||`

So in short, `PVector` is a Java object. So when we use the object, we just store certain values in this object. Like so:
```java
class PVector {
    float x;
    float y;
}
``` 

So the good thing of using the `PVector` class, is being able to access certain values in the object with built-in functions without having to make mathematical equations ourselves. If we want to know the magnitude of a vector, we could use the pythagoras theorem and calculate it ourselves. It does give the same answer, but we could also just use the `mag()` built-in function and access the value that is stored in the object. 

##### `normalize()` Normalize
The normalize function grows or shrinks a vector to a specific unit, that being `1`.

### 1.5 Acceleration
This video describes how to work with acceleration in the physics engine we're creating through all these different videos. Acceleration is 'just' another vector we're using in our sketches. So all the vectors we have now are:
```java
PVector position;
PVector velocity;
PVector acceleration;

Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0.0,0);
}
  
void update() {
    velocity.add(acceleration);
    position.add(velocity);
}
``` 

##### Constant acceleration
With constant acceleration we can just put a number (positive or negative) in the acceleration vector and with how we've build the update function, it will accelerate the displacement over time (just like in real life, yey). But we got to realize that it's adding this acceleration every frame, so 60 times per second if at default. 

With the example shown here, we would accelerate for a total of 60 pixels per second. So if `t=0` then `v=0`. At `t=1`, `v=60`. For `t=2`, then `v=120`. 
```java
Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(1,0); // accelerate over the x-axis for 1 pixel per frame
}

``` 

##### `PVector.random2D()`
This is a built-in function for the PVector class to create a random value in a vector. We can use this and use it with the ball sketch that we're using. This is the new code.
```java
PVector position;
PVector velocity;
PVector acceleration;

Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
}
  
void update() {
    // Using that new function to create random values in the vector acceleration
    acceleration = PVector.random2D();

    velocity.add(acceleration);
    position.add(velocity);

    // Limiting the maximum of the values to [-5, 5]
    // If we don't do this, it gets out of hand really fast and the movements looks unnatural. 
    velocity.limit(5);
}
``` 

##### Exercise 3#
See how much personality you can give to the moving ball. But, only changing the acceleration value: `acceleration = //CODE HERE`.

I got the perlin noise walking after a while. It was pretty cool, and I feel like everytime I get to understand Processing a bit better aswell. This is one of the hard things and the cool things of working with built-in objects. A lot of stuff doesn't work as you think, but once you get it working it feels very natural. 

```java
class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector t_noise;
 
  Mover() {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    t_noise = new PVector(0,0);
  }
  
  void update(){
    // creating perlin noise
    p += 0.05;
    pnoise = noise(p);
    
    //creating movement
    acceleration = PVector.random2D();
    acceleration.mult(pnoise);
    
    velocity.add(acceleration);
    position.add(velocity);
    
    velocity.limit(5);
  }
  
  void edges() {
  if (position.x > width)   position.x = 0;
  if (position.x < 0)       position.x = width;
  if (position.y > height)  position.y = 0;
  if (position.y < 0)       position.y = height;
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(position.x,position.y,48,48);
  }
}
``` 
Here you can see the difference. The left one is without perlin noise, the right one is with. I do think the right one moves a little less erratic. 
![](https://i.imgur.com/NZACJMn.gif)

##### Gifs
So, I found a way to record gifs for this project. So from now on, no more extra explanation and still frames, but moving ones, ＳＩＣＫ.

### 1.6 Acceleration towards mouse
Since we already have an engine that accounts for acceleration with velocity and poisition, making the ball move towards the mouse shouldn't be that hard. It looks more or less like this:

```java
void update() {
    // Make a vector for the position of the mouse
    PVector mouse = new PVector(mouseX, mouseY);

    // Subtract the position of the ball to create a vector towards the mouse
    mouse.sub(position);
    
    // We could leave this out, but then the ball would be instantaniously at the mouse
    // That is no fun
    mouse.setMag(0.5);

    // Change the vector of acceleration towards the value of vector mouse
    acceleration = mouse;
}
```

And then we get this:
![](https://i.imgur.com/v7kwrIs.gif)

I didn't account for the mouse not being visible in the gif whic is sad. But I can assure you it is following my mouse. At the end of the gif you can see the ball falling into an orbit around my mouse, which I thought was amazing. 