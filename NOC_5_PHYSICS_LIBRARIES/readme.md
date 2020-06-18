# PHYSICS ENGINES / LIBRARIES
This part of the series is about physiscs engines and libraries. This part of the video series is a lot bigger than the other chapters. Making an estimate with the hours I have left, I think this is where this project will end for me. There are 28 videos in this chapter. I'll see how far I get. 

5.0.a _Introduction to Physics Engines part I_
5.0.b _Introduction to Physics Engines part II_
1. _Introduction to Box2D_
2. _What makes up a Box2D World?_
3. _Box2D Coordinates and Vectors_
4. _Adding Box2D to Processing Sketch part I_
5. _Adding Box2D to Processing Sketch part II_
6. _Static Bodies and Chain Shapes in Box2D_
7. _Complex Shapes in Box2D_
8. _Box2D Joints: Distance Joint_
9. _Box2D Joints: Revolute Joint_
10. _User Controlled Objects: Mouse Joint and Kinematic Type_ 

### 5.0.a Introduction to Physics Engines part I
This is a re-recorded video. Since the development world never stops, a lot of things have changed for physics engines and what the norm is. Daniel described that these re-recorded videos are meant as an introduction to see what's new and from there on we can choose if we want to follow all the videos, or choose specifically for `Box2D` or a Javascript variant called `P5.js` 

##### The Basics of a Physics Engine
So, what does the engine do? Well, to use a physics engine we don't have to fully understand how it works. Daniel describes it as a blackbox that handles all the physics stuff for you. What we can do is setup a world for it to control. For example, we put a bunch of ellipses in the 'world' and then we tell the engine that we want to drop them. Then the engine handles all the collition and different stuff for us. 

Still, all the stuff we learned in the previous chapters was good. It helps us understand in a better way how to work with physics engines and what the basics are of all these physics principles. 

