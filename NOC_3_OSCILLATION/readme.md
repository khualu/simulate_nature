# OSCILLATION
This part of the series is about forces. The different chapters are:
1. _Angles and Angular Motion_
2. _Trigonometry and Polar Coordinates_
3. _Simple Harmonic Motion_
4. _Pendulum Simulation_
5. _Springs_

### 2.1 Angles and Angular Motion
Most computing languages and graphic softwares count angles in radians instead of degrees. When I was in highschool and had physics class, we actually counted all angles in degrees, but now we're going to learn to use radians instead for processing.  

###### Radians
A radian is a measure unit for an angle. If we take an example where the radius of a circle measures `r = 1`, then the circumference of the whole circle is `2 * pi`. 
//
![](https://getcalc.com/formula/geometry/circle.png)

#### 2D transformations
For a better undestanding of transformations in `Processing`, Daniel recommended doing [this tutorial](https://processing.org/tutorials/transform2d/) on the official Processing website. So we're taking a little detour and doing that in the meanwhile. 

##### Translation
> As you know, your Processing window works like a piece of graph paper. When you want to draw something, you specify its coordinates on the graph. Here is a simple rectangle drawn with the code rect(20, 20, 40, 40). The coordinate system (a fancy word for “graph paper”) is shown in gray.

![](https://processing.org/tutorials/transform2d/imgs/original.png)

>But there is a more interesting way to do it: move the graph paper instead. If you move the graph paper 60 units right and 80 units down, you will get exactly the same visual result. Moving the coordinate system is called translation.

![](https://processing.org/tutorials/transform2d/imgs/moved_grid.png)

```java
void setup()
{
  size(200, 200);
  background(255);
  noStroke();

  // draw the original position in gray
  fill(192);
  rect(20, 20, 40, 40);
  
  // draw a translucent red rectangle by changing the coordinates
  fill(255, 0, 0, 128);
  rect(20 + 60, 20 + 80, 40, 40);
  
  // draw a translucent blue rectangle by translating the grid
  fill(0, 0, 255, 128);
  pushMatrix();
  translate(60, 80);
  rect(20, 20, 40, 40);
  popMatrix();
}
```

##### `pushMatrix()` & `popMatrix()`
Here is a little experimentation with this built-in function:
![](https://i.imgur.com/4GeJ6tT.png)
```java
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
```

#### Rotation
Here is an image that shows how processing measures angles in radians. There is also a built-in function to go from degrees to radians, which is `radians()` and takes as parameter the amount of degrees to rotate the matrix to. 
![](https://processing.org/tutorials/transform2d/imgs/degrees.png)

#### Scaling
This is the last form of 2D transformation. As the name says, it scales the matrix in which you draw.
![](https://processing.org/tutorials/transform2d/imgs/scale1.png)

```java
void setup()
{
  size(200,200);
  background(255);
  
  stroke(128);
  rect(20, 20, 40, 40);
  
  stroke(0);
  pushMatrix();
  scale(2.0);
  rect(20, 20, 40, 40);
  popMatrix();
}
```

#### Back to the video
We can manipulate angular motion, without having to create a `PVector`. We just need a couple of different variables:
```java
float a = 0.0;          // the angle
float aVel = 0.0;       // the angular velocity
float aAcc = 0.0;       // the angular acceleration
```

With the variables shown above, we can make something move in an angular position, combining this with 2D transformation:
![](https://i.imgur.com/sKlyOu2.gif)

```java
void setup() {
 size(640,360); 
}

void draw() {
 background(255);
 
 a += aVel;        // our algorithm for angular motion
 aVel += aAcc;
 
// angular acceleration is based on the position of the mouse on the screen
 aAcc = map(mouseX,0,width,-0.01,0.01);  
 
 rectMode(CENTER);
 stroke(0);
 fill(128);
 translate(width/2,height/2);
 rotate(radians(a));
 rect(0,0, 64, 36);
}
```

Practicing we went a bit further and implemented the same angular motion to the last exercise of chapter 2. Here is what it looks like:
![](https://i.imgur.com/wzoRyJY.gif)

```java
void update() {
    a += aVel;
    aVel += aAcc;
    
    aAcc = velocity.x/25;           // how to calculate the angular acceleration
    constrain(aAcc,-0.001,0.001);   // capping the value between the given range
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
```

### 3.2 Trigonometry and Polar Coordinates
With trigonometry we can calculate certain angles and more stuff. For this we're going to need SOH.CAH.TOA a lot. So here is this image:
![](https://i.imgur.com/QyW03UI.png)

#### Polar Coordinates
This is a different way of describing a location. I think the image below describes it properly. So until now, we were using Cartesian coordinates, they look like this `(x,y)`. Polar Coordinates work differently, they describe a radius and an angle/radian and look like this `(r,θ)`. Polar coordinates navigate around a pole (like the north pole), which is placed at `(0,0)` in both cartesian and polar coordinates. See below: 

![](https://www.shelovesmath.com/wp-content/uploads/2019/05/Polar-Coordinates-Intro.png)

##### How do we use polar coordinates in Processing?
The drawing functions for primitives only accept cartesian coordinates, so we need to find a way around this. Luckely for me, Daniel made this very easy by giving a good explanation.

![](https://i.imgur.com/QoWvUyH.png)

So, if we now that `sin(θ) = y / r` & `cos(θ) = x / r`, because of SOHCAHTOA. Manipulating the function and thus multiplying it by `r` (the radius), we get a pretty comfortable way of calculating `x` & `y`. 
* `y = r * sin(θ)`
* `x = r * cos(θ)`

##### Sketch with polar coordinates
![](https://i.imgur.com/79iE2B9.gif)

```java
float aVel = 0.0;
float aAcc = 0.001;

void setup(){
 size(640,360); 
}

void draw() {
  background(0);
  
  translate(width/2,height/2);
  float x = r * cos(a);
  float y = r * sin(a);
  fill(255);
  stroke(255);
  line(0,0,x,y);
  ellipse(x,y,30,30);
  
  a += aVel;
  aVel += aAcc;
  aVel = constrain(aVel,0,0.01);
}
```
This was the end result, looked cool.
![](https://i.imgur.com/uRKBcDD.gif)

##### Experimenting
###### `r -= 0.1` & `aVel = 0.2`
![](https://i.imgur.com/k3cOtbo.gif)

![](https://i.imgur.com/6IWzbJa.png)

###### `r -= noise(0.2)` & `aAcc = 0.1`, no velocity constrain
![](https://i.imgur.com/MbV7OhK.gif)

### 3.3 Simple Harmonic Motion
Starting this chapter I gave myself the challenge to plot a sinus function on Processing. It was just a small challenge, but I got my results. Although there is something that I still don't know how to do. I wanted to make the frequency lower of the sinusoid, so the waves would take more space over the x-axis. I eventually 'cheated' a way of doing this by scaling only the x-axis in a transformation. 

![](https://i.imgur.com/uwAX4nV.gif)

```java
float x = 0;
float y = 0;

void setup() {
 size(640,360);
 background(255);
}

void draw() {
  x += 0.1;
  y = sin(x) * 50;
  pushMatrix();
  scale(3,1.0);
  translate(10,180);
  stroke(0);
  //strokeWeight(2);
  line(x,y,x,y);
  popMatrix();
}
```

So, harmonic motion and sinusoidal functions. I think the image below explains some important features of this.
![](https://www.dummies.com/wp-content/uploads/376143.image2.jpg)


Another feature of sinusoidal (cosinus aswell) functions is that their value will never exceed the range of `[-1, 1]`. We can of course manipulate the function so it does, like so `sin(x) * a`, where `a` is going to decide our amplitude.

So the `period` is the time it takes a sinusoidal function to go complete a full cicle. The frequency of it is calculated like so `f = 1 / period`. Notice this is also an `f`. The use of symbols in physics can get a bit messy. 

While watching the video, I noticed that Daniel had used a sinusoidal function to make movement. So instead of actually plotting the function, he used it for movement, which was very interesting. This is the example. 

![](https://i.imgur.com/91H5RVx.gif)

```java
float amplitude = 300;
float period = 150;

void setup() {
 size(640,360);
}

void draw() {
 background(255);
 translate(width/2, height/2);
 
 float x = amplitude *  sin((frameCount/period) * TWO_PI);
 fill(127);
 stroke(0);
 line(0,0,x,0);
 ellipse(x,0,36,36);
}
```

##### Exercise
I tried to remake the sinuswave that Daniel showed in the example. The results are pretty nice.
![](https://i.imgur.com/sr7ueUH.gif)

```java
float startAngle = 0;
float amplitude = 100;
float angleVel = 0.23;

void setup() {
 size(600,300); 
}

void draw() {
  background(0);
  startAngle += 0.015;
  float angle = startAngle;
  
  for( int x = 0; x < width; x = x + 30)
  {
    float y = amplitude * sin(angle);
    pushMatrix();
    translate(0,height/2);
    ellipse(x,y,36,36);
    fill(128,128,128,90);
    stroke(90);
    popMatrix();
  angle += angleVel;
  }
  angle += 0.05;
}
```

### 3.4 Pendulum Simulations
With this chapter we're going to use all the knowledge we have from the PVector series untill now. Daniel will explain different steps in how to make a pendulum move. 

##### Draw a pendulum at rest
![](https://i.imgur.com/VrpvlRz.png)
```java
PVector origin;
PVector bob;
float len;

void setup() {
   size(640,360);
   len = 180;
   origin = new PVector(width/2,0);
   bob = new PVector(width/2,len);
}


void draw() {
   background(255);
   line(origin.x,origin.y,bob.x,bob.y);
   ellipse(bob.x,bob.y,32,32);
}
```

##### Draw the pendulum at an angle
To draw the new position of the bob (this is actually the name for the head of the pendulum?), we need to know the values for `y` & `x` like they're shown in the image. The length of the pendulum chord is our `len` variable and will be constant. 

So we just need to formulas for this. 
* `y = len * sin(θ)`
* `x = len * cos(θ)`
![](https://i.imgur.com/IiLdgXi.png)

We translate this formula to something we can use in processing and we have a pendulum in a different position using polar coordinates.

```java
float angle = PI/4;
(...)

void draw() {
  bob.x = origin.x + len * sin(angle);
  bob.y = origin.y + len * cos(angle);
   
  line(origin.x,origin.y,bob.x,bob.y);
  ellipse(bob.x,bob.y,32,32);
}
```

![](https://i.imgur.com/eJ7a2Oz.png)

##### How to calculte the pendulum force

![](https://i.imgur.com/qUpteJX.png)

`F = Fg * sin(θ)`

But to find out the force of gravity we need to think of some constant or a way to simulate this. Remember we did this way earlier. We could make a fomula that looks like this:
`Fp = G * mass * sin(θ)`

##### Exercise 
Make something crazy with this.

### 3.5 Springs
This video is exciting in the way that we haven't done anything like this yet. But, we can combine all the stuff we've done before to work together with the spring physics. The most important question for this video is, how do we simulate a spring force?

##### Hooke's law
![](https://scx1.b-cdn.net/csz/news/800/2015/54e1ebda060dc.jpg)
* `k` is the spring constant. It describes how jumpy/elastic a spring is
* `x` is the distance that the spring is either stretched or contracted from its rest point

