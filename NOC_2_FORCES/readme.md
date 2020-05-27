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