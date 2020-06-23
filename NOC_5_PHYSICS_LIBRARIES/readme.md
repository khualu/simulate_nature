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
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Box> boxes;
Box2DProcessing box2d;
ArrayList<Boundary> boundaries;

void setup() {
  size(640,360); 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/4,height-5,width/2-100,10));
  boundaries.add(new Boundary(3*width/4,height-50,width/2-100,10));
}

void draw() {
  background(255);
  
  box2d.step();
  
  Box p = new Box(width/2,50); 
  boxes.add(p);
  
  for (Boundary wall: boundaries) {
   wall.display(); 
  }

  for (Box b : boxes) {
    b.display(); 
 }
 
 for (int i = boxes.size()-1; i >= 0; i--) {
   Box b = boxes.get(i);
   if (b.done()) {
    boxes.remove(i); 
   }
 }
}

class Box {
   Body body;
   float w,h;
   
   Box(float x, float y) {
    w = random(4,20);
    h = random(4,20);
   
   // 1. Define the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
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

   // Kill function for bodies outside of window
   void killBody(){
    box2d.destroyBody(body);
   }
   
   boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height) {
     killBody();
     return true;
    }
    return false;
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

class Boundary {
  float x;
  float y;
  float w;
  float h;
  
  // still need a body for box2d
  Body b;
  
  Boundary(float x_, float y_, float w_, float h_) {
   x = x_;
   y = y_;
   w = w_;
   h = h_;
   
   // Define polygon 
   PolygonShape ps = new PolygonShape();
   float box2dW = box2d.scalarPixelsToWorld(w/2);
   float box2dH = box2d.scalarPixelsToWorld(h/2);
   
   ps.setAsBox(box2dW,box2dH);
   
   // create the body
   BodyDef bd = new BodyDef();
   bd.type = BodyType.STATIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
   b = box2d.createBody(bd);
   
   // attach the shape with a fixture
   b.createFixture(ps,1);
  }
  
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }
}
```

### Exercise 2 || Get chain shapes to work
This was a super fun exercise. The only real difference for Box2D is saying to it that you're creating a `ChainShape()`, but there were some other small challenges to work around. Like the coordinates, and using `beginShape()` and `endShape()` with vertices. 

![](https://i.imgur.com/w3E5qje.gif)

It's nice to get a better understanding of how `beginShape()` and the vertixes work in Processing. I also had to loop through all the points of the chain shape to draw it. Which was a bit harder than expected. Because to draw the chain shape, I had to change the coordinates back to pixels. 

```java
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Box> boxes;
Box2DProcessing box2d;
Surface surface;

void setup() {
  size(640,360); 
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boxes = new ArrayList<Box>();
  surface = new Surface();
}

void draw() {
  box2d.step();
  background(255);
  
  // Only real difference here
  surface.display();
  
  Box p = new Box(width/2,50); 
  boxes.add(p);

  for (Box b : boxes) {
    b.display(); 
 }
 
 for (int i = boxes.size()-1; i >= 0; i--) {
   Box b = boxes.get(i);
   if (b.done()) {
    boxes.remove(i); 
   }
 }
}

class Box {
    // same
}

class Surface {
  Vec2[] vcs = new Vec2[6];
  Vec2[] vcsPixels = new Vec2[vcs.length];
  
  Surface() {
  vcs[0] = box2d.coordPixelsToWorld(0,height-50);
  vcs[1] = box2d.coordPixelsToWorld(width/5,height/2);
  vcs[2] = box2d.coordPixelsToWorld(width/5*2,height-50);
  vcs[3] = box2d.coordPixelsToWorld(width/5*3,height-50);
  vcs[4] = box2d.coordPixelsToWorld(width/5*4,height/2);
  vcs[5] = box2d.coordPixelsToWorld(width/5*5,height-50);
  
  ChainShape cs = new ChainShape();
  cs.createChain(vcs, vcs.length);
  
  // Edge of chain is now a body
  BodyDef bd = new BodyDef();
  Body body = box2d.createBody(bd);
  
  body.createFixture(cs,1);
  }
  
