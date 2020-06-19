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

##### Creating the world
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
  
  // This makes sure that the engines runs how it should, 
  // This is because it runs on real time units
  box2d.step();
  
  
  if (mousePressed) {
    // same
 }
  for (Box b : boxes) {
    b.display(); 
 }
}
```

##### Step 1, 2, 3, 4, 5 || 
```java
class Box {
   // 1. Define the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC;                      // Our body needs to experience physics, so it's dynamic
   bd.position.set(box2d.coordPixelsToWorld(x,y));  // change coordinates to World coordinates
   body = box2d.createBody(bd);

   // 2. Create body
   body = box2d.createBody(bd);

    // 3. Create a Shape
   PolygonShape ps = new PolygonShape();
   float box2Dw = box2d.scalarPixelsToWorld(w/2); 
   float box2Dh = box2d.scalarPixelsToWorld(h/2); 
   ps.setAsBox(box2Dw, box2Dh);

     // 4. Create a fixture
   FixtureDef fd = new FixtureDef();
   fd.shape = ps;
   // Parameters that affect physics
   fd.density = 1;
   fd.friction = 0.3;
   fd.restitution = 0.5;
   
   // 5. Put it together
   body.createFixture(fd);
   }
   
   void display() {
     // Get the location of the body from Box2D and translate to pixel coordinates
     Vec2 pos = box2d.getBodyPixelCoord(body);
     float a = body.getAngle();
     
     pushMatrix();
     translate(pos.x,pos.y);
     rotate(-a);
     fill(127);
     strokeWeight(2);
     rectMode(CENTER);
     rect(0,0,w,h);
     popMatrix();
   }
}
```
##### Result
I honestly spend like 1.5 hours trying to make it work and Processing giving me errors I couldn't use, just to find out I was typing all the `Box2D` stuff outside of the `class Box{}`. So yeah, lesson learned. I notice that I'm not used to not having color coded syntax in Processing. I always work in Visual Studio Code, where I even choose my own theme for the color coding.
![](https://i.imgur.com/fA9jhfE.gif)

### 5.6 Static Bodies & Chain Shapes in Box2D
We're going to briefly describe how each of this shapes work.

##### Static Bodies
The Static bodies are very easy to make. If you remember the steps we needed to make the box body work in the last video, we just need to change one thing. Instead of a `DYNAMIC` body, we now need a `STATIC` body when we define the body. 

```java
BodyDef bd = new BodyDef();
bd.type = BodyType.STATIC; 
```

##### Chain Shapes
The chain shapes do have a different method to them. But in fact we're just changing the kind of shape it is. It also has a `STATIC` body, but instead of a `PolygonShape ps = new PolygonShape();`, we now will use `ChainShape cs = new ChainShape();`.
```java
class Surface {
ChainShape cs = new ChainShape();
Vec2[] vertices = new Vec2[3];
vertices[0] = box2d.coordPixelsToWorld(x0,y0);
vertices[1] = box2d.coordPixelsToWorld(x1,y1);
vertices[2] = box2d.coordPixelsToWorld(x2,y2);

chain.createChain(vertices, vertices.length);
}
```

### Exercise 1 || Get static shapes to work
This took a very long time actually, so I'm wondering how long it's going to take me to get the chain shape working. But in the end we got it. I got stuck wondering why the static shapes were in the world, but they had no collision. Apparently I did everything correctly, I just forgot to create a fixture to get the body and shape together. 

![](https://i.imgur.com/izMM8qU.gif)

```java

```