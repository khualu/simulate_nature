# PARTICLE SYSTEMS
This part of the series is about forces. The different chapters are:
1. _Particle Systems_
2. _ArrayLists in Processing_
3. _Deleting Objects from ArrayList_
4. _Particle System Class_
5. _Introduction to Inheritance pt. I_
6. _Introduction to Inheritance pt. II_
7. _Introduction to Polymorphism_
8. _Applying forces to a Particle System_
9. _Using Image Textures with Particles_

### 4.1 Particle Systems
In this chapter of the video series we're going to expand our knowledge in how to manage systems. So how do we use and code systems with a lot of objects. An example of this would be using ArrayList in Processing. 

> We need organizational principles by which to live.

This video ended up being way more of a descriptional video about what particle systems are than anything else. 

### 4.2 ArrayLists in Processing
ArrayLists are a method that is native to Java, not so much Processing. But it is very often used in Processing aswell, so the official Processing website has a [page with the basics](https://processing.org/reference/ArrayList.html).

To make our lives easier, Daniel says that we actually only need a couple of of the build-in functions of the ArrayList, these are:
* `add()`
* `get()` 
* `remove()` 
* `size()` 

##### How to start an ArrayList
For this, we're going to assume we have a `class Particle{}` in our sketch.
```java
class Particle {
    // our class
}

ArrayList<Particle> particles;          // we need to tell processing what kind of objects are going into our Arraylist
particles = new ArrayList<Particle>();  // Just like we start an array or PVector
``` 

##### How to add objects to an Arraylist
We can do this easily with the `add()` method. Like so: `a.add(new Particle())`. In our code this will look like this: 
```java
 for (int i = 0; i < 10; i++) {
   particles.add(new Particle(new PVector(width/2,50)));
 }
``` 

##### How can we access the objects in our ArrayList
Again, very easy with the `get()` method.
```java
particles p = particles.get(0); // we only stored objects in the first index of our ArrayList
``` 

##### Exercise
So, I followed the examples and made the particle system that Daniel described. He ended the video on the note that the next video would talk about the `remove()` method, because we need to remove objects from the ArrayList once they're not used anymore, and now I can see why.

I made this example to make particles on mouse click, as you can see, after a while the framerate tanks horribly, and this was outside of the gif making part as well. 

![](https://i.imgur.com/kcxjVwG.gif)

```java
Particle p;

Particle[] particles;

void setup() {
 size(640,360);
 //p = new Particle(new PVector(width/2,20));
 particles = new Particle(new PVector(width/2,20));
 background(255);
 smooth();
}

void draw() {
 background(255);
 p.run();
 if (p.isDead()) {
  p = new Particle(new PVector(width/2,20));
 }
}

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(position.x, position.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}
``` 

### 4.3 Deleting Objects from ArrayList
So, Processing has built-in methods for deleting objects from an ArrayList. The one we're going to use is the `remove()` method, together with `size()`. The size method allows us to put a condition to when we remove particles or even to loop through all the objects in the ArrayList. Just like we can use `myArray.length`, we can use `myArrayList.size()` in a loop. 

The remove methods needs a parameter, which is the index of the object you want to remove in the ArrayList. For us, this will be `0`. Because we want to remove the oldest particle in existence. 

```java
for (int i = 0; i < particles.size(); i ++) {
   Particle p = particles.get(i);

   if (p.isDead()) {
      particles.remove(i); 
   }
}
``` 

#### The result
Now we have a particle system that spews out particles and removes then when they're not visible. Which looks very nice, no real stutters or FPS drops.

![](https://i.imgur.com/1lt4Tpf.gif)

```java
ArrayList<Particle> particles;

void setup() {
 size(640,360);
 particles = new ArrayList<Particle>();
 for (int i = 0; i < 10; i++) {
   particles.add(new Particle(new PVector(width/2,50)));
 }
 background(255);
 smooth();
}

void draw() {
 background(255);

 particles.add(new Particle(new PVector(width/2,50)));

   
 for (int i = 0; i < particles.size(); i ++) {
   Particle p = particles.get(i);
   p.update();
   p.display();
   
   if (p.isDead()) {
      particles.remove(i); 
   }
 }
}

class Particles{
    // same
}
``` 

But, Daniel demonstrates that there might be a problem, when we're trying to remove particles from our ArrayList. In our example it might not matter that much because all the particles are the same object. 

If we have an ArrayList filled with letters, like so `[a, b, c, d, e]`, and we want to delete the letter `c`. Our for loop will go through the indexes and then on `[2]` remove the letter `"c"`. 

Our new ArrayList will look like this `[a, b, d, e]`, which looks fine. This is what we wanted. But the next index our for loop is going to is `[3]` which now has in place `"e"`. So, as you might have noticed, we skipped an object to check on. 

There is a solution for this case. Looping through the ArrayList backwards. Our new algorithm for the particles looks like this:
```java
void draw() {
 background(255);

 particles.add(new Particle(new PVector(width/2,50)));

   
 for (int i = particles.size() -1; i >= 0; i --) {
   Particle p = particles.get(i);
   p.update();
   p.display();
   
   if (p.isDead()) {
      particles.remove(i); 
   }
}
``` 

### 4.4 Particle System Class
At this moment we have the particle class and an ArrayList. Now we're aiming to have a system for this ArrayList. So a Particle System, with which we can control our particles, and maybe even create more than one kind of particles. In short we're creating:
* Particle class: Describes a single entity
* Particle system class: Describes a list of those single entities

There isn't really much to explain. This is just a way of organizing our methods in an object oriented way. The new code is shown beneath, but it still works exactly the same.

```java
ParticleSystem ps;

void setup() {
 size(640,360);
 ps = new ParticleSystem();
 background(255);
 smooth();
}

void draw() {
 background(255);

 ps.addParticle();
 ps.run();
}

class Particles {
    // same
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
 
  ParticleSystem() {
     particles = new ArrayList<Particle>();
  }
  
  void addParticle(){
    //particles.add(new Particle());
    particles.add(new Particle(new PVector(width/2,50)));
  }
  
  void run() {
   for (int i = particles.size() -1; i >= 0; i --) {
     Particle p = particles.get(i);
     p.update();
     p.display();
   
     if (p.isDead()) {
       particles.remove(i); 
    }
   }  
  }
  
}
``` 

##### Experimenting
I want to try and make the example that Daniel showed, where if you click on a certain point in the window, a new particle system will be created and shown in the position of the click. So I will be experimenting and showing my results.

###### Follow the mouse
![](https://i.imgur.com/Uef82vK.gif)

###### On click on mouse 
![](https://i.imgur.com/fExsGxw.gif)

###### The last step
Now they just need to stay in the point where I click, so this is the whole point of the particle systems and an ArrayList. Everytime I click somewhere I need a new particle system to be created. This was a bit more difficult than I expected. I checked some examples and got it to work in the end. 

![](https://i.imgur.com/1KEAcHb.gif)

```java
ArrayList<ParticleSystem> systems;

void setup() {
 size(640,360);
 systems = new ArrayList<ParticleSystem>();
 background(255);
 smooth();
}

void draw() {
 background(255);
  
 for (ParticleSystem ps : systems) {
   ps.addParticle();
   ps.run();  
 }
}

void mousePressed() {
  systems.add(new ParticleSystem(1,new PVector(mouseX,mouseY)));
}

class Particle {
    // same
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;                               // New PVector
 
  ParticleSystem(int num, PVector v) {
     particles = new ArrayList<Particle>();
     origin = v.get();                          // This is where it gets the (mouseX, mouseY)
     for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin)); 
     }
  }
  
  void addParticle(){
    particles.add(new Particle(origin));
  }
  
  void run() {
   for (int i = particles.size() -1; i >= 0; i --) {
     Particle p = particles.get(i);
     p.update();
     p.display();
   
     if (p.isDead()) {
       particles.remove(i); 
     }
   }  
  }
}
``` 

### 4.5 Introduction to Inheritance part I
> Inheritance is an important pillar of OOP(Object Oriented Programming). It is the mechanism in java by which one class is allow to inherit the features(fields and methods) of another class.

```java
class Mammal {
  void eat(){
    print("Omnomnom");
  }

  void sleep(){
    print("Zzzzzzz");
  }
}

class kitten extends mammal {
  // 1# inherits all the code from class mamal

  // 2# add new data
  int numWhiskers;

  // 3# add new functions specific to kitten class
  void purr(){}

  // 4# override functions
  void eat() {
    // new way of eating function, different from the mammal class
  }

  // 5# "super" override with new functionality, but also keep old one
  void sleep () {
    print("purrrrr"); // new behavior
    super.sleep();    // BUT also do the old one
  }
}
``` 
### 4.6 Introduction to Inheritance part II
So in our examples with particles and the particle system, the use of inheritance will look like so:
```java
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    stroke(0,lifespan);
    strokeWeight(2);
    fill(127,lifespan);
    ellipse(position.x,position.y,12,12);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

class ReqSquareParticle extends Particle {
  
  ReqSquareParticle (PVector l) {
   super(l); 
  }
  
  void display(){
    fill(255,100,0);
    stroke(0);
    rectMode(CENTER);
    rect(position.x,position.y,10,10);
  } 
}
``` 

##### Exercise
As an exercise I tried myself to make a different sub-class and adding angular acceleration to this one. It was harder than I expected. And I will show you here why.
![](https://i.imgur.com/Lij4ATm.gif)
```java
class ReqSquareParticle extends Particle {
  
  float a = 0.0;
  float aVel = 0.0;
  float aAcc = 0.0;
 
  ReqSquareParticle (PVector l) {
   super(l); 
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
    
    a += aVel;
    aVel += aAcc;
    aAcc += velocity.x/25;
    constrain(aAcc,-0.001,0.001);
  }
  
  void display(){
    fill(255,100,0);
    stroke(0);
    rectMode(CENTER);
    rect(position.x,position.y,10,10);
    rotate(0.01);
  } 
}
``` 

In the end I got it to work. I messed up the locations of the translation & push/pop Matrix.
![](https://i.imgur.com/XTUp6BG.gif)

```java
class Particle {
  // same
}

class ReqSquareParticle extends Particle {
  
  float a = 0.0;
  float aVel = 0.0;
  float aAcc = 0.0;
 
  ReqSquareParticle (PVector l) {
   super(l); 
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
    
    a += aVel;
    aVel += aAcc;
    aAcc += lifespan/(lifespan*lifespan);   // as the lifespan decreases, bigger angular acceleration
  }
  
  void display(){
    fill(255,100,0,100);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    rotate(radians(a));
    rectMode(CENTER);
    rect(0,0,16,16);
    popMatrix();
  } 
}
``` 

### 4.7 Introduction to Polymorphism
Polymorphism is a big pilar in object oriented programming aswell. It allows for us to create object in the form of other objects. This sounds weird, but check to this. 

```java
class Animal {
  // Super class
}

// 3 sub classes
class Dog extends Animal {}
class Cat extends Animal {}
class Turtle extends Animal {}

// New array Kingdom with animals
Animal[] Kingdom = new Animal[1000];

// We can start with a constructor for Dog
Dog rover = new Dog();

// We can also just put dog into the array of animal
Animal spot = new Dog();

// Or into Kingdom
Kingdom[0] = new Dog();
Kingdom[1] = new Cat();
```

The interesting thing is that while the dog objects are in `Kingdom[]`, you can still approach them in the code in a non-select way. We can look through all the different animals and make callbacks in a non-select way. We dont have to say `if (a = Dog) then a.sleep()`.
```java
for (Animal a : Kingdom) {
  a.sleep();
  a.eat();
}
```

Here's an example of polymorphism in our inheritance exercise:
```java
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    float r = random(1);
    if (r < 0.4) {
      particles.add(new ReqSquareParticle(origin)); // 40% chance for square particles
    } else {
      particles.add(new Particle(origin));  
    }
  }

  // now when we loop through it, we don't have to explicitly call for 'ReqSquareParticle' or 'Particle'
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
```

### Exercise
Make a lot of different particles that inherit the `Particle` class and make some crazy confetti with it. 

I made some extra classes to experience how it works. This is the result.
![](https://i.imgur.com/gco0Bsk.gif)

##### Discussion
I don't fully understand how to make this usable, or think of a use case for this yet. It will come over time, for sure. But what I really don't get is why some particles seem to inherit certain properties from each other. The `StarParticle()` change color aswell, while I didn't put this in their code. 

```java
// particles in different colors
class ColorParticle extends Particle {
    ColorParticle (PVector l) {
     super(l); 
  }
  
  void display() {
   fill(random(100,255),random(100,255),random(100,255));
   ellipse(position.x,position.y,20,20);
   stroke(0);
  }
}

// meant to change alpha so it looks like they 'bleep'
class BleepParticle extends Particle {
   BleepParticle (PVector l) {
     super(l); 
  }
  void display(){
    fill(255,0,0,random(255));
    stroke(0);
    ellipse(position.x,position.y,16,16);
  } 
}

// star particles
class StarParticle extends Particle {
   StarParticle (PVector l) {
      super(l); 
   }
   
   void display () {
    star(position.x, position.y, 5, 30, 3);
    fill(127);
   }
   
  // https://processing.org/examples/star.html
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  } 
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  // CHANGES TO PARTICLESYSTEM
  void addParticle() {
    float r = random(1);
    if (r < 0.20) {
      particles.add(new ReqSquareParticle(origin));
    } else if ( r < 0.40) {
      particles.add(new Particle(origin));  
    } else if (r < 0.60) {
      particles.add(new BleepParticle(origin));
    } else if (r < 0.80) {
      particles.add(new ColorParticle(origin));
    } else {
      particles.add(new StarParticle(origin));
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
```

### 4.8 Applying Force to a Particle System
In the past few examples, all our particles have a constant acceleration. There's no `applyForce()`  method written in them. How are we going to add this? 

We're trying to add the same method we used two chapters ago, but then for the whole system. This is going to look like this: 

```java
// This is in the main Processing Sketch
// Apply gravity force to all Particles
PVector gravity = new PVector(0,0.1);
ps.applyForce(gravity);

class Particle {
  // Exactly the same function we used before
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);       // Very important, we want to make sure acceleration doesn't accumulate over time
    lifespan -= 2.0;
  }
}

class ParticleSystem {
  // A function to apply a force to all Particles
  void applyForce(PVector f) {
    for (Particle p: particles) { // for each particle in particles, use applyForce() method
      p.applyForce(f);
    }
  }
}
``` 

### 4.9 Using Image Texture with Particles
The video series clearly don't have an eye for the graphic design part of the results. We only make gray ellipses on a single color background and that's it. But, in Processing it is possible to use images to render textures. 

For this we need to use the method `PImage`. One very important thing is to preload the image into the particle system. This way, the image doesn't get loaded for every particle we draw. 

```java
PImage img = loadIMage("texture.png");
ps = new ParticleSystem(0, new PVector(width/2, height-75), img);

class Particle {
  
  PVector pos;
  PVector vel;
  PVector acc;
  float lifespan;
  PImage img;
  
  Particle(PVector l, PImage img_) {
    // all other properties
    img = img_;
  }

  void render() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, pos.x, pos.y, 32, 32);
  }
}
``` 

#### Rendering textures and efficiency
In the video Daniel explains that when you're doing this kind of more visual heavy work, the normal engine from Processing has a hard time rendering everything smoothly. Processing has different rendering engines that can greatly improve rendering in certain situations.

For rendering textures from images we can use the `P2D` engine. 
```java
void setup() {
  size(640,360,P2D);
};
```

For more information [check here](https://processing.org/tutorials/p3d/).

![](https://i.imgur.com/psCg4wo.gif)