##### Different engines
* [Box2D](https://box2d.org/) `2D`
    > Hello! I'm Erin Catto. I work at Blizzard Entertainment. I also created Box2D, a 2D physics engine for games. 
* [toxiclibs](http://toxiclibs.org/) `2D/3D`
     > toxiclibs is an independent, open source library collection for computational design tasks with Java & Processing developed by Karsten “toxi” Schmidt (thus far). The classes are purposefully kept fairly generic in order to maximize re-use in different contexts ranging from generative design, animation, interaction/interface design, data visualization to architecture and digital fabrication, use as teaching tool and more.
* [p5.js](https://p5js.org/) `2D/3D`
    > p5.js is a JavaScript library for creative coding, with a focus on making coding accessible and inclusive for artists, designers, educators, beginners, and anyone else! p5.js is free and open-source because we believe software, and the tools to learn it, should be accessible to everyone.

##### When to use a Physics Engine?
Most of the time, in your projects, you're going to be in a space where it is not very clear if you should use a physics engine or not. Why not just make something yourself? Daniel says there are certain situations where opting for a physics engine might be the better choice:
1. Collisions
    _When you're creating a world with a lot of collision, it is generally way easier to opt for the physics engine, than spending hours on hours of looking into trigonometry on how to make this collisions and angles look realistic. This is a problem that is already solved in a physics engine._
2. Connected Systems
    _An example of this would be to simulate movement of a piece of cloth, hair, chains, pendulums, soft bodies._

##### Features of engines
* [Box2D](https://box2d.org/): _Collisions_
* [toxiclibs](http://toxiclibs.org/): _Connected Systems, but no collisions_
    * And thus no geometry
* [Bullet](https://pybullet.org/wordpress/): _3D collisions_
* [matter.js](https://brm.io/matter-js/): _Collisions & Connected Systems_

### 5.0.b Introduction to Physics Engines part II
This video was a live stream of Daniel answering some questions. It was interesting, but I feel like the information given was not fully relevant to the stuff I'm putting down in this repo. So, we'll skip it for now. 

### 5.1 Introduction to Box2D
This was again a repetition on when to choose Box2D, plus some extra information on how to get the library imported to Processing. 
 
### 5.2 What makes up a Box2D world?
Structure wise it's going to look something like this:
```java
void setup() {
    // create our objects
}

void draw() {
    // ask Box2D to calculate physics

    // draw everything
    object.draw();
    object.update(); 
}
```

##### Elements of Box2D we need to know
1. World
    * _This is the "magic" Box2D box where everything happens and gets calculated._
2. Body
    * _We add bodies to our world. This is the main element in the sketch that will "have" the phycsics. But in terms of computing, the body is just empty and has no form. But, the body is the element that will have the velocity._
3. Shape
    * _This is where the geometry happens and what shows the actual shape of our element. This will be attached to the body._ 
4. Fixture
    * _With a fixture we can attach the shape to the body element._
5. Joint
    * _This element can connect two different bodies together._

#### Exercise
For the next video we need to create a simple sketch in which we can put elements by pressing mouse1. No physics nothing else. 
![](https://i.imgur.com/19ntALJ.gif)
```java
ArrayList<Box> boxes;

void setup() {
  size(600,600); 
  background(255);
  boxes = new ArrayList<Box>();
}

void draw() {
 if (mousePressed) {
  Box p = new Box(mouseX,mouseY); 
  boxes.add(p);
 }
 
 for (Box b : boxes) {
  b.display(); 
 }
}

class Box {
   float x,y;
   float w,h; 
   
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
```

### 5.3 Box2D Coordinates and Vectors
So, here is a big thing about Box2D. This engine doesn't know anything about our Processing skecth, or about computer measurements. Box2D calculates in real world measurements, so for instance, distance is calculated in meters, time is calculated in seconds. So we need a moment to think about how we're going to make this translation to pixels and frames. 

Now that we know this, our diagram of actions is going to look a little different:

```java
void setup() {
    // create our objects

    // translate pixels to Box2D "world"
}

void draw() {
    // ask Box2D to calculate physics

    // translate data from "world" to pixels

    // draw everything
    object.draw();
    object.update(); 
}
```

##### Vec2 (Box2D vectors)
Box2D of course also uses vectors. The syntax is a little different but nothing to go mad about.

| Vec2  | PVector |
|---|---|---|
| `Vec2 v = new Vec2(x,y)` | `PVector v = new PVector(x,y)`  |
| `pos.addLocal(vel)` | `pos.add(vel)`  |

##### Convertion
There are built-in methods to do the coordinate convertions. These functions can take two different float values as arguments, like shown here, or they can take a `Vec2` as argument, which also has two float values. 
* `coordPixelsToWorld(x,y)`
* `coordWorldToPixels(x,y)`

There is also a built-in functions for converting sizes of objects to Box2D world measurements:
* `scalarPixelsToWorld(w)`
* `scalarWorldToPixels(w)`

##### Objects
Box2D also creates objects in a different way. When we create a rectangle we give the size in pixels for the full width and height. In Box2D the parameters ask for the width and height from the center of the object.

![](https://image1.slideserve.com/2236391/box2d-worlds-l.jpg)

### 5.4 Adding Box2D to Processing Sketch Part I
We keep going with the example shown before in 5.1/5.2. We want to make collision available through Box2D. Boxes will collide with each other, and there will be two platforms on the bottom, where the boxes also collide on. 
![](https://i.imgur.com/19ntALJ.gif)

##### How is this going to work?
1. **Create a body definition**
    _When creating a body we need two important values, these are:_
    * Position
    * Type
        * Dynamic (has physics)
        * Static (does not have physics)
        * Kinematic (influenced by user)
2. **Create the body object**
    _We can then attach these bodies to a shape so they have geometry_
3. **Create a Shape**
   _Types of shape:_
    * Polygon
    * Circle shape
    * Chain Shape
4. **Create a fixture**
    _This will be the element that ties the shape and the body together. Here we also get to set some physics parameters, like:_
    * Density
    * Friction
    * Restitution (elasticity or bounciness)
5. **Put it all together**

### 5.5 Adding Box2D to Processing Sketch part II
We put together a list of what we need to do to create this body object from Box2D. We're missing a couple of things tho. 
1. **Create the Box2D World**
    * This will be in the "main" tab in `setup()`
2. **Create a Body**
    * In our own Body (Box) constructor.
3. **Ask Box2D "where is the body?"**
    * This will happen in `display()`

##### Step 1 || Creating the world
```java
import shiffman.box2d.*;

// making sure we can write a bit easier
Box2DProcessing box2d;

void setup() {
  size(640,360); 
  background(255);
  boxes = new ArrayList<Box>();
  
  // creating the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}

void draw() {
  background(255);
  
  // This makes sure that the engines runs how it should, so step by step calculations
  box2d.step();
  
  
  if (mousePressed) {
    // same
 }
  for (Box b : boxes) {
    b.display(); 
 }
}
```

##### Step 2 || Creating the body