  void display() {
  for (int t = 0; t < vcs.length; t++){
     vcsPixels[t] = box2d.coordWorldToPixels(vcs[t]); 
  }
   strokeWeight(1);
   stroke(0);
   beginShape();
   for (int l = 0; l < vcs.length; l++) {
    // vertex() only accepts two floats o as arguments
    // coordWorldToPixels() accepts only Vec2 as arguments
    // so no way to write this all in 1 line code, without the extra array
     vertex(vcsPixels[l].x, vcsPixels[l].y);
   }
   vertex(width, height);
   vertex(0, height);
   fill(0);
   endShape(CLOSE);
  }
}
```

### 5.7 Complex Shapes in Box2D
Up until now we've only representated the bodies we make in Box2D as rectangles. But what if a rectangle or an ellipse is not enough? What more can we do and what are strategies for this?

##### Custom Polygon
* _We use (just like the chain shape) an array of `Vec2` and then draw the shape with `ps.set()`_
* _Only convex shapes_
![](https://www.emanueleferonato.com/images/convex_concave.png)
* _Vertices in clock wise order_
* _Coordinates are from center of the shape_
![](https://i.imgur.com/3A1Pp7e.png)

###### Results
Here is what I got with some help of Daniel in the videos. It was a bit hard to get it working, because it's so hard to find documentation on how to properly use `Box2D` in Processing. 
![](https://i.imgur.com/dqga1Nf.gif)

##### **Multiple shapes attached to one body**
* _Can also have custom polygons_


### Notice
I decided here to stop doing the Box2D part of this video series. It's annoying to work with Box2D, which is written for `C++` and do this work in Processing. As of this moment I'm working in a wrapper within a wrapper. So a wrapper for C++ to Java, then one more for Java to Processing. Finding documentation is almost not possible, and everything is taking so long because of it. I'm going to keep working on the series, but just moving to `matter.js`, since it's in plain javascript and there's a lot of documentation for it. 


### 5.17 Introduction to Matter.js
I went and skipped some other libraries because they were so Processing focused. I thought it might be fun to actually do some stuff in Javascript in the browser. I first checked what the videos where about a bit and how to get it working. 

Daniel works in these videos with `p5.js` to render stuff in the browser and then he uses `matter.js` to do all the physics simulation. In this very folder there is a `matterjs` folder in which I'm following the videos. 

##### Get it running
We have to download the builds for each library. I thought at first we were going to do this in `NodeJs`, but apparently just Javascript and the browser is enough.

Download the latest stable build from each site:
* [P5 Library](https://p5js.org/)
* [matter.js](https://brm.io/matter-js/)

This will be a zip with a bunch of files, but in them look for the folder called `build` and put this in your folder where you're going to be working in and reference it in your `index.html`. 

##### First results
After a while, I got something very basic running. But hey, it's working as intended!
![](https://i.imgur.com/0slRgCx.gif)

```javascript
// module aliases
const Engine = Matter.Engine,
    // Render = Matter.Render,
    World = Matter.World,
    Bodies = Matter.Bodies

// create engine
let engine
let world
let box1

function setup() {
    // create canvas
    createCanvas(400,400)

    // create engine
    engine = Engine.create()

    // aliasing world
    world = engine.world

    // create a box
    box1 = Bodies.rectangle(200, 100, 80, 80)

    // run engine
    Engine.run(engine)

    World.add(world, box1)
}

function draw() {
    background(52)
    rect(box1.position.x,box1.position.y,80,80)
}
```

##### The Daniel Magic
I feel like Daniel is extremely good at object oriented programming, because in a matter of seconds, he wrote a new constructor to ease creating new boxes. The new code looks like this:
```javascript
// module aliases
const Engine = Matter.Engine,
    // Render = Matter.Render,
    World = Matter.World,
    Bodies = Matter.Bodies

// create engine
let engine
let world
let box1

function setup() {
    // create canvas
    createCanvas(400,400)
    // create engine
    engine = Engine.create()
    // aliasing world
    world = engine.world
    // run engine
    Engine.run(engine)

    box1 = new Box(200,100,50,50)
}

function draw() {
    background(52)
    box1.show()
}

function Box(x, y, w, h) {
    this.body = Bodies.rectangle(x, y, w, h)
    this.w = w
    this.h = h
    World.add(world, this.body)

    this.show = function() {
        let pos = this.body.position
        let angle = this.body.angle

        push()
        translate(pos.x, pos.y)
        rect(0,0, this.w, this.h)
        pop()
        
    }
}
```

We keep adding some code to make it behave better and more realistic. So the rectangles just bounced of each other, but always stayed perfectly horizontal. But, if you remember correctly, we did ask matter.js for the angle of the body. We can use this to turn the blocks and make the bounce and collision more realistic. We also added some functionality to make a lot of cubes instead of just one at the time. 

![](https://i.imgur.com/W87C6p9.gif)

```javascript
// module aliases
const Engine = Matter.Engine,
// Render = Matter.Render || WE USE P5 TO RENDER
World = Matter.World,
Bodies = Matter.Bodies

// create engine
let engine
let world
let box1
let boxes = []
let ground

function setup() {
    // create canvas
    createCanvas(400,400)
    // necessary code for matter.js
    engine = Engine.create()
    world = engine.world
    Engine.run(engine)

    // create ground bodies for boxes to bounce on
    ground = Bodies.rectangle(200, height, width, 10, { isStatic: true })
    World.add(world, ground)
}

function draw() {
    background(52)
    for (let i = 0; i < boxes.length; i ++) {
        boxes[i].show()
    }
    fill(255)
    strokeWeight(4)
    line(0, height, width, height)
}

function mouseDragged() {
    boxes.push(new Box(mouseX, mouseY, 15,15))
}

