# Introduction
This part of the video series will exists of 5 different models/examples that will be explained. These are the following:
1. _Random Walker_
2. _Probability Basics_
3. _Gaussian Distribution_
4. _Custom Distribution_
5. _Perlin Noise_


## The structure basis of code
Daniel (the host of the channel) tells us that for the project we will be making physics engines in different degrees of difficulty. He shows us the template that we will be working in, which is:

```java
float x;
float y;

x = x + a;
y = y + b;

ellipse(x, y ,2, 2);
```

The different degrees of difficulty will be displayed in `a` & `b`. Deppending on how complex they get, we might be simulating a force more accurately. So in this video series we will pretty much be calculating the movement of an object over time with different models. 

## Processing
Processing always uses 2 functions so it works as intended. First a `setup()` function, in which you describe (e.g.) variables. Second, a `draw()` function, which loops over and over. 

```java
void setup() {
    // code setup here 
    // variables
}

void draw() {
    // excecuting code here
}
```

### The Random Walker
As an exercise you get to make your own random walker. Daniel shows a basic setup for the code and then you get to change it however you want. This is the code I used with some screenshots. 

```java
// TAB ONE
Walker w;

void setup() {
  size(800, 600);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.render();
}

// TAB TWO
class Walker {
  int x,y;
  
  Walker () {
    x = width/2;
    y = height/2;
  }
  
  void render() {
    stroke(0);
    point(x,y);
  }
  
   void step() {
   int choice = int(random(4));
   
   if (choice == 0) {
     x = x + int(random(5));
   } else if (choice == 1) {
     x = x - int(random(5));
   } else if (choice == 2) {
     y = y + int(random(5)); 
   } else {
     y = y - int(random(5));
    }
  }
  
// AVODING WALKING OUT OF THE CANVAS 
  void reset() {
    if (x <= 0) {
      x = width/2;
      y = height/2;
    } else if (x >= width) {
      x = width/2;
      y = height/2;
    } else if (y <= 0) {
      x = width/2;
      y = height/2;
    } else if (y >= height) {
      x = width/2;
      y = height/2;
    }
  }
}
```

### Results
##### _Without reset function_
![alt text](https://imgur.com/wK57tds.png)

##### _With reset function_
![alt text](https://i.imgur.com/Tm43uek.png)

##### _First implementation_
![](https://i.imgur.com/JNy9sUu.png)

```java
void step() {
   int choice = int(random(8));
   
   if (choice == 0) {
      x++;
   } else if (choice == 1) {
     x--;
   } else if (choice == 2) {
     y++;
   } else if (choice == 3) {
     y--;
   } else if (choice == 4) {
     x++;
     y++;
   } else if (choice == 5) {
     x--;
     y--;
   } else if (choice == 6) {
     x++;
     y--;
   } else  {
     x--;
     y++;
   }
  }
```
