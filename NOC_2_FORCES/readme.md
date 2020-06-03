# FORCES
This part of the series is about forces. The different chapters are:
1. _What is a force_
2. _Applying a force_
3. _Simulating a mass_
4. _Friction force_
5. _Drag force_
6. _Gravitational attraction_

### 2.1 What is a force?
> A force is a vector that causes an object with mass to accelerate

* Vector: an entity with magnitude and direction
* acceleration: change in velocity over time _(for us per frame)_

So there is one _new_ part left in the definition, and that is _an object with mass_. So, what does this mean in our Processing engine, how do we try and simulate this? For this we're going to use the knowledge about Newton's laws of motion (in relation to the concept of a force).

#### Newton's Laws
1. An object at rest stays at rest and an object in motion stays in motion.
    * _An object that is at rest will stay at rest unless a force acts upon it._
    * _An object that is in motion will not change its velocity unless a force acts upon it._
2. `F = m * a`, so, force equals mass times acceleration.
    > _This is the most important one for us. Because it has some other implications like:_
     `a = F / m`, so accelerations is force divided by mass.
    
    > Daniel goes even further in explaining that if we create our digital world and decided that the mass of ALL objects is 1, so `m = 1`. Then we could rewrite this last function as `a = F`, so acceleration is equal to force. 
3. For every action there is an equal and opposite reaction 
    > Forces always occur in pairs. THe two forces are of equal strength, but in opposite directions.

##### Little note
From now on I'll be shortening different variables used in the code so:
* `position = pos`
* `velocity = vel`
* `acceleration = acc`
* `force = f`

### 2.2 Applying a force
#### `a = F`
We're going to use Newton's second law of motion with the assumption that all the objects in our digital world have a mass of `1`, so if `m = 1`, then `a = F`. We're going to use this. 

To use this in our code we need to write a new method called `applyForce()`, that is going to look more or less like this:
```java
void applyForce(PVector f) {
    acc = f;
}
```

But, this is somewhat simplyfied. In terms of simulation and in terms of coding. We want to write one function, from which we can apply different forces to the object. An easy solution is this:
```java
void applyForce(PVector f) {
    acc.add(f);
}

// Then we could add more forces like this
PVector gravity = new PVector(0,0.3);
m.applyForce(gravity);

PVector wind = new PVector(0.2,0);
m.applyForce(wind);
```

And now the coding problem shows up. The `acc` variable is now accumulating these different forces every frame over time. So they just keep adding up. While our acceleration variable should only be the difference in force over time. There is an easy fix for this though. We fix this in the update function of our engine, like so:
```java
  void update(){
    vel.add(acc);
    pos.add(vel);

    // This is the fix
    acc.mult(0);

    // Every frame we reset the values of acceleration to zero
  }
```

We also updated the `edges()` functions so it bounces now. This is all the code
```java
Mover m;

void setup() {
  size(640,360);
  m = new Mover();
}

void draw() {
  background(255);
  
  PVector grav = new PVector (0, 0.4);
  m.applyForce(grav);
  
  PVector wind = new PVector (0.2,0);
  if (mousePressed) {
     m.applyForce(wind); 
  }
  
  // execute all functions
  m.update();
  m.edges();
  m.display();
}

// MOVER class
class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
 
  Mover() {
    pos = new PVector(width/2,height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void edges() {
  if (pos.x > width) {
    pos.x = width;
    vel.x *= -1;
    } else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    } else if (pos.y > height)  {
     vel.y *= -1; 
     pos.y = height;
     }
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(pos.x, pos.y,48,48);
  }
  
  void applyForce(PVector f) {
     acc.add(f);
  }
}
```