function Box(x, y, w, h) {
    this.body = Bodies.rectangle(x, y, w, h)
    this.w = w
    this.h = h
    World.add(world, this.body)

    this.show = function() {
        let pos = this.body.position
        let angle = this.body.angle
        push()
        translate(pos.x, pos.y)
        rotate(angle)
        rectMode(CENTER)
        strokeWeight(1)
        stroke(255)
        fill(127)
        rect(0,0, this.w, this.h)
        pop()
    }
}
```
### 5.18 Introduction to Matter.js Continued
Since the last video we added a `Boundary` constructor. Which is to make static grounds instead of the dynamic boxes we had. It's almost the same constructor with just some little changes. 
![](https://i.imgur.com/D2iRGt2.gif)

```javascript
function Boundary(x, y, w, h) {
    let options = {
        friction: 0.3,
        restitution: 0.6,
        isStatic: true,
        angle: PI / 4
    }
    this.body = Bodies.rectangle(x, y, w, h, options)
    this.w = w
    this.h = h
    World.add(world, this.body)

    this.show = function() {
        let pos = this.body.position
        let angle = this.body.angle
        push()
        translate(pos.x, pos.y)
        rotate(angle)
        rectMode(CENTER)
        strokeWeight(1)
        noStroke()
        fill(0)
        rect(0,0, this.w, this.h)
        pop()
    }
}
```

Now we also went from boxes to circles. This way the circles can slide off of the different boundaries that we made. Another interesting find when using circles instead of cubes, is that it almost looks as if we're simulating a liquid running down a pipe. 
##### `circles.push(new Circle(mouseX, mouseY, random(2,10)))`
![](https://i.imgur.com/wRwQxVY.gif)

##### `circles.push(new Circle(mouseX, mouseY, random(0.001,0.1)))`
_This very easily gets way too heavy for the engine if I add a lot of objects_
![](https://i.imgur.com/w6WlPg8.gif)

```javascript
function Circle(x, y, r) {
    let options = {
        friction: 0,
        restitution: 0.6
    }
    this.body = Bodies.circle(x, y, r, options)
    this.r = r
    World.add(world, this.body)

    this.show = function() {
        let pos = this.body.position
        let angle = this.body.angle
        push()
        translate(pos.x, pos.y)
        rotate(angle)
        ellipseMode(CENTER)
        strokeWeight(1)
        stroke(255)
        fill(127)
        // This was interesting, matter.js uses the radius for a circle, but P5 expects coordinates to create a circle
        ellipse(0,0, this.r*2) 
        pop()
    }
}
```

### 5.19 Matter.js: Deleting Bodies
This was a very interesting video because I actually tried to do this before the video. I didn't get it working, I think I was focusing too much on how it worked in Java/Processing.  

![](https://i.imgur.com/LZHH2GC.gif)

##### Check for amount of bodies
_`World.bodies[]` will always have two more bodies than `circles[]`, because of the two boundaries._
![](https://i.imgur.com/9pTjegE.gif)

```javascript
function Circle() {
  // other stuff

  this.isDead = function() {
      let pos = this.body.position
      return (pos.y > height + 100)
  }

  this.removeFromWorld = function() {
    // functionality to actually remove bodies from matter.js engine
      World.remove(world, this.body)
  }
}

function draw() {
    background(52)
    Engine.update(engine)
    circles.push(new Circle(25, 25, random(2,10)))
    
    for (i = 0; i < circles.length; i ++) {
        circles[i].show()                   // first draw the circles
        if (circles[i].isDead()) {          // check if they're outside the canvas
            circles[i].removeFromWorld()    // remove them from the matter.js world
            circles.splice(i,1)             // then remove the object from the circles array
            i--                             // go back one step to not skip a circle
        }
    }
    for (i = 0; i < boundaries.length; i++) {
        boundaries[i].show()
    }

    // Check for amount of objects in circles[] and world.bodies[]
    console.log(circles.length, world.bodies.length)
}
```

### 5.20 Matter.js: Constraints
Matter.js has a built-in way to make chains, but for the sake of learning in this video we will make a chain ourselves. Making constraint between bodies is fairly easy, this is the basic code you will need:

```javascript
Constraint = Matter.Constraint

let options = {
    bodyA: bodyA,   // anchor point 1 
    bodyB: bodyB,   // anchor point 2
    length: l,      // length of constraint in pixels
    stifness: r     // how much does the constraint behave as a spring
}

let constraint = Constraint.create(options)
World.add(world, constraint)
```

But of course there is more logic to it than just this. For example, we need to make sure a constraint is made between all our particles, but the first one, only has a constraint with the second particle. So how do we make this possible? Bear with me.

![](https://i.imgur.com/3hAmrVs.gif)

```javascript
// create a variable to check if there is a previous particle to anchor the constraint to
// starts off as falsy
let prev = null

// loop for creating particles
for (x = width/2; x < width; x += 20) {
  let fixed = false         // create variable fixed to be falsy
  if (!prev) {              // if there is no previous, then make the first particle static
     fixed = true         
  }                         // if there is a previous then skip this
  let p = new Particle(x, 100, 5, fixed) // constructor for particle
  particles.push(p)

  if (prev) {               // if there is a previous particle then...
    let options = {
      bodyA: p.body,        // anchor points
      bodyB: prev.body,     // anchor points  
      length: 20,
      stiffness: 0.2
    }

    let constraint = Constraint.create(options)
    World.add(world, constraint)
  }
  prev = p                  // save the particle to be previous then loop starts again 
  }
}
```