And this is the product:
![](https://i.imgur.com/2k4bMgq.gif)

### 2.3 Simulating with mass
What is mass? Mass is the amount of matter of an object. So, we know that `a = F/m` and we can add this to the equation like:
```java
void applyForce(PVector force) {
    // we need to make a new PVector because of how Java works
    // Java will otherwise change all the other values of `f`
    PVector f = PVector.div(force,mass);
    acc.add(f);
  }
```

We also changed the amount of ball objects in the sketch. 
```java
Mover[] movers;

void setup() {
  size(640,360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
     movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  
  for (Mover m : movers) {
  
    PVector grav = new PVector (0, 0.4);
    // Notice how now the vector gravity is multiplied by mass
    grav.mult(m.mass);
    m.applyForce(grav);
  
    PVector wind = new PVector (0.2,0);
    if (mousePressed) {
    // Here vector wind is divided by mass, because if the object is heavier it needs more windforce to move
      wind.div(m.mass);
      m.applyForce(wind); 
    }
    // execute all functions
    m.update();
    m.edges();
    m.display();
  }
}
```

This is the new model that we have. As you can see, the smallest objects get impacted by way more by wind. 
![](https://i.imgur.com/z6hIUI6.gif)

### 2.4 Friction Force
This video two forces will be discussed. Friction and drag. 

##### Friction
Friction is a force that forces backwards from the direction of the velocity of an object. As shown here. 
![](https://i.imgur.com/DF32qOB.png)

To get an idea about how this works Daniel shows the formula for friction, which is:
//
![](https://3.bp.blogspot.com/-FWz956Wh29Y/V10WgbjExUI/AAAAAAAAADg/LqpEcN6oRU0zIic-ajM3VMU-kZ37LohjACLcB/s320/frictionequation.png)

To simulate this force Daniel worte it down this way `F = -1 * mu * N * v`. 
1. We can get the direction from `F = -1 * v`
   * `PVector friction = velocity.get();`
   * `friction.normalize();`
   * `friction.mult(-1);`
   * We have now the direction of the friction in a PVector

2. We can get the magnitude from `mu * N`
    * `N = 1` just to make our lives easier (Daniel's words)
    * Just the friction coefficient's left
    * We can make up a number for that
    *  `float c = 0.01`
    * `friction.mult(c);`

3. `applyForce(friction);`, and we're done. 

Here are the results. As you can see objects with less mass are impacted more by the friction. This makes sense since it will cost more energy to move an object with a greater mass. The way friction is computed right now, it doesn't take into account size of the object or the contact surface, so keep that in mind. 

![](https://i.imgur.com/5Eo1TE1.gif)

```java
Mover[] movers;

void setup() {
  size(640,360);

  // Initializing mover objects
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
     movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  
  for (Mover m : movers) {
  
    PVector grav = new PVector (0, 0.4);
    grav.mult(m.mass);
    m.applyForce(grav);
  
    //PVector wind = new PVector (0.2,0);
    //wind.div(m.mass);
    //m.applyForce(wind); 
    
    // friction computing
    PVector friction = m.vel.get();
    friction.normalize();
    
    // friction coefficient
    float c = -0.05;
    friction.mult(c);
    if (mousePressed) {
      m.applyForce(friction);
    }
    // execute all functions
    m.update();
    m.edges();
    m.display();
  }

  
  Mover class {
    // Mover class is still the same
  }
}

```

### 2.5 Drag Force
Drag is the force an object experiences when said object is moving through a gas or a fluid. Just like the normal force, it is always in the opposite direction of the movement vector. 

##### The formula for drag
_DISCLAIMER: DONT PAY ATTENTION TO THE_ `C = 0.32`. 
![](https://getcalc.com/formula/physics/drag-force.png)

* **Drag coefficient**: is a number that describes either how much drag an object experiences with a certain shape. This coefficient is mostly a result of different tests on objects. 
  * This means we can rewrite the formula for drag to also describe the drag coefficient like so: ![](https://i.imgur.com/z4oqsfi.png)
  * Here is a list of drag coefficient for (apparently) often used objects:
  ![https://www.engineeringtoolbox.com/drag-coefficient-d_627.html](https://i.imgur.com/TTTYYNT.png) https://www.engineeringtoolbox.com/drag-coefficient-d_627.html

* **Transversal or crossectional area**: is the amount of surface often in squared meters . 
 * ![](https://4.bp.blogspot.com/-qY2T1mc_D2c/VedBKzU5nJI/AAAAAAAADiA/hdnMgTSNyRI/s400/FASTER-frontal-area.jpg)
* **Rho: The density of the fluid**: can be looked up online or in physics books. Describes how thick or the thinness of a fluid or gas (or even a solid object, but you cannot move through a solid object).
  * `rho = mass / volume`
  * ![](https://wikimedia.org/api/rest_v1/media/math/render/svg/f63465553e3f944d6ef79f90f992a02cf29c7f38)
* **The flow velocity relative to the object**: So, here they mean the relative difference in movements between the object that we are calculating the drag force for and the velocity of the fluid/gas itself. 

##### Simplyfied formula for Processing
![](https://i.imgur.com/knVlZ0X.png)
So, as we did with the last couple of forces aswell. Daniel simplyfied this formula to makes our lives easier. We took the liberty to said that the density of the fluid, `rho = 1` and the surface area also has a value of 1, `A = 1`. Now we're left with a way shorter, easier looking formula to simulate drag. 
`F = - C * ||v||^2 * v`. 
* ||v|| is the magnitude of velocity
* v is the direction of velocity

We can get the direction of velocity and multiply it by minus 1 like so:
```java
PVector drag = velocity.get();
drag.normalize();
drag.multi(-1);
```

Now we're left with: `F = C * ||v||^2`

```java
float speed = velocity.mag(); // we want the magnitude of the velocity vector
float c = 0.01;               // drag coefficient
drag.mult(c * speed * speed);
```

##### Result
![](https://i.imgur.com/wdVbinY.gif)

```java
  size(640,360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
     movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  
  for (Mover m : movers) {
  
    PVector grav = new PVector (0, 0.4);
    grav.mult(m.mass);
    m.applyForce(grav);
    
    // friction computing
    
    
    
    if (mousePressed) {
      PVector drag = m.vel.get();
      drag.normalize();
      float c = -0.01;
      float speed = m.vel.mag();
      drag.mult(c*speed*speed);
      m.applyForce(drag);
    }
    // execute all functions
    m.update();
    m.edges();
    m.display();
  }
}

class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  
  float mass;
 
  Mover() {
    pos = new PVector(random(width),height-300);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    mass = random(0.5,4);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void edges() {
  if (pos.x > width) {
    pos.x = width;
    vel.x *= -1;
    } else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    } else if (pos.y > height)  {
     vel.y *= -1; 
     pos.y = height;
     }
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(pos.x, pos.y,mass*20,mass*20);
  }
  
  void applyForce(PVector force) {
     PVector f = PVector.div(force,mass);
     acc.add(f);
  }
}
```

#### Exercise
Try and make this as elaborate as you want. 

_DISCLAIMER_: I started off by looking at some examples that Daniel has made and now I'm trying to create something myself with them. So the code is by no means 100% mine. I will put down here the code that is relevant for the exercise. The rest can be seen in the repo. 

##### The code
```Java
// We're mimicking liquids to create liquid friction
// Liquid
Liquid liquid;
Liquid gas;
Liquid weird;
(...)
Liquid(x,y,width,height,c) // c = C = drag coefficient
gas = new Liquid(0, 150, width, 80, 0.25);
liquid = new Liquid(0, 300, width, 80, 0.1);
weird = new Liquid(0, 450, width, 80, -0.01);
```

So, to describe what I changed and tried to show. 
* I made a gas, with a very low drag coefficient. This will show almost no slowing down of the objects
* The liquid was already made by Daniel. This shows the true nature of liquid/gas friction
* Weird, which weirdly accelerates objects that go through it. 

![](https://i.imgur.com/c0iZKHu.gif)

Here the nature of our code shows. The model we created to simulate liquid friction doesn't work perfectly. As you can see the smallest object on the right end shoots in to space after going through the acceleration fluid and bouncing up through two other liquids that slow it down. 

### 2.6. Gravitational attraction
Gravitational attraction is the force that two objects put on each other. Every object ever that has a mass attracts other objects to it. So, what we call gravity is the force of the earth, pulling us to the center. We actually attract the earth towards us, but because our mass is so little in comparison to the earth, we don't really notice this. 
![](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/NewtonsLawOfUniversalGravitation.svg/1200px-NewtonsLawOfUniversalGravitation.svg.png)

##### Simplyfied again
For the sake of our ease, we're going to be using a mover object and an attraction object. The latter one doesn't move, it just attracts. 

In code the formula would look something like this: `F = ((G * m1 * m2) / d^2) * r`
* `r` is the difference in position, normalized
* `G` is the gravitational constant
* `m1` is the mass of object 1
* `m2` is the mass of object 2

#### How can we get these values?
##### How to get `r`?
```java
PVector dir = PVector.sub(pos2, pos1); // subtract positions to get a vector of the difference in position
dir.normalize();
```
##### How to get `G`?
This normally is a predefined universal constant, `G = 6.673×10-11 N m2 kg-2`. But for the sake of simplyfying stuff, we're just going to say `G = 1`. The way the constant works in this formula is by describing in a number: "Is the gravitational attraction going to be strong, or weak?".

##### How to get `d`? (huehuehue)
This value describes the distance between the two objects. We actually already calculated this value, like so: `PVector dir = PVector.sub(pos2, pos1)`. Since it's stored in the vector object, we can just ask for it, hence: `float d = dir.mag();`

##### What's left?
The mass of the objects is already in the Processing code. We made those values up. So all we got left is to actually compute the formula. 
`F = dir.mult((G * m1 * m2) / (d * d))`

#### Exercise
I started with Daniel's code again and changed stuff myself to see what results I could get. You can find the code I started with [here](https://github.com/nature-of-code/noc-examples-processing/tree/master/chp02_forces/NOC_2_6_attraction).

###### The example
![](https://i.imgur.com/7GMoLvk.gif)

##### What I got it to do
![](https://i.imgur.com/fzzBZK5.gif)